Return-Path: <linux-wireless+bounces-14709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7709B5A4B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 04:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CE2B2268E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362B197A99;
	Wed, 30 Oct 2024 03:21:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC918B09
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258471; cv=none; b=Omd4I07eTCDVwwJrEbIQWbCK9HPf6Ekuv/Kl9ZjQuWknOX99bLWHu/38QF0HoasQI8qCsVbuv8wBHUg8y+ldHmXhXo2MxGtZK2VxPP59/j+/4HgMelCgC48I7yNARPjx5U4cRVEaZLVYQdde3tIYRdvr4kivlswfaRGhljjGcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258471; c=relaxed/simple;
	bh=hJPxHWJpubdyD/SQlgS3Wr98e1dBrkxri7idlScU/ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJDetbbvcV/e5Qr6QJKxaFRIlbekeB3VBSEXluF03by25ceOwUaMCsc+httcLPXA9J15dCOwGgJYT+chPKVZcT/xr34xLRPXb6947M3PvGv9+XmtVjvnfW1PIEqTMY9k6wns+nJKHXdW2qmUZ9R5bTyhm8sjwA3/iV+Gg6CrRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: feb317a0966d11efa216b1d71e6e1362-20241030
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ccaa3e00-ae1f-4022-870a-9b46314c1235,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.38,REQID:ccaa3e00-ae1f-4022-870a-9b46314c1235,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:c14fae5083d772b477341bc6d7019a28,BulkI
	D:241030112104BGATBMM1,BulkQuantity:0,Recheck:0,SF:17|19|66|841|102,TC:nil
	,Content:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: feb317a0966d11efa216b1d71e6e1362-20241030
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1891818310; Wed, 30 Oct 2024 11:21:04 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: xiaopei01@kylinos.cn
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	xiaopeitux@foxmail.com
Subject: [PATCH V2] wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()
Date: Wed, 30 Oct 2024 11:20:58 +0800
Message-Id: <516a91f3997534f708af43c7592cbafdd53dd599.1730253508.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmalloc may fail, return value might be NULL and will cause
NULL pointer dereference. Add check NULL return of kmalloc in
btc_fw_set_monreg().

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Fixes: b952cb0a6e2d ("wifi: rtw89: coex: Add register monitor report v7 format")
---
 drivers/net/wireless/realtek/rtw89/coex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b60c8bd4537b..092f882147cd 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2507,6 +2507,8 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 	if (ver->fcxmreg == 7) {
 		sz = struct_size(v7, regs, n);
 		v7 = kmalloc(sz, GFP_KERNEL);
+		if (!v7)
+			return;
 		v7->type = RPT_EN_MREG;
 		v7->fver = ver->fcxmreg;
 		v7->len = n;
@@ -2521,6 +2523,8 @@ static void btc_fw_set_monreg(struct rtw89_dev *rtwdev)
 	} else {
 		sz = struct_size(v1, regs, n);
 		v1 = kmalloc(sz, GFP_KERNEL);
+		if (!v1)
+			return;
 		v1->fver = ver->fcxmreg;
 		v1->reg_num = n;
 		memcpy(v1->regs, chip->mon_reg, flex_array_size(v1, regs, n));
-- 
2.34.1


