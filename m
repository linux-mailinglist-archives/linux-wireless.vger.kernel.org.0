Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144737347CF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFRSvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjFRSvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:51:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD57E64
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114267; x=1718650267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FX+VqwJfvdTxVNkST+Sy1h96484hs2psU+SUNnRx9CE=;
  b=IxeQnEPM1Y85cp9cjS63q2Bi01Pq+FRUE8ogh+fugVjG+t13XVFToWyZ
   OtfYtekxoc6zzLTdv7/KVcZay3vS5wzBOFR70yfnZyqiW4mL3h0vAu9Bt
   ni6p+iVyjLYZjuulMqFD9Z/vy3+e89CpA8eulRc+Xy+c3TSsoLoRGAeWa
   nAADHVLC/BRDJpIzMxVwb4DdPVrU+5Btie+V61s3ggeJGJgSbsViZJhFt
   VIk58LD8t6T5EwOyTCv3LqlbE03S8eZ0k7GjIUVjT0OMauFdDtMDqDiJQ
   rHMhS/w8N6Zk2rH5FoWmDJL/5BABa6+ekDcT61k5V+jpQZ1Mb7p1onga2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116682"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116682"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:51:06 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234150"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234150"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:51:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 20/20] wifi: mac80211: check EHT basic MCS/NSS set
Date:   Sun, 18 Jun 2023 21:50:02 +0300
Message-Id: <20230618214436.737827c906c9.I0c11a3cd46ab4dcb774c11a5bbc30aecfb6fce11@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Check that all the NSS in the EHT basic MCS/NSS set
are actually supported, otherwise disable EHT for the
connection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 28 ++++++++----
 net/mac80211/mlme.c       | 89 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d2025c986b0f..fa679613c562 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1996,12 +1996,18 @@ struct ieee80211_mu_edca_param_set {
  * @rx_tx_mcs13_max_nss: indicates the maximum number of spatial streams
  *     supported for reception and the maximum number of spatial streams
  *     supported for transmission for MCS 12 - 13.
+ * @rx_tx_max_nss: array of the previous fields for easier loop access
  */
 struct ieee80211_eht_mcs_nss_supp_20mhz_only {
-	u8 rx_tx_mcs7_max_nss;
-	u8 rx_tx_mcs9_max_nss;
-	u8 rx_tx_mcs11_max_nss;
-	u8 rx_tx_mcs13_max_nss;
+	union {
+		struct {
+			u8 rx_tx_mcs7_max_nss;
+			u8 rx_tx_mcs9_max_nss;
+			u8 rx_tx_mcs11_max_nss;
+			u8 rx_tx_mcs13_max_nss;
+		};
+		u8 rx_tx_max_nss[4];
+	};
 };
 
 /**
@@ -2021,11 +2027,17 @@ struct ieee80211_eht_mcs_nss_supp_20mhz_only {
  * @rx_tx_mcs13_max_nss: indicates the maximum number of spatial streams
  *     supported for reception and the maximum number of spatial streams
  *     supported for transmission for MCS 12 - 13.
+ * @rx_tx_max_nss: array of the previous fields for easier loop access
  */
 struct ieee80211_eht_mcs_nss_supp_bw {
-	u8 rx_tx_mcs9_max_nss;
-	u8 rx_tx_mcs11_max_nss;
-	u8 rx_tx_mcs13_max_nss;
+	union {
+		struct {
+			u8 rx_tx_mcs9_max_nss;
+			u8 rx_tx_mcs11_max_nss;
+			u8 rx_tx_mcs13_max_nss;
+		};
+		u8 rx_tx_max_nss[3];
+	};
 };
 
 /**
@@ -2078,7 +2090,7 @@ struct ieee80211_eht_cap_elem {
  */
 struct ieee80211_eht_operation {
 	u8 params;
-	__le32 basic_mcs_nss;
+	struct ieee80211_eht_mcs_nss_supp_20mhz_only basic_mcs_nss;
 	u8 optional[];
 } __packed;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 06ba809f83a1..13226349e80e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4692,6 +4692,89 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 	return false;
 }
 
+static u8
+ieee80211_get_eht_cap_mcs_nss(const struct ieee80211_sta_he_cap *sta_he_cap,
+			      const struct ieee80211_sta_eht_cap *sta_eht_cap,
+			      unsigned int idx, int bw)
+{
+	u8 he_phy_cap0 = sta_he_cap->he_cap_elem.phy_cap_info[0];
+	u8 eht_phy_cap0 = sta_eht_cap->eht_cap_elem.phy_cap_info[0];
+
+	/* handle us being a 20 MHz-only EHT STA - with four values
+	 * for MCS 0-7, 8-9, 10-11, 12-13.
+	 */
+	if (!(he_phy_cap0 & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL))
+		return sta_eht_cap->eht_mcs_nss_supp.only_20mhz.rx_tx_max_nss[idx];
+
+	/* the others have MCS 0-9 together, rather than separately from 0-7 */
+	if (idx > 0)
+		idx--;
+
+	switch (bw) {
+	case 0:
+		return sta_eht_cap->eht_mcs_nss_supp.bw._80.rx_tx_max_nss[idx];
+	case 1:
+		if (!(he_phy_cap0 &
+		      (IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
+		       IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)))
+			return 0xff; /* pass check */
+		return sta_eht_cap->eht_mcs_nss_supp.bw._160.rx_tx_max_nss[idx];
+	case 2:
+		if (!(eht_phy_cap0 & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ))
+			return 0xff; /* pass check */
+		return sta_eht_cap->eht_mcs_nss_supp.bw._320.rx_tx_max_nss[idx];
+	}
+
+	WARN_ON(1);
+	return 0;
+}
+
+static bool
+ieee80211_verify_sta_eht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     struct ieee80211_supported_band *sband,
+				     const struct ieee80211_eht_operation *eht_op)
+{
+	const struct ieee80211_sta_he_cap *sta_he_cap =
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	const struct ieee80211_sta_eht_cap *sta_eht_cap =
+		ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	const struct ieee80211_eht_mcs_nss_supp_20mhz_only *req;
+	unsigned int i;
+
+	if (!sta_he_cap || !sta_eht_cap || !eht_op)
+		return false;
+
+	req = &eht_op->basic_mcs_nss;
+
+	for (i = 0; i < ARRAY_SIZE(req->rx_tx_max_nss); i++) {
+		u8 req_rx_nss, req_tx_nss;
+		unsigned int bw;
+
+		req_rx_nss = u8_get_bits(req->rx_tx_max_nss[i],
+					 IEEE80211_EHT_MCS_NSS_RX);
+		req_tx_nss = u8_get_bits(req->rx_tx_max_nss[i],
+					 IEEE80211_EHT_MCS_NSS_TX);
+
+		for (bw = 0; bw < 3; bw++) {
+			u8 have, have_rx_nss, have_tx_nss;
+
+			have = ieee80211_get_eht_cap_mcs_nss(sta_he_cap,
+							     sta_eht_cap,
+							     i, bw);
+			have_rx_nss = u8_get_bits(have,
+						  IEEE80211_EHT_MCS_NSS_RX);
+			have_tx_nss = u8_get_bits(have,
+						  IEEE80211_EHT_MCS_NSS_TX);
+
+			if (req_rx_nss > have_rx_nss ||
+			    req_tx_nss > have_tx_nss)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_link_data *link,
 				  struct cfg80211_bss *cbss,
@@ -4847,11 +4930,15 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		else
 			eht_oper = NULL;
 
+		if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
+			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+
 		eht_ml_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
 						     cbss_ies->data, cbss_ies->len);
 
 		/* data + 1 / datalen - 1 since it's an extended element */
-		if (eht_ml_elem &&
+		if (!(*conn_flags & IEEE80211_CONN_DISABLE_EHT) &&
+		    eht_ml_elem &&
 		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
 					  IEEE80211_ML_CONTROL_TYPE_BASIC,
 					  eht_ml_elem->datalen - 1)) {
-- 
2.38.1

