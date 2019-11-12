Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78CE4F86C3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 03:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKLCLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 21:11:55 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42492 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKLCLz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 21:11:55 -0500
Received: by mail-yb1-f202.google.com with SMTP id s7so13301405ybc.9
        for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2019 18:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bd5HhSVLJAcn4q/e4pw2+tp/oBLGlEV87QKwGKhUJ44=;
        b=I4PdQUBkhuGLaXnbtC2NmMC713PT2PcgetftZHMklW6bPMhJdVc337SGZpVNQnfTrd
         L0IbM0CW4TyHbyuQKvsARPGN+yw9pv6azNxVkjjS1NrhygJmlbF9cNTiOxUN72IOKZJa
         XLVVQbi42eV5NtylA084Z5csoSFfE+tQcBwvaY3tYBmWF6MxEhM3Aj14Ael8pEz9IQMM
         18w72bc4rO6o0g898GaIPQXp5PRugQ9Y4VoWTGXG8TCbhCl23SuLXLWGbk01OWYC0w3C
         uyNZzOjvTswC9SZ3QzZ5jCItYXe5/hsLXw3wUogDP2de8LKp6Q9Y5/irNqrk5WflQ3ju
         pTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bd5HhSVLJAcn4q/e4pw2+tp/oBLGlEV87QKwGKhUJ44=;
        b=oBq5YfuZwI8lzHf7Hg4FuUbEi314Bg/1mFG3tFUAlLsJQkxVo9GCD1eSyR2GUYDSK5
         vniowbHkNMoFrgQe2UuZCFzZegRkzWVk/nsNw/NB0UgqeAKtnTZAzWdaoDbz/caaABPG
         HrZdYtq96Ud2GHtUktDifBorM2s+qNymvC0ewFezfhKO8MpcduVcdZQXYinCgEOn9DEe
         JQb+K0NlFpHhLXJdjPXYoVeDCyh35dCOFXYpBWkTm8iB8CmbSmPCPtpQRbUIRxnjTzCi
         Oz0s1h8tkV1FJuo5TD8T07ulJfv94VfqKsYvhwaC+hmtqUV7Z86fWAipFb5h0OD+BPqJ
         c1tQ==
X-Gm-Message-State: APjAAAVHirRmGYyDwvZtJEmGIMxhsVyK6Jd3LxA+q/FkLzeZHZN7ptHA
        MsN4BXTHRu3mILAkhDAzBczYFtmw
X-Google-Smtp-Source: APXvYqzxPY9l0lw7BQ7Zlts78P8eBYhBFo3y6qcc9K1rFDpBDk+ZXLdMAfS8pLnO/ZyfVqvvvhXZiEqh
X-Received: by 2002:a0d:fc46:: with SMTP id m67mr2474169ywf.135.1573524711010;
 Mon, 11 Nov 2019 18:11:51 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:11:35 -0800
In-Reply-To: <20191112021136.42918-1-kyan@google.com>
Message-Id: <20191112021136.42918-2-kyan@google.com>
Mime-Version: 1.0
References: <20191112021136.42918-1-kyan@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v7 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Kan Yan <kyan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, john@phrozen.org,
        lorenzo@kernel.org, rmanohar@codeaurora.org, kevinhayes@google.com,
        Kan Yan <kyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order for the Fq_CoDel algorithm integrated in mac80211 layer to operate
effectively to control excessive queueing latency, the CoDel algorithm
requires an accurate measure of how long packets stays in the queue, AKA
sojourn time. The sojourn time measured at the mac80211 layer doesn't
include queueing latency in the lower layer (firmware/hardware) and CoDel
expects lower layer to have a short queue. However, most 802.11ac chipsets
offload tasks such TX aggregation to firmware or hardware, thus have a deep
lower layer queue.

Without a mechanism to control the lower layer queue size, packets only
stay in mac80211 layer transiently before being sent to firmware queue.
As a result, the sojourn time measured by CoDel in the mac80211 layer is
almost always lower than the CoDel latency target, hence CoDel does little
to control the latency, even when the lower layer queue causes excessive
latency.

The Byte Queue Limits (BQL) mechanism is commonly used to address the
similar issue with wired network interface. However, this method cannot be
applied directly to the wireless network interface. "Bytes" is not a
suitable measure of queue depth in the wireless network, as the data rate
can vary dramatically from station to station in the same network, from a
few Mbps to over Gbps.

This patch implements an Airtime-based Queue Limit (AQL) to make CoDel work
effectively with wireless drivers that utilized firmware/hardware
offloading. AQL allows each txq to release just enough packets to the lower
layer to form 1-2 large aggregations to keep hardware fully utilized and
retains the rest of the frames in mac80211 layer to be controlled by the
CoDel algorithm.

Signed-off-by: Kan Yan <kyan@google.com>
[ Toke: Keep API to set pending airtime internal, fix nits in commit msg ]
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 include/net/cfg80211.h     |  7 ++++
 include/net/mac80211.h     | 12 ++++++
 net/mac80211/debugfs.c     | 78 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs_sta.c | 43 ++++++++++++++++-----
 net/mac80211/ieee80211_i.h |  4 ++
 net/mac80211/main.c        | 10 ++++-
 net/mac80211/sta_info.c    | 40 +++++++++++++++++++
 net/mac80211/sta_info.h    |  8 ++++
 net/mac80211/tx.c          | 47 +++++++++++++++++++++--
 9 files changed, 235 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ab2c49423dc..15f9f04de149 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2602,6 +2602,13 @@ enum wiphy_params_flags {
=20
 #define IEEE80211_DEFAULT_AIRTIME_WEIGHT	256
=20
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
index 4319596ef472..269be699e89c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5558,6 +5558,18 @@ void ieee80211_send_eosp_nullfunc(struct ieee80211_s=
ta *pubsta, int tid);
 void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 				    u32 tx_airtime, u32 rx_airtime);
=20
+/**
+ * ieee80211_txq_airtime_check - check if a txq can send frame to device
+ *
+ * @hw: pointer obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface
+ *
+ * Return true if the AQL's airtime limit has not been reached and the txq=
 can
+ * continue to send more packets to the device. Otherwise return false.
+ */
+bool
+ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq =
*txq);
+
 /**
  * ieee80211_iter_keys - iterate keys programmed into the device
  * @hw: pointer obtained from ieee80211_alloc_hw()
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 568b3b276931..d77ea0e51c1d 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -148,6 +148,80 @@ static const struct file_operations aqm_ops =3D {
 	.llseek =3D default_llseek,
 };
=20
+static ssize_t aql_txq_limit_read(struct file *file,
+				  char __user *user_buf,
+				  size_t count,
+				  loff_t *ppos)
+{
+	struct ieee80211_local *local =3D file->private_data;
+	char buf[400];
+	int len =3D 0;
+
+	len =3D scnprintf(buf, sizeof(buf),
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
+	struct ieee80211_local *local =3D file->private_data;
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
+	buf[sizeof(buf) - 1] =3D 0;
+	len =3D strlen(buf);
+	if (len > 0 && buf[len - 1] =3D=3D '\n')
+		buf[len - 1] =3D 0;
+
+	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) !=3D 3)
+		return -EINVAL;
+
+	if (ac >=3D IEEE80211_NUM_ACS)
+		return -EINVAL;
+
+	local->aql_txq_limit_low[ac] =3D q_limit_low;
+	local->aql_txq_limit_high[ac] =3D q_limit_high;
+
+	mutex_lock(&local->sta_mtx);
+	list_for_each_entry(sta, &local->sta_list, list) {
+		sta->airtime[ac].aql_limit_low =3D q_limit_low;
+		sta->airtime[ac].aql_limit_high =3D q_limit_high;
+	}
+	mutex_unlock(&local->sta_mtx);
+	return count;
+}
+
+static const struct file_operations aql_txq_limit_ops =3D {
+	.write =3D aql_txq_limit_write,
+	.read =3D aql_txq_limit_read,
+	.open =3D simple_open,
+	.llseek =3D default_llseek,
+};
+
 static ssize_t force_tx_status_read(struct file *file,
 				    char __user *user_buf,
 				    size_t count,
@@ -441,6 +515,10 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	debugfs_create_u16("airtime_flags", 0600,
 			   phyd, &local->airtime_flags);
=20
+	DEBUGFS_ADD(aql_txq_limit);
+	debugfs_create_u32("aql_threshold", 0600,
+			   phyd, &local->aql_threshold);
+
 	statsd =3D debugfs_create_dir("statistics", phyd);
=20
 	/* if the dir failed, don't put all the other things into the root! */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index c8ad20c28c43..0185e6e5e5d1 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -197,10 +197,12 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
 {
 	struct sta_info *sta =3D file->private_data;
 	struct ieee80211_local *local =3D sta->sdata->local;
-	size_t bufsz =3D 200;
+	size_t bufsz =3D 400;
 	char *buf =3D kzalloc(bufsz, GFP_KERNEL), *p =3D buf;
 	u64 rx_airtime =3D 0, tx_airtime =3D 0;
 	s64 deficit[IEEE80211_NUM_ACS];
+	u32 q_depth[IEEE80211_NUM_ACS];
+	u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
=20
@@ -212,19 +214,22 @@ static ssize_t sta_airtime_read(struct file *file, ch=
ar __user *userbuf,
 		rx_airtime +=3D sta->airtime[ac].rx_airtime;
 		tx_airtime +=3D sta->airtime[ac].tx_airtime;
 		deficit[ac] =3D sta->airtime[ac].deficit;
+		q_limit_l[ac] =3D sta->airtime[ac].aql_limit_low;
+		q_limit_h[ac] =3D sta->airtime[ac].aql_limit_high;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
+		q_depth[ac] =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
 	}
=20
 	p +=3D scnprintf(p, bufsz + buf - p,
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
=20
 	rv =3D simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 	kfree(buf);
@@ -236,7 +241,25 @@ static ssize_t sta_airtime_write(struct file *file, co=
nst char __user *userbuf,
 {
 	struct sta_info *sta =3D file->private_data;
 	struct ieee80211_local *local =3D sta->sdata->local;
-	int ac;
+	u32 ac, q_limit_l, q_limit_h;
+	char _buf[100] =3D {}, *buf =3D _buf;
+
+	if (count > sizeof(_buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[sizeof(_buf) - 1] =3D '\0';
+	if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
+	    !=3D 3)
+		return -EINVAL;
+
+	if (ac >=3D IEEE80211_NUM_ACS)
+		return -EINVAL;
+
+	sta->airtime[ac].aql_limit_low =3D q_limit_l;
+	sta->airtime[ac].aql_limit_high =3D q_limit_h;
=20
 	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
 		spin_lock_bh(&local->active_txq_lock[ac]);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 225ea4e3cd76..ad15b3be8bb3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1142,6 +1142,10 @@ struct ieee80211_local {
 	u16 schedule_round[IEEE80211_NUM_ACS];
=20
 	u16 airtime_flags;
+	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
+	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
+	u32 aql_threshold;
+	atomic_t aql_total_pending_airtime;
=20
 	const struct ieee80211_ops *ops;
=20
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index aba094b4ccfc..071ea92a3748 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -667,8 +667,16 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv=
_data_len,
 	for (i =3D 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
+		local->aql_txq_limit_low[i] =3D IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
+		local->aql_txq_limit_high[i] =3D
+			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
-	local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
+
+	local->airtime_flags =3D AIRTIME_USE_TX |
+			       AIRTIME_USE_RX |
+			       AIRTIME_USE_AQL;
+	local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
+	atomic_set(&local->aql_total_pending_airtime, 0);
=20
 	INIT_LIST_HEAD(&local->chanctx_list);
 	mutex_init(&local->chanctx_mtx);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bd11fef2139f..a76e935a543a 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -396,6 +396,9 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if=
_data *sdata,
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
 		sta->airtime[i].deficit =3D sta->airtime_weight;
+		atomic_set(&sta->airtime[i].aql_tx_pending, 0);
+		sta->airtime[i].aql_limit_low =3D local->aql_txq_limit_low[i];
+		sta->airtime[i].aql_limit_high =3D local->aql_txq_limit_high[i];
 	}
=20
 	for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1893,6 +1896,43 @@ void ieee80211_sta_register_airtime(struct ieee80211=
_sta *pubsta, u8 tid,
 }
 EXPORT_SYMBOL(ieee80211_sta_register_airtime);
=20
+void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
+					  struct sta_info *sta, u8 ac,
+					  u16 tx_airtime, bool tx_completed)
+{
+	if (!tx_completed) {
+		if (sta)
+			atomic_add(tx_airtime,
+				   &sta->airtime[ac].aql_tx_pending);
+
+		atomic_add(tx_airtime, &local->aql_total_pending_airtime);
+		return;
+	}
+
+	if (sta) {
+		if (WARN_ONCE(atomic_read(&sta->airtime[ac].aql_tx_pending) <
+			      tx_airtime,
+			      "STA %pM AC %d txq pending airtime underflow: %u, %u",
+			      sta->addr, ac,
+			      atomic_read(&sta->airtime[ac].aql_tx_pending),
+			      tx_airtime))
+			atomic_set(&sta->airtime[ac].aql_tx_pending, 0);
+		else
+			atomic_sub(tx_airtime,
+				   &sta->airtime[ac].aql_tx_pending);
+	}
+
+	if (WARN_ONCE(atomic_read(&local->aql_total_pending_airtime) <
+		      tx_airtime,
+		      "Device %s AC %d pending airtime underflow: %u, %u",
+		      wiphy_name(local->hw.wiphy), ac,
+		      atomic_read(&local->aql_total_pending_airtime),
+		      tx_airtime))
+		atomic_set(&local->aql_total_pending_airtime, 0);
+	else
+		atomic_sub(tx_airtime, &local->aql_total_pending_airtime);
+}
+
 int sta_info_move_state(struct sta_info *sta,
 			enum ieee80211_sta_state new_state)
 {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 369c2dddce52..c8823bd0e55f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,13 +127,21 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
+#define AIRTIME_USE_AQL		BIT(2)
=20
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
 	s64 deficit;
+	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
+	u32 aql_limit_low;
+	u32 aql_limit_high;
 };
=20
+void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
+					  struct sta_info *sta, u8 ac,
+					  u16 tx_airtime, bool tx_completed);
+
 struct sta_info;
=20
 /**
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 238c47be5fe4..f53d56ef535a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3672,7 +3672,8 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee8=
0211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local =3D hw_to_local(hw);
 	struct ieee80211_txq *ret =3D NULL;
-	struct txq_info *txqi =3D NULL;
+	struct txq_info *txqi =3D NULL, *head =3D NULL;
+	bool found_eligible_txq =3D false;
=20
 	spin_lock_bh(&local->active_txq_lock[ac]);
=20
@@ -3683,13 +3684,26 @@ struct ieee80211_txq *ieee80211_next_txq(struct iee=
e80211_hw *hw, u8 ac)
 	if (!txqi)
 		goto out;
=20
+	if (txqi =3D=3D head && !found_eligible_txq)
+		goto out;
+
+	if (!head)
+		head =3D txqi;
+
 	if (txqi->txq.sta) {
 		struct sta_info *sta =3D container_of(txqi->txq.sta,
-						struct sta_info, sta);
+						    struct sta_info, sta);
+		bool aql_check =3D ieee80211_txq_airtime_check(hw, &txqi->txq);
+		s64 deficit =3D sta->airtime[txqi->txq.ac].deficit;
+
+		if (aql_check)
+			found_eligible_txq =3D true;
=20
-		if (sta->airtime[txqi->txq.ac].deficit < 0) {
+		if (deficit < 0)
 			sta->airtime[txqi->txq.ac].deficit +=3D
 				sta->airtime_weight;
+
+		if (deficit < 0 || !aql_check) {
 			list_move_tail(&txqi->schedule_order,
 				       &local->active_txqs[txqi->txq.ac]);
 			goto begin;
@@ -3743,6 +3757,33 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *h=
w,
 }
 EXPORT_SYMBOL(__ieee80211_schedule_txq);
=20
+bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
+				 struct ieee80211_txq *txq)
+{
+	struct sta_info *sta;
+	struct ieee80211_local *local =3D hw_to_local(hw);
+
+	if (!(local->airtime_flags & AIRTIME_USE_AQL))
+		return true;
+
+	if (!txq->sta)
+		return true;
+
+	sta =3D container_of(txq->sta, struct sta_info, sta);
+	if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
+	    sta->airtime[txq->ac].aql_limit_low)
+		return true;
+
+	if (atomic_read(&local->aql_total_pending_airtime) <
+	    local->aql_threshold &&
+	    atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
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
--=20
2.24.0.rc1.363.gb1bccd3e3d-goog

