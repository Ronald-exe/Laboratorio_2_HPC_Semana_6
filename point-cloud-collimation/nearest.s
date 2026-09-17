_ZNK9GridIndex7nearestERK5PointRS0_Rd:
.LVL331:
.LFB6542:
	.loc 2 238 8 is_stmt 1 view -0
	.cfi_startproc
	.loc 2 238 8 is_stmt 0 view .LVU1052
	endbr64
	.loc 2 240 5 is_stmt 1 view .LVU1053
	.loc 2 238 8 is_stmt 0 view .LVU1054
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
.LBB10179:
.LBB10180:
	.loc 2 280 40 view .LVU1055
	movq	xmm1, QWORD PTR .LC32[rip]
.LBE10180:
.LBE10179:
	.loc 2 238 8 view .LVU1056
	mov	r15, rdi
	mov	r10, rdx
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
.LBB10186:
.LBB10182:
	.loc 2 280 40 view .LVU1057
	movsd	xmm5, QWORD PTR .LC31[rip]
.LBE10182:
.LBE10186:
	.loc 2 238 8 view .LVU1058
	mov	r14, rcx
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movsd	xmm6, QWORD PTR 8[rdi]
.LBB10187:
.LBI10179:
	.loc 2 279 23 is_stmt 1 view .LVU1059
.LVL332:
.LBB10183:
	.loc 2 280 5 view .LVU1060
.LBE10183:
.LBE10187:
	.loc 2 238 8 is_stmt 0 view .LVU1061
	mov	rbx, rsi
.LBB10188:
.LBB10184:
	.loc 2 280 40 view .LVU1062
	movsd	xmm0, QWORD PTR [rsi]
	divsd	xmm0, xmm6
	movapd	xmm2, xmm0
	andpd	xmm2, xmm1
	ucomisd	xmm5, xmm2
	jbe	.L193
	cvttsd2si	rax, xmm0
	pxor	xmm2, xmm2
	movsd	xmm7, QWORD PTR .LC13[rip]
	movapd	xmm3, xmm1
	andnpd	xmm3, xmm0
	cvtsi2sd	xmm2, rax
	movapd	xmm4, xmm2
	cmpnlesd	xmm4, xmm0
	andpd	xmm4, xmm7
	subsd	xmm2, xmm4
	orpd	xmm2, xmm3
	movapd	xmm0, xmm2
.L193:
	.loc 2 280 13 discriminator 1 view .LVU1063
	cvttsd2si	eax, xmm0
	.loc 2 281 40 view .LVU1064
	movsd	xmm0, QWORD PTR 8[rbx]
	divsd	xmm0, xmm6
	.loc 2 280 13 discriminator 1 view .LVU1065
	mov	DWORD PTR -44[rsp], eax
	.loc 2 281 40 view .LVU1066
	movapd	xmm2, xmm0
	andpd	xmm2, xmm1
	ucomisd	xmm5, xmm2
	jbe	.L194
	cvttsd2si	rax, xmm0
	pxor	xmm2, xmm2
	movsd	xmm4, QWORD PTR .LC13[rip]
	andnpd	xmm1, xmm0
	cvtsi2sd	xmm2, rax
	movapd	xmm3, xmm2
	cmpnlesd	xmm3, xmm0
	andpd	xmm3, xmm4
	subsd	xmm2, xmm3
	orpd	xmm2, xmm1
	movapd	xmm0, xmm2
.L194:
.LBE10184:
.LBE10188:
	.loc 2 241 23 view .LVU1067
	mov	rax, QWORD PTR .LC33[rip]
.LBB10189:
.LBB10185:
	.loc 2 281 13 discriminator 1 view .LVU1068
	cvttsd2si	ecx, xmm0
.LVL333:
.LBB10181:
.LBI10181:
	.file 22 "/usr/include/c++/13/bits/stl_pair.h"
	.loc 22 687 12 is_stmt 1 view .LVU1069
	.loc 22 687 12 is_stmt 0 view .LVU1070
.LBE10181:
.LBE10185:
.LBE10189:
	.loc 2 241 5 is_stmt 1 view .LVU1071
.LBB10190:
	.loc 2 244 14 is_stmt 0 view .LVU1072
	xor	r13d, r13d
.LBE10190:
	.loc 2 242 10 view .LVU1073
	xor	ebp, ebp
	mov	rdi, rbx
.LVL334:
	.loc 2 241 23 view .LVU1074
	mov	r12d, 1
	.loc 2 242 10 view .LVU1075
	mov	rbx, r10
	mov	r10d, r13d
	.loc 2 241 23 view .LVU1076
	mov	QWORD PTR [r14], rax
	.loc 2 242 5 is_stmt 1 view .LVU1077
.LVL335:
	.loc 2 244 5 view .LVU1078
.LBB10252:
	.loc 2 244 33 discriminator 1 view .LVU1079
.L209:
.LBB10191:
	.loc 2 245 7 view .LVU1080
.LBB10192:
	.loc 2 245 16 is_stmt 0 view .LVU1081
	mov	esi, r10d
	mov	r11d, ecx
	mov	rax, rbx
	neg	esi
.LVL336:
	.loc 2 245 33 is_stmt 1 discriminator 1 view .LVU1082
	sub	r11d, r10d
	mov	DWORD PTR -12[rsp], esi
	.loc 2 245 16 is_stmt 0 view .LVU1083
	mov	r9d, esi
	mov	ebx, r11d
.LVL337:
	.loc 2 245 16 view .LVU1084
	mov	esi, ecx
.LVL338:
	.loc 2 245 16 view .LVU1085
	mov	r11d, ebp
	mov	rbp, rax
.LVL339:
	.p2align 4,,10
	.p2align 3
.L195:
.LBB10193:
	.loc 2 246 35 is_stmt 1 discriminator 1 view .LVU1086
.LBB10194:
	.loc 2 247 46 is_stmt 0 view .LVU1087
	mov	r8d, r9d
.LBB10195:
.LBB10196:
	.loc 2 286 12 view .LVU1088
	mov	eax, ebx
	mov	DWORD PTR -24[rsp], ebx
.LBE10196:
.LBE10195:
.LBE10194:
	.loc 2 246 18 view .LVU1089
	mov	ecx, DWORD PTR -12[rsp]
.LBB10246:
	.loc 2 247 46 view .LVU1090
	neg	r8d
.LBB10200:
.LBB10197:
	.loc 2 286 12 view .LVU1091
	mov	QWORD PTR -56[rsp], rax
	mov	ebx, esi
	mov	DWORD PTR -20[rsp], r9d
.LBE10197:
.LBE10200:
	.loc 2 247 46 view .LVU1092
	cmovs	r8d, r9d
	jmp	.L205
.LVL340:
	.p2align 4,,10
	.p2align 3
.L196:
	.loc 2 247 46 view .LVU1093
.LBE10246:
	.loc 2 246 9 is_stmt 1 discriminator 2 view .LVU1094
	add	ecx, 1
.LVL341:
	.loc 2 246 35 discriminator 1 view .LVU1095
	cmp	ecx, r12d
	je	.L235
.L205:
.LBB10247:
	.loc 2 247 11 view .LVU1096
.LBB10201:
.LBI10201:
	.loc 17 257 5 view .LVU1097
.LBE10201:
	.loc 2 247 32 is_stmt 0 view .LVU1098
	mov	eax, ecx
	neg	eax
	cmovs	eax, ecx
.LBB10203:
.LBB10202:
	.loc 17 262 7 view .LVU1099
	cmp	eax, r8d
	cmovl	eax, r8d
.LBE10202:
.LBE10203:
	.loc 2 247 11 discriminator 1 view .LVU1100
	cmp	eax, r10d
	jne	.L196
	.loc 2 251 11 is_stmt 1 view .LVU1101
.LVL342:
.LBB10204:
.LBI10195:
	.loc 2 284 23 view .LVU1102
.LBB10198:
	.loc 2 285 5 view .LVU1103
.LBE10198:
.LBE10204:
	.loc 2 251 42 is_stmt 0 view .LVU1104
	mov	eax, DWORD PTR -44[rsp]
	lea	esi, [rcx+rax]
.LVL343:
.LBB10205:
.LBB10199:
	.loc 2 286 40 view .LVU1105
	mov	rax, QWORD PTR -56[rsp]
	.loc 2 285 42 view .LVU1106
	sal	rsi, 32
.LVL344:
	.loc 2 286 40 view .LVU1107
	xor	rsi, rax
.LVL345:
	.loc 2 286 40 view .LVU1108
.LBE10199:
.LBE10205:
.LBB10206:
.LBI10206:
	.file 23 "/usr/include/c++/13/bits/unordered_map.h"
	.loc 23 886 7 is_stmt 1 view .LVU1109
.LBB10207:
.LBI10207:
	.file 24 "/usr/include/c++/13/bits/hashtable.h"
	.loc 24 1687 5 view .LVU1110
.LBB10208:
.LBB10209:
.LBB10210:
.LBI10210:
	.loc 24 647 7 view .LVU1111
	.loc 24 647 7 is_stmt 0 view .LVU1112
.LBE10210:
	.loc 24 1692 7 discriminator 1 view .LVU1113
	cmp	QWORD PTR 40[r15], 0
	jne	.L197
.LVL346:
.LBB10211:
.LBB10212:
.LBI10212:
	.loc 24 627 7 is_stmt 1 view .LVU1114
.LBB10213:
.LBI10213:
	.loc 24 464 7 view .LVU1115
.LBB10214:
	.loc 24 465 62 is_stmt 0 view .LVU1116
	mov	rax, QWORD PTR 32[r15]
.LVL347:
	.loc 24 465 62 view .LVU1117
.LBE10214:
.LBE10213:
.LBB10215:
.LBI10215:
	.file 25 "/usr/include/c++/13/bits/hashtable_policy.h"
	.loc 25 483 7 is_stmt 1 view .LVU1118
.LBB10216:
.LBI10216:
	.loc 25 393 7 view .LVU1119
	.loc 25 393 7 is_stmt 0 view .LVU1120
.LBE10216:
.LBE10215:
.LBE10212:
	.loc 24 1694 35 is_stmt 1 discriminator 1 view .LVU1121
.LBB10217:
.LBI10217:
	.loc 24 635 7 view .LVU1122
.LBB10218:
.LBI10218:
	.loc 25 483 7 view .LVU1123
.LBB10219:
.LBI10219:
	.loc 25 393 7 view .LVU1124
	.loc 25 393 7 is_stmt 0 view .LVU1125
.LBE10219:
.LBE10218:
.LBE10217:
	.loc 24 1694 35 discriminator 2 view .LVU1126
	test	rax, rax
	jne	.L199
	jmp	.L196
	.p2align 4,,10
	.p2align 3
.L236:
	.loc 24 1694 4 is_stmt 1 discriminator 2 view .LVU1127
.LVL348:
.LBB10222:
.LBI10222:
	.loc 25 499 7 view .LVU1128
.LBB10223:
.LBI10223:
	.loc 25 397 7 view .LVU1129
.LBB10224:
.LBI10224:
	.loc 25 380 7 view .LVU1130
.LBB10225:
	.loc 25 381 53 is_stmt 0 view .LVU1131
	mov	rax, QWORD PTR [rax]
.LVL349:
	.loc 25 381 53 view .LVU1132
.LBE10225:
.LBE10224:
.LBE10223:
.LBE10222:
	.loc 24 1694 35 is_stmt 1 discriminator 1 view .LVU1133
.LBB10226:
	.loc 24 635 7 view .LVU1134
.LBB10221:
	.loc 25 483 7 view .LVU1135
.LBB10220:
	.loc 25 393 7 view .LVU1136
	.loc 25 393 7 is_stmt 0 view .LVU1137
.LBE10220:
.LBE10221:
.LBE10226:
	.loc 24 1694 35 discriminator 2 view .LVU1138
	test	rax, rax
	je	.L196
.L199:
.LVL350:
.LBB10227:
.LBI10227:
	.loc 25 1708 7 is_stmt 1 view .LVU1139
.LBB10228:
.LBI10228:
	.file 26 "/usr/include/c++/13/bits/stl_function.h"
	.loc 26 377 7 view .LVU1140
	.loc 26 377 7 is_stmt 0 view .LVU1141
.LBE10228:
.LBE10227:
	.loc 24 1695 6 discriminator 1 view .LVU1142
	cmp	rsi, QWORD PTR 8[rax]
	jne	.L236
.LVL351:
.L198:
	.loc 24 1695 6 discriminator 1 view .LVU1143
.LBE10211:
.LBE10209:
.LBE10208:
.LBE10207:
.LBE10206:
	.loc 2 256 11 is_stmt 1 view .LVU1144
.LBB10229:
.LBB10230:
.LBI10230:
	.loc 3 883 7 view .LVU1145
.LBB10231:
.LBI10231:
	.loc 4 1076 7 view .LVU1146
.LBB10232:
	.loc 4 1077 9 is_stmt 0 view .LVU1147
	mov	rdx, QWORD PTR 16[rax]
.LVL352:
	.loc 4 1077 9 view .LVU1148
.LBE10232:
.LBE10231:
.LBE10230:
.LBB10233:
.LBI10233:
	.loc 3 903 7 is_stmt 1 view .LVU1149
.LBB10234:
.LBI10234:
	.loc 4 1076 7 view .LVU1150
.LBB10235:
	.loc 4 1077 9 is_stmt 0 view .LVU1151
	mov	rsi, QWORD PTR 24[rax]
.LVL353:
	.loc 4 1077 9 view .LVU1152
.LBE10235:
.LBE10234:
.LBE10233:
	.loc 2 256 32 is_stmt 1 discriminator 1 view .LVU1153
	cmp	rsi, rdx
	je	.L196
.LBB10236:
.LBB10237:
.LBB10238:
	.loc 3 1148 25 is_stmt 0 view .LVU1154
	mov	rax, QWORD PTR [r15]
.LVL354:
	.loc 3 1148 25 view .LVU1155
	mov	r9, QWORD PTR [rax]
	.p2align 4,,10
	.p2align 3
.L204:
.LVL355:
	.loc 3 1148 25 view .LVU1156
.LBE10238:
.LBE10237:
	.loc 2 257 13 is_stmt 1 view .LVU1157
.LBB10240:
.LBI10237:
	.loc 3 1145 7 view .LVU1158
.LBE10240:
	.loc 2 257 77 is_stmt 0 view .LVU1159
	movsx	rax, DWORD PTR [rdx]
.LVL356:
	.loc 2 258 26 view .LVU1160
	movsd	xmm0, QWORD PTR [rdi]
	.loc 2 259 26 view .LVU1161
	movsd	xmm1, QWORD PTR 8[rdi]
.LBB10241:
.LBB10239:
	.loc 3 1148 34 view .LVU1162
	sal	rax, 4
.LVL357:
	.loc 3 1148 39 view .LVU1163
	add	rax, r9
.LVL358:
	.loc 3 1148 39 view .LVU1164
.LBE10239:
.LBE10241:
	.loc 2 258 13 is_stmt 1 view .LVU1165
	.loc 2 258 26 is_stmt 0 view .LVU1166
	subsd	xmm0, QWORD PTR [rax]
.LVL359:
	.loc 2 259 13 is_stmt 1 view .LVU1167
	.loc 2 259 26 is_stmt 0 view .LVU1168
	subsd	xmm1, QWORD PTR 8[rax]
.LVL360:
	.loc 2 260 13 is_stmt 1 view .LVU1169
	.loc 2 260 34 is_stmt 0 view .LVU1170
	mulsd	xmm0, xmm0
.LVL361:
	.loc 2 260 44 view .LVU1171
	mulsd	xmm1, xmm1
.LVL362:
	.loc 2 260 26 view .LVU1172
	addsd	xmm0, xmm1
.LVL363:
	.loc 2 261 13 is_stmt 1 view .LVU1173
	movsd	xmm1, QWORD PTR [r14]
	comisd	xmm1, xmm0
	jbe	.L202
	.loc 2 262 15 view .LVU1174
	.loc 2 262 33 is_stmt 0 view .LVU1175
	movsd	QWORD PTR [r14], xmm0
.LVL364:
	.loc 2 263 15 is_stmt 1 view .LVU1176
	.loc 2 264 15 view .LVU1177
	.loc 2 263 29 is_stmt 0 view .LVU1178
	movdqu	xmm7, XMMWORD PTR [rax]
	.loc 2 264 21 view .LVU1179
	mov	r11d, 1
	.loc 2 263 29 view .LVU1180
	movups	XMMWORD PTR 0[rbp], xmm7
.LVL365:
.L202:
	.loc 2 263 29 view .LVU1181
.LBE10236:
	.loc 2 256 11 is_stmt 1 discriminator 2 view .LVU1182
	.loc 2 256 32 discriminator 1 view .LVU1183
	add	rdx, 4
.LVL366:
	.loc 2 256 32 is_stmt 0 discriminator 1 view .LVU1184
	cmp	rsi, rdx
	jne	.L204
.LVL367:
	.loc 2 256 32 discriminator 1 view .LVU1185
.LBE10229:
.LBE10247:
	.loc 2 246 9 is_stmt 1 discriminator 2 view .LVU1186
	add	ecx, 1
	.loc 2 246 35 discriminator 1 view .LVU1187
	cmp	ecx, r12d
	jne	.L205
.LVL368:
	.p2align 4,,10
	.p2align 3
.L235:
	.loc 2 246 35 is_stmt 0 discriminator 1 view .LVU1188
.LBE10193:
	.loc 2 245 7 discriminator 2 view .LVU1189
	mov	r9d, DWORD PTR -20[rsp]
	mov	esi, ebx
	mov	ebx, DWORD PTR -24[rsp]
	.loc 2 245 7 is_stmt 1 discriminator 2 view .LVU1190
	add	r9d, 1
.LVL369:
	.loc 2 245 33 discriminator 1 view .LVU1191
	add	ebx, 1
	cmp	r9d, r12d
	jne	.L195
.LBE10192:
	.loc 2 270 7 is_stmt 0 view .LVU1192
	mov	rbx, rbp
	mov	ecx, esi
.LVL370:
	.loc 2 270 7 view .LVU1193
	mov	ebp, r11d
.LVL371:
	.loc 2 270 7 is_stmt 1 view .LVU1194
	test	r11b, r11b
	je	.L207
	.loc 2 270 40 is_stmt 0 discriminator 1 view .LVU1195
	movsd	xmm0, QWORD PTR 8[r15]
	.loc 2 270 64 discriminator 1 view .LVU1196
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, r10d
	.loc 2 270 51 discriminator 1 view .LVU1197
	mulsd	xmm0, xmm0
	.loc 2 270 64 discriminator 1 view .LVU1198
	mulsd	xmm0, xmm1
	.loc 2 270 73 discriminator 1 view .LVU1199
	mulsd	xmm0, xmm1
	.loc 2 270 17 discriminator 1 view .LVU1200
	comisd	xmm0, QWORD PTR [r14]
	ja	.L233
.L207:
	.loc 2 270 17 discriminator 1 view .LVU1201
.LBE10191:
	.loc 2 244 5 is_stmt 1 discriminator 2 view .LVU1202
	add	r10d, 1
.LVL372:
	.loc 2 244 33 discriminator 1 view .LVU1203
	add	r12d, 1
	cmp	r10d, 17
	jne	.L209
.LVL373:
.L233:
	.loc 2 244 33 is_stmt 0 discriminator 1 view .LVU1204
.LBE10252:
	.loc 2 276 3 view .LVU1205
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
.LVL374:
	.loc 2 276 3 view .LVU1206
	mov	eax, ebp
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
.LVL375:
	.loc 2 276 3 view .LVU1207
	pop	r15
	.cfi_def_cfa_offset 8
.LVL376:
	.loc 2 276 3 view .LVU1208
	ret
.LVL377:
	.p2align 4,,10
	.p2align 3
.L197:
	.cfi_restore_state
	.loc 2 276 3 view .LVU1209
	mov	r9, QWORD PTR 24[r15]
	.loc 25 528 22 view .LVU1210
	mov	rax, rsi
	xor	edx, edx
	div	r9
	.loc 24 1954 23 view .LVU1211
	mov	rax, QWORD PTR 16[r15]
	mov	QWORD PTR -40[rsp], r9
.LVL378:
	.loc 24 1954 23 view .LVU1212
	mov	r13, QWORD PTR [rax+rdx*8]
	.loc 25 528 22 view .LVU1213
	mov	QWORD PTR -32[rsp], rdx
.LVL379:
	.loc 24 1955 7 view .LVU1214
	test	r13, r13
	je	.L196
	.loc 24 1958 23 view .LVU1215
	mov	rax, QWORD PTR 0[r13]
.LVL380:
	.loc 26 378 20 view .LVU1216
	mov	DWORD PTR -16[rsp], r12d
.LVL381:
	.loc 26 378 20 view .LVU1217
	mov	r9, QWORD PTR 8[rax]
	.loc 25 1734 36 discriminator 1 view .LVU1218
	cmp	rsi, r9
	je	.L200
.LVL382:
.L237:
	.loc 24 1964 14 view .LVU1219
	mov	r12, QWORD PTR [rax]
	.loc 24 1964 21 view .LVU1220
	test	r12, r12
	je	.L232
.LVL383:
	.loc 25 1310 18 discriminator 1 view .LVU1221
	mov	r9, QWORD PTR 8[r12]
.LVL384:
	.loc 24 1966 13 view .LVU1222
	mov	r13, rax
	.loc 25 528 22 view .LVU1223
	xor	edx, edx
	mov	rax, r9
.LVL385:
	.loc 25 528 22 view .LVU1224
	div	QWORD PTR -40[rsp]
	.loc 24 1964 21 discriminator 2 view .LVU1225
	cmp	QWORD PTR -32[rsp], rdx
	jne	.L232
	.loc 24 1959 23 view .LVU1226
	mov	rax, r12
.LVL386:
	.loc 25 1734 36 discriminator 1 view .LVU1227
	cmp	rsi, r9
	jne	.L237
.LVL387:
.L200:
	.loc 24 817 53 view .LVU1228
	mov	rax, QWORD PTR 0[r13]
.LVL388:
	.loc 24 817 53 view .LVU1229
	mov	r12d, DWORD PTR -16[rsp]
.LVL389:
.LBB10253:
.LBB10251:
.LBB10250:
.LBB10249:
.LBB10248:
	.loc 2 252 11 is_stmt 1 view .LVU1230
.LBB10242:
.LBI10242:
	.loc 23 363 7 view .LVU1231
.LBB10243:
.LBI10243:
	.loc 24 635 7 view .LVU1232
.LBB10244:
.LBI10244:
	.loc 25 483 7 view .LVU1233
.LBB10245:
.LBI10245:
	.loc 25 393 7 view .LVU1234
	.loc 25 393 7 is_stmt 0 view .LVU1235
.LBE10245:
.LBE10244:
.LBE10243:
.LBE10242:
	.loc 2 252 11 discriminator 2 view .LVU1236
	test	rax, rax
	jne	.L198
	jmp	.L196
.LVL390:
	.p2align 4,,10
	.p2align 3
.L232:
	.loc 2 252 11 discriminator 2 view .LVU1237
	mov	r12d, DWORD PTR -16[rsp]
	jmp	.L196
.LBE10248:
.LBE10249:
.LBE10250:
.LBE10251:
.LBE10253:
	.cfi_endproc
.LFE6542:
	.size	_ZNK9GridIndex7nearestERK5PointRS0_Rd, .-_ZNK9GridIndex7nearestERK5PointRS0_Rd
