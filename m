Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B090E407C29
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Sep 2021 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhILHT4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Sep 2021 03:19:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55923 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhILHTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Sep 2021 03:19:55 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18C7IZhv008575;
        Sun, 12 Sep 2021 16:18:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 12 Sep 2021 16:18:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18C7IZDC008571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Sep 2021 16:18:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Kalle Valo <kvalo@codeaurora.org>, ath9k-devel@qca.qualcomm.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] ath9k_htc: fix NULL pointer dereference at
 ath9k_htc_tx_get_packet()
Message-ID: <7145c55e-6b1d-d8be-57cc-6639e4e5fee2@i-love.sakura.ne.jp>
Date:   Sun, 12 Sep 2021 16:18:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syzbot is reporting NULL pointer dereference at get_htc_epid_queue() from
ath9k_htc_tx_get_packet() from ath9k_htc_txstatus() [1], for
ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) depends on spin_lock_init()
 from ath9k_init_priv() being already completed.

Since ath9k_wmi_event_tasklet() is set by ath9k_init_wmi() from
ath9k_htc_probe_device(), it is possible that ath9k_wmi_event_tasklet() is
called via tasklet interrupt before spin_lock_init() from ath9k_init_priv()
 from ath9k_init_device() from ath9k_htc_probe_device() is called.

Let's hold ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) no-op until
ath9k_tx_init() completes.

Link: https://syzkaller.appspot.com/bug?extid=31d54c60c5b254d6f75b [1]
Reported-by: syzbot <syzbot+31d54c60c5b254d6f75b@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot+31d54c60c5b254d6f75b@syzkaller.appspotmail.com
---
 drivers/net/wireless/ath/ath9k/htc.h          | 1 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 3 +++
 drivers/net/wireless/ath/ath9k/wmi.c          | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc.h b/drivers/net/wireless/ath/ath9k/htc.h
index 4f71e962279a..6b45e63fae4b 100644
--- a/drivers/net/wireless/ath/ath9k/htc.h
+++ b/drivers/net/wireless/ath/ath9k/htc.h
@@ -306,6 +306,7 @@ struct ath9k_htc_tx {
 	DECLARE_BITMAP(tx_slot, MAX_TX_BUF_NUM);
 	struct timer_list cleanup_timer;
 	spinlock_t tx_lock;
+	bool initialized;
 };
 
 struct ath9k_htc_tx_ctl {
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 0d4595ee51ba..a5240a7f8c00 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -813,6 +813,9 @@ int ath9k_tx_init(struct ath9k_htc_priv *priv)
 	skb_queue_head_init(&priv->tx.data_vi_queue);
 	skb_queue_head_init(&priv->tx.data_vo_queue);
 	skb_queue_head_init(&priv->tx.tx_failed);
+	/* Allow ath9k_wmi_event_tasklet(WMI_TXSTATUS_EVENTID) to operate. */
+	smp_wmb();
+	priv->tx.initialized = true;
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index fe29ad4b9023..7e17d86bf5d3 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -169,6 +169,9 @@ void ath9k_wmi_event_tasklet(struct tasklet_struct *t)
 					     &wmi->drv_priv->fatal_work);
 			break;
 		case WMI_TXSTATUS_EVENTID:
+			/* Check if ath9k_tx_init() completed. */
+			if (!data_race(priv->tx.initialized))
+				break;
 			spin_lock_bh(&priv->tx.tx_lock);
 			if (priv->tx.flags & ATH9K_HTC_OP_TX_DRAIN) {
 				spin_unlock_bh(&priv->tx.tx_lock);
-- 
2.30.2

