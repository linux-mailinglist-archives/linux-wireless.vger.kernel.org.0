Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E921F19421A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 15:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCZOxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 10:53:40 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48802 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZOxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 10:53:40 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jHTt5-00BYvu-CB; Thu, 26 Mar 2020 15:53:39 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] mac80211: set IEEE80211_TX_CTRL_PORT_CTRL_PROTO for nl80211 TX
Date:   Thu, 26 Mar 2020 15:53:34 +0100
Message-Id: <20200326155333.f183f52b02f0.I4054e2a8c11c2ddcb795a0103c87be3538690243@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When a frame is transmitted via the nl80211 TX rather than as a
normal frame, IEEE80211_TX_CTRL_PORT_CTRL_PROTO wasn't set and
this will lead to wrong decisions (rate control etc.) being made
about the frame; fix this.

Fixes: 911806491425 ("mac80211: Add support for tx_control_port")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 7dbfb9e3cd84..bc1c27dc8dd5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018, 2020 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -5132,6 +5132,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ethhdr *ehdr;
+	u32 ctrl_flags = 0;
 	u32 flags;
 
 	/* Only accept CONTROL_PORT_PROTOCOL configured in CONNECT/ASSOCIATE
@@ -5141,6 +5142,9 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	    proto != cpu_to_be16(ETH_P_PREAUTH))
 		return -EINVAL;
 
+	if (proto == sdata->control_port_protocol)
+		ctrl_flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
+
 	if (unencrypted)
 		flags = IEEE80211_TX_INTFL_DONT_ENCRYPT;
 	else
@@ -5166,7 +5170,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 	skb_reset_mac_header(skb);
 
 	local_bh_disable();
-	__ieee80211_subif_start_xmit(skb, skb->dev, flags, 0);
+	__ieee80211_subif_start_xmit(skb, skb->dev, flags, ctrl_flags);
 	local_bh_enable();
 
 	return 0;
-- 
2.25.1

