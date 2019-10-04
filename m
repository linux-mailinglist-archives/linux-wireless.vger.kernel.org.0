Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76698CB46E
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfJDGWT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 02:22:19 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:40317 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbfJDGWT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 02:22:19 -0400
Received: by mail-pl1-f202.google.com with SMTP id f10so3315288plr.7
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2019 23:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FQxxGPmbolFCbymL+sPoKt5wyaRBrFDbUGuAaIg7xEE=;
        b=dcFyxlXy2sQ+7a1dvri0eTQGuJqEjtismRmH86/WbBLiCJ0EpAMGgil61f9xPENuHH
         g+MaYPUEmoSN3vurp1CY07wTmtBD9JWc56ZoMKC0YRdhemXmYYsMmDJLjjOnFx010tTh
         C1sO8dLqsQEZzHlNMDgasSNarhBWirKa/8s1mkL1Tvzx0k+8pRP3PQG2WNuxHjUsFeQl
         L7nY/InC5KVKPftLLxUxmlhiCHOlRGprh74b/bpComYBf9OQy6DFXv2JVkLN2u43mRKD
         yltzHCBTvHMHcW61v75sWOO//1Ca1lwRSgYreR5dDYvqgvaTEHLWPWNFcY7yE1j97KK5
         vKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FQxxGPmbolFCbymL+sPoKt5wyaRBrFDbUGuAaIg7xEE=;
        b=ekgMbVas1Nw6w/wKUaIDcc75sgz1RbU35V33qzsu+ZNPQUfcsZi6F6oyMlfkmASy/c
         pgkDcomeZ0eRnGSDoNlL9Yb3kNvDZFypxM7BpXywMWH2b4UcdcWKBcehvKnqZBzvXc04
         u+bdJanJnNKf2WfGwE9lTfzOAoUp1ycMysKO/JJpBnh24dqJserET297BGGOaoMQIA1W
         R1MUZigRAb/T1sR5SQoIhb5+kfWZOfh9vhjzAyJhMjujRZJdFH6HM2l8W/nNjzGYN8d4
         19hqdxkBTwktJp4hbHjr3k36zhefJKAU3opBv1JSwkpXwHpTjxZ5ZVqdhPuYZYfqE5sm
         eM2w==
X-Gm-Message-State: APjAAAXQWuhUKxit8Ciy/GFuzCYD8Dcy0rTijfkUJUdTeE1YYzfvNDN9
        CYTqI6OqSDcZtP/Mt4IvNZna7vkH
X-Google-Smtp-Source: APXvYqyno0uQIfmfmzo9x3FpfTqFZTni93S0HqPVcyvHn7LNYNza9lmlgaon9k3aFyL0lNPxOnZwTd4W
X-Received: by 2002:a63:4652:: with SMTP id v18mr13965005pgk.364.1570170136918;
 Thu, 03 Oct 2019 23:22:16 -0700 (PDT)
Date:   Thu,  3 Oct 2019 23:21:50 -0700
In-Reply-To: <20191004062151.131405-1-kyan@google.com>
Message-Id: <20191004062151.131405-2-kyan@google.com>
Mime-Version: 1.0
References: <20191004062151.131405-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
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

In order for the Fq_CoDel integrated in mac80211 layer operates
effectively to control excessive queueing latency, the CoDel algorithm
requires an accurate measure of how long the packets stays in the
queue, aka sojourn time. The sojourn time measured at mac80211 layer
doesn't include queueing latency in lower layer (firmware/hardware)
and CoDel expects lower layer to have a short queue. However, most
802.11ac chipsets offload tasks such TX aggregation to firmware or
hardware, thus have a deep lower layer queue. Without a mechanism to
control the lower layer queue size, packets only stays in mac80211
layer transiently before being released to firmware due to the deep
queue in the lower layer. In this case, the sojourn time measured by
CoDel in the mac80211 layer is always lower than the CoDel latency
target hence it does little to control the latency, even when the lower
layer queue causes excessive latency.

Byte Queue limits (BQL) is commonly used to address the similar issue
with wired network interface. However, this method can not be applied
directly to the wireless network interface. Byte is not a suitable
measure of queue depth in the wireless network, as the data rate can
vary dramatically from station to station in the same network, from a
few Mbps to over 1 Gbps.

This patch implemented an Airtime-based Queue Limit (AQL) to make CoDel
works effectively with wireless drivers that utilized firmware/hardware
offloading. It only allows each txq to release just enough packets to
form 1-2 large aggregations to keep hardware fully utilized and keep the
rest of frames in mac80211 layer to be controlled by CoDel.

Change-Id: I1427db2c4c7fcb4162b087514dcb06d5613fa5d2
Signed-off-by: Kan Yan <kyan@google.com>
---
 include/net/cfg80211.h     |  7 ++++
 include/net/mac80211.h     | 34 ++++++++++++++++
 net/mac80211/debugfs.c     | 79 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c | 43 +++++++++++++++------
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/main.c        |  7 +++-
 net/mac80211/sta_info.c    | 23 +++++++++++
 net/mac80211/sta_info.h    |  4 ++
 net/mac80211/tx.c          | 60 ++++++++++++++++++++++++-----
 9 files changed, 239 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 26e2ad2c7027..301c11be366a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2499,6 +2499,13 @@ enum wiphy_params_flags {
 
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT	256
 
+/* The per TXQ firmware queue limit in airtime */
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	4000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	8000
+
+/* The firmware's transmit queue size limit in airtime */
+#define IEEE80211_DEFAULT_AQL_INTERFACE_LIMIT	24000
+
 /**
  * struct cfg80211_pmksa - PMK Security Association
  *
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d26da013f7c0..4d62aba3e4b2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5543,6 +5543,40 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_sta *pubsta, int tid);
 void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 				    u32 tx_airtime, u32 rx_airtime);
 
+/**
+ * ieee80211_sta_register_pending_airtime - register the estimated airtime for
+ * the frames pending in lower layer (firmware/hardware) txq.
+ *
+ * Update the total pending airtime of the frames released to firmware. The
+ * pending airtime is used by AQL to control queue size in the lower layer.
+ *
+ * The airtime is estimated using frame length and the last reported data
+ * rate. The pending airtime for a txq is increased by the estimated
+ * airtime when the frame is relased to the lower layer, and decreased by the
+ * same amount at the tx completion event.
+ *
+ * @pubsta: the station
+ * @tid: the TID to register airtime for
+ * @tx_airtime: the estimated airtime (in usec)
+ * @tx_commpleted: true if called from the tx completion event.
+ */
+void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta,
+					    u8 tid, u32 tx_airtime,
+					    bool tx_completed);
+
+/**
+ * ieee80211_txq_aritme_check - check if the airtime limit of AQL (Airtime based
+ * queue limit) has been reached.
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ * Retrun true if the queue limit has not been reached and txq can continue to
+ * release packets to the lower layer.
+ * Return false if the queue limit has been reached and the txq should not
+ * release more frames to the lower layer.
+ */
+bool
+ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2e7f75938c51..a7da9a93b63e 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,81 @@ static const struct file_operations aqm_ops = {
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
+	rcu_read_lock();
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
+	rcu_read_unlock();
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
+	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) == 3) {
+		if (ac < IEEE80211_NUM_ACS) {
+			local->aql_txq_limit_low[ac] = q_limit_low;
+			local->aql_txq_limit_high[ac] = q_limit_high;
+
+			mutex_lock(&local->sta_mtx);
+			list_for_each_entry(sta, &local->sta_list, list) {
+				sta->airtime[ac].aql_limit_low = q_limit_low;
+				sta->airtime[ac].aql_limit_high = q_limit_high;
+			}
+			mutex_unlock(&local->sta_mtx);
+			return count;
+		}
+	}
+	return -EINVAL;
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
@@ -442,6 +517,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	debugfs_create_u16("airtime_flags", 0600,
 			   phyd, &local->airtime_flags);
 
+	DEBUGFS_ADD(aql_txq_limit);
+	debugfs_create_u32("aql_interface_limit", 0600,
+			   phyd, &local->aql_interface_limit);
+
 	statsd = debugfs_create_dir("statistics", phyd);
 
 	/* if the dir failed, don't put all the other things into the root! */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index c8ad20c28c43..3db2afb9f6c8 100644
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
@@ -236,7 +241,23 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
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
+	    == 3) {
+		if (ac < IEEE80211_NUM_ACS) {
+			sta->airtime[ac].aql_limit_low = q_limit_l;
+			sta->airtime[ac].aql_limit_high = q_limit_h;
+		}
+	}
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
 		spin_lock_bh(&local->active_txq_lock[ac]);
@@ -245,8 +266,8 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 		sta->airtime[ac].deficit = sta->airtime_weight;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
-
 	return count;
+
 }
 STA_OPS_RW(airtime);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 004e2e3adb88..3b1508ed2570 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 	u16 schedule_round[IEEE80211_NUM_ACS];
 
 	u16 airtime_flags;
+	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+	u32 aql_interface_limit;
+	s32 aql_total_pending_airtime;
 
 	const struct ieee80211_ops *ops;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2702f128f3..960299317047 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -666,8 +666,13 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
+		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		local->aql_txq_limit_high[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
-	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+	local->airtime_flags =
+		AIRTIME_USE_TX | AIRTIME_USE_RX | AIRTIME_USE_AQL;
+	local->aql_interface_limit = IEEE80211_DEFAULT_AQL_INTERFACE_LIMIT;
 
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 95eb8220e2e4..0baae63e0222 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
 		sta->airtime[i].deficit = sta->airtime_weight;
+	        sta->airtime[i].aql_tx_pending = 0;
+		sta->airtime[i].aql_limit_low = local->aql_txq_limit_low[i];
+		sta->airtime[i].aql_limit_high = local->aql_txq_limit_high[i];
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1894,6 +1897,26 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
+void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta,
+					    u8 tid, u32 tx_airtime,
+					    bool tx_completed)
+{
+	u8 ac = ieee80211_ac_from_tid(tid);
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct ieee80211_local *local = sta->local;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
+	if (tx_completed) {
+		sta->airtime[ac].aql_tx_pending -= tx_airtime;
+		local->aql_total_pending_airtime -= tx_airtime;
+	} else {
+		sta->airtime[ac].aql_tx_pending += tx_airtime;
+		local->aql_total_pending_airtime += tx_airtime;
+	}
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+}
+EXPORT_SYMBOL(ieee80211_sta_register_pending_airtime);
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
index f13eb2f61ccf..354ff4e4dce4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3669,7 +3669,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_txq *ret = NULL;
-	struct txq_info *txqi = NULL;
+	struct txq_info *txqi = NULL, *head = NULL;
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
@@ -3680,13 +3680,20 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	if (!txqi)
 		goto out;
 
+	if (txqi == head)
+		goto out;
+
+	if (!head)
+		head = txqi;
+
 	if (txqi->txq.sta) {
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						struct sta_info, sta);
 
-		if (sta->airtime[txqi->txq.ac].deficit < 0) {
+		if (sta->airtime[txqi->txq.ac].deficit < 0)
 			sta->airtime[txqi->txq.ac].deficit +=
 				sta->airtime_weight;
+		if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
@@ -3726,9 +3733,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		 * get immediately moved to the back of the list on the next
 		 * call to ieee80211_next_txq().
 		 */
-		if (txqi->txq.sta &&
-		    wiphy_ext_feature_isset(local->hw.wiphy,
-					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
+		if (txqi->txq.sta && local->airtime_flags & AIRTIME_USE_TX)
 			list_add(&txqi->schedule_order,
 				 &local->active_txqs[txq->ac]);
 		else
@@ -3740,6 +3745,37 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
 
+bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
+			     struct ieee80211_txq *txq)
+{
+	struct sta_info *sta;
+	struct ieee80211_local *local = hw_to_local(hw);
+
+
+	if (!(local->airtime_flags & AIRTIME_USE_TX))
+		return true;
+
+	if (!txq->sta)
+		return true;
+
+	sta = container_of(txq->sta, struct sta_info, sta);
+	if (sta->airtime[txq->ac].deficit < 0)
+		return false;
+
+	if (!(local->airtime_flags & AIRTIME_USE_AQL))
+		return true;
+
+	if ((sta->airtime[txq->ac].aql_tx_pending <
+	     sta->airtime[txq->ac].aql_limit_low) ||
+	    (local->aql_total_pending_airtime < local->aql_interface_limit &&
+	     sta->airtime[txq->ac].aql_tx_pending <
+	     sta->airtime[txq->ac].aql_limit_high))
+		return true;
+	else
+		return false;
+}
+EXPORT_SYMBOL(ieee80211_txq_airtime_check);
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
@@ -3748,10 +3784,13 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	struct sta_info *sta;
 	u8 ac = txq->ac;
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
-
 	if (!txqi->txq.sta)
-		goto out;
+		return true;
+
+	if (!(local->airtime_flags & AIRTIME_USE_TX))
+		return true;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
 
 	if (list_empty(&txqi->schedule_order))
 		goto out;
@@ -3773,10 +3812,11 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	}
 
 	sta = container_of(txqi->txq.sta, struct sta_info, sta);
-	if (sta->airtime[ac].deficit >= 0)
+	if (ieee80211_txq_airtime_check(hw, &txqi->txq))
 		goto out;
 
-	sta->airtime[ac].deficit += sta->airtime_weight;
+        if (sta->airtime[ac].deficit < 0)
+		sta->airtime[ac].deficit += sta->airtime_weight;
 	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 
-- 
2.23.0.581.g78d2f28ef7-goog

