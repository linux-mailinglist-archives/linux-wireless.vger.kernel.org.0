Return-Path: <linux-wireless+bounces-12598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFD96F463
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7841F258B8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A31C8FA6;
	Fri,  6 Sep 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="GCt8yy/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DA1CDFB8
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626227; cv=none; b=L1egzD4nRoFGzgxLGcIv0e/uKUkaVuE8cJhqbEGB+NxHTynEIdOPIMvLuOGHiAmemzLp0IwJHiOUTMiR0fpGSme/hkzLy5dGFBKuCBMhLaZ+vPK3LzXbH+dSJXQNvJyu6eU1CSsde9Q/+S+1IMiRlPkdEZ6gPYBMBEluzDz5wrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626227; c=relaxed/simple;
	bh=e1e6UOcVrCeaB6pUGwrBPbYKWDopeDWvTIX3al8LCws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5OZRn/T9maRA5mnNacFKdm1AG5R/MaqudmhM2hXDrXetJ+uTRf6GAYIBgGoUAc+KAvTEQ1HCD9sQ0bPXtht7W9C1W97cLGY5blGrScZOpqcnX4WFBSrsEvfPf8CwrB9V77RmQKMdA+YYxT5eo/iyZNAlXvBOM8bBdUPQyVccpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=GCt8yy/I; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:70a1:0:640:6c31:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id D9B326092C;
	Fri,  6 Sep 2024 15:37:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0bdknLGZxW20-e0MxgnIV;
	Fri, 06 Sep 2024 15:37:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725626221; bh=o0LbJvBAtMxCq3N3jkwW7hW7zr665lTtZWCzoykbKZI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=GCt8yy/IssOgwlm+CKOlZlWgxi0afBGyZU9Bu4ePLhbO1cvS79khHeJGwhX44c4qL
	 fbauQMVMw8LiNrlCZq/Abz1ZQRVRHXON3zbFjWra1dujW2JMnzjjpqTf8xIhgympsy
	 zSUEyE1KEf5VzX0yfX91iKU+52vzJXoiymHliPv8=
Authentication-Results: mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com
Subject: [PATCH] wifi: mac80211: use two-phase skb reclamation in ieee80211_do_stop()
Date: Fri,  6 Sep 2024 15:31:51 +0300
Message-ID: <20240906123151.351647-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since '__dev_queue_xmit()' should be called with interrupts enabled,
the following backtrace:

ieee80211_do_stop()
 ...
 spin_lock_irqsave(&local->queue_stop_reason_lock, flags)
 ...
 ieee80211_free_txskb()
  ieee80211_report_used_skb()
   ieee80211_report_ack_skb()
    cfg80211_mgmt_tx_status_ext()
     nl80211_frame_tx_status()
      genlmsg_multicast_netns()
       genlmsg_multicast_netns_filtered()
        nlmsg_multicast_filtered()
	 netlink_broadcast_filtered()
	  do_one_broadcast()
	   netlink_broadcast_deliver()
	    __netlink_sendskb()
	     netlink_deliver_tap()
	      __netlink_deliver_tap_skb()
	       dev_queue_xmit()
	        __dev_queue_xmit() ; with IRQS disabled
 ...
 spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags)

issues the warning (as reported by syzbot reproducer):

WARNING: CPU: 2 PID: 5128 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120

Fix this by implementing a two-phase skb reclamation in
'ieee80211_do_stop()', where actual work is performed
outside of a section with interrupts disabled.

Fixes: 5061b0c2b906 ("mac80211: cooperate more with network namespaces")
Reported-by: syzbot+1a3986bbd3169c307819@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a3986bbd3169c307819
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/mac80211/iface.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b4ad66af3af3..f735e41560a3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -462,6 +462,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
+	struct sk_buff_head freeq;
 	struct sk_buff *skb, *tmp;
 	u32 hw_reconf_flags = 0;
 	int i, flushed;
@@ -637,18 +638,32 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		skb_queue_purge(&sdata->status_queue);
 	}
 
+	/*
+	 * Since ieee80211_free_txskb() may issue __dev_queue_xmit()
+	 * which should be called with interrupts enabled, reclamation
+	 * is done in two phases:
+	 */
+	__skb_queue_head_init(&freeq);
+
+	/* unlink from local queues... */
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
 	for (i = 0; i < IEEE80211_MAX_QUEUES; i++) {
 		skb_queue_walk_safe(&local->pending[i], skb, tmp) {
 			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 			if (info->control.vif == &sdata->vif) {
 				__skb_unlink(skb, &local->pending[i]);
-				ieee80211_free_txskb(&local->hw, skb);
+				__skb_queue_tail(&freeq, skb);
 			}
 		}
 	}
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
+	/* ... and perform actual reclamation with interrupts enabled. */
+	skb_queue_walk_safe(&freeq, skb, tmp) {
+		__skb_unlink(skb, &freeq);
+		ieee80211_free_txskb(&local->hw, skb);
+	}
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		ieee80211_txq_remove_vlan(local, sdata);
 
-- 
2.46.0


