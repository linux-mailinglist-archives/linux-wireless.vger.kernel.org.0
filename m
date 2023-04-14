Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C06E2082
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDNKPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNKPt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:15:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69D6E9F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467327; x=1713003327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydlu9PSLfzaJkzTfTeo2ZfRm5WFqoiTW3gR0bQ4SnTA=;
  b=ZbICIJ7PODV8ZEyaAx2yJFljBtIQLLZT68nBwyow5IRdwc+0TSXRkxeA
   t0We/s5+uRgVV6I/Be6RgonMa6zzzQKC7TyBZlC4r4NGL8clxvtGocGbz
   8WR3MQ1m09ErMBcDsVJRNx+WaDYIOGSswLkbtsXjYqyyxWtRT5CCtSpEW
   jO/JHG/0EDLDlAyAI3mkl9FM44fk82qvflfZVyd51XDwNEllFmHcu0Y5T
   ucgwusCZTrcHbJVBpi+XczLXEf2cvwUJ8s3P8hUJkrRGmvhh4iNkdtoGE
   kGNK3ezF50BcKQ9B9zSrqnzPo8tToDsRmWshp8C0tQBOb/9IIcAOgNutR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263681"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263681"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351815"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351815"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:42 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: mvm: set STA mask for keys in MLO
Date:   Fri, 14 Apr 2023 13:12:03 +0300
Message-Id: <20230414130637.cedae2f21829.Iae07b736c3109d085ad5b74ec8282ce45020da39@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Implement the full STA mask and selecting the correct link
for key installation.

While at it, catch errors if this function returns a bad
zero station mask, rather than waiting for the firmware to
crash on it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 69 ++++++++++++++++---
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 9ec1c505002f..7c417b39aca4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -14,23 +14,68 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 				    struct ieee80211_key_conf *keyconf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *link_info = &mvmvif->deflink;
+	struct iwl_mvm_link_sta *link_sta;
+	struct iwl_mvm_sta *mvmsta;
+	u32 result = 0;
+	int link_id;
 
+	lockdep_assert_held(&mvm->mutex);
+
+	if (keyconf->link_id >= 0) {
+		link_info = mvmvif->link[keyconf->link_id];
+		if (!link_info)
+			return 0;
+	}
+
+	/* AP group keys are per link and should be on the mcast STA */
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
-		return BIT(mvmvif->deflink.mcast_sta.sta_id);
+		return BIT(link_info->mcast_sta.sta_id);
+
+	/* for client mode use the AP STA also for group keys */
+	if (!sta && vif->type == NL80211_IFTYPE_STATION)
+		sta = mvmvif->ap_sta;
+
+	/* During remove the STA was removed and the group keys come later
+	 * (which sounds like a bad sequence, but remember that to mac80211 the
+	 * group keys have no sta pointer), so we don't have a STA now.
+	 * Since this happens for group keys only, just use the link_info as
+	 * the group keys are per link; make sure that is the case by checking
+	 * we do have a link_id or are not doing MLO.
+	 * Of course the same can be done during add as well, but we must do
+	 * it during remove, since we don't have the mvmvif->ap_sta pointer.
+	 */
+	if (!sta && (keyconf->link_id >= 0 || !vif->valid_links))
+		return BIT(link_info->ap_sta_id);
 
-	if (sta) {
-		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	/* this shouldn't happen now */
+	if (!sta)
+		return 0;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	/* it's easy when the STA is not an MLD */
+	if (!sta->valid_links)
 		return BIT(mvmsta->deflink.sta_id);
-	}
 
-	if (vif->type == NL80211_IFTYPE_STATION &&
-	    mvmvif->deflink.ap_sta_id != IWL_MVM_INVALID_STA)
-		return BIT(mvmvif->deflink.ap_sta_id);
+	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
+	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
+		/* unless we have a specific link in mind (GTK on client) */
+		if (keyconf->link_id >= 0 &&
+		    keyconf->link_id != link_id)
+			continue;
+
+		link_sta =
+			rcu_dereference_protected(mvmsta->link[link_id],
+						  lockdep_is_held(&mvm->mutex));
+		if (!link_sta)
+			continue;
+
+		result |= BIT(link_sta->sta_id);
+	}
 
-	/* invalid */
-	return 0;
+	return result;
 }
 
 static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
@@ -113,6 +158,9 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
 	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
 		return -EINVAL;
 
+	if (WARN_ON(!sta_mask))
+		return -EINVAL;
+
 	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
 	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
 		memcpy(cmd.u.add.key + IWL_SEC_WEP_KEY_OFFSET, keyconf->key,
@@ -159,6 +207,9 @@ static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
 	int ret;
 
+	if (WARN_ON(!sta_mask))
+		return -EINVAL;
+
 	ret = __iwl_mvm_sec_key_del(mvm, sta_mask, key_flags, keyconf->keyidx,
 				    flags);
 	if (ret)
-- 
2.38.1

