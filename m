Return-Path: <linux-wireless+bounces-26109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C7EB199D0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EEAE3B07B1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC291EB5DD;
	Mon,  4 Aug 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VyTRaM/s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89841B532F
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 01:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270626; cv=none; b=r1zzvNIgiWrcbKoMeoBxVAjxYUa5MQaLJRxKC5nZyHH1So/6MsrT1y9ADv7hqF4IQ9fHpPaDLE0N8SnabMrkMYgVKggSfBiieYRwca/Jg8CdyAq3sO4HqhGAEV+uspuDxQhvUdyMVcEleJfqqAq1fq2lLCELb423Pgflk7hroRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270626; c=relaxed/simple;
	bh=vBHRwyHm8mIWjVPWMBpz3SeuV3Hi/EgXV8hnJFeTAHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFzPcDfNdXIiVeLJ2/GXMBdEFmfGdrQ811T87MD2mn/5qN9tUAPO0xsXYfjMfh0j2zazRhw+Z7s+PsZ2XlVf4t5s0SOvJ7i9vIMzZ8ybTlUs145SoaxFXhQQZUJ1b7TKnu4lccZc/rKX0CoWBJ5TOVS2MpdEuYS1K1Nq6w95N08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VyTRaM/s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741NN9Z03190118, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754270603; bh=Lxo9/fWdj7nvZNyGneVBKtrQ1uQhkz0cZ83LzUaUAQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VyTRaM/skcct0q3VOgAq1VsKX6L+ph51rillltkfL9FKKaYcaMDdJ7FOd5LqPP/RD
	 kffOzE8PC3Npj2zDEVaD0npK9JYXSxBigEL/4H4oVM1HIS3IdWBXLqGT1zH7c193R6
	 ma+s//7AkEYdlubIzMfMPqCZTjnR3LCDeVbZbG9m2PCzq8T0cDSh4RdTxw/sFwzmwE
	 uPeH4BIfRUQoMOHUgkKsQBO3bPNaRTo5Gb3pLRWzDQalxwpSkEBFkpmL/uPiucO6mX
	 tq0rhA/0Apm8bbYYBedHIJtWB4IAHv7poLiNpKMBGnGcCHaLHivKXleuNHNhcnq612
	 vZF2e4gFp+sQA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741NN9Z03190118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:23:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:23:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Aug
 2025 09:23:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>, <sean.anderson@linux.dev>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: add dummy C2H handlers for BCN resend and update done
Date: Mon, 4 Aug 2025 09:22:34 +0800
Message-ID: <20250804012234.8913-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250804012234.8913-1-pkshih@realtek.com>
References: <20250804012234.8913-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Two C2H events are not listed, and driver throws

  MAC c2h class 0 func 6 not support
  MAC c2h class 1 func 3 not support

Since the implementation in vendor driver does nothing, add two dummy
functions for them.

Reported-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Closes: https://lore.kernel.org/linux-wireless/d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com/
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 13 ++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ef17a307b770..33a7dd9d6f0e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5235,6 +5235,11 @@ rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
 }
 
+static void
+rtw89_mac_c2h_bcn_upd_done(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static void
 rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 			   u32 len)
@@ -5257,6 +5262,11 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 	rtw89_complete_cond(wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_bcn_resend(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static void
 rtw89_mac_c2h_tx_duty_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
 {
@@ -5646,7 +5656,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_EFUSE_DUMP] = NULL,
 	[RTW89_MAC_C2H_FUNC_READ_RSP] = NULL,
 	[RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP] = rtw89_mac_c2h_pkt_ofld_rsp,
-	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
+	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = rtw89_mac_c2h_bcn_resend,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
 	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
 	[RTW89_MAC_C2H_FUNC_TX_DUTY_RPT] = rtw89_mac_c2h_tx_duty_rpt,
@@ -5661,6 +5671,7 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
 	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
 	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
+	[RTW89_MAC_C2H_FUNC_BCN_UPD_DONE] = rtw89_mac_c2h_bcn_upd_done,
 };
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 241e89983c4a..25fe5e5c8a97 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -419,6 +419,7 @@ enum rtw89_mac_c2h_info_func {
 	RTW89_MAC_C2H_FUNC_DONE_ACK,
 	RTW89_MAC_C2H_FUNC_C2H_LOG,
 	RTW89_MAC_C2H_FUNC_BCN_CNT,
+	RTW89_MAC_C2H_FUNC_BCN_UPD_DONE = 0x06,
 	RTW89_MAC_C2H_FUNC_INFO_MAX,
 };
 
-- 
2.25.1


