Return-Path: <linux-wireless+bounces-2569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1257E83DB6A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B167C295290
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A5214299;
	Fri, 26 Jan 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="S3Oq71DW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680761BDC6
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277751; cv=none; b=F7jPbdg+DriaxoWyTtoAUr/65jxr6BGZ/uYt26yZr8lxBaySmx9COxDPJVuwkJac07SsgzGboIQZHNtBFQiUOkoaSsX3cTSlJI8soJloIUyoWyJUqcF3htYQw9RsihAQMA5jBvniIoSwaMj8VfCcxN4MXxuNZT4wgaXRR47Dytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277751; c=relaxed/simple;
	bh=OEcyCXol0pnTAEwXWrZ8YP4TiY9sNFuZGDpT84oPOlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1u4Ct+/PJv0O24jm+zG47bw/jsZuDRsZaI5WjGKbpi627Svg21rW0LeMHCLwJYOAvkmJ+cUaVCr+d6AkRKTQIthx2SXpKzq0vYgg2wBwmCTRJJYNA2UxTi5iy48NV+D03+Ko8C/kduO2GUBEBJD4j3K0WSvhFWp+3Bd2MroTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=S3Oq71DW; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706277745; bh=OEcyCXol0pnTAEwXWrZ8YP4TiY9sNFuZGDpT84oPOlw=;
	h=From:To:Cc:Subject:Date:From;
	b=S3Oq71DWiTqORFK8m1zTTZmsHDEpfdjyByOFhxc0rLWuv0jkU5I/03lwmKoi4pSYZ
	 UAkAdxB8zCDhYLu+iYfb9QAzpwHZ4toZ5EA3JB3DzF7Fo79otE8nU8jh8MFThZ8y9c
	 S/Rr9JHHfpyBl6DOeht4A0VMKderjRMwQP6U4eXliDhy0SbSJKV9/hK3luuuEXFZLf
	 Ms7MZE0Snpy0w8BCjGba2Dtr2Iz8+JhU+pBTaxHMn9gx/mhfXjhdvC0/CKbWqWsKwV
	 IfT4NRdO5CpNdonSd8rIQRONL5Nk4vUf0xFREW1CPkwR40+dJaee60W7TsY7Lc046b
	 M5g9KhPnOtoQw==
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-wireless@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ubisectech Sirius <bugreport@ubisectech.com>
Subject: [PATCH] wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete
Date: Fri, 26 Jan 2024 15:02:17 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <20240126140218.1033443-1-toke@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

The ath9k_wmi_event_tasklet() used in ath9k_htc assumes that all the data
structures have been fully initialised by the time it runs. However, because of
the order in which things are initialised, this is not guaranteed to be the
case, because the device is exposed to the USB subsystem before the ath9k driver
initialisation is completed.

We already committed a partial fix for this in commit:
8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")

However, that commit only aborted the WMI_TXSTATUS_EVENTID command in the event
tasklet, pairing it with an "initialisation complete" bit in the TX struct. It
seems syzbot managed to trigger the race for one of the other commands as well,
so let's just move the existing synchronisation bit to cover the whole
tasklet (setting it at the end of ath9k_htc_probe_device() instead of inside
ath9k_tx_init()).

Link: https://lore.kernel.org/r/ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com
Fixes: 8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/ath/ath9k/htc.h          |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c |  4 ++++
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  4 ----
 drivers/net/wireless/ath/ath9k/wmi.c          | 10 ++++++----
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 237f4ec2cffd..6c33e898b300 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -306,7 +306,6 @@ struct ath9k_htc_tx {
 	DECLARE_BITMAP(tx_slot, MAX_TX_BUF_NUM);
 	struct timer_list cleanup_timer;
 	spinlock_t tx_lock;
-	bool initialized;
 };
 
 struct ath9k_htc_tx_ctl {
@@ -515,6 +514,7 @@ struct ath9k_htc_priv {
 	unsigned long ps_usecount;
 	bool ps_enabled;
 	bool ps_idle;
+	bool initialized;
 
 #ifdef CONFIG_MAC80211_LEDS
 	enum led_brightness brightness;
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 0aa5bdeb44a1..3633f9eb2c55 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -966,6 +966,10 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 
 	htc_handle->drv_priv = priv;
 
+	/* Allow ath9k_wmi_event_tasklet() to operate. */
+	smp_wmb();
+	priv->initialized = true;
+
 	return 0;
 
 err_init:
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index efcaeccb055a..ce9c04e418b8 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -815,10 +815,6 @@ int ath9k_tx_init(struct ath9k_htc_priv *priv)
 	skb_queue_head_init(&priv->tx.data_vo_queue);
 	skb_queue_head_init(&priv->tx.tx_failed);
 
-	/* Allow ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) to operate. */
-	smp_wmb();
-	priv->tx.initialized = true;
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 1476b42b52a9..805ad31edba2 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -155,6 +155,12 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 		}
 		spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
+		/* Check if ath9k_htc_probe_device() completed. */
+		if (!data_race(priv->initialized)) {
+			kfree_skb(skb);
+			continue;
+		}
+
 		hdr = (struct wmi_cmd_hdr *) skb->data;
 		cmd_id = be16_to_cpu(hdr->command_id);
 		wmi_event = skb_pull(skb, sizeof(struct wmi_cmd_hdr));
@@ -169,10 +175,6 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 					     &wmi->drv_priv->fatal_work);
 			break;
 		case WMI_TXSTATUS_EVENTID:
-			/* Check if ath9k_tx_init() completed. */
-			if (!data_race(priv->tx.initialized))
-				break;
-
 			spin_lock_bh(&priv->tx.tx_lock);
 			if (priv->tx.flags & ATH9K_HTC_OP_TX_DRAIN) {
 				spin_unlock_bh(&priv->tx.tx_lock);
-- 
2.43.0


