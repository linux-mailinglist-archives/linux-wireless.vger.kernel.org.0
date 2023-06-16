Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5547C7327F3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbjFPGyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjFPGyf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:54:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB52961
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898474; x=1718434474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jKS8ac917x6fG3VAiEprkoHJsX3ftSXRKxyl6hub3f4=;
  b=CdLN2lPUPI4UfAusxw2h3QC7vzFFsCS8Si0YwJAH4FTR63vECDFfy3lY
   WZ6SCFD55YqkIzDdAbKQc+DaxV4J7vtqWbG/qE2nlmNH6Kh3WL0RGx/4h
   G2GcC/q4vaM6I2QMCln/Ibheae/jWU99f9x8V40WkxGbqWWH4T+dJ/2pE
   o5ixv8v7mcRbBZb0Vi1h4Pu5r61fnu0EBA0/3gwwdvv4xppqSbi7/SMky
   viuidwTHqycFpo4Vh+BTQqodBhoqse8Zs2e+qxnvSgxz0BceuwrYW0IZ4
   xjAiVFGUGwN1giD3Fip7x1SlFIjbtxvVwlkFlzZofjmYg4eTC/Wsta7Q4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425078805"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425078805"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802720006"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="802720006"
Received: from ereznaim-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.237.118])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:54:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Abhishek Naik <abhishek.naik@intel.com>,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/20] wifi: mac80211: Add HE and EHT capa elements in TDLS frames
Date:   Fri, 16 Jun 2023 09:53:53 +0300
Message-Id: <20230616094948.c77128828b0d.Ied2d8800847c759718c2c35e8f6c0902afd6bca1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230616065409.633290-1-gregory.greenman@intel.com>
References: <20230616065409.633290-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abhishek Naik <abhishek.naik@intel.com>

Add HE and EHT capabilities IE in TDLS setup request,
response, confirm and discovery response frames.

Signed-off-by: Abhishek Naik <abhishek.naik@intel.com>
Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tdls.c        | 85 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/util.c        |  2 +-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ca8a1e1c8bbd..f8d5f37ebe9a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2426,6 +2426,7 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 				    const u8 *da, const u8 *bssid,
 				    u16 stype, u16 reason,
 				    bool send_frame, u8 *frame_buf);
+u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end);
 
 enum {
 	IEEE80211_PROBE_FLAG_DIRECTED		= BIT(0),
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 8f59f92ea9d9..c085c076aaef 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -372,6 +372,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct sta_info *sta = NULL;
 	size_t offset = 0, noffset;
 	u8 *pos;
@@ -533,6 +535,82 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 			ieee80211_tdls_chandef_vht_upgrade(sdata, sta);
 	}
 
+	/* add any custom IEs that go before HE capabilities */
+	if (extra_ies_len) {
+		static const u8 before_he_cap[] = {
+			WLAN_EID_EXTENSION,
+			WLAN_EID_EXT_FILS_REQ_PARAMS,
+			WLAN_EID_AP_CSN,
+		};
+		noffset = ieee80211_ie_split(extra_ies, extra_ies_len,
+					     before_he_cap,
+					     ARRAY_SIZE(before_he_cap),
+					     offset);
+		skb_put_data(skb, extra_ies + offset, noffset - offset);
+		offset = noffset;
+	}
+
+	/* build the HE-cap from sband */
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	if (he_cap &&
+	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
+	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
+	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)) {
+		__le16 he_6ghz_capa;
+		u8 cap_size;
+
+		cap_size =
+			2 + 1 + sizeof(he_cap->he_cap_elem) +
+			ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem) +
+			ieee80211_he_ppe_size(he_cap->ppe_thres[0],
+					      he_cap->he_cap_elem.phy_cap_info);
+		pos = skb_put(skb, cap_size);
+		pos = ieee80211_ie_build_he_cap(0, pos, he_cap, pos + cap_size);
+
+		/* Build HE 6Ghz capa IE from sband */
+		if (sband->band == NL80211_BAND_6GHZ) {
+			cap_size = 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
+			pos = skb_put(skb, cap_size);
+			he_6ghz_capa =
+				ieee80211_get_he_6ghz_capa_vif(sband, &sdata->vif);
+			pos = ieee80211_write_he_6ghz_cap(pos, he_6ghz_capa,
+							  pos + cap_size);
+		}
+	}
+
+	/* add any custom IEs that go before EHT capabilities */
+	if (extra_ies_len) {
+		static const u8 before_he_cap[] = {
+			WLAN_EID_EXTENSION,
+			WLAN_EID_EXT_FILS_REQ_PARAMS,
+			WLAN_EID_AP_CSN,
+		};
+
+		noffset = ieee80211_ie_split(extra_ies, extra_ies_len,
+					     before_he_cap,
+					     ARRAY_SIZE(before_he_cap),
+					     offset);
+		skb_put_data(skb, extra_ies + offset, noffset - offset);
+		offset = noffset;
+	}
+
+	/* build the EHT-cap from sband */
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
+	if (he_cap && eht_cap &&
+	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
+	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
+	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)) {
+		u8 cap_size;
+
+		cap_size =
+			2 + 1 + sizeof(eht_cap->eht_cap_elem) +
+			ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						   &eht_cap->eht_cap_elem, false) +
+			ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
+					       eht_cap->eht_cap_elem.phy_cap_info);
+		pos = skb_put(skb, cap_size);
+		ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + cap_size, false);
+	}
 	mutex_unlock(&local->sta_mtx);
 
 	/* add any remaining IEs */
@@ -897,6 +975,13 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80211_sub_if_data *sdata,
 				       sizeof(struct ieee80211_ht_operation)) +
 			       2 + max(sizeof(struct ieee80211_vht_cap),
 				       sizeof(struct ieee80211_vht_operation)) +
+			       2 + 1 + sizeof(struct ieee80211_he_cap_elem) +
+				       sizeof(struct ieee80211_he_mcs_nss_supp) +
+				       IEEE80211_HE_PPE_THRES_MAX_LEN +
+			       2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
+			       2 + 1 + sizeof(struct ieee80211_eht_cap_elem) +
+				       sizeof(struct ieee80211_eht_mcs_nss_supp) +
+				       IEEE80211_EHT_PPE_THRES_MAX_LEN +
 			       50 + /* supported channels */
 			       3 + /* 40/20 BSS coex */
 			       4 + /* AID */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2fc07717bcad..b81089fc51e1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1918,7 +1918,7 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
+u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
 {
 	if ((end - pos) < 5)
 		return pos;
-- 
2.38.1

