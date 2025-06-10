Return-Path: <linux-wireless+bounces-23933-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9188AD3883
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9680D1E00AB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A62E62C7;
	Tue, 10 Jun 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="N5KRtUgW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49E2E62BD
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560488; cv=none; b=c0lBxULbSvEVVoxBANssxYIYSxfeEY2OvvkoK+Wgebl3BhtD889zzUB3T55WH4bOjY6Pm0E4PQqFu+AOvA3Sq+9t1FuVo061bL2dF82XypyL8/P03h+uhWVlv0T7RdLiVE0v6fBYMtnr4ngVG+PQ9rWU8CDpBsniGJJEkQO2x1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560488; c=relaxed/simple;
	bh=uq29NcBOdnh9BZhibvLSIaHPgXaOI6bNTchinv4zeto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0pdyPiI2ii+Npt9odrxUnuVUoC/5jx2+Dxn7xWb7bF/sN2vrEYi28XU5bCrEkBAo5pqQ7DymsQV2LJrPtKmEsKfNcGv/iHhChayuE8x3kbgSHEUSc7cVbpbAe1gP6aT4CQpPLVkFF68ziNz/DDg/m98YqHyoFY6j6Uzr+RPTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=N5KRtUgW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD1NDZ02995491, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560483; bh=DZvogHduz9L14K6IKOYgtLwevs10ZwccjUjSBt+FLbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=N5KRtUgW7J6Heu8p6pC6DUb60v3F2lf1vimxhkHhNsSPF05UTgsArBsrLZYoiM6js
	 q3qIVY1INr9VjHPZhM5pzgMyairaX4V3LlFyKwRmIvl+k5CxreyWztHh6JDQjNGoS7
	 y4SK8k+FT0pUV14FY5Gl0n2WVbFlVTaUFJgtHEDLz3vopqLC3kwNtsEkAGuc/K09zV
	 FKgrOvyq07kGj2eKB5Y1aUq01efqgmoffQBDpb6wbWOOUvtdXBaaB0vSCrAFGxcQ+4
	 aKDAFtIZmRJppRTHefsRjfERQh2h7zRVijC27nrqMdC1V9AqXdt5izx+AVFTTgT69w
	 T6oGnUx/Qbuww==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD1NDZ02995491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:24 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 06/12] wifi: rtw89: TX nulldata 0 after scan complete
Date: Tue, 10 Jun 2025 21:00:28 +0800
Message-ID: <20250610130034.14692-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

HW scan leak to TX nulldata 0 to AP after scan completed, which allowed
AP start to TX packet to us. Therefore, driver TX nulldata 0 after scan
completed.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 130e89743991..9c4360df77f1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5205,6 +5205,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_bss_conf *bss_conf;
 	struct rtw89_bb_ctx *bb;
+	int ret;
 
 	if (!rtwvif_link)
 		return;
@@ -5224,6 +5225,14 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	rtw89_phy_config_edcca(rtwdev, bb, false);
 	rtw89_tas_scan(rtwdev, false);
 
+	if (hw_scan) {
+		ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, false, false,
+					       RTW89_SCAN_NULL_TIMEOUT);
+		if (ret)
+			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+				    "scan send null-0 failed: %d\n", ret);
+	}
+
 	rtwdev->scanning = false;
 	rtw89_for_each_active_bb(rtwdev, bb)
 		bb->dig.bypass_dig = true;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ce2f13313826..c017bdaf0500 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3440,6 +3440,8 @@ struct rtw89_tx_skb_data {
 	u8 hci_priv[];
 };
 
+#define RTW89_SCAN_NULL_TIMEOUT 30
+
 #define RTW89_ROC_IDLE_TIMEOUT 500
 #define RTW89_ROC_TX_TIMEOUT 30
 enum rtw89_roc_state {
-- 
2.25.1


