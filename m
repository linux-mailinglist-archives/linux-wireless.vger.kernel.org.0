Return-Path: <linux-wireless+bounces-4762-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789D87C185
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887DA1C20956
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBBD74297;
	Thu, 14 Mar 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+AsQ4W7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WUrNFzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59D7351E
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434939; cv=none; b=Mw74VRnhNhiSKmooMIo9IwFhrMWTwvqDAO4u3BZgHnhaPQ6e5BUt7DP1QaLeFZI6XN6bGa36uOxh1DbDGWgzhOOrEzvvnuMQjg125AGhYaY3SiaEc/89ZXzi2EKbAyMWy0TKZ1XoPCtpmXaLy6xZ6CzD5FANneu0IwbuSBszq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434939; c=relaxed/simple;
	bh=k3KT+RO5FUXsJhQKwMyx8PhStYOkk66SuJIZU5HB2NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nx8T7jwwAxmPX5OShEIk4xdOPcjW8BlnEOkZ3juIkc6kLArOc+/r+B+rlyIneeEX5t4+spwH+npRh8dSXjihdRp+a+SeUF2qIdHZXfzsT7EhNaUv4sTMYmh1ne9N376EzA+UgfwpAqO6mBjIohuu6k+PetpN4rTweKnyxe96mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+AsQ4W7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WUrNFzz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710434935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iCV839v/J5uj5+FnYht3eBGwYOtBew+Ek4jD2ITaim4=;
	b=I+AsQ4W7QlxICKgAIMx7pznpNKydUuOFiUcXsvo2U7s5GngRYnjW2W8M3nJhIWsWh7snEU
	SywiI47NlL5Zg/VlJFLgIqBl37z62l7Eq/ka67TEcEVbhu6tHcrs3diN2V27DxuLFbV13F
	xs3LIZLWjHygEhtLSRGxLjAiTZJcCMe8EJo0CUZaFkKOoYv3tr4v6gS1UHdaCvo93EZ3p8
	REzSIqJ+yfn++mSW6dz1fB+Wvcjw4FtK3RoPh52JR9IpL/S1T9pC9orUSe8hp4B+xN4ErA
	qfNGMLKS8m2bMnNVD+AM2IdU6LOzbs13clcWM5Sa9Xr2Bkv1iAUl9l5/TjxoeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710434935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iCV839v/J5uj5+FnYht3eBGwYOtBew+Ek4jD2ITaim4=;
	b=2WUrNFzzZv2XkxuIhZi1HCIKshBl86Z1GbbxY+D4p5H2PaiaF6wqMaFxQQH8LsJnk1UloI
	YU5WlfVNv7he2ACQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] wifi: rtl8xxxu: enable MFP support
Date: Thu, 14 Mar 2024 17:48:50 +0100
Message-Id: <20240314164850.86432-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to connect to networks which require 802.11w, add the
MFP_CAPABLE flag and let mac80211 do the actual crypto in software.

When a robust management frames is received, rx_dec->swdec is not set,
even though the HW did not decrypt it. Extend the check and don't set
RX_FLAG_DECRYPTED for these frames in order to use SW decryption.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 4a49f8f9d80f2..870bd952f5902 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6473,7 +6473,9 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec)
+			if (!rx_desc->swdec &&
+			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
+			      ieee80211_has_protected(hdr->frame_control)))
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -6578,7 +6580,9 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec)
+			if (!rx_desc->swdec &&
+			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
+			      ieee80211_has_protected(hdr->frame_control)))
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -7998,6 +8002,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
-- 
2.39.2


