Return-Path: <linux-wireless+bounces-7516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E80F8C3507
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C006D1C20A86
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577A14A8E;
	Sun, 12 May 2024 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWWCTd0y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBE12E71
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488293; cv=none; b=JD/ttzn3EN8QXvzf+C5+aqnwePkBecHEevkMxGQTvIiqmmIDBDuHB42OWW8TVaosWL+G95T9YJ3hIt43xE+UKrCVF0rteUSA2o98LVI7htFhOBSKxPfBc+u+HU22MMzW1HZi6vqnS4XW0MSIx91sUr+j/ncLVuMqIgTElTedAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488293; c=relaxed/simple;
	bh=KZPX2OG4/jcYUZjM5ulQdQ7PAkEjaVHVAr+Cb2+3/cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNB2vT0Ms0KB7ZoffaKGTJDHxB0Lyk8jmMQL8WRk5P7ifsdMi2kQH6gtQG82uYGnDIKbxTwGhpEjwFlaOAQpNziS+DIOxg2ivajV9xuwhzxhY9ckIbccpXqHqDB4+gDsxJG/Ziu7jH29nB/rIH2qrhlHiFzZJicDcVgW5kojwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWWCTd0y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488292; x=1747024292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZPX2OG4/jcYUZjM5ulQdQ7PAkEjaVHVAr+Cb2+3/cg=;
  b=NWWCTd0yIKVrj95GAIsWVTcz1R4hnYU65a22Tblp3I46m0F1rG9KMZtg
   LCpjgJco/R1rfa8ss9Qi+LwgItXg2u3Xwx56cXuYq+wC9K9Ll3DF5cqul
   7hb2tQBZ8gR9jqLpbZ+8ORM2IUMX6dcDD5NCgleltc9B7fUQMAHf8bFZv
   B/uGwTy4K5w/zlEJx4ay/8l5HhLz/nkPTzD+U798TZYuSWsrBQ+KJ7nHm
   wqPkeq43q4seT6bT3PTbji7HhNF3n2LHgWqJLzQ3C0h5r5igxPA+azdSv
   wEgBG3go8Di0grnfj5kEjvxc9w+q1bwVMl4zZG7r/rttUomNwhK8c9OQq
   g==;
X-CSE-ConnectionGUID: /H548CJxRsenDVf3UYv9xg==
X-CSE-MsgGUID: WlqAAi7oRiWxUtyh7A91gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323843"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323843"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:32 -0700
X-CSE-ConnectionGUID: oO2jeZ1fTSKxnkth6o732w==
X-CSE-MsgGUID: 8sa5iHodSZWSP6ZY84eC1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532153"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/16] wifi: iwlwifi: mvm: mark bad no-data RX as having bad PLCP
Date: Sun, 12 May 2024 07:30:59 +0300
Message-Id: <20240512072733.e6adcb9a6ece.Ic14c2e8ed5e80d48af78b2f04e9f08beeb62d68e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Just like with any other frame, mac80211 will do sanity checks
on no-data RX (representing e.g. sounding PPDUs), and if e.g.
the NSS is wrong, it will warn. This isn't a good idea if we
already know the frame wasn't received well, e.g. has bad PLCP.
Unless the firmware reports "no error", set the bad PLCP flag
to skip checks in mac80211.

Also, since we're now extracting two different values from the
info field, use le32_get_bits() for both.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 98a4f6fb3f03..0f78a9ef5240 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2361,7 +2361,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_rx_no_data_ver_3 *desc = (void *)pkt->data;
 	u32 rssi;
-	u32 info_type;
 	struct ieee80211_sta *sta = NULL;
 	struct sk_buff *skb;
 	struct iwl_mvm_rx_phy_data phy_data;
@@ -2374,7 +2373,6 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		return;
 
 	rssi = le32_to_cpu(desc->rssi);
-	info_type = le32_to_cpu(desc->info) & RX_NO_DATA_INFO_TYPE_MSK;
 	phy_data.d0 = desc->phy_info[0];
 	phy_data.d1 = desc->phy_info[1];
 	phy_data.phy_info = IWL_RX_MPDU_PHY_TSF_OVERLOAD;
@@ -2426,7 +2424,12 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	/* 0-length PSDU */
 	rx_status->flag |= RX_FLAG_NO_PSDU;
 
-	switch (info_type) {
+	/* mark as failed PLCP on any errors to skip checks in mac80211 */
+	if (le32_get_bits(desc->info, RX_NO_DATA_INFO_ERR_MSK) !=
+	    RX_NO_DATA_INFO_ERR_NONE)
+		rx_status->flag |= RX_FLAG_FAILED_PLCP_CRC;
+
+	switch (le32_get_bits(desc->info, RX_NO_DATA_INFO_TYPE_MSK)) {
 	case RX_NO_DATA_INFO_TYPE_NDP:
 		rx_status->zero_length_psdu_type =
 			IEEE80211_RADIOTAP_ZERO_LEN_PSDU_SOUNDING;
-- 
2.34.1


