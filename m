Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCE128F0F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Dec 2019 18:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLVRZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Dec 2019 12:25:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27905 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725919AbfLVRZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Dec 2019 12:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577035500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V6kWaCSmmH3ZHsWUhH6jdUYKwkQn9Eo3jAjEgUnGAIM=;
        b=cN7fy1ddCbNzngUdHLTlCalY3o2LdT591iM/anZXLxw/UbzcXpzI6urEXbBvO0Vx3eKsCd
        u/NWKncQlsVV6S4zEXhA7d2msdg2c7mlTot4vY7i2F9heSI7OTmMm9F90TR1QWJlERYY9N
        /mHCZyUt9yAOGHDSw8nUMq0Ps7ZYBpk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-699aanlsNMmY6B3dPtJm0g-1; Sun, 22 Dec 2019 12:24:59 -0500
X-MC-Unique: 699aanlsNMmY6B3dPtJm0g-1
Received: by mail-lj1-f199.google.com with SMTP id g5so986522ljj.22
        for <linux-wireless@vger.kernel.org>; Sun, 22 Dec 2019 09:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V6kWaCSmmH3ZHsWUhH6jdUYKwkQn9Eo3jAjEgUnGAIM=;
        b=c5xjTub9YqZkdCuewhknMEjA9v8syGKOqawNcK2o5ht3QT4lzjh2r5ojYJN39m8RNX
         pnF3C8+P8R1dk/+20SFLELuRMf3srR6w52xK5Eoe7gRr3BLUKSbWtbPfAM3t+yooAvMQ
         wDFtzcbiL4J7Zp+TIcEBZ02hNkood2Z1w3wBjSIcAnz2OKnBTQW8cJba24YNRTkcCeij
         ke1pnhEz4iHz1roITmTWg7b8Rni6d20uSQBVMMEPOOQnFdYJU3GY540UNWkACIabmoRn
         g/ITDMYlM8zSsHWxFFEONCG2GuNyj/951pp/t86ckxt+s0QXwh7MC5+Th03HnwSEbOTO
         Pg2A==
X-Gm-Message-State: APjAAAXHLLcfKRvx2/wHoidFmvRMtgUzAOYXk8I2kc5fMFi2ItjnlAd8
        8CcLEBsVF/QX6GgTVf1Vks+5zN3AtIxa/xMepqrl4WVi5QR057rKwgWr5jcRBcBm2tAcqn4neXf
        LV5odaGx1DBbvrfOWuICD0yV6dJg=
X-Received: by 2002:ac2:4553:: with SMTP id j19mr15161763lfm.142.1577035496696;
        Sun, 22 Dec 2019 09:24:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxL16QDaCrfcTfEF7bZttd1NTKunostnLbWnG7YytJ/yx3QTTPHCho0ycZ7DyqVP3jiLw8qxw==
X-Received: by 2002:ac2:4553:: with SMTP id j19mr15161744lfm.142.1577035495910;
        Sun, 22 Dec 2019 09:24:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t81sm6892667lff.25.2019.12.22.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 09:24:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E4391180979; Sun, 22 Dec 2019 18:24:48 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>,
        make-wifi-fast@lists.bufferbloat.net,
        Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH v5] mac80211: Switch to a virtual time-based airtime scheduler
Date:   Sun, 22 Dec 2019 18:24:23 +0100
Message-Id: <20191222172423.131033-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This switches the airtime scheduler in mac80211 to use a virtual time-based
scheduler instead of the round-robin scheduler used before. This has a
couple of advantages:

- No need to sync up the round-robin scheduler in firmware/hardware with
  the round-robin airtime scheduler.

- If several stations are eligible for transmission we can schedule both of
  them; no need to hard-block the scheduling rotation until the head of the
  queue has used up its quantum.

- The check of whether a station is eligible for transmission becomes
  simpler (in ieee80211_txq_may_transmit()).

The drawback is that scheduling becomes slightly more expensive, as we need
to maintain an rbtree of TXQs sorted by virtual time. This means that
ieee80211_register_airtime() becomes O(logN) in the number of currently
scheduled TXQs. However, hopefully this number rarely grows too big (it's
only TXQs currently backlogged, not all associated stations), so it
shouldn't be too big of an issue.

Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
This version resolves the two outstanding issues Felix pointed out back
at the RFC: The risk that the vif TXQ will always be scheduled first,
and the division in the fast path. This means that as far as I'm
concerned, this patch is now "feature complete". Didn't have a chance to
do anything other than compile-test it yet, but wanted to get it out
before the holidays (which I almost managed, since technically my
holiday started two days ago)...

Full changelog:

Changes since v4:
  Rebase on latest mac80211-next.

  Squash everything into a single patch again, and add back Yibo's
  co-developed-by tag and signoff.

  Move all the per-ac airtime-related data into separate structs.

  Use pre-calculated reciprocals to avoid divisions in the fast path.

  Record airtime usage for the vif TXQ to avoid it always being
  scheduled first.

Changes since v3:
  Change schedule_pos to previous node once it has chance to be moved/removed
  from current position in the tree in loop scenario and bring back schedule_round
  in case that same node is to be scheduled again in the mean time.

  Increase airtime grace period to 2000 us in the first patch.

  Put per-AC station weight checking in its lock during configuration from application.

Changes since v2:
  Changes station airtime weight to be per-AC based to avoid sync issue
  Remove Co-developed-by and Toke's sign-off as Toke suggested

Changes since v1:
  Modify the author of Co-developed-by as Johannes suggested

 include/net/mac80211.h     |  17 +--
 net/mac80211/cfg.c         |  30 +++-
 net/mac80211/debugfs.c     |  72 +++++++--
 net/mac80211/debugfs_sta.c |  24 +--
 net/mac80211/ieee80211_i.h |  73 ++++++++-
 net/mac80211/iface.c       |   3 +
 net/mac80211/main.c        |  10 +-
 net/mac80211/rx.c          |   6 +-
 net/mac80211/sta_info.c    |  69 ++++++---
 net/mac80211/sta_info.h    |  13 +-
 net/mac80211/status.c      |  17 +++
 net/mac80211/tx.c          | 296 +++++++++++++++++++++++--------------
 12 files changed, 438 insertions(+), 192 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 682fd2f4431b..4e9ef0fe294f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6362,9 +6362,6 @@ static inline void ieee80211_txq_schedule_end(struct ieee80211_hw *hw, u8 ac)
 {
 }
 
-void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
-			      struct ieee80211_txq *txq, bool force);
-
 /**
  * ieee80211_schedule_txq - schedule a TXQ for transmission
  *
@@ -6377,11 +6374,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
  * The driver may call this function if it has buffered packets for
  * this TXQ internally.
  */
-static inline void
-ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
-{
-	__ieee80211_schedule_txq(hw, txq, true);
-}
+void ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 
 /**
  * ieee80211_return_txq - return a TXQ previously acquired by ieee80211_next_txq()
@@ -6393,12 +6386,8 @@ ieee80211_schedule_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
  * The driver may set force=true if it has buffered packets for this TXQ
  * internally.
  */
-static inline void
-ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
-		     bool force)
-{
-	__ieee80211_schedule_txq(hw, txq, force);
-}
+void ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
+			  bool force);
 
 /**
  * ieee80211_txq_may_transmit - check whether TXQ is allowed to transmit
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4fb7f1f12109..9ce05740bcf0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1333,7 +1333,8 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	int ret = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 mask, set;
+	u32 mask, set, tid, ac, old_weight;
+	struct txq_info *txqi;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -1510,8 +1511,31 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		sta_apply_mesh_params(local, sta, params);
 
-	if (params->airtime_weight)
-		sta->airtime_weight = params->airtime_weight;
+	if (params->airtime_weight) {
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+			struct airtime_sched_info *air_sched = &local->airtime[ac];
+			struct airtime_info *air_info = &sta->airtime[ac];
+
+			spin_lock_bh(&air_sched->lock);
+			for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
+				if (air_info->weight == params->airtime_weight ||
+				    !sta->sta.txq[tid] ||
+				    ac != ieee80211_ac_from_tid(tid))
+					continue;
+
+				old_weight = air_info->weight;
+				airtime_weight_set(air_info, params->airtime_weight);
+
+				txqi = to_txq_info(sta->sta.txq[tid]);
+				if (RB_EMPTY_NODE(&txqi->schedule_order))
+					continue;
+
+				airtime_weight_add(air_sched,
+						   params->airtime_weight - old_weight);
+			}
+			spin_unlock_bh(&air_sched->lock);
+		}
+	}
 
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index ad41d74530c6..7c55d12466c4 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -165,14 +165,14 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			"VI	%u		%u\n"
 			"BE	%u		%u\n"
 			"BK	%u		%u\n",
-			local->aql_txq_limit_low[IEEE80211_AC_VO],
-			local->aql_txq_limit_high[IEEE80211_AC_VO],
-			local->aql_txq_limit_low[IEEE80211_AC_VI],
-			local->aql_txq_limit_high[IEEE80211_AC_VI],
-			local->aql_txq_limit_low[IEEE80211_AC_BE],
-			local->aql_txq_limit_high[IEEE80211_AC_BE],
-			local->aql_txq_limit_low[IEEE80211_AC_BK],
-			local->aql_txq_limit_high[IEEE80211_AC_BK]);
+			local->airtime[IEEE80211_AC_VO].aql_txq_limit_low,
+			local->airtime[IEEE80211_AC_VO].aql_txq_limit_high,
+			local->airtime[IEEE80211_AC_VI].aql_txq_limit_low,
+			local->airtime[IEEE80211_AC_VI].aql_txq_limit_high,
+			local->airtime[IEEE80211_AC_BE].aql_txq_limit_low,
+			local->airtime[IEEE80211_AC_BE].aql_txq_limit_high,
+			local->airtime[IEEE80211_AC_BK].aql_txq_limit_low,
+			local->airtime[IEEE80211_AC_BK].aql_txq_limit_high);
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -205,11 +205,11 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	if (ac >= IEEE80211_NUM_ACS)
 		return -EINVAL;
 
-	q_limit_low_old = local->aql_txq_limit_low[ac];
-	q_limit_high_old = local->aql_txq_limit_high[ac];
+	q_limit_low_old = local->airtime[ac].aql_txq_limit_low;
+	q_limit_high_old = local->airtime[ac].aql_txq_limit_high;
 
-	local->aql_txq_limit_low[ac] = q_limit_low;
-	local->aql_txq_limit_high[ac] = q_limit_high;
+	local->airtime[ac].aql_txq_limit_low = q_limit_low;
+	local->airtime[ac].aql_txq_limit_high = q_limit_high;
 
 	mutex_lock(&local->sta_mtx);
 	list_for_each_entry(sta, &local->sta_list, list) {
@@ -283,6 +283,46 @@ static const struct file_operations force_tx_status_ops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t airtime_read(struct file *file,
+			    char __user *user_buf,
+			    size_t count,
+			    loff_t *ppos)
+{
+	struct ieee80211_local *local = file->private_data;
+	char buf[200];
+	u64 v_t[IEEE80211_NUM_ACS];
+	u64 wt[IEEE80211_NUM_ACS];
+	int len = 0, ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->airtime[ac].lock);
+		v_t[ac] = local->airtime[ac].v_t;
+		wt[ac] = local->airtime[ac].weight_sum;
+		spin_unlock_bh(&local->airtime[ac].lock);
+	}
+	len = scnprintf(buf, sizeof(buf),
+			"\tVO         VI         BE         BK\n"
+			"Virt-t\t%-10llu %-10llu %-10llu %-10llu\n"
+			"Weight\t%-10llu %-10llu %-10llu %-10llu\n",
+			v_t[0],
+			v_t[1],
+			v_t[2],
+			v_t[3],
+			wt[0],
+			wt[1],
+			wt[2],
+			wt[3]);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buf, len);
+}
+
+static const struct file_operations airtime_ops = {
+	.read = airtime_read,
+	.open = simple_open,
+	.llseek = default_llseek,
+};
+
 #ifdef CONFIG_PM
 static ssize_t reset_write(struct file *file, const char __user *user_buf,
 			   size_t count, loff_t *ppos)
@@ -522,8 +562,12 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	if (local->ops->wake_tx_queue)
 		DEBUGFS_ADD_MODE(aqm, 0600);
 
-	debugfs_create_u16("airtime_flags", 0600,
-			   phyd, &local->airtime_flags);
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
+		DEBUGFS_ADD_MODE(airtime, 0600);
+		debugfs_create_u16("airtime_flags", 0600,
+				   phyd, &local->airtime_flags);
+	}
 
 	DEBUGFS_ADD(aql_txq_limit);
 	debugfs_create_u32("aql_threshold", 0600,
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 266d63819415..40df93b32c66 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -200,7 +200,7 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
-	s64 deficit[IEEE80211_NUM_ACS];
+	u64 v_t[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -208,18 +208,18 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->active_txq_lock[ac]);
+		spin_lock_bh(&local->airtime[ac].lock);
 		rx_airtime += sta->airtime[ac].rx_airtime;
 		tx_airtime += sta->airtime[ac].tx_airtime;
-		deficit[ac] = sta->airtime[ac].deficit;
-		spin_unlock_bh(&local->active_txq_lock[ac]);
+		v_t[ac] = sta->airtime[ac].v_t;
+		spin_unlock_bh(&local->airtime[ac].lock);
 	}
 
 	p += scnprintf(p, bufsz + buf - p,
 		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
-		rx_airtime, tx_airtime, sta->airtime_weight,
-		deficit[0], deficit[1], deficit[2], deficit[3]);
+		"Virt-T: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+		rx_airtime, tx_airtime, sta->airtime[0].weight,
+		v_t[0], v_t[1], v_t[2], v_t[3]);
 
 	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
@@ -234,11 +234,11 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 	int ac;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->active_txq_lock[ac]);
+		spin_lock_bh(&local->airtime[ac].lock);
 		sta->airtime[ac].rx_airtime = 0;
 		sta->airtime[ac].tx_airtime = 0;
-		sta->airtime[ac].deficit = sta->airtime_weight;
-		spin_unlock_bh(&local->active_txq_lock[ac]);
+		sta->airtime[ac].v_t = 0;
+		spin_unlock_bh(&local->airtime[ac].lock);
 	}
 
 	return count;
@@ -261,10 +261,10 @@ static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
 		return -ENOMEM;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->active_txq_lock[ac]);
+		spin_lock_bh(&local->airtime[ac].lock);
 		q_limit_l[ac] = sta->airtime[ac].aql_limit_low;
 		q_limit_h[ac] = sta->airtime[ac].aql_limit_high;
-		spin_unlock_bh(&local->active_txq_lock[ac]);
+		spin_unlock_bh(&local->airtime[ac].lock);
 		q_depth[ac] = atomic_read(&sta->airtime[ac].aql_tx_pending);
 	}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3cf24cb4615..db15f6100c2d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -843,7 +843,7 @@ struct txq_info {
 	struct codel_vars def_cvars;
 	struct codel_stats cstats;
 	struct sk_buff_head frags;
-	struct list_head schedule_order;
+	struct rb_node schedule_order;
 	u16 schedule_round;
 	unsigned long flags;
 
@@ -919,6 +919,8 @@ struct ieee80211_sub_if_data {
 	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
 	struct mac80211_qos_map __rcu *qos_map;
 
+	struct airtime_info airtime[IEEE80211_NUM_ACS];
+
 	struct work_struct csa_finalize_work;
 	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
 	struct cfg80211_chan_def csa_chandef;
@@ -1128,6 +1130,18 @@ enum mac80211_scan_state {
 	SCAN_ABORT,
 };
 
+struct airtime_sched_info {
+	spinlock_t lock;
+	struct rb_root_cached active_txqs;
+	struct rb_node *schedule_pos;
+	u64 v_t;
+	u64 weight_sum;
+	u64 weight_sum_reciprocal;
+	u32 aql_txq_limit_low;
+	u32 aql_txq_limit_high;
+	u16 schedule_round;
+};
+
 struct ieee80211_local {
 	/* embed the driver visible part.
 	 * don't cast (use the static inlines below), but we keep
@@ -1139,13 +1153,8 @@ struct ieee80211_local {
 	struct codel_params cparams;
 
 	/* protects active_txqs and txqi->schedule_order */
-	spinlock_t active_txq_lock[IEEE80211_NUM_ACS];
-	struct list_head active_txqs[IEEE80211_NUM_ACS];
-	u16 schedule_round[IEEE80211_NUM_ACS];
-
+	struct airtime_sched_info airtime[IEEE80211_NUM_ACS];
 	u16 airtime_flags;
-	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
-	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
 	atomic_t aql_total_pending_airtime;
 
@@ -1556,6 +1565,52 @@ static inline bool txq_has_queue(struct ieee80211_txq *txq)
 	return !(skb_queue_empty(&txqi->frags) && !txqi->tin.backlog_packets);
 }
 
+static inline struct airtime_info *to_airtime_info(struct ieee80211_txq *txq)
+{
+	struct ieee80211_sub_if_data *sdata;
+	struct sta_info *sta;
+
+	if (txq->sta) {
+		sta = container_of(txq->sta, struct sta_info, sta);
+		return &sta->airtime[txq->ac];
+	}
+
+	sdata = vif_to_sdata(txq->vif);
+	return &sdata->airtime[txq->ac];
+}
+
+static inline void airtime_weight_set(struct airtime_info *air_info, u16 weight)
+{
+	air_info->weight = weight;
+	if (weight) {
+		air_info->weight_reciprocal = IEEE80211_RECIPROCAL_DIVISOR;
+		do_div(air_info->weight_reciprocal, weight);
+	} else {
+		air_info->weight_reciprocal = 0;
+	}
+}
+
+static inline void airtime_weight_add(struct airtime_sched_info *air_sched,
+				      int weight)
+{
+	air_sched->weight_sum += weight;
+	if (air_sched->weight_sum) {
+		air_sched->weight_sum_reciprocal = IEEE80211_RECIPROCAL_DIVISOR;
+		do_div(air_sched->weight_sum_reciprocal, air_sched->weight_sum);
+	} else {
+		air_sched->weight_sum_reciprocal = 0;
+	}
+}
+
+static inline void init_airtime_info(struct airtime_info *air_info,
+				     struct airtime_sched_info *air_sched)
+{
+	atomic_set(&air_info->aql_tx_pending, 0);
+	air_info->aql_limit_low = air_sched->aql_txq_limit_low;
+	air_info->aql_limit_high = air_sched->aql_txq_limit_high;
+	airtime_weight_set(air_info, IEEE80211_DEFAULT_AIRTIME_WEIGHT);
+}
+
 static inline int ieee80211_bssid_match(const u8 *raddr, const u8 *addr)
 {
 	return ether_addr_equal(raddr, addr) ||
@@ -1789,6 +1844,10 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *dest, __be16 proto, bool unencrypted);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
+void ieee80211_resort_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq);
+void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq);
 
 /* HT */
 void ieee80211_apply_htcap_overrides(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9b833e170c20..a0481ea59212 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1922,6 +1922,9 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		}
 	}
 
+	for (i = 0; i < IEEE80211_NUM_ACS; i++)
+		init_airtime_info(&sdata->airtime[i], &local->airtime[i]);
+
 	ieee80211_set_default_queues(sdata);
 
 	sdata->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2b5ba3ac09..cf2e6be21b98 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -665,10 +665,12 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->queue_stop_reason_lock);
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		INIT_LIST_HEAD(&local->active_txqs[i]);
-		spin_lock_init(&local->active_txq_lock[i]);
-		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
-		local->aql_txq_limit_high[i] =
+		struct airtime_sched_info *air_sched = &local->airtime[i];
+
+		air_sched->active_txqs = RB_ROOT_CACHED;
+		spin_lock_init(&air_sched->lock);
+		air_sched->aql_txq_limit_low = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		air_sched->aql_txq_limit_high =
 			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0e05ff037672..eafdd7492aba 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1586,12 +1586,8 @@ static void sta_ps_start(struct sta_info *sta)
 
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
 		struct ieee80211_txq *txq = sta->sta.txq[tid];
-		struct txq_info *txqi = to_txq_info(txq);
 
-		spin_lock(&local->active_txq_lock[txq->ac]);
-		if (!list_empty(&txqi->schedule_order))
-			list_del_init(&txqi->schedule_order);
-		spin_unlock(&local->active_txq_lock[txq->ac]);
+		ieee80211_unschedule_txq(&local->hw, txq);
 
 		if (txq_has_queue(txq))
 			set_bit(tid, &sta->txq_buffered_tids);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0f5f40678885..c1d925096b02 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -404,15 +404,11 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	if (sta_prepare_rate_control(local, sta, gfp))
 		goto free_txq;
 
-	sta->airtime_weight = IEEE80211_DEFAULT_AIRTIME_WEIGHT;
 
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
-		sta->airtime[i].deficit = sta->airtime_weight;
-		atomic_set(&sta->airtime[i].aql_tx_pending, 0);
-		sta->airtime[i].aql_limit_low = local->aql_txq_limit_low[i];
-		sta->airtime[i].aql_limit_high = local->aql_txq_limit_high[i];
+		init_airtime_info(&sta->airtime[i], &local->airtime[i]);
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1889,24 +1885,58 @@ void ieee80211_sta_set_buffered(struct ieee80211_sta *pubsta,
 }
 EXPORT_SYMBOL(ieee80211_sta_set_buffered);
 
-void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
-				    u32 tx_airtime, u32 rx_airtime)
+void ieee80211_register_airtime(struct ieee80211_txq *txq,
+				u32 tx_airtime, u32 rx_airtime)
 {
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-	struct ieee80211_local *local = sta->sdata->local;
-	u8 ac = ieee80211_ac_from_tid(tid);
-	u32 airtime = 0;
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->vif);
+	u64 airtime = 0, weight_sum, weight_sum_reciprocal;
+	struct ieee80211_local *local = sdata->local;
+	struct airtime_sched_info *air_sched;
+	struct airtime_info *air_info;
+
+	air_sched = &local->airtime[txq->ac];
+	air_info = to_airtime_info(txq);
 
-	if (sta->local->airtime_flags & AIRTIME_USE_TX)
+	if (local->airtime_flags & AIRTIME_USE_TX)
 		airtime += tx_airtime;
-	if (sta->local->airtime_flags & AIRTIME_USE_RX)
+	if (local->airtime_flags & AIRTIME_USE_RX)
 		airtime += rx_airtime;
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
-	sta->airtime[ac].tx_airtime += tx_airtime;
-	sta->airtime[ac].rx_airtime += rx_airtime;
-	sta->airtime[ac].deficit -= airtime;
-	spin_unlock_bh(&local->active_txq_lock[ac]);
+	/* Weights scale so the unit weight is 256 */
+	airtime <<= 8;
+
+	spin_lock_bh(&air_sched->lock);
+
+	air_info->tx_airtime += tx_airtime;
+	air_info->rx_airtime += rx_airtime;
+
+	if (air_sched->weight_sum) {
+		weight_sum = air_sched->weight_sum;
+		weight_sum_reciprocal = air_sched->weight_sum_reciprocal;
+	} else {
+		weight_sum = air_info->weight;
+		weight_sum_reciprocal = air_info->weight_reciprocal;
+	}
+
+	/* Round the calculation of global vt */
+	air_sched->v_t += ((airtime + (weight_sum >> 1)) *
+			   weight_sum_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT;
+	air_info->v_t += (airtime * air_info->weight_reciprocal) >>
+		IEEE80211_RECIPROCAL_SHIFT;
+	ieee80211_resort_txq(&local->hw, txq);
+
+	spin_unlock_bh(&air_sched->lock);
+}
+
+void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
+				    u32 tx_airtime, u32 rx_airtime)
+{
+	struct ieee80211_txq *txq = pubsta->txq[tid];
+
+	if (!txq)
+		return;
+
+	ieee80211_register_airtime(txq, tx_airtime, rx_airtime);
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
 
@@ -1948,6 +1978,7 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 			       tx_pending, 0);
 }
 
+
 int sta_info_move_state(struct sta_info *sta,
 			enum ieee80211_sta_state new_state)
 {
@@ -2330,7 +2361,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT))) {
-		sinfo->airtime_weight = sta->airtime_weight;
+		sinfo->airtime_weight = sta->airtime[0].weight;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_AIRTIME_WEIGHT);
 	}
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index c00e28585f9d..1cdecca28b3d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,19 +127,27 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
+#define AIRTIME_GRACE 2000 /* usec of grace period before reset */
+
+#define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
+#define IEEE80211_RECIPROCAL_SHIFT 32
 
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
-	s64 deficit;
+	u64 v_t;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
 	u32 aql_limit_low;
 	u32 aql_limit_high;
+	u64 weight_reciprocal;
+	u16 weight;
 };
 
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
 					  u16 tx_airtime, bool tx_completed);
+void ieee80211_register_airtime(struct ieee80211_txq *txq,
+				u32 tx_airtime, u32 rx_airtime);
 
 struct sta_info;
 
@@ -480,7 +488,6 @@ struct ieee80211_sta_rx_stats {
  * @tid_seq: per-TID sequence numbers for sending to this STA
  * @airtime: per-AC struct airtime_info describing airtime statistics for this
  *	station
- * @airtime_weight: station weight for airtime fairness calculation purposes
  * @ampdu_mlme: A-MPDU state machine state
  * @mesh: mesh STA information
  * @debugfs_dir: debug filesystem directory dentry
@@ -525,6 +532,7 @@ struct ieee80211_sta_rx_stats {
  * @status_stats.ack_signal_filled: last ACK signal validity
  * @status_stats.avg_ack_signal: average ACK signal
  */
+
 struct sta_info {
 	/* General information, mostly static */
 	struct list_head list, free_list;
@@ -607,7 +615,6 @@ struct sta_info {
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
 	struct airtime_info airtime[IEEE80211_NUM_ACS];
-	u16 airtime_weight;
 
 	/*
 	 * Aggregation information, locked with lock.
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 0344b82a34f5..e2f660addc9f 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1025,6 +1025,23 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 				ieee80211_lost_packet(sta, info);
 			}
 		}
+	} else if (wiphy_ext_feature_isset(local->hw.wiphy,
+					   NL80211_EXT_FEATURE_AIRTIME_FAIRNESS)) {
+		struct ieee80211_sub_if_data *sdata;
+		struct ieee80211_txq *txq;
+		u32 airtime;
+
+		sdata = ieee80211_sdata_from_skb(local, skb);
+
+		if (sdata && (txq = sdata->vif.txq)) {
+			airtime = info->status.tx_time ?:
+				ieee80211_calc_expected_tx_airtime(hw,
+								   &sdata->vif,
+								   NULL,
+								   skb->len);
+
+			ieee80211_register_airtime(txq, airtime, 0);
+		}
 	}
 
 	/* SNMP counters
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 302cc7c83a4f..d63145f86c39 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1451,7 +1451,7 @@ void ieee80211_txq_init(struct ieee80211_sub_if_data *sdata,
 	codel_vars_init(&txqi->def_cvars);
 	codel_stats_init(&txqi->cstats);
 	__skb_queue_head_init(&txqi->frags);
-	INIT_LIST_HEAD(&txqi->schedule_order);
+	RB_CLEAR_NODE(&txqi->schedule_order);
 
 	txqi->txq.vif = &sdata->vif;
 
@@ -1495,9 +1495,7 @@ void ieee80211_txq_purge(struct ieee80211_local *local,
 	ieee80211_purge_tx_queue(&local->hw, &txqi->frags);
 	spin_unlock_bh(&fq->lock);
 
-	spin_lock_bh(&local->active_txq_lock[txqi->txq.ac]);
-	list_del_init(&txqi->schedule_order);
-	spin_unlock_bh(&local->active_txq_lock[txqi->txq.ac]);
+	ieee80211_unschedule_txq(&local->hw, &txqi->txq);
 }
 
 void ieee80211_txq_set_params(struct ieee80211_local *local)
@@ -3699,100 +3697,194 @@ EXPORT_SYMBOL(ieee80211_tx_dequeue);
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct airtime_sched_info *air_sched;
 	struct ieee80211_txq *ret = NULL;
-	struct txq_info *txqi = NULL, *head = NULL;
-	bool found_eligible_txq = false;
+	struct txq_info *txqi = NULL;
+	struct airtime_info *air_info;
+	struct rb_node *node;
+	bool first = false;
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
+	air_sched = &local->airtime[ac];
+	spin_lock_bh(&air_sched->lock);
 
- begin:
-	txqi = list_first_entry_or_null(&local->active_txqs[ac],
-					struct txq_info,
-					schedule_order);
-	if (!txqi)
+	node = air_sched->schedule_pos;
+
+begin:
+	if (!node) {
+		node = rb_first_cached(&air_sched->active_txqs);
+		first = true;
+	} else {
+		node = rb_next(node);
+	}
+
+	if (!node)
 		goto out;
 
-	if (txqi == head) {
-		if (!found_eligible_txq)
-			goto out;
+	txqi = container_of(node, struct txq_info, schedule_order);
+	air_info = to_airtime_info(&txqi->txq);
+
+	if (air_info->v_t > air_sched->v_t) {
+		if (first)
+			air_sched->v_t = air_sched->v_t;
 		else
-			found_eligible_txq = false;
+			goto out;
 	}
 
-	if (!head)
-		head = txqi;
-
-	if (txqi->txq.sta) {
-		struct sta_info *sta = container_of(txqi->txq.sta,
-						    struct sta_info, sta);
-		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
-		s64 deficit = sta->airtime[txqi->txq.ac].deficit;
+	if (!ieee80211_txq_airtime_check(hw, &txqi->txq)) {
+		first = false;
+		goto begin;
+	}
 
-		if (aql_check)
-			found_eligible_txq = true;
+	if (txqi->schedule_round == air_sched->schedule_round)
+		goto begin;
 
-		if (deficit < 0)
-			sta->airtime[txqi->txq.ac].deficit +=
-				sta->airtime_weight;
+	txqi->schedule_round = air_sched->schedule_round;
+	air_sched->schedule_pos = node;
+	ret = &txqi->txq;
+out:
+	spin_unlock_bh(&air_sched->lock);
+	return ret;
+}
+EXPORT_SYMBOL(ieee80211_next_txq);
 
-		if (deficit < 0 || !aql_check) {
-			list_move_tail(&txqi->schedule_order,
-				       &local->active_txqs[txqi->txq.ac]);
-			goto begin;
+static void __ieee80211_insert_txq(struct rb_root_cached *root,
+				   struct txq_info *txqi)
+{
+	struct rb_node **new = &root->rb_root.rb_node;
+	struct airtime_info *old_air, *new_air;
+	struct rb_node *parent = NULL;
+	struct txq_info *__txqi;
+	bool leftmost = true;
+
+	while (*new) {
+		parent = *new;
+		__txqi = rb_entry(parent, struct txq_info, schedule_order);
+		old_air = to_airtime_info(&__txqi->txq);
+		new_air = to_airtime_info(&txqi->txq);
+
+		if (new_air->v_t <= old_air->v_t) {
+			/* new txqi has no sta - insert to the left */
+			new = &parent->rb_left;
+		} else {
+			/* existing txqi has no sta - insert to the right */
+			new = &parent->rb_right;
+			leftmost = false;
 		}
 	}
 
+	rb_link_node(&txqi->schedule_order, parent, new);
+	rb_insert_color_cached(&txqi->schedule_order, root, leftmost);
+}
 
-	if (txqi->schedule_round == local->schedule_round[ac])
+void ieee80211_resort_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+	struct airtime_sched_info *air_sched;
+
+	air_sched = &local->airtime[txq->ac];
+
+	lockdep_assert_held(&air_sched->lock);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order)) {
+		if (air_sched->schedule_pos == &txqi->schedule_order)
+			air_sched->schedule_pos = rb_prev(&txqi->schedule_order);
+
+		rb_erase_cached(&txqi->schedule_order,
+				&air_sched->active_txqs);
+		RB_CLEAR_NODE(&txqi->schedule_order);
+		__ieee80211_insert_txq(&air_sched->active_txqs, txqi);
+	}
+}
+
+void ieee80211_schedule_txq(struct ieee80211_hw *hw,
+			    struct ieee80211_txq *txq)
+	__acquires(txq_lock) __releases(txq_lock)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+	struct airtime_sched_info *air_sched;
+	struct airtime_info *air_info;
+	u8 ac = txq->ac;
+
+	air_sched = &local->airtime[ac];
+	air_info = to_airtime_info(txq);
+
+	spin_lock_bh(&air_sched->lock);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order))
 		goto out;
 
-	list_del_init(&txqi->schedule_order);
-	txqi->schedule_round = local->schedule_round[ac];
-	ret = &txqi->txq;
+	airtime_weight_add(air_sched, air_info->weight);
+	if (air_sched->v_t > AIRTIME_GRACE)
+		air_info->v_t = max(air_sched->v_t - AIRTIME_GRACE,
+				    air_info->v_t);
+
+	__ieee80211_insert_txq(&air_sched->active_txqs, txqi);
 
 out:
-	spin_unlock_bh(&local->active_txq_lock[ac]);
-	return ret;
+	spin_unlock_bh(&air_sched->lock);
 }
-EXPORT_SYMBOL(ieee80211_next_txq);
+EXPORT_SYMBOL(ieee80211_schedule_txq);
 
-void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
-			      struct ieee80211_txq *txq,
-			      bool force)
+static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+				       struct ieee80211_txq *txq)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
+	struct airtime_sched_info *air_sched;
+	struct airtime_info *air_info;
 
-	spin_lock_bh(&local->active_txq_lock[txq->ac]);
-
-	if (list_empty(&txqi->schedule_order) &&
-	    (force || !skb_queue_empty(&txqi->frags) ||
-	     txqi->tin.backlog_packets)) {
-		/* If airtime accounting is active, always enqueue STAs at the
-		 * head of the list to ensure that they only get moved to the
-		 * back by the airtime DRR scheduler once they have a negative
-		 * deficit. A station that already has a negative deficit will
-		 * get immediately moved to the back of the list on the next
-		 * call to ieee80211_next_txq().
-		 */
-		if (txqi->txq.sta &&
-		    wiphy_ext_feature_isset(local->hw.wiphy,
-					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
-			list_add(&txqi->schedule_order,
-				 &local->active_txqs[txq->ac]);
-		else
-			list_add_tail(&txqi->schedule_order,
-				      &local->active_txqs[txq->ac]);
-	}
+	air_sched = &local->airtime[txq->ac];
+	air_info = to_airtime_info(&txqi->txq);
+
+	lockdep_assert_held(&air_sched->lock);
+
+	if (RB_EMPTY_NODE(&txqi->schedule_order))
+		return;
+
+	if (air_sched->schedule_pos == &txqi->schedule_order)
+		air_sched->schedule_pos = rb_prev(&txqi->schedule_order);
+
+	airtime_weight_add(air_sched, -air_info->weight);
+
+	rb_erase_cached(&txqi->schedule_order,
+			&air_sched->active_txqs);
+	RB_CLEAR_NODE(&txqi->schedule_order);
+}
+
+void ieee80211_unschedule_txq(struct ieee80211_hw *hw,
+			      struct ieee80211_txq *txq)
+	__acquires(txq_lock) __releases(txq_lock)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+
+	spin_lock_bh(&local->airtime[txq->ac].lock);
+	__ieee80211_unschedule_txq(hw, txq);
+	spin_unlock_bh(&local->airtime[txq->ac].lock);
+}
+
+void ieee80211_return_txq(struct ieee80211_hw *hw,
+			  struct ieee80211_txq *txq, bool force)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct txq_info *txqi = to_txq_info(txq);
+
+	spin_lock_bh(&local->airtime[txq->ac].lock);
+
+	if (!RB_EMPTY_NODE(&txqi->schedule_order) && !force &&
+	    !txq_has_queue(txq))
+		__ieee80211_unschedule_txq(hw, txq);
 
-	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
+	spin_unlock_bh(&local->airtime[txq->ac].lock);
 }
-EXPORT_SYMBOL(__ieee80211_schedule_txq);
+EXPORT_SYMBOL(ieee80211_return_txq);
 
 bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 				 struct ieee80211_txq *txq)
 {
-	struct sta_info *sta;
+	struct airtime_info *air_info = to_airtime_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
@@ -3801,15 +3893,12 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (!txq->sta)
 		return true;
 
-	sta = container_of(txq->sta, struct sta_info, sta);
-	if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
-	    sta->airtime[txq->ac].aql_limit_low)
+	if (atomic_read(&air_info->aql_tx_pending) < air_info->aql_limit_low)
 		return true;
 
 	if (atomic_read(&local->aql_total_pending_airtime) <
 	    local->aql_threshold &&
-	    atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
-	    sta->airtime[txq->ac].aql_limit_high)
+	    atomic_read(&air_info->aql_tx_pending) < air_info->aql_limit_high)
 		return true;
 
 	return false;
@@ -3819,60 +3908,45 @@ EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
+	struct txq_info *first_txqi = NULL, *txqi = to_txq_info(txq);
 	struct ieee80211_local *local = hw_to_local(hw);
-	struct txq_info *iter, *tmp, *txqi = to_txq_info(txq);
-	struct sta_info *sta;
-	u8 ac = txq->ac;
+	struct airtime_sched_info *air_sched;
+	struct airtime_info *air_info;
+	struct rb_node *node = NULL;
+	bool ret;
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
+	if (!ieee80211_txq_airtime_check(hw, txq))
+		return false;
 
-	if (!txqi->txq.sta)
-		goto out;
+	air_sched = &local->airtime[txq->ac];
+	spin_lock_bh(&air_sched->lock);
 
-	if (list_empty(&txqi->schedule_order))
-		goto out;
+	node = rb_first_cached(&air_sched->active_txqs);
+	if (node) {
+		first_txqi = container_of(node, struct txq_info,
+					  schedule_order);
+		air_info = to_airtime_info(&first_txqi->txq);
 
-	list_for_each_entry_safe(iter, tmp, &local->active_txqs[ac],
-				 schedule_order) {
-		if (iter == txqi)
-			break;
-
-		if (!iter->txq.sta) {
-			list_move_tail(&iter->schedule_order,
-				       &local->active_txqs[ac]);
-			continue;
-		}
-		sta = container_of(iter->txq.sta, struct sta_info, sta);
-		if (sta->airtime[ac].deficit < 0)
-			sta->airtime[ac].deficit += sta->airtime_weight;
-		list_move_tail(&iter->schedule_order, &local->active_txqs[ac]);
+		if (air_sched->v_t < air_info->v_t)
+			air_sched->v_t = air_info->v_t;
 	}
 
-	sta = container_of(txqi->txq.sta, struct sta_info, sta);
-	if (sta->airtime[ac].deficit >= 0)
-		goto out;
-
-	sta->airtime[ac].deficit += sta->airtime_weight;
-	list_move_tail(&txqi->schedule_order, &local->active_txqs[ac]);
-	spin_unlock_bh(&local->active_txq_lock[ac]);
+	air_info = to_airtime_info(&txqi->txq);
+	ret = (air_info->v_t <= air_sched->v_t);
 
-	return false;
-out:
-	if (!list_empty(&txqi->schedule_order))
-		list_del_init(&txqi->schedule_order);
-	spin_unlock_bh(&local->active_txq_lock[ac]);
-
-	return true;
+	spin_unlock_bh(&air_sched->lock);
+	return ret;
 }
 EXPORT_SYMBOL(ieee80211_txq_may_transmit);
 
 void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	struct airtime_sched_info *air_sched = &local->airtime[ac];
 
-	spin_lock_bh(&local->active_txq_lock[ac]);
-	local->schedule_round[ac]++;
-	spin_unlock_bh(&local->active_txq_lock[ac]);
+	spin_lock_bh(&air_sched->lock);
+	air_sched->schedule_round++;
+	spin_unlock_bh(&air_sched->lock);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
-- 
2.24.1

