Return-Path: <linux-wireless+bounces-24379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15587AE5A46
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13731B648FA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7018DB0D;
	Tue, 24 Jun 2025 02:53:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBD5680;
	Tue, 24 Jun 2025 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750733582; cv=none; b=BJItydNeN2a8oyXPJ8S4TCUvZc9HOsxkGvxZRV4RLpa8Vy+NtVrxUxy7BGIy9KKRXgll4Nt2w2Blu1LEMZoQIb7SAgY3GCValS/f3bxNWJq0XEnukxav5ZEe8reEyiIyECdXHAmu1PlIJrpTvvWApwJVB1jNAl62FE8Dbz7p7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750733582; c=relaxed/simple;
	bh=vIpLd/cyAmz+XfQiCG2Jf/0TRUcsx5+tJCzFyFnQOAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k4qS4Vy57swjc/5YLxXbdDIHqfmGoXoKTfiUs12K0n0ApHX9Du24VdA5g20ABaM+r9HsfoAu3Nj9kc5zGBej0QW71DP4mc6u9Kc9eFMkGcTC7Y0g5Ekdwb3VAeav9ZxSK/Px+WQKRNNQsjagRZu9o2kPZdo50SwWO0BCcH6Flr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f899bfc50a611f0b29709d653e92f7d-20250624
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:631ce60d-ce78-4ba6-b1b5-e46cc1369294,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:631ce60d-ce78-4ba6-b1b5-e46cc1369294,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:0cad014a6960af960f8faa693fbd8d98,BulkI
	D:2506241052498Z90EC03,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102,TC:n
	il,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 4f899bfc50a611f0b29709d653e92f7d-20250624
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1603356935; Tue, 24 Jun 2025 10:52:47 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2] wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags
Date: Tue, 24 Jun 2025 10:52:40 +0800
Message-Id: <c68a8642c325f626ac34ccee71d9d9aa69f0c92c.1750733428.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This silences the following coccinelle warning:
  WARNING: sum of probable bitmasks, consider |

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
v2: just replace '+' by '|'. Keep spaces. 
---
 drivers/net/wireless/realtek/rtw88/coex.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 64904278ddad..b4dc6ff2c175 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -1501,28 +1501,28 @@ static u8 rtw_coex_algorithm(struct rtw_dev *rtwdev)
 		algorithm = COEX_ALGO_HFP;
 		break;
 	case           BPM_HID:
-	case BPM_HFP + BPM_HID:
+	case BPM_HFP | BPM_HID:
 		algorithm = COEX_ALGO_HID;
 		break;
-	case BPM_HFP           + BPM_A2DP:
-	case           BPM_HID + BPM_A2DP:
-	case BPM_HFP + BPM_HID + BPM_A2DP:
+	case BPM_HFP           | BPM_A2DP:
+	case           BPM_HID | BPM_A2DP:
+	case BPM_HFP | BPM_HID | BPM_A2DP:
 		algorithm = COEX_ALGO_A2DP_HID;
 		break;
-	case BPM_HFP                      + BPM_PAN:
-	case           BPM_HID            + BPM_PAN:
-	case BPM_HFP + BPM_HID            + BPM_PAN:
+	case BPM_HFP                      | BPM_PAN:
+	case           BPM_HID            | BPM_PAN:
+	case BPM_HFP | BPM_HID            | BPM_PAN:
 		algorithm = COEX_ALGO_PAN_HID;
 		break;
-	case BPM_HFP           + BPM_A2DP + BPM_PAN:
-	case           BPM_HID + BPM_A2DP + BPM_PAN:
-	case BPM_HFP + BPM_HID + BPM_A2DP + BPM_PAN:
+	case BPM_HFP           | BPM_A2DP | BPM_PAN:
+	case           BPM_HID | BPM_A2DP | BPM_PAN:
+	case BPM_HFP | BPM_HID | BPM_A2DP | BPM_PAN:
 		algorithm = COEX_ALGO_A2DP_PAN_HID;
 		break;
 	case                                BPM_PAN:
 		algorithm = COEX_ALGO_PAN;
 		break;
-	case                     BPM_A2DP + BPM_PAN:
+	case                     BPM_A2DP | BPM_PAN:
 		algorithm = COEX_ALGO_A2DP_PAN;
 		break;
 	case                     BPM_A2DP:
-- 
2.25.1


