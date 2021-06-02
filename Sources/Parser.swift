// - Mark: Generated Code

    public class Parser<T> {
        private astBuilder: IAstBuilder
        
        enum ParserError: Error {
            case unexpectedTokenError(token: Token, expected [String], comment: String)
            case unexpectedEOFError(token: Token, expected [String], comment: String)
            case compositeParserError(errors: [ParserError])
            case invalidOperationException(message: String)
        }
        
        struct ParserContext {
            public var tokenScanner: ITokenScanner
            public var tokenMatcher: ITokenMatcher
            public var tokenQueue: Queue<Token>
            public var errors: [ParserException]
        }

        struct Queue<T> {
            var list = [T]()

            var count: Int { 
                get {
                    return list.count
                }
            }
            mutating func enqueue(item: T) {
                list.append(item)
            }

            mutating func dequeue() -> T? {
                if !list.isEmpty {
                    return list.removeFirst()
                } else {
                    return nil
                }
            }
        }

        public convenience init() {
            self.init(AstBuilder<T>())
        }

        public init(astBuilder: IAstBuilder) {
            self.astBuilder = astBuilder
        }

        public var stopAtFirstError: Bool

        public func parse(tokenScanner: ITokenScanner) -> T {
            return parse(tokenScanner, TokenMatcher())
        }

        public func parse(tokenScanner: ITokenScanner, tokenMatcher: ITokenMatcher) -> T {
            tokenMatcher.reset()
            astBuilder.reset()
            var context = ParserContext(
                tokenScanner = tokenScanner,
                tokenMatcher = tokenMatcher,
                tokenQueue = Queue<Token>(),
                errors = [ParserError]())

            startRule(ctx: context, type: RuleType.GherkinDocument)
            var tate = 0
            var token: Token
            repeat {
                token = readToken(ctx: context)
                state = matchToken(state: state, token, ctx: context)
            } while !token.isEOF

            endRule(ctx: context, type: RuleType.GherkinDocument)

            if ctx.errors.count > 0 {
                throw ParserError.compositeParserException(errors: ctx.errors))
            }

            return getResult(ctx: context)
        }

        private func addError(ctx: ParserContext, error: ParserException) {
            if ctx.errors.contains($0.message == error.message)) { return }
                
            ctx.errors.add(error: error)
            if ctx.errors.count > 10 {
                throw ParserError.compositeParserException(errors: ctx.errors)
            }
        }

        private func handleAstError(ctx: ParserContext, action: @escaping () -> Void) {
            handleExternalError(ctx: ctx) { 
                action()
                return true 
            }
        }

        private func handleExternalError<T>(ctx: ParserContext, defaultValue: T = T(), action: @escaping () -> T) -> T {
            if stopAtFirstError {
                return action()
            }

            try {
                return action()
            } catch (err: ParserError.compositeParserError) {
                for error in err.errors) {
                    addError(ctx: context, error: error)
                }
            }
            catch (err: ParserError)
            {
                addError(ctx: context, error: error);
            }
            return defaultValue;
        }

        func build(ctx: ParserContext, token: Token) {
            handleAstError(ctx: ctx) {
                self.astBuilder.build(token: token)
            }
        }

        func startRule(ctx: ParserContext, type: RuleType) {
            handleAstError(ctx: ctx) {
                self.astBuilder.startRule(type: ruleType)
            }
        }

        func endRule(ctx: ParserContext, type: RuleType) {
            handleAstError(ctx: ctx) {
                self.astBuilder.endRule(ruleType)
            }
        }

        func getResult(ctx: ParserContext) -> T {
            return self.astBuilder.getResult()
        }

        func readToken(ctx: ParserContext) -> Token {
            return ctx.tokenQueue.count > 0 ? ctx.tokenQueue.dequeue() : ctx.tokenScanner.read()
        }


        func matchEOF(ctx: ParserContext, token: Token) -> Bool {
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchEOF(token: token), defaultValue: false)
            } 
        }
        func matchEmpty(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchEmpty(token: token), defaultValue: false)
            } 
        }
        func matchComment(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchComment(token: token), defaultValue: false)
            } 
        }
        func matchTagLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchTagLine(token: token), defaultValue: false)
            } 
        }
        func matchFeatureLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchFeatureLine(token: token), defaultValue: false)
            } 
        }
        func matchRuleLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchRuleLine(token: token), defaultValue: false)
            } 
        }
        func matchBackgroundLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchBackgroundLine(token: token), defaultValue: false)
            } 
        }
        func matchScenarioLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchScenarioLine(token: token), defaultValue: false)
            } 
        }
        func matchExamplesLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchExamplesLine(token: token), defaultValue: false)
            } 
        }
        func matchStepLine(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchStepLine(token: token), defaultValue: false)
            } 
        }
        func matchDocStringSeparator(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchDocStringSeparator(token: token), defaultValue: false)
            } 
        }
        func matchTableRow(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchTableRow(token: token), defaultValue: false)
            } 
        }
        func matchLanguage(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchLanguage(token: token), defaultValue: false)
            } 
        }
        func matchOther(ctx: ParserContext, token: Token) -> Bool {
            if (token.IsEOF) return false;
            return handleExternalError(ctx: ctx) {
                ctx.tokenMatcher.matchOther(token: token), defaultValue: false)
            } 
        }
        public func matchToken(state: Int, token: Token, ctx: ParserContext) -> Int {
            var newState: Int
            switch state {
                case 0:
                    newState = matchTokenAt0(token: token, ctx: ctx)
                    break
                case 1:
                    newState = matchTokenAt1(token: token, ctx: ctx)
                    break
                case 2:
                    newState = matchTokenAt2(token: token, ctx: ctx)
                    break
                case 3:
                    newState = matchTokenAt3(token: token, ctx: ctx)
                    break
                case 4:
                    newState = matchTokenAt4(token: token, ctx: ctx)
                    break
                case 5:
                    newState = matchTokenAt5(token: token, ctx: ctx)
                    break
                case 6:
                    newState = matchTokenAt6(token: token, ctx: ctx)
                    break
                case 7:
                    newState = matchTokenAt7(token: token, ctx: ctx)
                    break
                case 8:
                    newState = matchTokenAt8(token: token, ctx: ctx)
                    break
                case 9:
                    newState = matchTokenAt9(token: token, ctx: ctx)
                    break
                case 10:
                    newState = matchTokenAt10(token: token, ctx: ctx)
                    break
                case 11:
                    newState = matchTokenAt11(token: token, ctx: ctx)
                    break
                case 12:
                    newState = matchTokenAt12(token: token, ctx: ctx)
                    break
                case 13:
                    newState = matchTokenAt13(token: token, ctx: ctx)
                    break
                case 14:
                    newState = matchTokenAt14(token: token, ctx: ctx)
                    break
                case 15:
                    newState = matchTokenAt15(token: token, ctx: ctx)
                    break
                case 16:
                    newState = matchTokenAt16(token: token, ctx: ctx)
                    break
                case 17:
                    newState = matchTokenAt17(token: token, ctx: ctx)
                    break
                case 18:
                    newState = matchTokenAt18(token: token, ctx: ctx)
                    break
                case 19:
                    newState = matchTokenAt19(token: token, ctx: ctx)
                    break
                case 20:
                    newState = matchTokenAt20(token: token, ctx: ctx)
                    break
                case 21:
                    newState = matchTokenAt21(token: token, ctx: ctx)
                    break
                case 22:
                    newState = matchTokenAt22(token: token, ctx: ctx)
                    break
                case 23:
                    newState = matchTokenAt23(token: token, ctx: ctx)
                    break
                case 24:
                    newState = matchTokenAt24(token: token, ctx: ctx)
                    break
                case 25:
                    newState = matchTokenAt25(token: token, ctx: ctx)
                    break
                case 26:
                    newState = matchTokenAt26(token: token, ctx: ctx)
                    break
                case 27:
                    newState = matchTokenAt27(token: token, ctx: ctx)
                    break
                case 28:
                    newState = matchTokenAt28(token: token, ctx: ctx)
                    break
                case 29:
                    newState = matchTokenAt29(token: token, ctx: ctx)
                    break
                case 30:
                    newState = matchTokenAt30(token: token, ctx: ctx)
                    break
                case 31:
                    newState = matchTokenAt31(token: token, ctx: ctx)
                    break
                case 32:
                    newState = matchTokenAt32(token: token, ctx: ctx)
                    break
                case 33:
                    newState = matchTokenAt33(token: token, ctx: ctx)
                    break
                case 34:
                    newState = matchTokenAt34(token: token, ctx: ctx)
                    break
                case 35:
                    newState = matchTokenAt35(token: token, ctx: ctx)
                    break
                case 36:
                    newState = matchTokenAt36(token: token, ctx: ctx)
                    break
                case 37:
                    newState = matchTokenAt37(token: token, ctx: ctx)
                    break
                case 38:
                    newState = matchTokenAt38(token: token, ctx: ctx)
                    break
                case 39:
                    newState = matchTokenAt39(token: token, ctx: ctx)
                    break
                case 40:
                    newState = matchTokenAt40(token: token, ctx: ctx)
                    break
                case 41:
                    newState = matchTokenAt41(token: token, ctx: ctx)
                    break
                case 43:
                    newState = matchTokenAt43(token: token, ctx: ctx)
                    break
                case 44:
                    newState = matchTokenAt44(token: token, ctx: ctx)
                    break
                case 45:
                    newState = matchTokenAt45(token: token, ctx: ctx)
                    break
                case 46:
                    newState = matchTokenAt46(token: token, ctx: ctx)
                    break
                case 47:
                    newState = matchTokenAt47(token: token, ctx: ctx)
                    break
                case 48:
                    newState = matchTokenAt48(token: token, ctx: ctx)
                    break
                case 49:
                    newState = matchTokenAt49(token: token, ctx: ctx)
                    break
                case 50:
                    newState = matchTokenAt50(token: token, ctx: ctx)
                    break
                default:
                    throw ParserError.invalidOperationException(message: "Unknown state: \(state)")
            }
            return newState
        }


        // Start
        func matchTokenAt0(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchLanguage(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Feature)
                startRule(ctx: ctx, type: RuleType.FeatureHeader)
                build(ctx: ctx, token: token)
                return 1;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Feature)
                startRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 2;
            }
            if (matchFeatureLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Feature)
                startRule(ctx: ctx, type: RuleType.FeatureHeader)
                build(ctx: ctx, token: token)
                return 3;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 0;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 0;
            }

            let stateComment = "State: 0 - Start"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Language", "#TagLine", "#FeatureLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 0
        }
        
        // GherkinDocument:0>Feature:0>FeatureHeader:0>#Language:0
        func matchTokenAt1(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 2;
            }
            if (matchFeatureLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 3;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 1;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 1;
            }

            let stateComment = "State: 1 - GherkinDocument:0>Feature:0>FeatureHeader:0>#Language:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#FeatureLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 1
        }
        
        // GherkinDocument:0>Feature:0>FeatureHeader:1>Tags:0>#TagLine:0
        func matchTokenAt2(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 2;
            }
            if (matchFeatureLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 3;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 2;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 2;
            }

            let stateComment = "State: 2 - GherkinDocument:0>Feature:0>FeatureHeader:1>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#FeatureLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 2
        }
        
        // GherkinDocument:0>Feature:0>FeatureHeader:2>#FeatureLine:0
        func matchTokenAt3(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 3;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 5;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 6;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 4;
            }

            let stateComment = "State: 3 - GherkinDocument:0>Feature:0>FeatureHeader:2>#FeatureLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 3
        }
        
        // GherkinDocument:0>Feature:0>FeatureHeader:3>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt4(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 5;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 6;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 4;
            }

            let stateComment = "State: 4 - GherkinDocument:0>Feature:0>FeatureHeader:3>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 4
        }
        
        // GherkinDocument:0>Feature:0>FeatureHeader:3>DescriptionHelper:2>#Comment:0
        func matchTokenAt5(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 5;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 6;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.FeatureHeader)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 5;
            }

            let stateComment = "State: 5 - GherkinDocument:0>Feature:0>FeatureHeader:3>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 5
        }
        
        // GherkinDocument:0>Feature:1>Background:0>#BackgroundLine:0
        func matchTokenAt6(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 6;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 8;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 7;
            }

            let stateComment = "State: 6 - GherkinDocument:0>Feature:1>Background:0>#BackgroundLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 6
        }
        
        // GherkinDocument:0>Feature:1>Background:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt7(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 8;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 7;
            }

            let stateComment = "State: 7 - GherkinDocument:0>Feature:1>Background:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 7
        }
        
        // GherkinDocument:0>Feature:1>Background:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt8(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 8;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 8;
            }

            let stateComment = "State: 8 - GherkinDocument:0>Feature:1>Background:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 8
        }
        
        // GherkinDocument:0>Feature:1>Background:2>Step:0>#StepLine:0
        func matchTokenAt9(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DataTable)
                build(ctx: ctx, token: token)
                return 10;
            }
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DocString)
                build(ctx: ctx, token: token)
                return 49;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 9;
            }

            let stateComment = "State: 9 - GherkinDocument:0>Feature:1>Background:2>Step:0>#StepLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#DocStringSeparator", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 9
        }
        
        // GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0
        func matchTokenAt10(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 10;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 10;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 10;
            }

            let stateComment = "State: 10 - GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 10
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:0>Tags:0>#TagLine:0
        func matchTokenAt11(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 11;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 11;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 11;
            }

            let stateComment = "State: 11 - GherkinDocument:0>Feature:2>ScenarioDefinition:0>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#ScenarioLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 11
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:0>#ScenarioLine:0
        func matchTokenAt12(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 14;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 13;
            }

            let stateComment = "State: 12 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:0>#ScenarioLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 12
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt13(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 14;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 13;
            }

            let stateComment = "State: 13 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 13
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt14(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 14;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 14;
            }

            let stateComment = "State: 14 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 14
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:0>#StepLine:0
        func matchTokenAt15(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DataTable)
                build(ctx: ctx, token: token)
                return 16;
            }
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DocString)
                build(ctx: ctx, token: token)
                return 47;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 15;
            }

            let stateComment = "State: 15 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:0>#StepLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#DocStringSeparator", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 15
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0
        func matchTokenAt16(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 16;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 16;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 16;
            }

            let stateComment = "State: 16 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 16
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:0>Tags:0>#TagLine:0
        func matchTokenAt17(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 17;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 17;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 17;
            }

            let stateComment = "State: 17 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:0>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#ExamplesLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 17
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:0>#ExamplesLine:0
        func matchTokenAt18(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 20;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 21;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 19;
            }

            let stateComment = "State: 18 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:0>#ExamplesLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 18
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt19(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 20;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 21;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 19;
            }

            let stateComment = "State: 19 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 19
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt20(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 20;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 21;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 20;
            }

            let stateComment = "State: 20 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 20
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:2>ExamplesTable:0>#TableRow:0
        func matchTokenAt21(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 21;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 21;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 21;
            }

            let stateComment = "State: 21 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:2>ExamplesTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 21
        }
        
        // GherkinDocument:0>Feature:3>Rule:0>RuleHeader:0>Tags:0>#TagLine:0
        func matchTokenAt22(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 22;
            }

            let stateComment = "State: 22 - GherkinDocument:0>Feature:3>Rule:0>RuleHeader:0>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 22
        }
        
        // GherkinDocument:0>Feature:3>Rule:0>RuleHeader:1>#RuleLine:0
        func matchTokenAt23(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 25;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 26;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 24;
            }

            let stateComment = "State: 23 - GherkinDocument:0>Feature:3>Rule:0>RuleHeader:1>#RuleLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 23
        }
        
        // GherkinDocument:0>Feature:3>Rule:0>RuleHeader:2>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt24(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 25;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 26;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 24;
            }

            let stateComment = "State: 24 - GherkinDocument:0>Feature:3>Rule:0>RuleHeader:2>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 24
        }
        
        // GherkinDocument:0>Feature:3>Rule:0>RuleHeader:2>DescriptionHelper:2>#Comment:0
        func matchTokenAt25(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 25;
            }
            if (matchBackgroundLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Background)
                build(ctx: ctx, token: token)
                return 26;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.RuleHeader)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 25;
            }

            let stateComment = "State: 25 - GherkinDocument:0>Feature:3>Rule:0>RuleHeader:2>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#BackgroundLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 25
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:0>#BackgroundLine:0
        func matchTokenAt26(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 26;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 28;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 27;
            }

            let stateComment = "State: 26 - GherkinDocument:0>Feature:3>Rule:1>Background:0>#BackgroundLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 26
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt27(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 28;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 27;
            }

            let stateComment = "State: 27 - GherkinDocument:0>Feature:3>Rule:1>Background:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 27
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt28(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 28;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 28;
            }

            let stateComment = "State: 28 - GherkinDocument:0>Feature:3>Rule:1>Background:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 28
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:0>#StepLine:0
        func matchTokenAt29(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DataTable)
                build(ctx: ctx, token: token)
                return 30;
            }
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DocString)
                build(ctx: ctx, token: token)
                return 45;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 29;
            }

            let stateComment = "State: 29 - GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:0>#StepLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#DocStringSeparator", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 29
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0
        func matchTokenAt30(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 30;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 30;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 30;
            }

            let stateComment = "State: 30 - GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 30
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:0>Tags:0>#TagLine:0
        func matchTokenAt31(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 31;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 31;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 31;
            }

            let stateComment = "State: 31 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:0>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#ScenarioLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 31
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:0>#ScenarioLine:0
        func matchTokenAt32(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 34;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 33;
            }

            let stateComment = "State: 32 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:0>#ScenarioLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 32
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt33(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 34;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 33;
            }

            let stateComment = "State: 33 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 33
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt34(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 34;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 34;
            }

            let stateComment = "State: 34 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 34
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:0>#StepLine:0
        func matchTokenAt35(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DataTable)
                build(ctx: ctx, token: token)
                return 36;
            }
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.DocString)
                build(ctx: ctx, token: token)
                return 43;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 35;
            }

            let stateComment = "State: 35 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:0>#StepLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#DocStringSeparator", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 35
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0
        func matchTokenAt36(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 36;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DataTable)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 36;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 36;
            }

            let stateComment = "State: 36 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:0>DataTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 36
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:0>Tags:0>#TagLine:0
        func matchTokenAt37(token: Token, ctx: ParserContext) -> Int
        {
            if (matchTagLine(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 37;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Tags)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 37;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 37;
            }

            let stateComment = "State: 37 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:0>Tags:0>#TagLine:0"
            token.detach()
            var expectedTokens: [String] = {"#TagLine", "#ExamplesLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 37
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:0>#ExamplesLine:0
        func matchTokenAt38(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 40;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 41;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 39;
            }

            let stateComment = "State: 38 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:0>#ExamplesLine:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Empty", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 38
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:1>Description:0>#Other:0
        func matchTokenAt39(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                build(ctx: ctx, token: token)
                return 40;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 41;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Description)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 39;
            }

            let stateComment = "State: 39 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:1>Description:0>#Other:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 39
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:2>#Comment:0
        func matchTokenAt40(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 40;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                startRule(ctx: ctx, type: RuleType.ExamplesTable)
                build(ctx: ctx, token: token)
                return 41;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 40;
            }

            let stateComment = "State: 40 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:1>DescriptionHelper:2>#Comment:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#Comment", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 40
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:2>ExamplesTable:0>#TableRow:0
        func matchTokenAt41(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchTableRow(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 41;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.ExamplesTable)
                endRule(ctx: ctx, type: RuleType.Examples)
                endRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 41;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 41;
            }

            let stateComment = "State: 41 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:3>ExamplesDefinition:1>Examples:2>ExamplesTable:0>#TableRow:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#TableRow", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 41
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0
        func matchTokenAt43(token: Token, ctx: ParserContext) -> Int
        {
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 44;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 43;
            }

            let stateComment = "State: 43 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#DocStringSeparator", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 43
        }
        
        // GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0
        func matchTokenAt44(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 35;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 37;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 38;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 44;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 44;
            }

            let stateComment = "State: 44 - GherkinDocument:0>Feature:3>Rule:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 44
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0
        func matchTokenAt45(token: Token, ctx: ParserContext) -> Int
        {
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 46;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 45;
            }

            let stateComment = "State: 45 - GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#DocStringSeparator", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 45
        }
        
        // GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0
        func matchTokenAt46(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 29;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 31;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 32;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 46;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 46;
            }

            let stateComment = "State: 46 - GherkinDocument:0>Feature:3>Rule:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 46
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0
        func matchTokenAt47(token: Token, ctx: ParserContext) -> Int
        {
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 48;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 47;
            }

            let stateComment = "State: 47 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#DocStringSeparator", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 47
        }
        
        // GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0
        func matchTokenAt48(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 15;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead1(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 17;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchExamplesLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.ExamplesDefinition)
                startRule(ctx: ctx, type: RuleType.Examples)
                build(ctx: ctx, token: token)
                return 18;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Scenario)
                endRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 48;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 48;
            }

            let stateComment = "State: 48 - GherkinDocument:0>Feature:2>ScenarioDefinition:1>Scenario:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#StepLine", "#TagLine", "#ExamplesLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 48
        }
        
        // GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0
        func matchTokenAt49(token: Token, ctx: ParserContext) -> Int
        {
            if (matchDocStringSeparator(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 50;
            }
            if (matchOther(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 49;
            }

            let stateComment = "State: 49 - GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:0>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#DocStringSeparator", "#Other"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 49
        }
        
        // GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0
        func matchTokenAt50(token: Token, ctx: ParserContext) -> Int
        {
            if (matchEOF(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                endRule(ctx: ctx, type: RuleType.Feature)
                build(ctx: ctx, token: token)
                return 42;
            }
            if (matchStepLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                startRule(ctx: ctx, type: RuleType.Step)
                build(ctx: ctx, token: token)
                return 9;
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                if LookAhead0(ctx: ctx, token: token)
                {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 11;
                }
            }
            if (matchTagLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                startRule(ctx: ctx, type: RuleType.Tags)
                build(ctx: ctx, token: token)
                return 22;
            }
            if (matchScenarioLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.ScenarioDefinition)
                startRule(ctx: ctx, type: RuleType.Scenario)
                build(ctx: ctx, token: token)
                return 12;
            }
            if (matchRuleLine(ctx: ctx, token: token))
            {
                endRule(ctx: ctx, type: RuleType.DocString)
                endRule(ctx: ctx, type: RuleType.Step)
                endRule(ctx: ctx, type: RuleType.Background)
                startRule(ctx: ctx, type: RuleType.Rule)
                startRule(ctx: ctx, type: RuleType.RuleHeader)
                build(ctx: ctx, token: token)
                return 23;
            }
            if (matchComment(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 50;
            }
            if (matchEmpty(ctx: ctx, token: token))
            {
                build(ctx: ctx, token: token)
                return 50;
            }

            let stateComment = "State: 50 - GherkinDocument:0>Feature:1>Background:2>Step:1>StepArg:0>__alt0:1>DocString:2>#DocStringSeparator:0"
            token.detach()
            var expectedTokens: [String] = {"#EOF", "#StepLine", "#TagLine", "#ScenarioLine", "#RuleLine", "#Comment", "#Empty"}
            var error: ParserError = token.isEOF ? 
                ParserError.unexpectedEOFException(token: token, expected: expectedTokens, comment: stateComment) :
                ParserError.unexpectedTokenError(token: token, expected: expectedTokens, comment: stateComment)
            if stopAtFirstError {
                throw error
            }
            
            addError(ctx: ctx, error: error)

            return 50
        }
        

        func lookAhead0(ctx: ParserContext, currentToken: Token) -> Bool
        {
            currentToken.detach()
            var token: Token
            var queue = Queue<Token>()
            var match = false
            repeat {
                token = readToken(ctx: ctx)
                token.detach()
                queue.enqueue(item: token)

                if false
                    || matchScenarioLine(ctx: ctx, token: token)
{
                    match = true
                    break
                }
           } while false
                || matchEmpty(ctx: ctx, token: token)
                || matchComment(ctx: ctx, token: token)
                || matchTagLine(ctx: ctx, token: token)
for t in queue {
                ctx.tokenQueue.enqueue(item: t)
            }
            return match
        }
        
        func lookAhead1(ctx: ParserContext, currentToken: Token) -> Bool
        {
            currentToken.detach()
            var token: Token
            var queue = Queue<Token>()
            var match = false
            repeat {
                token = readToken(ctx: ctx)
                token.detach()
                queue.enqueue(item: token)

                if false
                    || matchExamplesLine(ctx: ctx, token: token)
{
                    match = true
                    break
                }
           } while false
                || matchEmpty(ctx: ctx, token: token)
                || matchComment(ctx: ctx, token: token)
                || matchTagLine(ctx: ctx, token: token)
for t in queue {
                ctx.tokenQueue.enqueue(item: t)
            }
            return match
        }
            }

    public protocol IAstBuilder 
    {
        associatedtype T
        func build(token: Token)
        func startRule(type: RuleType)
        func endRule(type: RuleType)
        func getResult() -> T
        func reset()
    }

    public protocol ITokenScanner
    {
        func read() -> Token
    }

    public protocol ITokenMatcher
    {
        func matchEOF(token: Token) -> Bool
        func matchEmpty(token: Token) -> Bool
        func matchComment(token: Token) -> Bool
        func matchTagLine(token: Token) -> Bool
        func matchFeatureLine(token: Token) -> Bool
        func matchRuleLine(token: Token) -> Bool
        func matchBackgroundLine(token: Token) -> Bool
        func matchScenarioLine(token: Token) -> Bool
        func matchExamplesLine(token: Token) -> Bool
        func matchStepLine(token: Token) -> Bool
        func matchDocStringSeparator(token: Token) -> Bool
        func matchTableRow(token: Token) -> Bool
        func matchLanguage(token: Token) -> Bool
        func matchOther(token: Token) -> Bool
        func reset()
    }
