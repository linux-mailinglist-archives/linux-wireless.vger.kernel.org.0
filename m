Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06E4A6D43
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 09:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiBBIuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 03:50:01 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37928 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245216AbiBBIuB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 03:50:01 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFBKw-0004v8-OT;
        Wed, 02 Feb 2022 10:50:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Wed,  2 Feb 2022 10:49:36 +0200
Message-Id: <iwlwifi.20220202104617.230736e19e0e.I3e6745873585ad943c152fab9e23b5221f17a95f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220202084947.370289-1-luca@coelho.fi>
References: <20220202084947.370289-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 03/14] cfg80211/mac80211: assume CHECKSUM_COMPLETE includes SNAP
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's currently only one driver that reports CHECKSUM_COMPLETE,
that is iwlwifi. The current hardware there calculates checksum
after the SNAP header, but only RFC 1042 (and some other cases,
but replicating the exact hardware logic for corner cases in the
driver seemed awkward.)

Newer generations of hardware will checksum _including_ the SNAP,
which makes things easier.

To handle that, simply always assume the checksum _includes_ the
SNAP header, which this patch does, requiring to first add it
for older iwlwifi hardware, and then remove it again later on
conversion.

Alternatively, we could have:

 1) Always assumed the checksum starts _after_ the SNAP header;
    the problem with this is that we'd have to replace the exact
    "what is the SNAP" check in iwlwifi that cfg80211 has.

 2) Made it configurable with some flag, but that seemed like too
    much complexity.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 3 +++
 net/mac80211/rx.c                             | 2 ++
 net/wireless/util.c                           | 8 +++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 18f5b1b14ae7..2c43a9989783 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -209,6 +209,9 @@ static int iwl_mvm_create_skb(struct iwl_mvm *mvm, struct sk_buff *skb,
 			      shdr->type != htons(ETH_P_PAE) &&
 			      shdr->type != htons(ETH_P_TDLS))))
 			skb->ip_summed = CHECKSUM_NONE;
+		else
+			/* mac80211 assumes full CSUM including SNAP header */
+			skb_postpush_rcsum(skb, shdr, sizeof(*shdr));
 	}
 
 	fraglen = len - headlen;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 93680af62c47..d54a4d98c648 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4629,6 +4629,8 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* do the header conversion - first grab the addresses */
 	ether_addr_copy(addrs.da, skb->data + fast_rx->da_offs);
 	ether_addr_copy(addrs.sa, skb->data + fast_rx->sa_offs);
+	skb_postpull_rcsum(skb, skb->data + snap_offs,
+			   sizeof(rfc1042_header) + 2);
 	/* remove the SNAP but leave the ethertype */
 	skb_pull(skb, snap_offs + sizeof(rfc1042_header));
 	/* push the addresses in front */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 41ea65deb6e1..e02f1702806e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -634,12 +634,14 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	if (likely((!is_amsdu && ether_addr_equal(payload.hdr, rfc1042_header) &&
 		    tmp.h_proto != htons(ETH_P_AARP) &&
 		    tmp.h_proto != htons(ETH_P_IPX)) ||
-		   ether_addr_equal(payload.hdr, bridge_tunnel_header)))
+		   ether_addr_equal(payload.hdr, bridge_tunnel_header))) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and
 		 * replace EtherType */
 		hdrlen += ETH_ALEN + 2;
-	else
+		skb_postpull_rcsum(skb, &payload, ETH_ALEN + 2);
+	} else {
 		tmp.h_proto = htons(skb->len - hdrlen);
+	}
 
 	pskb_pull(skb, hdrlen);
 
-- 
2.34.1

