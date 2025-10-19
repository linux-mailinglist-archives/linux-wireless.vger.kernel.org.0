Return-Path: <linux-wireless+bounces-28056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB1BEE0E3
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B994B3AA47F
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D81E1DE5;
	Sun, 19 Oct 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpSDgJN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFB129D29B
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863533; cv=none; b=cEMSR+XsUIHUjHxd/QyYDw5OahI2+uvodzoolQ1K/xhcEqq6LwC1GbItp7xkPFhdEsZSGUx+kOisg9YDCx3dVxSjLfaGT2/m1DZrvtIKQKNiLsUMxSvpyQi3/1YUc6SHLFUXpP0KQWgKwkmVoj+ngN5J6GelF944P50x6xSkbQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863533; c=relaxed/simple;
	bh=RsTE8UkQTtp6DtUcbnWPckG0gG2d9YPuwZedZhwDM9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izhxGa0IwCmeDmbA3H6seyqEVjWhj0u0/ubvHX1ELVG4nyoaxbRjuBLhuhxpzd9/yK7afwpAPc4hzbOmvHNkrM4vJfWvCs0ANPnmWZt3h+CX+jJ7P4dfw1XCIyvsZv2YWCv6e61s6LL+XpBza+GEW9FOH1l6Xm2sF9p9gB8Vx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpSDgJN3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863531; x=1792399531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RsTE8UkQTtp6DtUcbnWPckG0gG2d9YPuwZedZhwDM9M=;
  b=hpSDgJN3Hyn2ZY+CWLhPlNrC6jAFIqoUNiAyRgG3TWMpwetaLDZb981Y
   mW3Siji7imkCr6EI7zq3gu8fFjEedP1emumXKgwBZLjhp/JdikAnoCcS7
   jMJpktSRyKExLKoL7cPBOwwk8UOkqcFu6vYhmmUnqtoTBz0rq68vQBXdZ
   Koa5sP4pmgd2iSTk0fcOhSeEaGzqlVKCuQ/nmF0aJ1wrLsDHwSzeGt7ZK
   L4Az7bSqGabnQyjJHw+X/RcF4UiMawnoCXl9xRGPEvzIDoIQTNdsRzfdx
   Li1genHz52PxhIOLAETF0kFiM2ixFXcqREsnKvyNwTNsIu+WgQqXpyKRJ
   Q==;
X-CSE-ConnectionGUID: BhjcTJp0Qc+ns+OBZfrW7w==
X-CSE-MsgGUID: yVa4s+nxSgeYvenPIMfsVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363180"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363180"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:31 -0700
X-CSE-ConnectionGUID: 0WGxYqTDTDuoom/OH3hEug==
X-CSE-MsgGUID: qtxMTXh4SPSIwdQFp1L35A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279863"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: include raw PHY notification in radiotap
Date: Sun, 19 Oct 2025 11:45:03 +0300
Message-Id: <20251019114304.5fe26e9061f2.Iefb45e3a6a2a62ff3247db4de3777059d390af95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is useful for debugging and can also be used to see
anything that isn't encoded in radiotap (yet.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 45 +++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 052a19bb85b4..19e78d2fbf9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1217,8 +1217,9 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 	radiotap->oui[0] = 0xf6;
 	radiotap->oui[1] = 0x54;
 	radiotap->oui[2] = 0x25;
-	/* radiotap sniffer config sub-namespace */
+	/* Intel OUI default radiotap subtype */
 	radiotap->oui_subtype = 1;
+	/* Sniffer config element type */
 	radiotap->vendor_type = 0;
 
 	/* fill the data now */
@@ -1229,6 +1230,34 @@ static void iwl_mld_add_rtap_sniffer_config(struct iwl_mld *mld,
 }
 #endif
 
+static void iwl_mld_add_rtap_sniffer_phy_data(struct iwl_mld *mld,
+					      struct sk_buff *skb,
+					      struct iwl_rx_phy_air_sniffer_ntfy *ntfy)
+{
+	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_radiotap_vendor_content *radiotap;
+	const u16 vendor_data_len = sizeof(*ntfy);
+
+	radiotap =
+		iwl_mld_radiotap_put_tlv(skb,
+					 IEEE80211_RADIOTAP_VENDOR_NAMESPACE,
+					 sizeof(*radiotap) + vendor_data_len);
+
+	/* Intel OUI */
+	radiotap->oui[0] = 0xf6;
+	radiotap->oui[1] = 0x54;
+	radiotap->oui[2] = 0x25;
+	/* Intel OUI default radiotap subtype */
+	radiotap->oui_subtype = 1;
+	/* PHY data element type */
+	radiotap->vendor_type = cpu_to_le16(1);
+
+	/* fill the data now */
+	memcpy(radiotap->data, ntfy, vendor_data_len);
+
+	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
+}
+
 static void
 iwl_mld_set_rx_nonlegacy_rate_info(u32 rate_n_flags,
 				   struct ieee80211_rx_status *rx_status)
@@ -1371,6 +1400,9 @@ static void iwl_mld_rx_fill_status(struct iwl_mld *mld, int link_id,
 		}
 	}
 #endif
+
+	if (phy_data->ntfy)
+		iwl_mld_add_rtap_sniffer_phy_data(mld, skb, phy_data->ntfy);
 }
 
 /* iwl_mld_create_skb adds the rxb to a new skb */
@@ -1866,6 +1898,7 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 	u32 mpdu_len;
 	enum iwl_mld_reorder_result reorder_res;
 	struct ieee80211_rx_status *rx_status;
+	unsigned int alloc_size = 128;
 
 	if (unlikely(mld->fw_status.in_hw_restart))
 		return;
@@ -1884,8 +1917,13 @@ void iwl_mld_rx_mpdu(struct iwl_mld *mld, struct napi_struct *napi,
 
 	/* Don't use dev_alloc_skb(), we'll have enough headroom once
 	 * ieee80211_hdr pulled.
+	 *
+	 * For monitor mode we need more space to include the full PHY
+	 * notification data.
 	 */
-	skb = alloc_skb(128, GFP_ATOMIC);
+	if (unlikely(mld->monitor.on) && phy_data.ntfy)
+		alloc_size += sizeof(struct iwl_rx_phy_air_sniffer_ntfy);
+	skb = alloc_skb(alloc_size, GFP_ATOMIC);
 	if (!skb) {
 		IWL_ERR(mld, "alloc_skb failed\n");
 		return;
@@ -2102,7 +2140,8 @@ static void iwl_mld_no_data_rx(struct iwl_mld *mld,
 	u32 format = phy_data.rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
 	struct sk_buff *skb;
 
-	skb = alloc_skb(128, GFP_ATOMIC);
+	skb = alloc_skb(128 + sizeof(struct iwl_rx_phy_air_sniffer_ntfy),
+			GFP_ATOMIC);
 	if (!skb)
 		return;
 
-- 
2.34.1


