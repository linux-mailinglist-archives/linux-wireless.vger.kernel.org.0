Return-Path: <linux-wireless+bounces-6432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E668A7FB9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC691F22111
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72011327E5;
	Wed, 17 Apr 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0MiUKkD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/A7I8SO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42112FB3E;
	Wed, 17 Apr 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346449; cv=none; b=o22FmE9wmRHlRH8gkwtP3o2zwJgfW7mhebbi9rv0vYd4ljHts65tOejNn0/AseVCQPk0WkT2dLiuRzkvedK5ehuKb++io7csUd/RT6Na0SInDZB/C1tHBR0MDcyQ7QikSeHaQF0H0qlp6u4iEFaJU0wsOXxjff9Q3e6rtB5Ap44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346449; c=relaxed/simple;
	bh=kN90jndgiFO0MC3EhH/pmTsVnzp2fc8W39rYQDRB/HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leCwAaMOzwMF9WhS02B9qoX9yAvAd8oR7Ys4/JjqIyxe2upWUXXWS3IjJPn+Ygo0GRhfgA70fUOe9mAoHFAtEpfU4BOKShObQtj3pasUvSSEw/dVOLbtIjtU1wl070Syol2kpFcJQOLLwD2PU78r85yvGMrrha1zAZrpoU6HN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0MiUKkD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/A7I8SO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXHMgCoxkvQpet00Q19cxZJkOm1T4p+LzBOkMzDbXOE=;
	b=Q0MiUKkDHTYfWXT3LH1rsuYBwNEsZ4h/JYly1ASppJC4iFAiFuILpgcvBOjj1U5I1T717p
	lqHS2225EGbzHpq7VfKBKFmjKefk7QdJMGq1//hkid1eun3rw4z+rkUbL0iKzEdjXONu2U
	Plw1hyyqTMNIv1+xAxft29bYXsJWaRr2o++F5VAC9RNrWo8X4Mr2ZM2SsQ+O1NFblTOtuT
	tFRlUKfLuOABVa430G0qzYZTIhHBKD1i8pPkgRRdLT4gb7xvcHUfsnCtTstleUx7uGi9cQ
	YnB16FF777MtAsRXu2gqcvr79CyzDeORtbEdnF1zxxeJxyveifNor8TZ/a43tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXHMgCoxkvQpet00Q19cxZJkOm1T4p+LzBOkMzDbXOE=;
	b=c/A7I8SOMI3vyvSmsclkbn2uLOeRruiCLrU3ZeV022vdkIHCQyvoKTmSrjPdG6ZekeLkv5
	fWXj5Hh68F+eq/CQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: rtl8xxxu: enable MFP support
Date: Wed, 17 Apr 2024 11:33:52 +0200
Message-Id: <20240417093352.1840632-3-martin.kaistra@linutronix.de>
In-Reply-To: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
References: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
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
index fd92d23c43d91..4f2615dbfd0f0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -122,6 +122,15 @@ enum rtl8xxxu_rx_type {
 	RX_TYPE_ERROR = -1
 };
 
+enum rtw_rx_desc_enc {
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


