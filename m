Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85496FA230
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjEHIZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjEHIZW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC121940E
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534318; x=1715070318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNNmq6hQQ8WX3i9H7Gz9k6QPIKcpJCZ+Yk3vH9TLWOs=;
  b=WvyWkt0/heeWfCZNCXTfQlY5ksJoKLYhGIC0g/9NsGazPXgLCWU1SIvi
   AGL+AZZHUgsAwvPl3zXef5mme6Cab26leLnggdGOzgidwqVKjCZPBRneT
   elh+U48q54PPRb5qn0o2uRsBPwWfaBkYuE9uWBcwVkJfHD6+CjzKYIkDz
   8UZzOjmeyvhFx37EoXeETKBB4hSdLsvELNKT+BpLm+L+qFQiQcVTFMnUb
   DoDeKhtEE1rrRqqgsvob9kDAJhTK1baYkH2lXsWvMPS/yUsmKGdc85aws
   kNp5LzUeC2jUOM2mOraiq7CsZM+QmigxRmR2jxuIGrvZ6/KxPW81n2DRx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949924"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949924"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982683"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982683"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:09 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: fix number of concurrent link checks
Date:   Mon,  8 May 2023 11:24:32 +0300
Message-Id: <20230508082433.1349733-14-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The concurrent link checks need to correctly differentiate
between AP and non-AP, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c        | 12 +++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c    |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index a1d31c6eab2c..dc31f8de7d1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -127,11 +127,13 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				if (mvmvif->link[i]->phy_ctxt)
 					count++;
 
-			/* FIXME: IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM should be
-			 * defined per HW
-			 */
-			if (count >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM)
-				return -EINVAL;
+			if (vif->type == NL80211_IFTYPE_AP) {
+				if (count > mvm->fw->ucode_capa.num_beacons)
+					return -EOPNOTSUPP;
+			/* this should be per HW or such */
+			} else if (count >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM) {
+				return -EOPNOTSUPP;
+			}
 		}
 
 		/* Catch early if driver tries to activate or deactivate a link
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9dfb07db396e..fb06cf94fcc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -906,11 +906,12 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 				n_active++;
 		}
 
-		if (vif->type == NL80211_IFTYPE_AP &&
-		    n_active > mvm->fw->ucode_capa.num_beacons)
-			return -EOPNOTSUPP;
-		else if (n_active > 1)
+		if (vif->type == NL80211_IFTYPE_AP) {
+			if (n_active > mvm->fw->ucode_capa.num_beacons)
+				return -EOPNOTSUPP;
+		} else if (n_active > 1) {
 			return -EOPNOTSUPP;
+		}
 	}
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-- 
2.38.1

