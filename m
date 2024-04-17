Return-Path: <linux-wireless+bounces-6431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B378B8A7FB8
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 11:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700DC283E88
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46736130499;
	Wed, 17 Apr 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPpItFcX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AiUq6DJn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC512F375
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346449; cv=none; b=rLscsOaT9DHsVukVp0kCwtdW8n7xEZkDzH8tX/L8T2AOVMqZet4329w/HGuawQmiKmvTuAdpbrtNe5C21pgtUR1cN2jn8R+PieXLtyrfL1EPij7jJ5d7CsWDELAZzxzliflWco4TEsNafIp3oe9Vh2peDP7+bjZL1yntIAE0Rgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346449; c=relaxed/simple;
	bh=Cg1iTi2FUXqVVHzGMD1K2e1YDIXHsJDkNuJnwdsixCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJDZgTUzq+WeuluwDv6PqQJXWXXVGIPRKlK0D4v2fPGOglNtCcPY/5Mgb79qwzHs++UlIWYD9dmy58hJwdO+od/TlUZunDgEgaRpS03ePJjyrCZKlqhJc76sZtGOhyh+45S9W8taeTrQGN40X1i+XsA13CVazJ4Wy5Li77dcjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPpItFcX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AiUq6DJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6VB8MvZp7y+//9ulInPdAxj0qajVjR9ewdbxzm77yY=;
	b=GPpItFcXXEp3//xiL3BX5yY59SZSa4nLDXS/4qLsqW0s6kSjQbJ0rrNe+R/cEuqD9ko/EK
	j5rweu4Y5xfeBPswefWlAnk72RU96QwbWTez7lGxOfo6VDyAdGlnByM5pdCh+hVKD/Bbki
	6k0A8l85U+arDgAue6ml6sI+zfc2bI7V8q5rXHkhsOpD4VTrzrg324xn+jq7BNoUAt/XOg
	mV9thZU4HHL88ZXRrpr0+nngSl2XGpvtFL+5Cq7GEvpz5ZFfilD7FyQM266CtO/dH1SWfE
	ECpOauIttiHx5Vq+pCqxUjK42+X86+iu6bFKdZKkn0Yko1v9Bii033Ext538Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713346446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6VB8MvZp7y+//9ulInPdAxj0qajVjR9ewdbxzm77yY=;
	b=AiUq6DJnN9XUjay3nMiJG5BohPrI2752RWE/kZ90TSGwmqMaithbCgAQAiTij9RUGS3gH2
	2cscfq+e4ZbtgKAg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] Revert "wifi: rtl8xxxu: enable MFP support"
Date: Wed, 17 Apr 2024 11:33:51 +0200
Message-Id: <20240417093352.1840632-2-martin.kaistra@linutronix.de>
In-Reply-To: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
References: <20240417093352.1840632-1-martin.kaistra@linutronix.de>
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


