Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E939B4A6D4A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbiBBIuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:10 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37946 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245235AbiBBIuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:09 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBL5-0004v8-9j;
        Wed, 02 Feb 2022 10:50:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:45 +0200
Message-Id: <iwlwifi.20220202104617.5172d7fd878e.I2f1fce686a2b71003f083b2566fb09cf16b8165a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/14] mac80211: remove unused macros
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Various macros in mac80211 aren't used, remove them. In one
case it's used under ifdef, so ifdef it for the W=2 warning.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/airtime.c             | 6 ------
 net/mac80211/debugfs.c             | 2 ++
 net/mac80211/debugfs_key.c         | 2 +-
 net/mac80211/debugfs_netdev.c      | 4 +---
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 net/mac80211/status.c              | 4 ++--
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index ffb7559b36d4..64e8ce9760b9 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -68,17 +68,11 @@
 #define IEEE80211_VHT_STREAM_GROUPS	8 /* BW(=4) * SGI(=2) */
 
 #define IEEE80211_HE_MAX_STREAMS	8
-#define IEEE80211_HE_STREAM_GROUPS	12 /* BW(=4) * GI(=3) */
 
 #define IEEE80211_HT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
 				 IEEE80211_HT_STREAM_GROUPS)
 #define IEEE80211_VHT_GROUPS_NB	(IEEE80211_MAX_STREAMS *	\
 					 IEEE80211_VHT_STREAM_GROUPS)
-#define IEEE80211_HE_GROUPS_NB	(IEEE80211_HE_MAX_STREAMS *	\
-				 IEEE80211_HE_STREAM_GROUPS)
-#define IEEE80211_GROUPS_NB	(IEEE80211_HT_GROUPS_NB +	\
-				 IEEE80211_VHT_GROUPS_NB +	\
-				 IEEE80211_HE_GROUPS_NB)
 
 #define IEEE80211_HT_GROUP_0	0
 #define IEEE80211_VHT_GROUP_0	(IEEE80211_HT_GROUP_0 + IEEE80211_HT_GROUPS_NB)
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 8dbfe325ee66..f4c9a92f50f9 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -634,8 +634,10 @@ static const struct file_operations stats_ ##name## _ops = {		\
 	.llseek = generic_file_llseek,					\
 };
 
+#ifdef CONFIG_MAC80211_DEBUG_COUNTERS
 #define DEBUGFS_STATS_ADD(name)					\
 	debugfs_create_u32(#name, 0400, statsd, &local->name);
+#endif
 #define DEBUGFS_DEVSTATS_ADD(name)					\
 	debugfs_create_file(#name, 0400, statsd, local, &stats_ ##name## _ops);
 
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index f53dec8a3d5c..edc7792e1361 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright (C) 2015	Intel Deutschland GmbH
+ * Copyright (C) 2021   Intel Corporation
  */
 
 #include <linux/kobject.h>
@@ -22,7 +23,6 @@ static ssize_t key_##name##_read(struct file *file,			\
 	return mac80211_format_buffer(userbuf, count, ppos, 		\
 				      format_string, key->prop);	\
 }
-#define KEY_READ_D(name) KEY_READ(name, name, "%d\n")
 #define KEY_READ_X(name) KEY_READ(name, name, "0x%x\n")
 
 #define KEY_OPS(name)							\
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index db724fc10a5f..e490c3da3aca 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020 Intel Corporation
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -77,8 +77,6 @@ static ssize_t ieee80211_if_fmt_##name(					\
 		IEEE80211_IF_FMT(name, field, "%#x\n")
 #define IEEE80211_IF_FMT_LHEX(name, field)				\
 		IEEE80211_IF_FMT(name, field, "%#lx\n")
-#define IEEE80211_IF_FMT_SIZE(name, field)				\
-		IEEE80211_IF_FMT(name, field, "%zd\n")
 
 #define IEEE80211_IF_FMT_HEXARRAY(name, field)				\
 static ssize_t ieee80211_if_fmt_##name(					\
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 9c3b7fc377c1..9c6ace858107 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2010-2013 Felix Fietkau <nbd@openwrt.org>
- * Copyright (C) 2019-2020 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  */
 #include <linux/netdevice.h>
 #include <linux/types.h>
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f6f63a0b1b72..22cb8f01731d 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -5,6 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2008-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
+ * Copyright 2021  Intel Corporation
  */
 
 #include <linux/export.h>
@@ -754,7 +755,6 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
  */
 #define STA_LOST_PKT_THRESHOLD	50
 #define STA_LOST_PKT_TIME	HZ		/* 1 sec since last ACK */
-#define STA_LOST_TDLS_PKT_THRESHOLD	10
 #define STA_LOST_TDLS_PKT_TIME		(10*HZ) /* 10secs since last ACK */
 
 static void ieee80211_lost_packet(struct sta_info *sta,
@@ -781,7 +781,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	}
 
 	/*
-	 * If we're in TDLS mode, make sure that all STA_LOST_TDLS_PKT_THRESHOLD
+	 * If we're in TDLS mode, make sure that all STA_LOST_PKT_THRESHOLD
 	 * of the last packets were lost, and that no ACK was received in the
 	 * last STA_LOST_TDLS_PKT_TIME ms, before triggering the CQM packet-loss
 	 * mechanism.
-- 
2.34.1

