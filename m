Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42FB319B9C6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgDBBSQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:16 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46428 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733222AbgDBBSQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5EFDE4F7A30;
        Thu,  2 Apr 2020 01:18:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qCuuED7eu3T7; Thu,  2 Apr 2020 01:18:11 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id B03BB4F7AE8;
        Thu,  2 Apr 2020 01:18:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 1/9] ieee80211: share 802.11 unit conversion helpers
Date:   Wed,  1 Apr 2020 18:18:02 -0700
Message-Id: <20200402011810.22947-2-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MHZ_TO_KHZ, and KHZ_TO_MHZ are useful to drivers and
elsewhere so export these in the common ieee80211 header.
Move the power helpers also because we might as well.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/linux/ieee80211.h | 10 ++++++++++
 include/net/regulatory.h  |  7 -------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16268ef1cbcc..8c4226b8a048 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3323,6 +3323,16 @@ static inline int ieee80211_get_tdls_action(struct sk_buff *skb, u32 hdr_size)
 #define TU_TO_JIFFIES(x)	(usecs_to_jiffies((x) * 1024))
 #define TU_TO_EXP_TIME(x)	(jiffies + TU_TO_JIFFIES(x))
 
+/* convert frequencies */
+#define MHZ_TO_KHZ(freq) ((freq) * 1000)
+#define KHZ_TO_MHZ(freq) ((freq) / 1000)
+
+/* convert powers */
+#define DBI_TO_MBI(gain) ((gain) * 100)
+#define MBI_TO_DBI(gain) ((gain) / 100)
+#define DBM_TO_MBM(gain) ((gain) * 100)
+#define MBM_TO_DBM(gain) ((gain) / 100)
+
 /**
  * ieee80211_action_contains_tpc - checks if the frame contains TPC element
  * @skb: the skb containing the frame, length will be checked
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index 3469750df0f4..09a3099886e5 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -231,13 +231,6 @@ struct ieee80211_regdomain {
 	struct ieee80211_reg_rule reg_rules[];
 };
 
-#define MHZ_TO_KHZ(freq) ((freq) * 1000)
-#define KHZ_TO_MHZ(freq) ((freq) / 1000)
-#define DBI_TO_MBI(gain) ((gain) * 100)
-#define MBI_TO_DBI(gain) ((gain) / 100)
-#define DBM_TO_MBM(gain) ((gain) * 100)
-#define MBM_TO_DBM(gain) ((gain) / 100)
-
 #define REG_RULE_EXT(start, end, bw, gain, eirp, dfs_cac, reg_flags)	\
 {									\
 	.freq_range.start_freq_khz = MHZ_TO_KHZ(start),			\
-- 
2.20.1

