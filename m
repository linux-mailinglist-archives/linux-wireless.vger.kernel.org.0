Return-Path: <linux-wireless+bounces-4580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D77878C61
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 02:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2295C1C20429
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276995684;
	Tue, 12 Mar 2024 01:38:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EE9567D
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207526; cv=none; b=aX6W4G/H/iua4ZJyFe1b5QY8KMlhA7ecPx2/YiUUL5hHoRPMnplvkhVpRbUVH8yvvQJ5Ea3TuhctmdzFb9MFrC6eigSHZ7nlZZdoEXhwZQCLPx51l++tJiSFBQSazu6EBrIJdEzG5M2H+CQlfddlxy/PhA7TSKknDCd5huAk+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207526; c=relaxed/simple;
	bh=QN4GAcF7WSPxlYdd4ZCr9Vq1rs+oSpdZJgQOUy/yMmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8VjFWXXWevsE9fAzXt/1lb3ZpOrDPIOONY83aWv5WXhT/QDsfc4tcS4bQFmpuxJbA6qNqm18B9o90NBdaUsfBHGBhUyQq5x3DtU0/8hH4mGP/LCIdxiUWUsID5kTYpvb8f5WeVZ0EHsHgxIC7PHx8TU/O7Y+rqnNxMv+NxmDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42C1ccq073941705, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42C1ccq073941705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 09:38:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 09:38:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 12 Mar
 2024 09:38:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/6] wifi: rtw89: coex: Add TDMA version 7
Date: Tue, 12 Mar 2024 09:37:18 +0800
Message-ID: <20240312013721.17452-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312013721.17452-1-pkshih@realtek.com>
References: <20240312013721.17452-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Ching-Te Ku <ku920601@realtek.com>

In order to packet up the slots information, the TLV header has updated.
TDMA also use the TLV header to packet up to H2C, so upgrade to version 7.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 57bf23d1adc7..306846f3ef11 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -219,6 +219,13 @@ struct rtw89_btc_btf_tlv {
 	u8 val[];
 } __packed;
 
+struct rtw89_btc_btf_tlv_v7 {
+	u8 type;
+	u8 ver;
+	u8 len;
+	u8 val[];
+} __packed;
+
 enum btc_btf_set_report_en {
 	RPT_EN_TDMA,
 	RPT_EN_CYCLE,
@@ -1210,7 +1217,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 		if (ver->fcxtdma == 1) {
 			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v1;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v1);
-		} else if (ver->fcxtdma == 3) {
+		} else if (ver->fcxtdma == 3 || ver->fcxtdma == 7) {
 			pfinfo = &pfwinfo->rpt_fbtc_tdma.finfo.v3;
 			pcinfo->req_len = sizeof(pfwinfo->rpt_fbtc_tdma.finfo.v3);
 		} else {
@@ -1486,7 +1493,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 				     memcmp(&dm->tdma_now,
 					    &pfwinfo->rpt_fbtc_tdma.finfo.v1,
 					    sizeof(dm->tdma_now)));
-		else if (ver->fcxtdma == 3)
+		else if (ver->fcxtdma == 3 || ver->fcxtdma == 7)
 			_chk_btc_err(rtwdev, BTC_DCNT_TDMA_NONSYNC,
 				     memcmp(&dm->tdma_now,
 					    &pfwinfo->rpt_fbtc_tdma.finfo.v3.tdma,
@@ -1727,6 +1734,7 @@ static void _parse_btc_report(struct rtw89_dev *rtwdev,
 }
 
 #define BTC_TLV_HDR_LEN 2
+#define BTC_TLV_HDR_LEN_V7 3
 
 static void _append_tdma(struct rtw89_dev *rtwdev)
 {
@@ -1734,6 +1742,7 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_btf_tlv *tlv;
+	struct rtw89_btc_btf_tlv_v7 *tlv_v7;
 	struct rtw89_btc_fbtc_tdma *v;
 	struct rtw89_btc_fbtc_tdma_v3 *v3;
 	u16 len = btc->policy_len;
@@ -1753,6 +1762,13 @@ static void _append_tdma(struct rtw89_dev *rtwdev)
 		tlv->len = sizeof(*v);
 		*v = dm->tdma;
 		btc->policy_len += BTC_TLV_HDR_LEN + sizeof(*v);
+	} else if (ver->fcxtdma == 7) {
+		tlv_v7 = (struct rtw89_btc_btf_tlv_v7 *)&btc->policy[len];
+		tlv_v7->len = sizeof(dm->tdma);
+		tlv_v7->ver = ver->fcxtdma;
+		tlv_v7->type = CXPOLICY_TDMA;
+		memcpy(tlv_v7->val, &dm->tdma, tlv_v7->len);
+		btc->policy_len += BTC_TLV_HDR_LEN_V7 + tlv_v7->len;
 	} else {
 		tlv->len = sizeof(*v3);
 		v3 = (struct rtw89_btc_fbtc_tdma_v3 *)&tlv->val[0];
-- 
2.25.1


