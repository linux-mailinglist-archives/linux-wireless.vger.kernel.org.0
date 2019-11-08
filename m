Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 662BAF57D9
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfKHTm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:42:28 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:46176 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732057AbfKHTm2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:42:28 -0500
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 9A79F13C344;
        Fri,  8 Nov 2019 11:42:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9A79F13C344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1573242146;
        bh=dAfkrecoZ/4g9FfUejdYcZyZn8oAZsnLU+MkX3o2L+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmTBSzgdf3iKFRgeMqbRSsqYCn0hJhml5bNDbt4lZim0FSZyJiDoQLI0zbpQ3/UQj
         eN7WlrHdTUpInhLCCwv4sEQdRdSxujgq98UjwDu9ZB0AM7RE3Ky24YOD1z+aiQH6Eh
         8dvJfKNj6QSvlvlLSZGfA/qyEOA1WrZR89sWoMiM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 08/10] mac80211: Support decrypting action frames for reinsertion into the driver.
Date:   Fri,  8 Nov 2019 11:42:09 -0800
Message-Id: <20191108194210.23618-9-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108194210.23618-1-greearb@candelatech.com>
References: <20191108194210.23618-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Some drivers, like ath10k-ct support rxswcrypt, but the firmware needs to
handle at least part of the blockack logic internally.  Since firmware cannot
decode the frame in rxswcrypt mode, this patch adds a way for the driver to
request to be delivered the decrypted blockack action frames.  The
driver can then re-insert the decrypted frame for proper handling.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/mac80211.h    | 10 ++++++++++
 net/mac80211/driver-ops.c |  9 +++++++++
 net/mac80211/driver-ops.h |  3 +++
 net/mac80211/iface.c      |  7 +++++++
 4 files changed, 29 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 523c6a09e1c8..7ea9a17c8cb8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3752,6 +3752,14 @@ enum ieee80211_reconfig_type {
  *
  * @start_pmsr: start peer measurement (e.g. FTM) (this call can sleep)
  * @abort_pmsr: abort peer measurement (this call can sleep)
+ * @consume_block_ack: Offer block-ack management frames back to driver to see
+ *      if it wishes to consume it.  This can be useful for when firmware wants
+ *      to handle block-ack logic itself, but PMF is used and the firmware
+ *      cannot actually decode the block-ack frames itself.  So, firmware can
+ *      pass the encoded block-ack up the stack, and receive it through this
+ *      callback.  If return value is zero, the mac80211 stack will not further
+ *      process the skb.  skb will be freed by calling code, so driver must
+ *      make a copy of anything it needs in the skb before returning.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4043,6 +4051,8 @@ struct ieee80211_ops {
 	void (*del_nan_func)(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    u8 instance_id);
+	int (*consume_block_ack)(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif, struct sk_buff* skb);
 	bool (*can_aggregate_in_amsdu)(struct ieee80211_hw *hw,
 				       struct sk_buff *head,
 				       struct sk_buff *skb);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index c9a8a2433e8a..aba803bd2718 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -49,6 +49,15 @@ void drv_stop(struct ieee80211_local *local)
 	local->started = false;
 }
 
+int drv_consume_block_ack(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata, struct sk_buff *skb)
+{
+	/*pr_warn("consume-block-ack: %p\n", local->ops->consume_block_ack);*/
+	if (local->ops->consume_block_ack)
+		return local->ops->consume_block_ack(&local->hw, &sdata->vif, skb);
+	return -EINVAL;
+}
+
 int drv_add_interface(struct ieee80211_local *local,
 		      struct ieee80211_sub_if_data *sdata)
 {
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index e734a85165ad..b3cf5d88f83e 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -148,6 +148,9 @@ static inline void drv_set_wakeup(struct ieee80211_local *local,
 }
 #endif
 
+int drv_consume_block_ack(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata, struct sk_buff *skb);
+
 int drv_add_interface(struct ieee80211_local *local,
 		      struct ieee80211_sub_if_data *sdata);
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index af8b09214786..f050410d0986 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1249,6 +1249,11 @@ static void ieee80211_iface_work(struct work_struct *work)
 		if (ieee80211_is_action(mgmt->frame_control) &&
 		    mgmt->u.action.category == WLAN_CATEGORY_BACK) {
 			int len = skb->len;
+			int barv = drv_consume_block_ack(local, sdata, skb);
+
+			/*pr_err("called drv_consume_blockack, rv: %d\n", barv);*/
+			if (barv == 0)
+				goto done_skb_free;
 
 			mutex_lock(&local->sta_mtx);
 			sta = sta_info_get_bss(sdata, mgmt->sa);
@@ -1349,6 +1354,8 @@ static void ieee80211_iface_work(struct work_struct *work)
 			break;
 		}
 
+	done_skb_free:
+
 		kfree_skb(skb);
 	}
 
-- 
2.20.1

