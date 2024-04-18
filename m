Return-Path: <linux-wireless+bounces-6502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1F8A93DC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B6F281C57
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7986A353;
	Thu, 18 Apr 2024 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q8Nc4tUH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKkbkvm5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A33BB22;
	Thu, 18 Apr 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424701; cv=none; b=P3Zyu1+672E2aVIGmiuLV6ozMhAGqQ30AMhy5uCaJkEacIlTTp8QMiyGj6FDClVIl2yfw+LbQhIf3kxbjIcv3Op98qXqOxn/nZWyuLDdIAqCJR6YtaJMPW01nwehYYszm3Ml0fMWLpq/B14f6kC4xPh90yiXihWbjBWu/gJrIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424701; c=relaxed/simple;
	bh=kSmybSuk0Gp2zGe5jwz7Jb8ibYlAi+O173JdALK0pq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fw+1LLEjQUzuVf6zusrByZtOED89WJlXWvVuN1MIutPfJMZRFy6QIDUmy/lfZcSODEPnb+kiiMRNumw2X+V1Lkbvd3AXZOJxQYL210j/783RTiKcdWRgA5CuPtSdOnRhDifMQ8TEW5U2remsut/mmaVMaysdzX4YPVifkq99q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q8Nc4tUH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKkbkvm5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSz9EbV7Go68IjIBCLe7KIpM4jH0XbRpBsMopvgUL94=;
	b=q8Nc4tUHS+Q9yVd9fEKFGqHJ+6YxrKc67hNgFqr1IeQHBalKGY02w+O0aK//gDJ4VpfPoy
	HfY+dcMbNOLfnC0yNTlbqC8CX5F84NeV2ewrY0qeuzp1M3l9kvYxhi2P6JDyIJkgkTqAq9
	jEUylCXEG7HqY8gi8uOGaSDU7Esa/MsG2A7HimiAm5rDAScEceO8LC00k2l3glQpgImLp8
	t6bDZiZ72ONQvT/WUMnTOVzngcEzf7W4rKxuiKW/OClFPQ9dYZZt8mKjX55qZozJo2un5h
	pH/vzFSOvXf4Ud8BhcSsrlkl/46h0oEfoH4noT3iZOrb54VtXYWcBKn1eiKxvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSz9EbV7Go68IjIBCLe7KIpM4jH0XbRpBsMopvgUL94=;
	b=uKkbkvm5VlkGy4orVzzaPS5Murapo+W4ORkkoZ25fkDPvJJS/+MuwFFcka8NPh9Fh/3P0R
	VGNETJDT+XSdRgAA==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor
Date: Thu, 18 Apr 2024 09:18:13 +0200
Message-Id: <20240418071813.1883174-3-martin.kaistra@linutronix.de>
In-Reply-To: <20240418071813.1883174-1-martin.kaistra@linutronix.de>
References: <20240418071813.1883174-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to connect to networks which require 802.11w, add the
MFP_CAPABLE flag and let mac80211 do the actual crypto in software.

When a robust management frame is received, rx_dec->swdec is not set,
even though the HW did not decrypt it. Extend the check and don't set
RX_FLAG_DECRYPTED for these frames in order to use SW decryption.

Use the security flag in the RX descriptor for this purpose, like it is
done in the rtw88 driver.

Cc: stable@vger.kernel.org
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      | 9 +++++++++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 7 +++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index fd92d23c43d91..16d884a3d87df 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -122,6 +122,15 @@ enum rtl8xxxu_rx_type {
 	RX_TYPE_ERROR = -1
 };
 
+enum rtl8xxxu_rx_desc_enc {
+	RX_DESC_ENC_NONE	= 0,
+	RX_DESC_ENC_WEP40	= 1,
+	RX_DESC_ENC_TKIP_WO_MIC	= 2,
+	RX_DESC_ENC_TKIP_MIC	= 3,
+	RX_DESC_ENC_AES		= 4,
+	RX_DESC_ENC_WEP104	= 5,
+};
+
 struct rtl8xxxu_rxdesc16 {
 #ifdef __LITTLE_ENDIAN
 	u32 pktlen:14;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 4a49f8f9d80f2..b15a30a54259e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6473,7 +6473,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec)
+			if (!rx_desc->swdec &&
+			    rx_desc->security != RX_DESC_ENC_NONE)
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -6578,7 +6579,8 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec)
+			if (!rx_desc->swdec &&
+			    rx_desc->security != RX_DESC_ENC_NONE)
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -7998,6 +8000,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
-- 
2.39.2


