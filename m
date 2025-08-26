Return-Path: <linux-wireless+bounces-26625-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE25B357B9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 10:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDECA17DD5D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DD12FD1A1;
	Tue, 26 Aug 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KncW2Bt6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DA28371
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756198522; cv=none; b=iwTS564j93eatrOugH+tLymS3RzXVzf4gXtWtR4aln70XWfHZyHRZuDF7BKJ1BimMK5wRw0PTwIuMIeeQ9/jmySD90Cq7nMXw7zeYuXcrf8aPui9FLMSxVQZlgtA+cjOz7ksB2tj4yn6KsDA8drDBrdj/vufWlj2cbykysIi1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756198522; c=relaxed/simple;
	bh=aPLIkIMnl3j5npODvjfDMl+hXkulS7vNEuKSrwUCeko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMG4YyxEG8txsgJu7MGGwC2IelZMh4HdslptPvp7KtsFSaZC+kQZKyMGdjYx4NvSdCQSSL2tBSVKBMByughGU/jo0o6gv+5SgrjAQnrls7CESGziQvA1FDZQ0Cp2LzuVEqOnMmQiH59ODF3LTHOr6ZykxwjHZKIp4U+9/Cjk/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KncW2Bt6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57Q8tIwO51264588, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756198518; bh=7U5Gi5R6CHGj7C2Vv5TpGUQo1nUgEXl1kqteS5LTaHc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KncW2Bt6LG7Gjh+kdLZIpPdhsqXxA8/EDnsi6t57rSeKnT7g/n7kr1k7c6q/ZpAYu
	 Nk+TyhVrVSJ4zTsZTQP8Ycr4YepHG77DCrSFrsyCJ0JJz/T1YUN2X7pRn14wmFdJ2V
	 EraWeYIA/N/lXvRfJDJkQzQOffU+sroC186NDixcjmhm9jUf63SKctSBQIKmOtknHL
	 QcjEKUmb4nDkiQwWGbGfKbjjugKHy7ZtRq4hTRRg6Cna39RNEU3nwyh4rnFV+dnun5
	 0x6iRVq9px7GH+QZ1Bp5Gc/xGk29LTffztiCCAL8mShr0POJZ0qPvybKoCyEVVCqL/
	 HxutzURXB/UWA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57Q8tIwO51264588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:55:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 26 Aug 2025 16:55:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Tue, 26 Aug
 2025 16:55:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 10/10] wifi: rtw89: add getting function of DMA channel v1
Date: Tue, 26 Aug 2025 16:54:24 +0800
Message-ID: <20250826085424.28713-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826085152.28164-1-pkshih@realtek.com>
References: <20250826085152.28164-1-pkshih@realtek.com>
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

The coming RTL8922DE uses new mapping of DMA channel. Add it accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 625baa0cb63c..20d8f2221f81 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -737,6 +737,28 @@ u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 }
 EXPORT_SYMBOL(rtw89_core_get_ch_dma);
 
+u8 rtw89_core_get_ch_dma_v1(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	switch (qsel) {
+	default:
+		rtw89_warn(rtwdev, "Cannot map qsel to dma v1: %d\n", qsel);
+		fallthrough;
+	case RTW89_TX_QSEL_BE_0:
+	case RTW89_TX_QSEL_BK_0:
+		return RTW89_TXCH_ACH0;
+	case RTW89_TX_QSEL_VI_0:
+	case RTW89_TX_QSEL_VO_0:
+		return RTW89_TXCH_ACH2;
+	case RTW89_TX_QSEL_B0_MGMT:
+	case RTW89_TX_QSEL_B0_HI:
+		return RTW89_TXCH_CH8;
+	case RTW89_TX_QSEL_B1_MGMT:
+	case RTW89_TX_QSEL_B1_HI:
+		return RTW89_TXCH_CH10;
+	}
+}
+EXPORT_SYMBOL(rtw89_core_get_ch_dma_v1);
+
 static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 22f7fb30ff96..ecfbcff85047 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7451,6 +7451,7 @@ void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
 u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel);
+u8 rtw89_core_get_ch_dma_v1(struct rtw89_dev *rtwdev, u8 qsel);
 void rtw89_core_rx(struct rtw89_dev *rtwdev,
 		   struct rtw89_rx_desc_info *desc_info,
 		   struct sk_buff *skb);
-- 
2.25.1


