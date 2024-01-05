Return-Path: <linux-wireless+bounces-1522-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D482524A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A705F1C22AC4
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48A24B21;
	Fri,  5 Jan 2024 10:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911D24213
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82ca52cb7a6d421c803db3c62f50c12c-20240105
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1522fc26-4557-46de-b103-d38af0d7bf16,IP:5,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.35,REQID:1522fc26-4557-46de-b103-d38af0d7bf16,IP:5,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:5d391d7,CLOUDID:e5a9d82e-1ab8-4133-9780-81938111c800,B
	ulkID:240105184547TTX7LNWT,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 82ca52cb7a6d421c803db3c62f50c12c-20240105
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2008004636; Fri, 05 Jan 2024 18:45:44 +0800
From: lilinmao <lilinmao@kylinos.cn>
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	kvalo@kernel.org,
	lilinmao <lilinmao@kylinos.cn>
Subject: [PATCH] wifi: rtw89: 8852b: fix cppcheck issues
Date: Fri,  5 Jan 2024 18:45:42 +0800
Message-Id: <20240105104542.463834-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppcheck reports
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1414:22: error: Array
 'iqk_info->iqk_mcc_ch[2][4]' accessed at index iqk_info->iqk_mcc_ch[2][*],
which is out of bounds. [arrayIndexOutOfBounds]
 iqk_info->iqk_mcc_ch[idx][path] = chan->channel;
                     ^
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1393:2: note: After for
loop, idx has value 2
 for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
 ^
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1414:22: note: Array index
out of bounds
 iqk_info->iqk_mcc_ch[idx][path] = chan->channel;
                     ^
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1424:38: error: Array
'iqk_info->iqk_mcc_ch[2][4]' accessed at index iqk_info->iqk_mcc_ch[2][*],
which is out of bounds. [arrayIndexOutOfBounds]
      idx, path, iqk_info->iqk_mcc_ch[idx][path]);
                                     ^
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1393:2: note: After for
loop, idx has value 2
 for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
 ^
drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c:1424:38: note: Array index
out of bounds
      idx, path, iqk_info->iqk_mcc_ch[idx][path]);
                                     ^

Fixes: f2abe804e823 ("wifi: rtw89: 8852b: rfk: add IQK")
Signed-off-by: lilinmao <lilinmao@kylinos.cn>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 259df67836a0..03dec3f4e7ba 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1388,17 +1388,15 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u
 	u32 reg_rf18;
 	u32 reg_35c;
 	u8 idx;
-	u8 get_empty_table = false;
 
 	for (idx = 0; idx < RTW89_IQK_CHS_NR; idx++) {
 		if (iqk_info->iqk_mcc_ch[idx][path] == 0) {
-			get_empty_table = true;
 			break;
 		}
 	}
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK] (1)idx = %x\n", idx);
 
-	if (!get_empty_table) {
+	if (idx > RTW89_IQK_CHS_NR - 1) {
 		idx = iqk_info->iqk_table_idx[path] + 1;
 		if (idx > 1)
 			idx = 0;
-- 
2.25.1


