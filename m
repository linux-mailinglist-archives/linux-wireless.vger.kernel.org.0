Return-Path: <linux-wireless+bounces-6501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10A8A93DB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A529B228DD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F583BBF9;
	Thu, 18 Apr 2024 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="thPKWe2e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcKEnq58"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0B38F9A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424700; cv=none; b=pLIOgpYMj1FzZBsArTVy66FywglpCwOBYsXKfwxtQlqv4usi1gapPwm9NFtnqzSTOhjCsOLRD1QjPxaEy5SpTPxNPo2poXkIOBaUDLtiz1pzkn2j8z0LXahZJ32mTATAu+8sRShGdwAqNd3BJJInhRXd6AoezfELvJdDMrSNmFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424700; c=relaxed/simple;
	bh=Cg1iTi2FUXqVVHzGMD1K2e1YDIXHsJDkNuJnwdsixCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSGCEjRN1LCfxjAKMfs3CSXolePJBzRQALjJgiRajCK24l0axbEsnr/LKpHfZKhZm2YBhi/R2KipdBlqMRSdoPQU0xQIQR7HrxtSzFDMbHnmFINPGqFFOm0vhBlXC0as1gdJmHdS58z7r/GfGXgI7FZhzLaI+T+OIOs1z/4CLjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=thPKWe2e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcKEnq58; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6VB8MvZp7y+//9ulInPdAxj0qajVjR9ewdbxzm77yY=;
	b=thPKWe2eD+z/WBLJLn6/VBhNdZcaPQjQ738CgFnOlf75J0RtoGx4gcmSybD/B25RPtucbV
	GiyJYa9297chc0yevWkSDRD+DclI9Oj7ywe7Zp6pK+ibq02c7lWL2W0Jui1IJ+4SA5ACSD
	eA9BC4MbMPRPwzjU6n8xYP/D9QQFGe8EmCnr3kX5KVebH9HgMdFjgj3gwSGlvT7kBFVasr
	odIqvUH5xALfAYeIx3bCXs35hkEqC/CRPdisznCYH3HEiaPt4PCMk934xUvN5p5P4+WtTQ
	YXCpS62jhGZqTYoPT7Eb8wMnFQqCCMu1c+mYdK0K5Zzz4TQ84SZsYdEp31Xusg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713424697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6VB8MvZp7y+//9ulInPdAxj0qajVjR9ewdbxzm77yY=;
	b=JcKEnq58izsmDsLRGOFeJclV14AQZJwjrUFYRDWk42MRM/+rBPAAWEbwiOI2bo1gMzOZ9e
	3P121HxX9PEaeSBQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/2] Revert "wifi: rtl8xxxu: enable MFP support"
Date: Thu, 18 Apr 2024 09:18:12 +0200
Message-Id: <20240418071813.1883174-2-martin.kaistra@linutronix.de>
In-Reply-To: <20240418071813.1883174-1-martin.kaistra@linutronix.de>
References: <20240418071813.1883174-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 77f5924fc41c243e907c80ce2576902d3a9cb336.

There is a more elegant solution to check for not decrypted frames,
which is to check the security flag in the RX descriptor.

Revert commit 77f5924fc41c ("wifi: rtl8xxxu: enable MFP support") in
favor of this to be able to send it to stable.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 870bd952f5902..4a49f8f9d80f2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6473,9 +6473,7 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec &&
-			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
-			      ieee80211_has_protected(hdr->frame_control)))
+			if (!rx_desc->swdec)
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -6580,9 +6578,7 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
 
-			if (!rx_desc->swdec &&
-			    !(_ieee80211_is_robust_mgmt_frame(hdr) &&
-			      ieee80211_has_protected(hdr->frame_control)))
+			if (!rx_desc->swdec)
 				rx_status->flag |= RX_FLAG_DECRYPTED;
 			if (rx_desc->crc32)
 				rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
@@ -8002,7 +7998,6 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
-	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 
-- 
2.39.2


