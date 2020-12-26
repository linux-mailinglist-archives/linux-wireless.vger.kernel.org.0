Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E82E2DDB
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Dec 2020 10:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLZJts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Dec 2020 04:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgLZJtr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Dec 2020 04:49:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB7D1221ED;
        Sat, 26 Dec 2020 09:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608976147;
        bh=wOAsFsWid5f4MpOgWRVIs8Yy/rKSa+2DMlO+N7ol/pk=;
        h=From:To:Cc:Subject:Date:From;
        b=p5YhCn1qBCj19E3G/lvy2+n4eDPlgMj+Kv8FjqTU+EKNQs5zbOe1zgJ/knNGt6Kph
         fC2F+ooLh4KALD7jnN2KJRzypXl+sS7q/JHJNlEDi4PjW3TZwLUvwJZlzSHlDHUcN+
         kh21n7giMiqCiXe0Ktz0UUnDGJBuA7dWLfnKEmXPiA2MBWa5ldvler+Lcgd1MIDe8K
         +hOIzua/dHDETy+pUXTm+z5vuaiWMTlqPKTFjNkI8rROTMm0qCRf0cWIolC4HkCM5Y
         Uy2dh9/yTP0SCdVsLbm0KkAza5kq0e8Mi41R55Zvl+szSFZ78aIw6f8uCcPfYEIxbh
         9h0vJbAfTYlZQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     kyan@google.com, toke@redhat.com, johannes@sipsolutions.net,
        lorenzo.bianconi@redhat.com
Subject: [PATCH mac80211-next] mac80211: introduce aql_enable node in debugfs
Date:   Sat, 26 Dec 2020 10:49:18 +0100
Message-Id: <0ad278def3875fc2c60b4898daa3f0d53288c168.1608975795.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce aql_enable node in debugfs in order to enable/disable aql.
This is useful for debugging purpose.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/debugfs.c     | 1 +
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/main.c        | 1 +
 net/mac80211/tx.c          | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 48f144f107d5..898ad57bebd0 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -581,6 +581,7 @@ void debugfs_hw_add(struct ieee80211_local *local)
 	DEBUGFS_ADD(aql_txq_limit);
 	debugfs_create_u32("aql_threshold", 0600,
 			   phyd, &local->aql_threshold);
+	debugfs_create_bool("aql_enable", 0600, phyd, &local->aql_enable);
 
 	statsd = debugfs_create_dir("statistics", phyd);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8bf9c0e974d6..8c9cce373010 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1162,6 +1162,7 @@ struct ieee80211_local {
 	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
 	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
+	bool aql_enable;
 	atomic_t aql_total_pending_airtime;
 
 	const struct ieee80211_ops *ops;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index dee88ec566ad..b3bec68943c8 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -700,6 +700,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
 	local->aql_threshold = IEEE80211_AQL_THRESHOLD;
+	local->aql_enable = true;
 	atomic_set(&local->aql_total_pending_airtime, 0);
 
 	INIT_LIST_HEAD(&local->chanctx_list);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6422da6690f7..86503d47d86e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3832,6 +3832,9 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 		return true;
 
+	if (!local->aql_enable)
+		return true;
+
 	if (!txq->sta)
 		return true;
 
-- 
2.29.2

