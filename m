Return-Path: <linux-wireless+bounces-14630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFCA9B4559
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 10:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D8C1F2333F
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918020403A;
	Tue, 29 Oct 2024 09:12:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F8204037;
	Tue, 29 Oct 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193140; cv=none; b=BkwLsjkYxNoffyf2O0iCdwlpMotGekuBq1VNDwkq8tcIn2iyL0GrtXuwVJ0ILSiymb0TZFPkCzD1zNQaKPBFWNycBkTV/z8diu+d6K08CwblZzVU8WYVtxuga5dghnp3hn7JShrEIjqfZowkNff3QbBgGF3uFU7w0Ohjgl5Vd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193140; c=relaxed/simple;
	bh=F/rVR4l5Scy7U0//a0Uhui1AH5VjS0Dg/jmTcL8ws14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b+NSfhGKSyhLc5HvoQ9FKbO60q+RWqjDpMFHw5sd/Q/stnJDiYRwTSN3sTSlolYqpp1elKcKccVZ1YCjRGSmtU6EJk4+C7dKihlxMSwkLgWYTHzCjA1YkM4ZsRwPzlbFG4FuRGPwJ6vVLeojiBGqvJep62HUXaHuqYfLLXJMakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: deb7e8c495d511efa216b1d71e6e1362-20241029
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fea1eefe-9061-43ed-9117-463ccb5cf6bd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:fea1eefe-9061-43ed-9117-463ccb5cf6bd,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:9defbc8387e5e00f07b5071d8410f52e,BulkI
	D:241029171208PR0B2CCJ,BulkQuantity:0,Recheck:0,SF:66|841|38|17|19|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: deb7e8c495d511efa216b1d71e6e1362-20241029
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1551847879; Tue, 29 Oct 2024 17:12:06 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: xiaopeitux@foxmail.com,
	xiongxin@kylinos.cn,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] net: wireless: realtek/rtw89: Add check null return of kmalloc
Date: Tue, 29 Oct 2024 17:12:01 +0800
Message-Id: <82dd45fe7faed8f558841643a0593202b2da90c5.1730192926.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmalloc may fail, return might be NULL and will cause
NULL pointer dereference later.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
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


