/** \file
 *  This C header file was generated by $ANTLR version 3.2 Sep 23, 2009 12:02:23
 *
 *     -  From the grammar source file : tmp_g\\jal.g
 *     -                            On : 2010-04-25 22:53:57
 *     -                for the parser : jalParserParser *
 * Editing it, at least manually, is not wise. 
 *
 * C language generator and runtime by Jim Idle, jimi|hereisanat|idle|dotgoeshere|ws.
 *
 *
 * The parser jalParser has the callable functions (rules) shown below,
 * which will invoke the code for the associated rule in the source grammar
 * assuming that the input stream is pointing to a token/text stream that could begin
 * this rule.
 * 
 * For instance if you call the first (topmost) rule in a parser grammar, you will
 * get the results of a full parse, but calling a rule half way through the grammar will
 * allow you to pass part of a full token stream to the parser, such as for syntax checking
 * in editors and so on.
 *
 * The parser entry points are called indirectly (by function pointer to function) via
 * a parser context typedef pjalParser, which is returned from a call to jalParserNew().
 *
 * The methods in pjalParser are  as follows:
 *
 *  - jalParser_program_return      pjalParser->program(pjalParser)
 *  - jalParser_statement_return      pjalParser->statement(pjalParser)
 *  - jalParser_variable_return      pjalParser->variable(pjalParser)
 *  - jalParser_asm_stmt_return      pjalParser->asm_stmt(pjalParser)
 *  - jalParser_asm_block_return      pjalParser->asm_block(pjalParser)
 *  - jalParser_cexpr_return      pjalParser->cexpr(pjalParser)
 *  - jalParser_cexpr_list_return      pjalParser->cexpr_list(pjalParser)
 *  - jalParser_for_stmt_return      pjalParser->for_stmt(pjalParser)
 *  - jalParser_loop_stmt_return      pjalParser->loop_stmt(pjalParser)
 *  - jalParser_forever_stmt_return      pjalParser->forever_stmt(pjalParser)
 *  - jalParser_while_stmt_return      pjalParser->while_stmt(pjalParser)
 *  - jalParser_repeat_stmt_return      pjalParser->repeat_stmt(pjalParser)
 *  - jalParser_if_stmt_return      pjalParser->if_stmt(pjalParser)
 *  - jalParser_if_else_return      pjalParser->if_else(pjalParser)
 *  - jalParser_if_elsif_return      pjalParser->if_elsif(pjalParser)
 *  - jalParser_case_value_return      pjalParser->case_value(pjalParser)
 *  - jalParser_case_stmt_return      pjalParser->case_stmt(pjalParser)
 *  - jalParser_block_stmt_return      pjalParser->block_stmt(pjalParser)
 *  - jalParser_proc_params_return      pjalParser->proc_params(pjalParser)
 *  - jalParser_proc_param_return      pjalParser->proc_param(pjalParser)
 *  - jalParser_proc_body_return      pjalParser->proc_body(pjalParser)
 *  - jalParser_proc_def_return      pjalParser->proc_def(pjalParser)
 *  - jalParser_func_body_return      pjalParser->func_body(pjalParser)
 *  - jalParser_func_def_return      pjalParser->func_def(pjalParser)
 *  - jalParser_alias_def_return      pjalParser->alias_def(pjalParser)
 *  - jalParser_const_def2_return      pjalParser->const_def2(pjalParser)
 *  - jalParser_const_def_return      pjalParser->const_def(pjalParser)
 *  - jalParser_var_init_return      pjalParser->var_init(pjalParser)
 *  - jalParser_var_def2_return      pjalParser->var_def2(pjalParser)
 *  - jalParser_var_def_return      pjalParser->var_def(pjalParser)
 *  - jalParser_vtype_return      pjalParser->vtype(pjalParser)
 *  - jalParser_type_return      pjalParser->type(pjalParser)
 *  - jalParser_at_decl_return      pjalParser->at_decl(pjalParser)
 *  - jalParser_is_decl_return      pjalParser->is_decl(pjalParser)
 *  - jalParser_bitloc_return      pjalParser->bitloc(pjalParser)
 *  - jalParser_proc_func_call_return      pjalParser->proc_func_call(pjalParser)
 *  - jalParser_pragma_return      pjalParser->pragma(pjalParser)
 *  - jalParser_pragma_target_return      pjalParser->pragma_target(pjalParser)
 *  - jalParser_pragma_fusedef_return      pjalParser->pragma_fusedef(pjalParser)
 *  - jalParser_expr_return      pjalParser->expr(pjalParser)
 *  - jalParser_or_expr_return      pjalParser->or_expr(pjalParser)
 *  - jalParser_xor_expr_return      pjalParser->xor_expr(pjalParser)
 *  - jalParser_and_expr_return      pjalParser->and_expr(pjalParser)
 *  - jalParser_equality_expr_return      pjalParser->equality_expr(pjalParser)
 *  - jalParser_relational_expr_return      pjalParser->relational_expr(pjalParser)
 *  - jalParser_arith_expr_return      pjalParser->arith_expr(pjalParser)
 *  - jalParser_term_return      pjalParser->term(pjalParser)
 *  - jalParser_pling_return      pjalParser->pling(pjalParser)
 *  - jalParser_factor_return      pjalParser->factor(pjalParser)
 *  - jalParser_atom_return      pjalParser->atom(pjalParser)
 *  - jalParser_identifier_return      pjalParser->identifier(pjalParser)
 *  - jalParser_constant_return      pjalParser->constant(pjalParser)
 *
 * The return type for any particular rule is of course determined by the source
 * grammar file.
 */
// [The "BSD licence"]
// Copyright (c) 2005-2009 Jim Idle, Temporal Wave LLC
// http://www.temporal-wave.com
// http://www.linkedin.com/in/jimidle
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef	_jalParser_H
#define _jalParser_H
/* =============================================================================
 * Standard antlr3 C runtime definitions
 */
#include    <antlr3.h>

/* End of standard antlr 3 runtime definitions
 * =============================================================================
 */
 
#ifdef __cplusplus
extern "C" {
#endif

// Forward declare the context typedef so that we can use it before it is
// properly defined. Delegators and delegates (from import statements) are
// interdependent and their context structures contain pointers to each other
// C only allows such things to be declared if you pre-declare the typedef.
//
typedef struct jalParser_Ctx_struct jalParser, * pjalParser;



#ifdef	ANTLR3_WINDOWS
// Disable: Unreferenced parameter,							- Rules with parameters that are not used
//          constant conditional,							- ANTLR realizes that a prediction is always true (synpred usually)
//          initialized but unused variable					- tree rewrite variables declared but not needed
//          Unreferenced local variable						- lexer rule declares but does not always use _type
//          potentially unitialized variable used			- retval always returned from a rule 
//			unreferenced local function has been removed	- susually getTokenNames or freeScope, they can go without warnigns
//
// These are only really displayed at warning level /W4 but that is the code ideal I am aiming at
// and the codegen must generate some of these warnings by necessity, apart from 4100, which is
// usually generated when a parser rule is given a parameter that it does not use. Mostly though
// this is a matter of orthogonality hence I disable that one.
//
#pragma warning( disable : 4100 )
#pragma warning( disable : 4101 )
#pragma warning( disable : 4127 )
#pragma warning( disable : 4189 )
#pragma warning( disable : 4505 )
#pragma warning( disable : 4701 )
#endif

/* ========================
 * BACKTRACKING IS ENABLED
 * ========================
 */
typedef struct jalParser_program_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_program_return;

typedef struct jalParser_statement_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_statement_return;

typedef struct jalParser_variable_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_variable_return;

typedef struct jalParser_asm_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_asm_stmt_return;

typedef struct jalParser_asm_block_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_asm_block_return;

typedef struct jalParser_cexpr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_cexpr_return;

typedef struct jalParser_cexpr_list_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_cexpr_list_return;

typedef struct jalParser_for_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_for_stmt_return;

typedef struct jalParser_loop_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_loop_stmt_return;

typedef struct jalParser_forever_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_forever_stmt_return;

typedef struct jalParser_while_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_while_stmt_return;

typedef struct jalParser_repeat_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_repeat_stmt_return;

typedef struct jalParser_if_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_if_stmt_return;

typedef struct jalParser_if_else_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_if_else_return;

typedef struct jalParser_if_elsif_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_if_elsif_return;

typedef struct jalParser_case_value_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_case_value_return;

typedef struct jalParser_case_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_case_stmt_return;

typedef struct jalParser_block_stmt_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_block_stmt_return;

typedef struct jalParser_proc_params_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_proc_params_return;

typedef struct jalParser_proc_param_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_proc_param_return;

typedef struct jalParser_proc_body_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_proc_body_return;

typedef struct jalParser_proc_def_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_proc_def_return;

typedef struct jalParser_func_body_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_func_body_return;

typedef struct jalParser_func_def_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_func_def_return;

typedef struct jalParser_alias_def_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_alias_def_return;

typedef struct jalParser_const_def2_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_const_def2_return;

typedef struct jalParser_const_def_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_const_def_return;

typedef struct jalParser_var_init_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_var_init_return;

typedef struct jalParser_var_def2_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_var_def2_return;

typedef struct jalParser_var_def_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_var_def_return;

typedef struct jalParser_vtype_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_vtype_return;

typedef struct jalParser_type_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_type_return;

typedef struct jalParser_at_decl_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_at_decl_return;

typedef struct jalParser_is_decl_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_is_decl_return;

typedef struct jalParser_bitloc_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_bitloc_return;

typedef struct jalParser_proc_func_call_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_proc_func_call_return;

typedef struct jalParser_pragma_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_pragma_return;

typedef struct jalParser_pragma_target_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_pragma_target_return;

typedef struct jalParser_pragma_fusedef_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_pragma_fusedef_return;

typedef struct jalParser_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_expr_return;

typedef struct jalParser_or_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_or_expr_return;

typedef struct jalParser_xor_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_xor_expr_return;

typedef struct jalParser_and_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_and_expr_return;

typedef struct jalParser_equality_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_equality_expr_return;

typedef struct jalParser_relational_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_relational_expr_return;

typedef struct jalParser_arith_expr_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_arith_expr_return;

typedef struct jalParser_term_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_term_return;

typedef struct jalParser_pling_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_pling_return;

typedef struct jalParser_factor_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_factor_return;

typedef struct jalParser_atom_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_atom_return;

typedef struct jalParser_identifier_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_identifier_return;

typedef struct jalParser_constant_return_struct
{
    /** Generic return elements for ANTLR3 rules that are not in tree parsers or returning trees
     */
    pANTLR3_COMMON_TOKEN    start;
    pANTLR3_COMMON_TOKEN    stop;
    pANTLR3_BASE_TREE	tree;
   
}
    jalParser_constant_return;



/** Context tracking structure for jalParser
 */
struct jalParser_Ctx_struct
{
    /** Built in ANTLR3 context tracker contains all the generic elements
     *  required for context tracking.
     */
    pANTLR3_PARSER   pParser;


     jalParser_program_return (*program)	(struct jalParser_Ctx_struct * ctx);
     jalParser_statement_return (*statement)	(struct jalParser_Ctx_struct * ctx);
     jalParser_variable_return (*variable)	(struct jalParser_Ctx_struct * ctx);
     jalParser_asm_stmt_return (*asm_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_asm_block_return (*asm_block)	(struct jalParser_Ctx_struct * ctx);
     jalParser_cexpr_return (*cexpr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_cexpr_list_return (*cexpr_list)	(struct jalParser_Ctx_struct * ctx);
     jalParser_for_stmt_return (*for_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_loop_stmt_return (*loop_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_forever_stmt_return (*forever_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_while_stmt_return (*while_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_repeat_stmt_return (*repeat_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_if_stmt_return (*if_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_if_else_return (*if_else)	(struct jalParser_Ctx_struct * ctx);
     jalParser_if_elsif_return (*if_elsif)	(struct jalParser_Ctx_struct * ctx);
     jalParser_case_value_return (*case_value)	(struct jalParser_Ctx_struct * ctx);
     jalParser_case_stmt_return (*case_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_block_stmt_return (*block_stmt)	(struct jalParser_Ctx_struct * ctx);
     jalParser_proc_params_return (*proc_params)	(struct jalParser_Ctx_struct * ctx);
     jalParser_proc_param_return (*proc_param)	(struct jalParser_Ctx_struct * ctx);
     jalParser_proc_body_return (*proc_body)	(struct jalParser_Ctx_struct * ctx);
     jalParser_proc_def_return (*proc_def)	(struct jalParser_Ctx_struct * ctx);
     jalParser_func_body_return (*func_body)	(struct jalParser_Ctx_struct * ctx);
     jalParser_func_def_return (*func_def)	(struct jalParser_Ctx_struct * ctx);
     jalParser_alias_def_return (*alias_def)	(struct jalParser_Ctx_struct * ctx);
     jalParser_const_def2_return (*const_def2)	(struct jalParser_Ctx_struct * ctx);
     jalParser_const_def_return (*const_def)	(struct jalParser_Ctx_struct * ctx);
     jalParser_var_init_return (*var_init)	(struct jalParser_Ctx_struct * ctx);
     jalParser_var_def2_return (*var_def2)	(struct jalParser_Ctx_struct * ctx);
     jalParser_var_def_return (*var_def)	(struct jalParser_Ctx_struct * ctx);
     jalParser_vtype_return (*vtype)	(struct jalParser_Ctx_struct * ctx);
     jalParser_type_return (*type)	(struct jalParser_Ctx_struct * ctx);
     jalParser_at_decl_return (*at_decl)	(struct jalParser_Ctx_struct * ctx);
     jalParser_is_decl_return (*is_decl)	(struct jalParser_Ctx_struct * ctx);
     jalParser_bitloc_return (*bitloc)	(struct jalParser_Ctx_struct * ctx);
     jalParser_proc_func_call_return (*proc_func_call)	(struct jalParser_Ctx_struct * ctx);
     jalParser_pragma_return (*pragma)	(struct jalParser_Ctx_struct * ctx);
     jalParser_pragma_target_return (*pragma_target)	(struct jalParser_Ctx_struct * ctx);
     jalParser_pragma_fusedef_return (*pragma_fusedef)	(struct jalParser_Ctx_struct * ctx);
     jalParser_expr_return (*expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_or_expr_return (*or_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_xor_expr_return (*xor_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_and_expr_return (*and_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_equality_expr_return (*equality_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_relational_expr_return (*relational_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_arith_expr_return (*arith_expr)	(struct jalParser_Ctx_struct * ctx);
     jalParser_term_return (*term)	(struct jalParser_Ctx_struct * ctx);
     jalParser_pling_return (*pling)	(struct jalParser_Ctx_struct * ctx);
     jalParser_factor_return (*factor)	(struct jalParser_Ctx_struct * ctx);
     jalParser_atom_return (*atom)	(struct jalParser_Ctx_struct * ctx);
     jalParser_identifier_return (*identifier)	(struct jalParser_Ctx_struct * ctx);
     jalParser_constant_return (*constant)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred17_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred27_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred28_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred32_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred33_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred34_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred35_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred70_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred72_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred73_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred90_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred92_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred121_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred133_jal)	(struct jalParser_Ctx_struct * ctx);
     ANTLR3_BOOLEAN (*synpred134_jal)	(struct jalParser_Ctx_struct * ctx);
    // Delegated rules
    const char * (*getGrammarFileName)();
    void	    (*free)   (struct jalParser_Ctx_struct * ctx);
    /* @headerFile.members() */
    pANTLR3_BASE_TREE_ADAPTOR	adaptor;
    pANTLR3_VECTOR_FACTORY		vectors;
    /* End @headerFile.members() */
};

// Function protoypes for the constructor functions that external translation units
// such as delegators and delegates may wish to call.
//
ANTLR3_API pjalParser jalParserNew         (pANTLR3_COMMON_TOKEN_STREAM instream);
ANTLR3_API pjalParser jalParserNewSSD      (pANTLR3_COMMON_TOKEN_STREAM instream, pANTLR3_RECOGNIZER_SHARED_STATE state);

/** Symbolic definitions of all the tokens that the parser will work with.
 * \{
 *
 * Antlr will define EOF, but we can't use that as it it is too common in
 * in C header files and that would be confusing. There is no way to filter this out at the moment
 * so we just undef it here for now. That isn't the value we get back from C recognizers
 * anyway. We are looking for ANTLR3_TOKEN_EOF.
 */
#ifdef	EOF
#undef	EOF
#endif
#ifdef	Tokens
#undef	Tokens
#endif 
#define J2C_COMMENT      17
#define L__ERROR      20
#define L_USING      34
#define LETTER      110
#define L_INTERRUPT      75
#define L_VAR      61
#define CONDITION      6
#define ASTERIX      62
#define EOF      -1
#define L_CODE      77
#define L__DEBUG      18
#define L_REPEAT      37
#define LBRACKET      23
#define L_DWORD      66
#define L_SBYTE      67
#define CASE_VALUE      5
#define RPAREN      48
#define STRING_LITERAL      19
#define GREATER      90
#define FUNC_PROC_CALL      7
#define NOT_EQUAL      88
#define L_NOP      26
#define L_FUSEDEF      82
#define CARET      85
#define LESS      89
#define BIN_LITERAL      100
#define L_STACK      76
#define VAR      9
#define BODY      4
#define L_PRAGMA      72
#define APOSTROPHE      54
#define L_ELSE      41
#define L_DATA      80
#define L_VOID      10
#define L_CONST      59
#define LINE_COMMENT      109
#define INCLUDE_STMT      15
#define L_VOLATILE      49
#define CHARACTER_LITERAL      60
#define OCTAL_ESCAPE      106
#define LCURLY      31
#define L_GET      57
#define L_END      30
#define L_BYTE      64
#define WS      107
#define L_EXIT      11
#define L_BLOCK      46
#define OR      84
#define LEFT_SHIFT      93
#define LESS_EQUAL      91
#define L_FUNCTION      56
#define L_SHARED      70
#define DECIMAL_LITERAL      103
#define L_THEN      40
#define L_AT      71
#define L_IF      39
#define L_FOREVER      35
#define L_RETURN      13
#define L_ALIAS      58
#define AMP      86
#define L_IS      52
#define L_EEPROM      78
#define L_IN      50
#define L_ASSERT      14
#define J2CG_COMMENT      16
#define L_CHIP      83
#define L_ID      79
#define L_PUT      55
#define LPAREN      47
#define NEOL      108
#define ESCAPE_SEQUENCE      105
#define SLASH      96
#define L_SWORD      68
#define COMMA      27
#define L_CASE      43
#define L_BIT      63
#define IDENTIFIER      99
#define EQUAL      87
#define RIGHT_SHIFT      94
#define PLUS      95
#define HEX_LITERAL      101
#define L_LOOP      12
#define RBRACKET      24
#define L_ELSIF      42
#define PARAMS      8
#define L_ASSEMBLER      28
#define L_FOR      33
#define PERCENT      97
#define L_WORD      65
#define L__WARN      21
#define OCTAL_LITERAL      102
#define HEX_DIGIT      104
#define BANG      98
#define L_OTHERWISE      45
#define MINUS      81
#define L_UNTIL      38
#define COLON      29
#define L_WHILE      36
#define L_TARGET      73
#define L_SDWORD      69
#define L_OUT      51
#define RCURLY      32
#define ASSIGN      22
#define L_OF      44
#define L_PROCEDURE      53
#define L_INLINE      74
#define L_ASM      25
#define GREATER_EQUAL      92
#ifdef	EOF
#undef	EOF
#define	EOF	ANTLR3_TOKEN_EOF
#endif

#ifndef TOKENSOURCE
#define TOKENSOURCE(lxr) lxr->pLexer->rec->state->tokSource
#endif

/* End of token definitions for jalParser
 * =============================================================================
 */
/** \} */

#ifdef __cplusplus
}
#endif

#endif

/* END - Note:Keep extra line feed to satisfy UNIX systems */
