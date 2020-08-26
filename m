Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEA2526A1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 07:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHZF5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 01:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgHZF5E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 01:57:04 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336DC061757
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 22:57:03 -0700 (PDT)
Received: from [149.224.157.14] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kAoQc-0004ao-AL; Wed, 26 Aug 2020 07:56:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5 1/5] nl80211: rename csa counter attributes countdown counters
Date:   Wed, 26 Aug 2020 07:56:46 +0200
Message-Id: <20200826055650.1101224-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We want to reuse the attributes for other counters such as BSS color
change. Rename them to more generic names.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/uapi/linux/nl80211.h | 14 ++++++++------
 net/wireless/nl80211.c       | 16 ++++++++--------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 631f3a997b3c..bccd16f743b9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2082,10 +2082,10 @@ enum nl80211_commands {
  *	operation).
  * @NL80211_ATTR_CSA_IES: Nested set of attributes containing the IE information
  *	for the time while performing a channel switch.
- * @NL80211_ATTR_CSA_C_OFF_BEACON: An array of offsets (u16) to the channel
- *	switch counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).
- * @NL80211_ATTR_CSA_C_OFF_PRESP: An array of offsets (u16) to the channel
- *	switch counters in the probe response (%NL80211_ATTR_PROBE_RESP).
+ * @NL80211_ATTR_CNTDWN_OFFS_BEACON: An array of offsets (u16) to the channel
+ *	switch or color change counters in the beacons tail (%NL80211_ATTR_BEACON_TAIL).
+ * @NL80211_ATTR_CNTDWN_OFFS_PRESP: An array of offsets (u16) to the channel
+ *	switch or color change counters in the probe response (%NL80211_ATTR_PROBE_RESP).
  *
  * @NL80211_ATTR_RXMGMT_FLAGS: flags for nl80211_send_mgmt(), u32.
  *	As specified in the &enum nl80211_rxmgmt_flags.
@@ -2821,8 +2821,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_CH_SWITCH_COUNT,
 	NL80211_ATTR_CH_SWITCH_BLOCK_TX,
 	NL80211_ATTR_CSA_IES,
-	NL80211_ATTR_CSA_C_OFF_BEACON,
-	NL80211_ATTR_CSA_C_OFF_PRESP,
+	NL80211_ATTR_CNTDWN_OFFS_BEACON,
+	NL80211_ATTR_CNTDWN_OFFS_PRESP,
 
 	NL80211_ATTR_RXMGMT_FLAGS,
 
@@ -3009,6 +3009,8 @@ enum nl80211_attrs {
 #define	NL80211_ATTR_MESH_PARAMS NL80211_ATTR_MESH_CONFIG
 #define NL80211_ATTR_IFACE_SOCKET_OWNER NL80211_ATTR_SOCKET_OWNER
 #define NL80211_ATTR_SAE_DATA NL80211_ATTR_AUTH_DATA
+#define NL80211_ATTR_CSA_C_OFF_BEACON NL80211_ATTR_CNTDWN_OFFS_BEACON
+#define NL80211_ATTR_CSA_C_OFF_PRESP NL80211_ATTR_CNTDWN_OFFS_PRESP
 
 /*
  * Allow user space programs to use #ifdef on new attributes by defining them
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 814e23d3ce7c..e41fcec7c306 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -567,8 +567,8 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CH_SWITCH_COUNT] = { .type = NLA_U32 },
 	[NL80211_ATTR_CH_SWITCH_BLOCK_TX] = { .type = NLA_FLAG },
 	[NL80211_ATTR_CSA_IES] = { .type = NLA_NESTED },
-	[NL80211_ATTR_CSA_C_OFF_BEACON] = { .type = NLA_BINARY },
-	[NL80211_ATTR_CSA_C_OFF_PRESP] = { .type = NLA_BINARY },
+	[NL80211_ATTR_CNTDWN_OFFS_BEACON] = { .type = NLA_BINARY },
+	[NL80211_ATTR_CNTDWN_OFFS_PRESP] = { .type = NLA_BINARY },
 	[NL80211_ATTR_STA_SUPPORTED_CHANNELS] = { .type = NLA_BINARY },
 	[NL80211_ATTR_STA_SUPPORTED_OPER_CLASSES] = { .type = NLA_BINARY },
 	[NL80211_ATTR_HANDLE_DFS] = { .type = NLA_FLAG },
@@ -8787,10 +8787,10 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
-	if (!csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON])
+	if (!csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON])
 		return -EINVAL;
 
-	len = nla_len(csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON]);
+	len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
 	if (!len || (len % sizeof(u16)))
 		return -EINVAL;
 
@@ -8801,7 +8801,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	params.counter_offsets_beacon =
-		nla_data(csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON]);
+		nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
 
 	/* sanity checks - counters should fit and be the same */
 	for (i = 0; i < params.n_counter_offsets_beacon; i++) {
@@ -8814,8 +8814,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
-	if (csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]) {
-		len = nla_len(csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]);
+	if (csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
+		len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
 		if (!len || (len % sizeof(u16)))
 			return -EINVAL;
 
@@ -8826,7 +8826,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 
 		params.counter_offsets_presp =
-			nla_data(csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]);
+			nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
 
 		/* sanity checks - counters should fit and be the same */
 		for (i = 0; i < params.n_counter_offsets_presp; i++) {
-- 
2.25.1

