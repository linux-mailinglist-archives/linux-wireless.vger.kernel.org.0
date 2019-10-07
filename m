Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412C2CDB1A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 06:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfJGEba (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 00:31:30 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56857 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfJGEb3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 00:31:29 -0400
Received: by mail-vk1-f201.google.com with SMTP id 63so2759824vkr.23
        for <linux-wireless@vger.kernel.org>; Sun, 06 Oct 2019 21:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZTFpRUF7OT9YnJig3EFR+2VZJKtYwiYIKRN6+YZmlWA=;
        b=pBBPkG8/40lz89CZyw+h5zWdOTi97krbn53QgM+3CwvIx7v7NhT/wdcQFznZreidZ+
         Hr6TJisCUuKGN5Ir2STYktjR0RhfVFPOrZMqNYDYcZ5OEEJ/d0oz9vTwLwwv5K2GE+ac
         A36i9rTjxDX+W3kLkb+zg6VpJEr719E2FVe55hIueZl26xtUtKqo+27UdecUGW8/xDlS
         tyyyEuAKsVAkNP5TTzDwF3gvDm14qvrrrqp4ZNJQte/YzQASfEHw7O51lF+ujO+LEugj
         E2AeaJ+H5j6qo4Gcz+vaefXSIDICUq0mAVJl4EvkYQHghJS2wfzKaSf3KsGGpgRJGy4o
         dy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTFpRUF7OT9YnJig3EFR+2VZJKtYwiYIKRN6+YZmlWA=;
        b=VQBFQF3cmx/kKRNlWjP3+SAsCDmeh3p9VMf/o3w34EJGQ6w6n4rErWTyGTL8Y3VTsn
         kBBcROFbIC5MdLq2J8bjYEFqZ6DqvlMxbLb7Ovingd+cvs7ZxcCdnynmNSJHEz45jiJU
         8/NzdXAXPcspQiPVj7vuc3wVG1D7dk9sBHZjDN4DMusZKNfPwQk7YiwriBTxJhwHhpWb
         smK1f8kkKvuF8oyTtF64K73mks7g7OCpwlaWCsbHpiGXy03AZfh6hmgeC2zzwAJOq12W
         Pma27sfp2EiYHjdslLdWmOoDwgEVbFSkDQzI5DTEFDg5SIaBwWEIIZANInEwVae/IuLL
         WeIw==
X-Gm-Message-State: APjAAAXDmTC1jsToskVwiCb+sv3ZPC4zUww9OU+Ag9RUJJ4XJ6f10MsN
        pEGuQNy8QjZ3cmD5OiRcohtq6S2H
X-Google-Smtp-Source: APXvYqy+y1Vf9hKMNz/Kb4uauq2jRu+XNplWsZ5Ec3OMjE6MTNnchzKAhZREsl+ix7nn7nhJbmi/DVUc
X-Received: by 2002:a67:fe0b:: with SMTP id l11mr14265988vsr.68.1570422688348;
 Sun, 06 Oct 2019 21:31:28 -0700 (PDT)
Date:   Sun,  6 Oct 2019 21:31:19 -0700
In-Reply-To: <20191007043120.67567-1-kyan@google.com>
Message-Id: <20191007043120.67567-2-kyan@google.com>
Mime-Version: 1.0
References: <20191007043120.67567-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v2 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order for the Fq_CoDel integrated in mac80211 layer operates effectively
to control excessive queueing latency, the CoDel algorithm requires an
accurate measure of how long the packets stays in the queue, aka sojourn
time. The sojourn time measured at mac80211 layer doesn't include queueing
latency in lower layer (firmware/hardware) and CoDel expects lower layer to
have a short queue. However, most 802.11ac chipsets offload tasks such TX
aggregation to firmware or hardware, thus have a deep lower layer queue.
Without a mechanism to control the lower layer queue size, packets only
stays in mac80211 layer transiently before being sent to firmware queue.
As a result, the sojourn time measured by CoDel in the mac80211 layer is
almost always lower than the CoDel latency target, hence CoDel does little
to control the latency, even when the lower layer queue causes excessive
latency.

Byte Queue limits (BQL) is commonly used to address the similar issue with
wired network interface. However, this method cannot be applied directly
to the wireless network interface. Byte is not a suitable measure of queue
depth in the wireless network, as the data rate can vary dramatically from
station to station in the same network, from a few Mbps to over Gbps.

This patch implemented an Airtime-based Queue Limit (AQL) to make CoDel
works effectively with wireless drivers that utilized firmware/hardware
offloading. AQL only allows each txq to release just enough packets to the
lower layer to form 1-2 large aggregations to keep hardware fully utilized
and keep the rest of frames in mac80211 layer to be controlled by the CoDel
algorithm.

Signed-off-by: Kan Yan <kyan@google.com>
---
 include/net/cfg80211.h     |  7 ++++
 include/net/mac80211.h     | 29 ++++++++++++++
 net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c | 44 +++++++++++++++------
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/main.c        |  8 +++-
 net/mac80211/sta_info.c    | 20 ++++++++++
 net/mac80211/sta_info.h    |  4 ++
 net/mac80211/tx.c          | 58 +++++++++++++++++++++++-----
 9 files changed, 231 insertions(+), 21 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 26e2ad2c7027..05352eac82ec 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2499,6 +2499,13 @@ enum wiphy_params_flags {
 
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT	256
 
+/* The per TXQ firmware queue limit in airtime */
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	4000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	8000
+
+/* The per interface airtime threshold to switch to lower queue limit */
+#define IEEE80211_AQL_THRESHOLD			24000
+
 /**
  * struct cfg80211_pmksa - PMK Security Association
  *
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..51ee28e72161 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5543,6 +5543,35 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_sta *pubsta, int tid);
 void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 				    u32 tx_airtime, u32 rx_airtime);
 
+/**
+ * ieee80211_sta_update_pending_airtime - update txq's estimated airtime
+ *
+ * Update the estimated total airtime of frames queued in the lower layer queue.
+ *
+ * The airtime is estimated using frame length and the last reported data
+ * rate. The pending airtime for a txq is increased by the estimated
+ * airtime when the frame is relased to the lower layer, and decreased by the
+ * same amount at the tx completion event.
+ *
+ * @pubsta: the station
+ * @tid: the TID to register airtime for
+ * @tx_airtime: the estimated airtime (in usec)
+ */
+void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta,
+					    u8 tid, s32 tx_airtime);
+
+/**
+ * ieee80211_txq_aql_check - check if a txq can send more frames to firmware
+ *
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ *
+ * Return true if the AQL's airtime limit has not been reached and the txq can
+ * continue to send more packets to the lower layer. Otherwise return false.
+ */
+bool
+ieee80211_txq_aql_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2e7f75938c51..f7cbf248163a 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,80 @@ static const struct file_operations aqm_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t aql_txq_limit_read(struct file *file,
+				  char __user *user_buf,
+				  size_t count,
+				  loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[400];
+	int len = 0;
+
+	len = scnprintf(buf, sizeof(buf),
+			"AC	AQL limit low	AQL limit high\n"
+			"0	%u		%u\n"
+			"1	%u		%u\n"
+			"2	%u		%u\n"
+			"3	%u		%u\n",
+			local->aql_txq_limit_low[0],
+			local->aql_txq_limit_high[0],
+			local->aql_txq_limit_low[1],
+			local->aql_txq_limit_high[1],
+			local->aql_txq_limit_low[2],
+			local->aql_txq_limit_high[2],
+			local->aql_txq_limit_low[3],
+			local->aql_txq_limit_high[3]);
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buf, len);
+}
+
+static ssize_t aql_txq_limit_write(struct file *file,
+				   const char __user *user_buf,
+				   size_t count,
+				   loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[100];
+	size_t len;
+	u32	ac, q_limit_low, q_limit_high;
+	struct sta_info *sta;
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = '\0';
+	len = strlen(buf);
+	if (len > 0 && buf[len - 1] == '\n')
+		buf[len - 1] = 0;
+
+	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
+		return -EINVAL;
+
+	if (ac >= IEEE80211_NUM_ACS)
+		return -EINVAL;
+
+	local->aql_txq_limit_low[ac] = q_limit_low;
+	local->aql_txq_limit_high[ac] = q_limit_high;
+
+	mutex_lock(&local->sta_mtx);
+	list_for_each_entry(sta, &local->sta_list, list) {
+		sta->airtime[ac].aql_limit_low = q_limit_low;
+		sta->airtime[ac].aql_limit_high = q_limit_high;
+	}
+	mutex_unlock(&local->sta_mtx);
+	return count;
+}
+
+static const struct file_operations aql_txq_limit_ops = {
+	.write = aql_txq_limit_write,
+	.read = aql_txq_limit_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 static ssize_t force_tx_status_read(struct file *file,
 				    char __user *user_buf,
 				    size_t count,
@@ -442,6 +516,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	debugfs_create_u16("airtime_flags", 0600,
 			   phyd, &local->airtime_flags);
 
+	DEBUGFS_ADD(aql_txq_limit);
+	debugfs_create_u32("aql_threshold", 0600,
+			   phyd, &local->aql_threshold);
+
 	statsd = debugfs_create_dir("statistics", phyd);
 
 	/* if the dir failed, don't put all the other things into the root! */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index c8ad20c28c43..bd8adb92b927 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 {
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
-	size_t bufsz = 200;
+	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
 	s64 deficit[IEEE80211_NUM_ACS];
+	u32 q_depth[IEEE80211_NUM_ACS];
+	u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		rx_airtime += sta->airtime[ac].rx_airtime;
 		tx_airtime += sta->airtime[ac].tx_airtime;
 		deficit[ac] = sta->airtime[ac].deficit;
+		q_limit_l[ac] = sta->airtime[ac].aql_limit_low;
+		q_limit_h[ac] = sta->airtime[ac].aql_limit_high;
+		q_depth[ac] = sta->airtime[ac].aql_tx_pending;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
 	p += scnprintf(p, bufsz + buf - p,
 		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
-		rx_airtime,
-		tx_airtime,
-		sta->airtime_weight,
-		deficit[0],
-		deficit[1],
-		deficit[2],
-		deficit[3]);
+		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n"
+		"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
+		"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
+		rx_airtime, tx_airtime, sta->airtime_weight,
+		deficit[0], deficit[1], deficit[2], deficit[3],
+		q_depth[0], q_depth[1], q_depth[2], q_depth[3],
+		q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
+		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
@@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 {
 	struct sta_info *sta = file->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
-	int ac;
+	u32 ac, q_limit_l, q_limit_h;
+	char _buf[100] = {}, *buf = _buf;
+
+	if (count > sizeof(_buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[sizeof(_buf) - 1] = '\0';
+	if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
+	    != 3)
+		return -EINVAL;
+
+	if (ac >= IEEE80211_NUM_ACS)
+		return -EINVAL;
+
+	sta->airtime[ac].aql_limit_low = q_limit_l;
+	sta->airtime[ac].aql_limit_high = q_limit_h;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		spin_lock_bh(&local->active_txq_lock[ac]);
@@ -245,7 +268,6 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 		sta->airtime[ac].deficit = sta->airtime_weight;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
-
 	return count;
 }
 STA_OPS_RW(airtime);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 004e2e3adb88..c7e98ed0710d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 	u16 schedule_round[IEEE80211_NUM_ACS];
 
 	u16 airtime_flags;
+	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+	u32 aql_threshold;
+	s32 aql_total_pending_airtime;
 
 	const struct ieee80211_ops *ops;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2702f128f3..750d783aae05 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -666,8 +666,14 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
+		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		local->aql_txq_limit_high[i] =
+			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
-	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+	local->airtime_flags =
+		AIRTIME_USE_TX | AIRTIME_USE_RX | AIRTIME_USE_AQL;
+	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 95eb8220e2e4..9c250a886143 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
 		sta->airtime[i].deficit = sta->airtime_weight;
+		sta->airtime[i].aql_tx_pending = 0;
+		sta->airtime[i].aql_limit_low = local->aql_txq_limit_low[i];
+		sta->airtime[i].aql_limit_high = local->aql_txq_limit_high[i];
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1894,6 +1897,23 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
+void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta, u8 tid,
+					  s32 tx_airtime)
+{
+	u8 ac = ieee80211_ac_from_tid(tid);
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct ieee80211_local *local = sta->local;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
+	sta->airtime[ac].aql_tx_pending += tx_airtime;
+	local->aql_total_pending_airtime += tx_airtime;
+	WARN_ONCE(sta->airtime[ac].aql_tx_pending < 0, "STA pending airtime < 0");
+	WARN_ONCE(local->aql_total_pending_airtime < 0,
+		  "Total pending airtime < 0");
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+}
+EXPORT_SYMBOL(ieee80211_sta_update_pending_airtime);
+
 int sta_info_move_state(struct sta_info *sta,
 			enum ieee80211_sta_state new_state)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 3260d4234920..d1ba4553c557 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,11 +127,15 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
+#define AIRTIME_USE_AQL		BIT(2)
 
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
 	s64 deficit;
+	s32 aql_tx_pending; /* Estimated airtime for frames pending in queue */
+	u32 aql_limit_low;
+	u32 aql_limit_high;
 };
 
 struct sta_info;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f13eb2f61ccf..dadb643a5498 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3669,7 +3669,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_txq *ret = NULL;
-	struct txq_info *txqi = NULL;
+	struct txq_info *txqi = NULL, *head = NULL;
+	bool found_eligible_txq = false;
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
@@ -3680,20 +3681,32 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	if (!txqi)
 		goto out;
 
+	if (txqi == head && !found_eligible_txq)
+		goto out;
+
+	if (!head)
+		head = txqi;
+
 	if (txqi->txq.sta) {
 		struct sta_info *sta = container_of(txqi->txq.sta,
-						struct sta_info, sta);
+						    struct sta_info, sta);
+		bool aql_check = ieee80211_txq_aql_check(hw, &txqi->txq);
+		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
 
-		if (sta->airtime[txqi->txq.ac].deficit < 0) {
+		if (aql_check)
+			found_eligible_txq = true;
+
+		if (deficit < 0)
 			sta->airtime[txqi->txq.ac].deficit +=
 				sta->airtime_weight;
+
+		if (deficit < 0 || !aql_check) {
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
 		}
 	}
 
-
 	if (txqi->schedule_round == local->schedule_round[ac])
 		goto out;
 
@@ -3740,6 +3753,30 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
 
+bool ieee80211_txq_aql_check(struct ieee80211_hw *hw,
+			     struct ieee80211_txq *txq)
+{
+	struct sta_info *sta;
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	if (!(local->airtime_flags & AIRTIME_USE_AQL))
+		return true;
+
+	if (!txq->sta)
+		return true;
+
+	sta = container_of(txq->sta, struct sta_info, sta);
+	if (sta->airtime[txq->ac].aql_tx_pending <
+	     sta->airtime[txq->ac].aql_limit_low ||
+	    (local->aql_total_pending_airtime < local->aql_threshold &&
+	     sta->airtime[txq->ac].aql_tx_pending <
+	     sta->airtime[txq->ac].aql_limit_high))
+		return true;
+	else
+		return false;
+}
+EXPORT_SYMBOL(ieee80211_txq_aql_check);
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
@@ -3748,10 +3785,10 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	struct sta_info *sta;
 	u8 ac = txq->ac;
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
-
 	if (!txqi->txq.sta)
-		goto out;
+		return true;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
 
 	if (list_empty(&txqi->schedule_order))
 		goto out;
@@ -3773,10 +3810,13 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	}
 
 	sta = container_of(txqi->txq.sta, struct sta_info, sta);
-	if (sta->airtime[ac].deficit >= 0)
+	if (sta->airtime[ac].deficit >= 0 &&
+	    ieee80211_txq_aql_check(hw, &txqi->txq))
 		goto out;
 
-	sta->airtime[ac].deficit += sta->airtime_weight;
+	if (sta->airtime[ac].deficit < 0)
+		sta->airtime[ac].deficit += sta->airtime_weight;
+
 	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 
-- 
2.23.0.581.g78d2f28ef7-goog

