Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62001F292D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgFHXX0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 19:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731052AbgFHXXW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 19:23:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E96F2072F;
        Mon,  8 Jun 2020 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658602;
        bh=XmULk4RpbHjwdExWxl3eSqltVLakRu4oCupHTgvysew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfLVDbRGj8cYOXFZcgJGZuj3SwnHvy7TsFaU7x6o8fNfHZOb3/0ZrUMxX05MubsZj
         l/5OPDHijMMwUsbQHXhuKrTS8GuwjL2ddQD/dKKYrQPK6tKEnukdHOYZD/RCqv4bf2
         XVshN6VVKbBZzytltNPShc8WfKpCAC0VMNaEf344=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 031/106] ath9k: Fix use-after-free Read in ath9k_wmi_ctrl_rx
Date:   Mon,  8 Jun 2020 19:21:23 -0400
Message-Id: <20200608232238.3368589-31-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

[ Upstream commit abeaa85054ff8cfe8b99aafc5c70ea067e5d0908 ]

Free wmi later after cmd urb has been killed, as urb cb will access wmi.

the case reported by syzbot:
https://lore.kernel.org/linux-usb/0000000000000002fc05a1d61a68@google.com
BUG: KASAN: use-after-free in ath9k_wmi_ctrl_rx+0x416/0x500
drivers/net/wireless/ath/ath9k/wmi.c:215
Read of size 1 at addr ffff8881cef1417c by task swapper/1/0

Call Trace:
<IRQ>
ath9k_wmi_ctrl_rx+0x416/0x500 drivers/net/wireless/ath/ath9k/wmi.c:215
ath9k_htc_rx_msg+0x2da/0xaf0
drivers/net/wireless/ath/ath9k/htc_hst.c:459
ath9k_hif_usb_reg_in_cb+0x1ba/0x630
drivers/net/wireless/ath/ath9k/hif_usb.c:718
__usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
expire_timers kernel/time/timer.c:1449 [inline]
__run_timers kernel/time/timer.c:1773 [inline]
__run_timers kernel/time/timer.c:1740 [inline]
run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1786

Reported-and-tested-by: syzbot+5d338854440137ea0fef@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200404041838.10426-3-hqjagain@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c      |  5 +++--
 drivers/net/wireless/ath/ath9k/hif_usb.h      |  1 +
 drivers/net/wireless/ath/ath9k/htc_drv_init.c | 10 +++++++---
 drivers/net/wireless/ath/ath9k/wmi.c          |  5 ++++-
 drivers/net/wireless/ath/ath9k/wmi.h          |  3 ++-
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index c4a2b7201ce3..6049d3766c64 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -978,7 +978,7 @@ static int ath9k_hif_usb_alloc_urbs(struct hif_device_usb *hif_dev)
 	return -ENOMEM;
 }
 
-static void ath9k_hif_usb_dealloc_urbs(struct hif_device_usb *hif_dev)
+void ath9k_hif_usb_dealloc_urbs(struct hif_device_usb *hif_dev)
 {
 	usb_kill_anchored_urbs(&hif_dev->regout_submitted);
 	ath9k_hif_usb_dealloc_reg_in_urbs(hif_dev);
@@ -1346,8 +1346,9 @@ static void ath9k_hif_usb_disconnect(struct usb_interface *interface)
 
 	if (hif_dev->flags & HIF_USB_READY) {
 		ath9k_htc_hw_deinit(hif_dev->htc_handle, unplugged);
-		ath9k_htc_hw_free(hif_dev->htc_handle);
 		ath9k_hif_usb_dev_deinit(hif_dev);
+		ath9k_destoy_wmi(hif_dev->htc_handle->drv_priv);
+		ath9k_htc_hw_free(hif_dev->htc_handle);
 	}
 
 	usb_set_intfdata(interface, NULL);
diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.h b/drivers/net/wireless/ath/ath9k/hif_usb.h
index 7846916aa01d..a94e7e1c86e9 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.h
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.h
@@ -133,5 +133,6 @@ struct hif_device_usb {
 
 int ath9k_hif_usb_init(void);
 void ath9k_hif_usb_exit(void);
+void ath9k_hif_usb_dealloc_urbs(struct hif_device_usb *hif_dev);
 
 #endif /* HTC_USB_H */
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_init.c b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
index 214c68269a69..27d9fe6799f5 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_init.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_init.c
@@ -933,8 +933,9 @@ static int ath9k_init_device(struct ath9k_htc_priv *priv,
 int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 			   u16 devid, char *product, u32 drv_info)
 {
-	struct ieee80211_hw *hw;
+	struct hif_device_usb *hif_dev;
 	struct ath9k_htc_priv *priv;
+	struct ieee80211_hw *hw;
 	int ret;
 
 	hw = ieee80211_alloc_hw(sizeof(struct ath9k_htc_priv), &ath9k_htc_ops);
@@ -969,7 +970,10 @@ int ath9k_htc_probe_device(struct htc_target *htc_handle, struct device *dev,
 	return 0;
 
 err_init:
-	ath9k_deinit_wmi(priv);
+	ath9k_stop_wmi(priv);
+	hif_dev = (struct hif_device_usb *)htc_handle->hif_dev;
+	ath9k_hif_usb_dealloc_urbs(hif_dev);
+	ath9k_destoy_wmi(priv);
 err_free:
 	ieee80211_free_hw(hw);
 	return ret;
@@ -984,7 +988,7 @@ void ath9k_htc_disconnect_device(struct htc_target *htc_handle, bool hotunplug)
 			htc_handle->drv_priv->ah->ah_flags |= AH_UNPLUGGED;
 
 		ath9k_deinit_device(htc_handle->drv_priv);
-		ath9k_deinit_wmi(htc_handle->drv_priv);
+		ath9k_stop_wmi(htc_handle->drv_priv);
 		ieee80211_free_hw(htc_handle->drv_priv->hw);
 	}
 }
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index d1f6710ca63b..e7a3127395be 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -112,14 +112,17 @@ struct wmi *ath9k_init_wmi(struct ath9k_htc_priv *priv)
 	return wmi;
 }
 
-void ath9k_deinit_wmi(struct ath9k_htc_priv *priv)
+void ath9k_stop_wmi(struct ath9k_htc_priv *priv)
 {
 	struct wmi *wmi = priv->wmi;
 
 	mutex_lock(&wmi->op_mutex);
 	wmi->stopped = true;
 	mutex_unlock(&wmi->op_mutex);
+}
 
+void ath9k_destoy_wmi(struct ath9k_htc_priv *priv)
+{
 	kfree(priv->wmi);
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.h b/drivers/net/wireless/ath/ath9k/wmi.h
index 380175d5ecd7..d8b912206232 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.h
+++ b/drivers/net/wireless/ath/ath9k/wmi.h
@@ -179,7 +179,6 @@ struct wmi {
 };
 
 struct wmi *ath9k_init_wmi(struct ath9k_htc_priv *priv);
-void ath9k_deinit_wmi(struct ath9k_htc_priv *priv);
 int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 		      enum htc_endpoint_id *wmi_ctrl_epid);
 int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
@@ -189,6 +188,8 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 void ath9k_wmi_event_tasklet(unsigned long data);
 void ath9k_fatal_work(struct work_struct *work);
 void ath9k_wmi_event_drain(struct ath9k_htc_priv *priv);
+void ath9k_stop_wmi(struct ath9k_htc_priv *priv);
+void ath9k_destoy_wmi(struct ath9k_htc_priv *priv);
 
 #define WMI_CMD(_wmi_cmd)						\
 	do {								\
-- 
2.25.1

