Return-Path: <linux-wireless+bounces-5044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA89881909
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA8D2841E6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791385C43;
	Wed, 20 Mar 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mmy2+lSD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F14F8B2
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970015; cv=none; b=TaIBN1usf10n5H6u4f1gGj4gaVupyJLPbmYl66kxNJztCYTGbkMUscJetIkUGE/iXmpUSxkd7ERBTLMM1daA/qVWYH3MPPe5emDogUjlXfIQRdP3C6Ek56M6H1dKe5Dv2YvnnOKNbBuOsbK1uX7eshRDkepvSoZVSKukRj5WleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970015; c=relaxed/simple;
	bh=cQ0tn1VSVEDeu3c9NixN8rumlAm3gOClS9Xb5cSGPc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PpRj1lu9OTw02KlsUcjf4H14cgnuQvD7LuVpwczEUP5B/UHmDGTOJTRRAdSPRt4QukEn+6zx5Vh0lJF8TOAzGCqtarwz3yjPoNkyydjEaFJRylbOVB0rlmVejvguDD5W3pBu6rA67uT1BzcO4YGBTBwpaedOVfzs6uL4l+/FXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mmy2+lSD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970013; x=1742506013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQ0tn1VSVEDeu3c9NixN8rumlAm3gOClS9Xb5cSGPc8=;
  b=Mmy2+lSDpECH7cU7Y6M6SM+wnv8stulOgGey4C2tq2ukmUVDUmX27jta
   3syFeJJ2XuyVzxBpl/b7BorOVCwPgpgHeDiz94QXJM/pIOaH3xp4Q8RwV
   y9VfPAhxyp3MIvYgICilOYqd0SI5pq/PyhMPf4BQryFBRlf+SPzm8fSAF
   BIyr9gBRDj8MLjiOxEWVRSlWTksyoY1kE8j4lARqXy3jiGOXImyNW/zTf
   QKadOcp+a2H7jVh4CzgeWOZaOxHz02/rA3znoD93L8VUGv2slWd7Kuv90
   6/OzZRwmvNrWRlJY3/+uOO3TNkQpLr9YxvW8uZbNlnCiFon2GrJogOZwH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698039"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698039"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184099"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/17] wifi: iwlwifi: mvm: include link ID when releasing frames
Date: Wed, 20 Mar 2024 23:26:22 +0200
Message-Id: <20240320232419.bbbd5e9bfe80.Iec1bf5c884e371f7bc5ea2534ed9ea8d3f2c0bf6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

When releasing frames from the reorder buffer, the link ID was not
included in the RX status information. This subsequently led mac80211 to
drop the frame. Change it so that the link information is set
immediately when possible so that it doesn't not need to be filled in
anymore when submitting the frame to mac80211.

Fixes: b8a85a1d42d7 ("wifi: iwlwifi: mvm: rxmq: report link ID to mac80211")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Tested-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1484eaedf452..ce8d83c771a7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -236,21 +236,13 @@ static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 					    struct napi_struct *napi,
 					    struct sk_buff *skb, int queue,
-					    struct ieee80211_sta *sta,
-					    struct ieee80211_link_sta *link_sta)
+					    struct ieee80211_sta *sta)
 {
 	if (unlikely(iwl_mvm_check_pn(mvm, skb, queue, sta))) {
 		kfree_skb(skb);
 		return;
 	}
 
-	if (sta && sta->valid_links && link_sta) {
-		struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-
-		rx_status->link_valid = 1;
-		rx_status->link_id = link_sta->link_id;
-	}
-
 	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
 }
 
@@ -588,7 +580,7 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		while ((skb = __skb_dequeue(skb_list))) {
 			iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb,
 							reorder_buf->queue,
-							sta, NULL /* FIXME */);
+							sta);
 			reorder_buf->num_stored--;
 		}
 	}
@@ -2213,6 +2205,11 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			if (IS_ERR(sta))
 				sta = NULL;
 			link_sta = rcu_dereference(mvm->fw_id_to_link_sta[id]);
+
+			if (sta && sta->valid_links && link_sta) {
+				rx_status->link_valid = 1;
+				rx_status->link_id = link_sta->link_id;
+			}
 		}
 	} else if (!is_multicast_ether_addr(hdr->addr2)) {
 		/*
@@ -2356,8 +2353,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		    !(desc->amsdu_info & IWL_RX_MPDU_AMSDU_LAST_SUBFRAME))
 			rx_status->flag |= RX_FLAG_AMSDU_MORE;
 
-		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta,
-						link_sta);
+		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta);
 	}
 out:
 	rcu_read_unlock();
-- 
2.34.1


