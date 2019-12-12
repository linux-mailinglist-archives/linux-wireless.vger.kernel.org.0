Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24A911CBFD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 12:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfLLLOu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 06:14:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728458AbfLLLOu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 06:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576149288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SmtwoW3jjR6ALn+0jKUNLELW2YZXymbQpOPrW3VH1Qw=;
        b=a3xo4sie+bE/yob+UcP+T4l+ImKFdqEBqspM2cJRzohBl+/su3QIc6Suq1FYwN93VNF4q4
        9epCQH5qsrJA2xXvEIRbyuQYz5hL5T7aZ8Z5aqE7inPmW+ayKMqSJdOIca1BC2DkiwIczm
        289jSowqn67vIyrv1CYZSRoAgWzwZZQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-KcTrSw8vOcCCIcUkBmiaIA-1; Thu, 12 Dec 2019 06:14:44 -0500
X-MC-Unique: KcTrSw8vOcCCIcUkBmiaIA-1
Received: by mail-lj1-f199.google.com with SMTP id l2so346100lja.18
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 03:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmtwoW3jjR6ALn+0jKUNLELW2YZXymbQpOPrW3VH1Qw=;
        b=nJ/RPhGpBx2XBFUFF1ZDoZIwqYykLWoQrbPEqP8Op5UE9qbDoezpzNqaXv7vytVxgF
         j8ieu2HY0amGpWCpKTOLXKJiJI+r+edsM7v50qchJzbyIGp5Hg1ownPIyF40BPQPAoYQ
         HkMTSGxBfqhYPD6zmfuZM+3bU1UzVwlnuvTklJh7C5Z0H2WXUCaXsv77+qYJ1A3KShhz
         MrYM4nTXWRpspofR3+WAMN4UkRJYMysKiEQ95bgiz8qlRYThLu6NPwE5gdNTBUw59HW/
         PMQKnR5PmsOLzxZVsM2nFEEP0rkb2Turvp/jEuG6JN8nygwd3CZZadUrcgL+D1iGCWVi
         yzuA==
X-Gm-Message-State: APjAAAUS7bRYR5iOvIn9CdbJ3NIzQEkJI7SJ0weiaCtm0gY6tss9CPpG
        +uzT503dBRgmWtvlSEwB0oBZ3NdmaqmGNxntZR+R/UrJWydbCvI61zvlLHnUmmo7eB9Tg1WMWHP
        EIvNcMObp7XnYM1MSkyVAq8LrnhY=
X-Received: by 2002:ac2:5975:: with SMTP id h21mr5204366lfp.165.1576149283263;
        Thu, 12 Dec 2019 03:14:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCutaWHGLNzmBR9aNyoiQQtQkEHOnRTgb7zNtQ2rnrOFYNX7kIti9iJlmTrhduR1HWJBiG9w==
X-Received: by 2002:ac2:5975:: with SMTP id h21mr5204343lfp.165.1576149282906;
        Thu, 12 Dec 2019 03:14:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f24sm2838104ljm.12.2019.12.12.03.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 03:14:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 59FE01819EA; Thu, 12 Dec 2019 12:14:41 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH v2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
Date:   Thu, 12 Dec 2019 12:14:37 +0100
Message-Id: <20191212111437.224294-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of just having an airtime flag in debugfs, turn AQL into a proper
NL80211_EXT_FEATURE, so drivers can turn it on when they are ready, and so
we also expose the presence of the feature to userspace.

This also has the effect of flipping the default, so drivers have to opt in
to using AQL instead of getting it by default with TXQs. To keep
functionality the same as pre-patch, we set this feature for ath10k (which
is where it is needed the most).

While we're at it, split out the debugfs interface so AQL gets its own
per-station debugfs file instead of using the 'airtime' file.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Squash into a single patch
  - Add kernel doc for NL80211_EXT_FEATURE_AQL

 drivers/net/wireless/ath/ath10k/mac.c |  1 +
 include/uapi/linux/nl80211.h          |  5 ++
 net/mac80211/debugfs_sta.c            | 76 ++++++++++++++++++++-------
 net/mac80211/main.c                   |  4 +-
 net/mac80211/sta_info.c               |  3 ++
 net/mac80211/sta_info.h               |  1 -
 net/mac80211/tx.c                     |  4 +-
 7 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 83cc8778ca1e..978f0037ed52 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8958,6 +8958,7 @@ int ath10k_mac_register(struct ath10k *ar)
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 	wiphy_ext_feature_set(ar->hw->wiphy,
 			      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
 
 	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map) ||
 	    test_bit(WMI_SERVICE_HTT_MGMT_TX_COMP_VALID_FLAGS, ar->wmi.svc_map))
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 341e0e8cae46..5eab191607f8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -5517,6 +5517,10 @@ enum nl80211_feature_flags {
  *	with VLAN tagged frames and separate VLAN-specific netdevs added using
  *	vconfig similarly to the Ethernet case.
  *
+ * @NL80211_EXT_FEATURE_AQL: The driver supports the Airtime Queue Limit (AQL)
+ *	feature, which prevents bufferbloat by using the expected transmission
+ *	time to limit the amount of data buffered in the hardware.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5563,6 +5567,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
+	NL80211_EXT_FEATURE_AQL,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index b3c9001d1f43..c80b1e163ea4 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -201,8 +201,6 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
 	u64 rx_airtime = 0, tx_airtime = 0;
 	s64 deficit[IEEE80211_NUM_ACS];
-	u32 q_depth[IEEE80211_NUM_ACS];
-	u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
 	ssize_t rv;
 	int ac;
 
@@ -214,6 +212,56 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		rx_airtime += sta->airtime[ac].rx_airtime;
 		tx_airtime += sta->airtime[ac].tx_airtime;
 		deficit[ac] = sta->airtime[ac].deficit;
+		spin_unlock_bh(&local->active_txq_lock[ac]);
+	}
+
+	p += scnprintf(p, bufsz + buf - p,
+		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
+		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n",
+		rx_airtime, tx_airtime, sta->airtime_weight,
+		deficit[0], deficit[1], deficit[2], deficit[3]);
+
+	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	kfree(buf);
+	return rv;
+}
+
+static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
+				 size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct ieee80211_local *local = sta->sdata->local;
+	int ac;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->active_txq_lock[ac]);
+		sta->airtime[ac].rx_airtime = 0;
+		sta->airtime[ac].tx_airtime = 0;
+		sta->airtime[ac].deficit = sta->airtime_weight;
+		spin_unlock_bh(&local->active_txq_lock[ac]);
+	}
+
+	return count;
+}
+STA_OPS_RW(airtime);
+
+static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
+				size_t count, loff_t *ppos)
+{
+	struct sta_info *sta = file->private_data;
+	struct ieee80211_local *local = sta->sdata->local;
+	size_t bufsz = 400;
+	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
+	u32 q_depth[IEEE80211_NUM_ACS];
+	u32 q_limit_l[IEEE80211_NUM_ACS], q_limit_h[IEEE80211_NUM_ACS];
+	ssize_t rv;
+	int ac;
+
+	if (!buf)
+		return -ENOMEM;
+
+	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+		spin_lock_bh(&local->active_txq_lock[ac]);
 		q_limit_l[ac] = sta->airtime[ac].aql_limit_low;
 		q_limit_h[ac] = sta->airtime[ac].aql_limit_high;
 		spin_unlock_bh(&local->active_txq_lock[ac]);
@@ -221,12 +269,8 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	}
 
 	p += scnprintf(p, bufsz + buf - p,
-		"RX: %llu us\nTX: %llu us\nWeight: %u\n"
-		"Deficit: VO: %lld us VI: %lld us BE: %lld us BK: %lld us\n"
 		"Q depth: VO: %u us VI: %u us BE: %u us BK: %u us\n"
 		"Q limit[low/high]: VO: %u/%u VI: %u/%u BE: %u/%u BK: %u/%u\n",
-		rx_airtime, tx_airtime, sta->airtime_weight,
-		deficit[0], deficit[1], deficit[2], deficit[3],
 		q_depth[0], q_depth[1], q_depth[2], q_depth[3],
 		q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
 		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]),
@@ -236,11 +280,10 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 	return rv;
 }
 
-static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
+static ssize_t sta_aql_write(struct file *file, const char __user *userbuf,
 				 size_t count, loff_t *ppos)
 {
 	struct sta_info *sta = file->private_data;
-	struct ieee80211_local *local = sta->sdata->local;
 	u32 ac, q_limit_l, q_limit_h;
 	char _buf[100] = {}, *buf = _buf;
 
@@ -251,7 +294,7 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 		return -EFAULT;
 
 	buf[sizeof(_buf) - 1] = '\0';
-	if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
+	if (sscanf(buf, "limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
 	    != 3)
 		return -EINVAL;
 
@@ -261,17 +304,10 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 	sta->airtime[ac].aql_limit_low = q_limit_l;
 	sta->airtime[ac].aql_limit_high = q_limit_h;
 
-	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
-		spin_lock_bh(&local->active_txq_lock[ac]);
-		sta->airtime[ac].rx_airtime = 0;
-		sta->airtime[ac].tx_airtime = 0;
-		sta->airtime[ac].deficit = sta->airtime_weight;
-		spin_unlock_bh(&local->active_txq_lock[ac]);
-	}
-
 	return count;
 }
-STA_OPS_RW(airtime);
+STA_OPS_RW(aql);
+
 
 static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 					size_t count, loff_t *ppos)
@@ -996,6 +1032,10 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 				    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 		DEBUGFS_ADD(airtime);
 
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_AQL))
+		DEBUGFS_ADD(aql);
+
 	debugfs_create_xul("driver_buffered_tids", 0400, sta->debugfs_dir,
 			   &sta->driver_buffered_tids);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 6cca0853f183..4c2b5ba3ac09 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -672,9 +672,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
 	}
 
-	local->airtime_flags = AIRTIME_USE_TX |
-			       AIRTIME_USE_RX |
-			       AIRTIME_USE_AQL;
+	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
 	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
 	atomic_set(&local->aql_total_pending_airtime, 0);
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8eafd81e97b4..0f5f40678885 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1916,6 +1916,9 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 {
 	int tx_pending;
 
+	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
+		return;
+
 	if (!tx_completed) {
 		if (sta)
 			atomic_add(tx_airtime,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index ad5d8a4ae56d..c00e28585f9d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -127,7 +127,6 @@ enum ieee80211_agg_stop_reason {
 /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
 #define AIRTIME_USE_TX		BIT(0)
 #define AIRTIME_USE_RX		BIT(1)
-#define AIRTIME_USE_AQL		BIT(2)
 
 struct airtime_info {
 	u64 rx_airtime;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b696b9136f4c..259989a81108 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3668,7 +3668,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
-	if (local->airtime_flags & AIRTIME_USE_AQL) {
+	if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
 		u32 airtime;
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
@@ -3790,7 +3790,7 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	struct sta_info *sta;
 	struct ieee80211_local *local = hw_to_local(hw);
 
-	if (!(local->airtime_flags & AIRTIME_USE_AQL))
+	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 		return true;
 
 	if (!txq->sta)
-- 
2.24.0

