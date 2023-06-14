Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187F72F998
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjFNJp2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbjFNJow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E8D294B
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735838; x=1718271838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+AKH+sItKrSY4tD4VKmzffujsEhzQBK5iCUX41dIp88=;
  b=mAZhHyzwSmF1OlcDelflx/EVR/IbSCY9SWaWndSC4d0B1u0pO5pbkyzk
   Whbf0vTNOypOUjn0+TxEhYoJ6g++H25joHAbYPIxo28j3GrgwH8ZS+edZ
   uZ4V2n+448a+TG9FRGokOhw10NyJ4gHa32bsELH+JYCe7NifSo39G969c
   gzytHW0e0xOqxa46JlBv0KW3/5TJGja2l8jIPnCZT6VbZp4l/8txMfZYt
   6z2m8XS9TkDo/cD4BaClwiBSFth/ckF4OybIUc/nFBEnXwf62pqswSCbF
   sEc2hcSHYIaYyEr5CiQtNZbQbjDJyHyqc1mIVSX2oVfB1Zoo0SKnz6HMy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049912"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049912"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989905"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989905"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:31 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/20] wifi: iwlwifi: mvm: track u-APSD misbehaving AP by AP address
Date:   Wed, 14 Jun 2023 12:41:34 +0300
Message-Id: <20230614123447.b6a4f7edd10c.Ie5a8029ed686b9441620ba06596d430432f65559@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the AP is an AP MLD, then we shouldn't track just the BSSID
but the MLD address. Just generally use ap_addr since it has
the BSSID in the non-MLD case.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  6 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 35 ++++++++++++-------
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index 762bce70e262..92c325ff3e88 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -554,7 +554,7 @@ static ssize_t iwl_dbgfs_uapsd_misbehaving_read(struct file *file,
 	char buf[20];
 	int len;
 
-	len = sprintf(buf, "%pM\n", mvmvif->uapsd_misbehaving_bssid);
+	len = sprintf(buf, "%pM\n", mvmvif->uapsd_misbehaving_ap_addr);
 	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
 }
 
@@ -567,7 +567,7 @@ static ssize_t iwl_dbgfs_uapsd_misbehaving_write(struct ieee80211_vif *vif,
 	bool ret;
 
 	mutex_lock(&mvm->mutex);
-	ret = mac_pton(buf, mvmvif->uapsd_misbehaving_bssid);
+	ret = mac_pton(buf, mvmvif->uapsd_misbehaving_ap_addr);
 	mutex_unlock(&mvm->mutex);
 
 	return ret ? count : -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3be67ec5cd4b..c1430e707f8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -419,7 +419,7 @@ struct iwl_mvm_vif {
 #endif
 
 	/* FW identified misbehaving AP */
-	u8 uapsd_misbehaving_bssid[ETH_ALEN];
+	u8 uapsd_misbehaving_ap_addr[ETH_ALEN] __aligned(2);
 	struct delayed_work uapsd_nonagg_detected_wk;
 
 	bool csa_countdown;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 19839cc44eb3..34d4b7a94d82 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -237,8 +237,8 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (!memcmp(mvmvif->uapsd_misbehaving_bssid, vif->bss_conf.bssid,
-		    ETH_ALEN))
+	if (ether_addr_equal(mvmvif->uapsd_misbehaving_ap_addr,
+			     vif->cfg.ap_addr))
 		return false;
 
 	/*
@@ -502,9 +502,9 @@ void iwl_mvm_power_vif_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-	if (memcmp(vif->bss_conf.bssid, mvmvif->uapsd_misbehaving_bssid,
-		   ETH_ALEN))
-		eth_zero_addr(mvmvif->uapsd_misbehaving_bssid);
+	if (!ether_addr_equal(mvmvif->uapsd_misbehaving_ap_addr,
+			      vif->cfg.ap_addr))
+		eth_zero_addr(mvmvif->uapsd_misbehaving_ap_addr);
 }
 
 static void iwl_mvm_power_uapsd_misbehav_ap_iterator(void *_data, u8 *mac,
@@ -512,14 +512,23 @@ static void iwl_mvm_power_uapsd_misbehav_ap_iterator(void *_data, u8 *mac,
 {
 	u8 *ap_sta_id = _data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
 
-	/* The ap_sta_id is not expected to change during current association
-	 * so no explicit protection is needed
-	 */
-	if (mvmvif->deflink.ap_sta_id == *ap_sta_id)
-		memcpy(mvmvif->uapsd_misbehaving_bssid,
-		       vif->bss_conf.bssid,
-		       ETH_ALEN);
+	rcu_read_lock();
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
+
+		/* The ap_sta_id is not expected to change during current
+		 * association so no explicit protection is needed
+		 */
+		if (link_info->ap_sta_id == *ap_sta_id) {
+			ether_addr_copy(mvmvif->uapsd_misbehaving_ap_addr,
+					vif->cfg.ap_addr);
+			break;
+		}
+	}
+	rcu_read_unlock();
 }
 
 void iwl_mvm_power_uapsd_misbehaving_ap_notif(struct iwl_mvm *mvm,
-- 
2.38.1

