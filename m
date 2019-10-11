Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F3BD377E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJKCYX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Oct 2019 22:24:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:49608 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfJKCYX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Oct 2019 22:24:23 -0400
Received: by mail-pg1-f201.google.com with SMTP id l6so5827468pgq.16
        for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2019 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iy3/2CPaGQldv0uXX/s6G4YvrAYLLpvHAwubBPa9QCA=;
        b=VMr258XjekpKCGS+3nfj73PHFx1hLF/ASpq9nZOeVgkYBNoNm1vEVI5xG+OSM5OWeq
         Kf0aNGphwamukpF2YfBtxlgShVAvGxS3aBqgGUWxBjpuPI8RMWKFsBuHxnoiI9YNKAxf
         taY6NGkshcYJdrE8PtSzouANc0nVTgtnU3WzL9vF3VBY/PT05rBtuq00DUOMrDuoXiyT
         7fmaxPvFQAEL0I9i9dFERw7VOqc2muem0DTu+nZbsF433CgyQa7HAG/ab+1AQxpjpHr7
         Dq20CY0pI6SmqrgadJjj2178Hu9R9AhcTvar0UZEXKz4htmW3cVo04zwJ7BPVsArbOB8
         8gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iy3/2CPaGQldv0uXX/s6G4YvrAYLLpvHAwubBPa9QCA=;
        b=X9l59ztbwyYow1bzSmvih8BEQPyEBidne2hpXYvdD95Af8EY13xKqNCTN/rvjj5xPU
         BqmQkgor28mF12GklMrE+w/LexHOwvaRjGijAeRReNuRHf1wzRy+TFjPowKeyBLfwzsw
         GTSMNoT66P9DDKSuW7AYYliKRb372493mt78KgH729qWQ1maBGnYfqSBotHAhn5HF6PL
         cjS3ut7w6lrN+C0ULpUja5o99DvGnpoCnlbDg6nmBKZU/t068EM0A31nyQtKQuaiApBl
         /I27rP1JXRiBfcUFDr2FAGbJy2j+Gs/KhK7osqmR8n+pvBEicR8938bRl3CdWlqc1w2V
         vFnw==
X-Gm-Message-State: APjAAAVKMfDFax+1o1P0Ii4g4knr/MJ0Lg4EP1k31DesKXQsenmsB3GQ
        mBjx46c0kv46rhKi6XGCD2I54R1I
X-Google-Smtp-Source: APXvYqz29DqwTTe1UnQqgxi1MlDTssmPESGpdvLxWdQDigWZNzUADHNzvKsGKpFZchY/+RPNnvEKuOP0
X-Received: by 2002:a65:5c45:: with SMTP id v5mr13882982pgr.82.1570760660700;
 Thu, 10 Oct 2019 19:24:20 -0700 (PDT)
Date:   Thu, 10 Oct 2019 19:24:12 -0700
In-Reply-To: <20191011022413.176208-1-kyan@google.com>
Message-Id: <20191011022413.176208-2-kyan@google.com>
Mime-Version: 1.0
References: <20191011022413.176208-1-kyan@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v4 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, ath10k@lists.infradead.org, yiboz@codeaurora.org,
        Kan Yan <kyan@google.com>
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
 include/net/mac80211.h     | 47 +++++++++++++++++++++++
 net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c | 43 ++++++++++++++++-----
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/main.c        |  9 ++++-
 net/mac80211/sta_info.c    | 33 ++++++++++++++++
 net/mac80211/sta_info.h    |  4 ++
 net/mac80211/tx.c          | 46 ++++++++++++++++++++--
 9 files changed, 257 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 26e2ad2c7027..781cf4f2daa3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2499,6 +2499,13 @@ enum wiphy_params_flags {
 
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT	256
 
+/* The per TXQ device queue limit in airtime */
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
index d26da013f7c0..65dd99974165 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5543,6 +5543,53 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_sta *pubsta, int tid);
 void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 				    u32 tx_airtime, u32 rx_airtime);
 
+/**
+ * ieee80211_sta_update_pending_airtime - update txq's estimated airtime
+ *
+ * Update the estimated total airtime of frames queued in device.
+ *
+ * The pending airtime is used to enforce queue limit by AQL to prevent too
+ * many packets get queued in the device. The airtime can be estimated from the
+ * station's current data rate and stored in the frame's CB field.
+ * ieee80211_sta_register_pending_airtime() should be called to increment the
+ * pending airtime when a frame is sent to device. The same amount of airtime
+ * should be subtracted by calling ieee80211_sta_release_pending_airtime() when
+ * a frame is completed, either successfully transmitted or failed.
+ *
+ * @pubsta: the station
+ * @tid: the TID to update airtime for
+ * @tx_airtime: the estimated airtime (in usec)
+ */
+void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta,
+					  u8 tid, u32 tx_airtime,
+					  bool tx_completed);
+
+static inline void
+ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta,
+				       u8 tid, u32 tx_airtime)
+{
+	ieee80211_sta_update_pending_airtime(pubsta, tid, tx_airtime, false);
+}
+
+static inline void
+ieee80211_sta_release_pending_airtime(struct ieee80211_sta *pubsta,
+				      u8 tid, u32 tx_airtime)
+{
+	ieee80211_sta_update_pending_airtime(pubsta, tid, tx_airtime, true);
+}
+
+/**
+ * ieee80211_txq_airtime_check - check if a txq can send frame to device
+ *
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ *
+ * Return true if the AQL's airtime limit has not been reached and the txq can
+ * continue to send more packets to the device. Otherwise return false.
+ */
+bool
+ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2e7f75938c51..ad7bcda1e025 100644
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
+			"VO	%u		%u\n"
+			"VI	%u		%u\n"
+			"BE	%u		%u\n"
+			"BK	%u		%u\n",
+			local->aql_txq_limit_low[IEEE80211_AC_VO],
+			local->aql_txq_limit_high[IEEE80211_AC_VO],
+			local->aql_txq_limit_low[IEEE80211_AC_VI],
+			local->aql_txq_limit_high[IEEE80211_AC_VI],
+			local->aql_txq_limit_low[IEEE80211_AC_BE],
+			local->aql_txq_limit_high[IEEE80211_AC_BE],
+			local->aql_txq_limit_low[IEEE80211_AC_BK],
+			local->aql_txq_limit_high[IEEE80211_AC_BK]);
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
+	u32 ac, q_limit_low, q_limit_high;
+	struct sta_info *sta;
+
+	if (count > sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+
+	buf[sizeof(buf) - 1] = 0;
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
index c8ad20c28c43..9f9b8f5ed86a 100644
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
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 004e2e3adb88..1d2b6f6f745c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 	u16 schedule_round[IEEE80211_NUM_ACS];
 
 	u16 airtime_flags;
+	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+	u32 aql_threshold;
+	u32 aql_total_pending_airtime;
 
 	const struct ieee80211_ops *ops;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2702f128f3..dcbcd0f85a86 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -666,8 +666,15 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
+		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		local->aql_txq_limit_high[i] =
+			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
-	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+	local->airtime_flags = AIRTIME_USE_TX |
+			       AIRTIME_USE_RX |
+			       AIRTIME_USE_AQL;
+	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 95eb8220e2e4..e8a7c250e7b5 100644
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
@@ -1894,6 +1897,36 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
+void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta, u8 tid,
+					  u32 tx_airtime, bool tx_completed)
+{
+	u8 ac = ieee80211_ac_from_tid(tid);
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct ieee80211_local *local = sta->local;
+
+	spin_lock_bh(&local->active_txq_lock[ac]);
+	if (tx_completed) {
+		if (WARN_ONCE(sta->airtime[ac].aql_tx_pending < tx_airtime,
+			      "TXQ pending airtime underflow: %u, %u",
+			      sta->airtime[ac].aql_tx_pending, tx_airtime))
+			sta->airtime[ac].aql_tx_pending = 0;
+		else
+			sta->airtime[ac].aql_tx_pending -= tx_airtime;
+
+		if (WARN_ONCE(local->aql_total_pending_airtime < tx_airtime,
+			      "Device pending airtime underflow: %u, %u",
+			      local->aql_total_pending_airtime, tx_airtime))
+			local->aql_total_pending_airtime = 0;
+		else
+			local->aql_total_pending_airtime -= tx_airtime;
+	} else {
+		sta->airtime[ac].aql_tx_pending += tx_airtime;
+		local->aql_total_pending_airtime += tx_airtime;
+	}
+	spin_unlock_bh(&local->active_txq_lock[ac]);
+}
+EXPORT_SYMBOL(ieee80211_sta_update_pending_airtime);
+
 int sta_info_move_state(struct sta_info *sta,
 			enum ieee80211_sta_state new_state)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 3260d4234920..6ce252407b19 100644
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
+	u32 aql_tx_pending; /* Estimated airtime for frames pending in queue */
+	u32 aql_limit_low;
+	u32 aql_limit_high;
 };
 
 struct sta_info;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f13eb2f61ccf..5f6cb4caa114 100644
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
 
@@ -3680,13 +3681,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
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
+		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
+		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
+
+		if (aql_check)
+			found_eligible_txq = true;
 
-		if (sta->airtime[txqi->txq.ac].deficit < 0) {
+		if (deficit < 0)
 			sta->airtime[txqi->txq.ac].deficit +=
 				sta->airtime_weight;
+
+		if (deficit < 0 || !aql_check) {
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
@@ -3740,6 +3754,32 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
 
+bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
+				 struct ieee80211_txq *txq)
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
+	    sta->airtime[txq->ac].aql_limit_low)
+		return true;
+
+	if (local->aql_total_pending_airtime < local->aql_threshold &&
+	    sta->airtime[txq->ac].aql_tx_pending <
+	    sta->airtime[txq->ac].aql_limit_high)
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL(ieee80211_txq_airtime_check);
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
-- 
2.23.0.700.g56cf767bdb-goog

