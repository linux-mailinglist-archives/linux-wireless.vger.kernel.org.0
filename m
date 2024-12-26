Return-Path: <linux-wireless+bounces-16815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444869FCBA9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B4161B9D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2207112E5B;
	Thu, 26 Dec 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvBFRBmU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FBE14036E
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227928; cv=none; b=MyC7itzjulN8XFYdCx9M70NF7GNppylb2+YXYpJSIwubouAGqL1RoGQNFdMjLz/3YOhZTgysLaXFwehhQZ33gbtVLC3BY1VcdlJ/oikIh4149t1BEhNq4K4Wo972ChHqvBrx8dMZPoYIy4t6gTcET0yZSuuPX8ISQ4Xln9XSfXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227928; c=relaxed/simple;
	bh=zm/+J2BWw1uuh0huLFW2NN/67i2/V4HLAtW1J1Igqbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0bqt6uK/GN/WAVUXYY3kUFBIdVqgLdtfIA3Ao5Sgd6IXAFVHb3NP3Q0fnrEjOsjQLRTirfNVTk5KiO7VBriSH3lmIVRudaiHcEPJ/Y8RNF/aAxcXMIH+YS/RMu69AGLGgI57Lf4pXXq2m7/FiPKIATwGaVQ7fLKfAEU2ID1lt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvBFRBmU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227926; x=1766763926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zm/+J2BWw1uuh0huLFW2NN/67i2/V4HLAtW1J1Igqbs=;
  b=RvBFRBmUvrdXJM4BVoK8zNDMTWSqKfHzjtW3t9s82UOMMgIPulTOJ0fU
   nKfgsVxe5Of10DIQ9CK8C1iriuTj+Ew9fcqxzKv9FXgQ9KG2DiBAVHxBi
   0QvKRu2bQ4J+BSpsM22ozFYnk5cH/ERXwwbWVIDXrfsqthvjQHYYFDmsA
   qRAU2HsHbvOPKYacUyCc7eL1rZSGFoVzP8w/evzLkghfkNWtTQnn61sht
   znI+OQRwwpBaGnFkrUoet/fAbrSUk+TpiKe1TPBAVEwCKnU4h7BKiIt2O
   1XwdXUFXQGjO2ZcV7/p1H+YfifmIF3haSFowyKsxXlM+sRrmi2apE6FWy
   A==;
X-CSE-ConnectionGUID: quSmK6vJS6StU0VxdP4szw==
X-CSE-MsgGUID: dqiwT8pUT4qrAAnPyUORMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878152"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:26 -0800
X-CSE-ConnectionGUID: 9CxsuWoST+i4A3Sfzd253Q==
X-CSE-MsgGUID: HMPuexZmSvWzIEBqgqNq6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778002"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: Move TSO code to shared utility
Date: Thu, 26 Dec 2024 17:44:51 +0200
Message-Id: <20241226174257.3b940175a14b.Ib7188572f18afb31840d193a348c17c9b292c7af@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Move TSO segment logic from mvm to the iwlwifi level, as this code is
not opmode-dependent and can be shared with the mld driver.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-utils.c    | 85 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-utils.h    | 36 ++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 82 ++----------------
 4 files changed, 127 insertions(+), 77 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.h

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index 64c123314245..8d118ee92698 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -5,6 +5,7 @@ iwlwifi-objs		+= iwl-io.o
 iwlwifi-objs		+= iwl-drv.o
 iwlwifi-objs		+= iwl-debug.o
 iwlwifi-objs		+= iwl-nvm-utils.o
+iwlwifi-objs		+= iwl-utils.o
 iwlwifi-objs		+= iwl-phy-db.o iwl-nvm-parse.o
 iwlwifi-objs		+= pcie/drv.o pcie/rx.o pcie/tx.o pcie/trans.o
 iwlwifi-objs		+= pcie/ctxt-info.o pcie/ctxt-info-gen3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.c b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
new file mode 100644
index 000000000000..b14ec98e28b6
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.c
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <net/gso.h>
+#include <linux/ieee80211.h>
+#include <net/gso.h>
+#include <net/ip.h>
+
+#include "iwl-drv.h"
+#include "iwl-utils.h"
+
+#ifdef CONFIG_INET
+int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
+		       netdev_features_t netdev_flags,
+		       struct sk_buff_head *mpdus_skbs)
+{
+	struct sk_buff *tmp, *next;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	char cb[sizeof(skb->cb)];
+	u16 i = 0;
+	unsigned int tcp_payload_len;
+	unsigned int mss = skb_shinfo(skb)->gso_size;
+	bool ipv4 = (skb->protocol == htons(ETH_P_IP));
+	bool qos = ieee80211_is_data_qos(hdr->frame_control);
+	u16 ip_base_id = ipv4 ? ntohs(ip_hdr(skb)->id) : 0;
+
+	skb_shinfo(skb)->gso_size = num_subframes * mss;
+	memcpy(cb, skb->cb, sizeof(cb));
+
+	next = skb_gso_segment(skb, netdev_flags);
+	skb_shinfo(skb)->gso_size = mss;
+	skb_shinfo(skb)->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+
+	if (IS_ERR(next) && PTR_ERR(next) == -ENOMEM)
+		return -ENOMEM;
+
+	if (WARN_ONCE(IS_ERR(next),
+		      "skb_gso_segment error: %d\n", (int)PTR_ERR(next)))
+		return PTR_ERR(next);
+
+	if (next)
+		consume_skb(skb);
+
+	skb_list_walk_safe(next, tmp, next) {
+		memcpy(tmp->cb, cb, sizeof(tmp->cb));
+		/*
+		 * Compute the length of all the data added for the A-MSDU.
+		 * This will be used to compute the length to write in the TX
+		 * command. We have: SNAP + IP + TCP for n -1 subframes and
+		 * ETH header for n subframes.
+		 */
+		tcp_payload_len = skb_tail_pointer(tmp) -
+			skb_transport_header(tmp) -
+			tcp_hdrlen(tmp) + tmp->data_len;
+
+		if (ipv4)
+			ip_hdr(tmp)->id = htons(ip_base_id + i * num_subframes);
+
+		if (tcp_payload_len > mss) {
+			skb_shinfo(tmp)->gso_size = mss;
+			skb_shinfo(tmp)->gso_type = ipv4 ? SKB_GSO_TCPV4 :
+							   SKB_GSO_TCPV6;
+		} else {
+			if (qos) {
+				u8 *qc;
+
+				if (ipv4)
+					ip_send_check(ip_hdr(tmp));
+
+				qc = ieee80211_get_qos_ctl((void *)tmp->data);
+				*qc &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+			}
+			skb_shinfo(tmp)->gso_size = 0;
+		}
+
+		skb_mark_not_on_list(tmp);
+		__skb_queue_tail(mpdus_skbs, tmp);
+		i++;
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_tx_tso_segment);
+#endif /* CONFIG_INET */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-utils.h b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
new file mode 100644
index 000000000000..b43703afdff2
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-utils.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_utils_h__
+#define __iwl_utils_h__
+
+#ifdef CONFIG_INET
+/**
+ * iwl_tx_tso_segment - Segments a TSO packet into subframes for A-MSDU.
+ * @skb: buffer to segment.
+ * @num_subframes: number of subframes to create.
+ * @netdev_flags: netdev feature flags.
+ * @mpdus_skbs: list to hold the segmented subframes.
+ *
+ * This function segments a large TCP packet into subframes.
+ * subframes are added to the mpdus_skbs list
+ *
+ * Returns: 0 on success and negative value on failure.
+ */
+int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
+		       netdev_features_t netdev_flags,
+		       struct sk_buff_head *mpdus_skbs);
+#else
+static inline
+int iwl_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
+		       netdev_features_t netdev_flags,
+		       struct sk_buff_head *mpdus_skbs)
+{
+	WARN_ON(1)
+
+	return -1;
+}
+#endif /* CONFIG_INET */
+
+#endif /* __iwl_utils_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f1a8f4ad8b39..b5f6bb9cab4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -13,6 +13,7 @@
 
 #include "iwl-trans.h"
 #include "iwl-nvm-utils.h"
+#include "iwl-utils.h"
 #include "mvm.h"
 #include "sta.h"
 #include "time-sync.h"
@@ -938,78 +939,6 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 
 #ifdef CONFIG_INET
 
-static int
-iwl_mvm_tx_tso_segment(struct sk_buff *skb, unsigned int num_subframes,
-		       netdev_features_t netdev_flags,
-		       struct sk_buff_head *mpdus_skb)
-{
-	struct sk_buff *tmp, *next;
-	struct ieee80211_hdr *hdr = (void *)skb->data;
-	char cb[sizeof(skb->cb)];
-	u16 i = 0;
-	unsigned int tcp_payload_len;
-	unsigned int mss = skb_shinfo(skb)->gso_size;
-	bool ipv4 = (skb->protocol == htons(ETH_P_IP));
-	bool qos = ieee80211_is_data_qos(hdr->frame_control);
-	u16 ip_base_id = ipv4 ? ntohs(ip_hdr(skb)->id) : 0;
-
-	skb_shinfo(skb)->gso_size = num_subframes * mss;
-	memcpy(cb, skb->cb, sizeof(cb));
-
-	next = skb_gso_segment(skb, netdev_flags);
-	skb_shinfo(skb)->gso_size = mss;
-	skb_shinfo(skb)->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
-
-	if (IS_ERR(next) && PTR_ERR(next) == -ENOMEM)
-		return -ENOMEM;
-
-	if (WARN_ONCE(IS_ERR(next),
-		      "skb_gso_segment error: %d\n", (int)PTR_ERR(next)))
-		return PTR_ERR(next);
-
-	if (next)
-		consume_skb(skb);
-
-	skb_list_walk_safe(next, tmp, next) {
-		memcpy(tmp->cb, cb, sizeof(tmp->cb));
-		/*
-		 * Compute the length of all the data added for the A-MSDU.
-		 * This will be used to compute the length to write in the TX
-		 * command. We have: SNAP + IP + TCP for n -1 subframes and
-		 * ETH header for n subframes.
-		 */
-		tcp_payload_len = skb_tail_pointer(tmp) -
-			skb_transport_header(tmp) -
-			tcp_hdrlen(tmp) + tmp->data_len;
-
-		if (ipv4)
-			ip_hdr(tmp)->id = htons(ip_base_id + i * num_subframes);
-
-		if (tcp_payload_len > mss) {
-			skb_shinfo(tmp)->gso_size = mss;
-			skb_shinfo(tmp)->gso_type = ipv4 ? SKB_GSO_TCPV4 :
-							   SKB_GSO_TCPV6;
-		} else {
-			if (qos) {
-				u8 *qc;
-
-				if (ipv4)
-					ip_send_check(ip_hdr(tmp));
-
-				qc = ieee80211_get_qos_ctl((void *)tmp->data);
-				*qc &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
-			}
-			skb_shinfo(tmp)->gso_size = 0;
-		}
-
-		skb_mark_not_on_list(tmp);
-		__skb_queue_tail(mpdus_skb, tmp);
-		i++;
-	}
-
-	return 0;
-}
-
 static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 			  struct ieee80211_tx_info *info,
 			  struct ieee80211_sta *sta,
@@ -1028,7 +957,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (!mvmsta->max_amsdu_len ||
 	    !ieee80211_is_data_qos(hdr->frame_control) ||
 	    !mvmsta->amsdu_enabled)
-		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
+		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
 	/*
 	 * Do not build AMSDU for IPv6 with extension headers.
@@ -1038,7 +967,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	    ((struct ipv6hdr *)skb_network_header(skb))->nexthdr !=
 	    IPPROTO_TCP) {
 		netdev_flags &= ~NETIF_F_CSUM_MASK;
-		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
+		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 	}
 
 	tid = ieee80211_get_tid(hdr);
@@ -1052,7 +981,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if ((info->flags & IEEE80211_TX_CTL_AMPDU &&
 	     !mvmsta->tid_data[tid].amsdu_in_ampdu_allowed) ||
 	    !(mvmsta->amsdu_enabled & BIT(tid)))
-		return iwl_mvm_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
+		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skb);
 
 	/*
 	 * Take the min of ieee80211 station and mvm station
@@ -1110,8 +1039,7 @@ static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
 	 * Trick the segmentation function to make it
 	 * create SKBs that can fit into one A-MSDU.
 	 */
-	return iwl_mvm_tx_tso_segment(skb, num_subframes, netdev_flags,
-				      mpdus_skb);
+	return iwl_tx_tso_segment(skb, num_subframes, netdev_flags, mpdus_skb);
 }
 #else /* CONFIG_INET */
 static int iwl_mvm_tx_tso(struct iwl_mvm *mvm, struct sk_buff *skb,
-- 
2.34.1


