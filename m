Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C2701C79
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjENJQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENJQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A722683
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055785; x=1715591785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hina5WF2GvD6F9d+Gh7VJZvPA4HPyIkUXO09tm/2auA=;
  b=WyguKxZJMzLXU6WueSeVhQj5Uv7M7pIUxDpQoNIg+zlnSlexI1Yux3Nf
   02+4gobPgihhOtBlsEk/2MKQ1CsCz2uy172sfiegFfcacNZxDg3M+Aliv
   v9x0jafXcOzozS8FNXUa7fKqqmyCFWXQd80rQFih8jj+mSJrYA8IXSPjr
   RmZsf+CKSp3uwk7o3WXX96uF32GKfEKTF8CScAkEnDU4AWRiPS/WcbS+z
   yrHAte8SR13kTKiNgxYGdN0LW1E2BnVVIpUky0S/2H3XEjoWCeRmBIk12
   rCRR5bADrMvpTvr+bodnQJNj+fhDcfV26jsPNE4tSlE1OoAIh2aFibfn2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366840"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366840"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300368"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300368"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 04/12] wifi: iwlwifi: mvm: fix number of concurrent link checks
Date:   Sun, 14 May 2023 12:15:47 +0300
Message-Id: <20230514120631.992b2f981ef6.I7d386c19354e9be39c4822f436dd22c93422b660@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
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

The concurrent link checks need to correctly differentiate
between AP and non-AP, fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c        | 12 +++++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c    |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index eb828de40a3c..3814915cb1a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -123,11 +123,13 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
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
index fbc2d5ed1006..7fb66c570959 100644
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

