Return-Path: <linux-wireless+bounces-1586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A034826C4E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA241F22435
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 11:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D714277;
	Mon,  8 Jan 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tzOsTpOQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOXnHP+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35D1426F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704712268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCBZYKelwPSBbvo8QbeIDuylGcGZeyIhZ8SF3NSIMsw=;
	b=tzOsTpOQ8atQ4kLB4DeBPCWQ3+0fgBmBPkZ472dFaE7gyR2/lPHodFNfxDEM1VkoDdPMBm
	lk+mE5RtpUsfdtB+jxP2EkWDCHam6/fXDrKeMGdfxI/7ouVAg/4HklaEAfMQKddAQf9mSf
	gW7DeU1/+Or8i5/tNilogxwCF6j2v+bQo7WdsFgrU0Fw37cKlb9Ce+u1rrbEGLcYPwNEQO
	rFqbcuyRJhTN94Rm0ldoWHXuzHbxtDOse5dED3iU+otXWsh/fFTvCSJu5oSVkkxFPQzh5a
	+yk93JGjldUtmdI4qyXV5g0OvFcFsRFnXzfmLOM4yVTOviMqOYSL5wiSfOqH0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704712268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bCBZYKelwPSBbvo8QbeIDuylGcGZeyIhZ8SF3NSIMsw=;
	b=WOXnHP+0EjPdzrlE/zoQQXeDYnA4hBEu2YxCy89hQ00Ij6dViCvQXbDWLbYbkaTW87qYUP
	5Gny+0nuG5oeJLBw==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] wifi: rtl8xxxu: enable channel switch support
Date: Mon,  8 Jan 2024 12:11:03 +0100
Message-Id: <20240108111103.121378-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CSA countdown in the beacon frames, which are sent out by firmware,
needs to get updated by the driver. Do this at the end of the
update_beacon_work function by sleeping for a bit shorter than the
beacon interval and then either scheduling another run of
update_beacon_work or calling ieee80211_csa_finish() when the end of the
countdown is reached.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5fddbd6594a24..c4f3f52bde303 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5696,7 +5696,7 @@ static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
 	struct rtl8xxxu_priv *priv = hw->priv;
 	struct sk_buff *skb = ieee80211_beacon_get(hw, vif, 0);
 	struct device *dev = &priv->udev->dev;
-	int retry;
+	int retry, interval;
 	u8 val8;
 
 	/* BCN_VALID, write 1 to clear, cleared by SW */
@@ -5722,6 +5722,15 @@ static void rtl8xxxu_send_beacon_frame(struct ieee80211_hw *hw,
 
 	if (!retry)
 		dev_err(dev, "%s: Failed to read beacon valid bit\n", __func__);
+
+	if (vif->bss_conf.csa_active) {
+		interval = 1024 * vif->bss_conf.beacon_int;
+		usleep_range(interval - 2048, interval - 1024);
+		if (ieee80211_beacon_cntdwn_is_complete(vif))
+			ieee80211_csa_finish(vif);
+		else
+			schedule_work(&priv->update_beacon_work);
+	}
 }
 
 static void rtl8xxxu_update_beacon_work_callback(struct work_struct *work)
@@ -7825,6 +7834,8 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_AP);
 	hw->queues = 4;
 
+	hw->wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
+
 	if (priv->fops->supports_concurrent) {
 		hw->wiphy->iface_combinations = rtl8xxxu_combinations;
 		hw->wiphy->n_iface_combinations = ARRAY_SIZE(rtl8xxxu_combinations);
-- 
2.39.2


