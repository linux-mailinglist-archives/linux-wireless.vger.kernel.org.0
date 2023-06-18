Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD57347BF
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjFRSu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFRSu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7F9E4E
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114226; x=1718650226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egUBU7Lb9AeiWmo/nWjPDm/T3DhPQxDqgThWkj7kovI=;
  b=iPqJ29dN2I2awNU6tk5KBqjtQ4CAWSPyfKSOIhp/XURZSqPA+lbvF1C3
   96Tnx6AJA/ckiEsAND8WvUn9Oiq+OOdHWI2vzSxAmDLT15FD0UH+FdTyN
   SqqIz4mKmF0SVfNOnpks9eIauwkChkSgzeAL/tfzMFewvfE1kgeilPQSL
   iUyMtpq+1Zp3XsGn08MAXnCtBsjS5uq4K8u6JAEVsPiODkrFEEjl0MiBv
   NG7ms14xVE4Q5NV08+g8GoTGNBeSAyX4R+SF9VimTp/Ps+NZ+bws1GOyF
   dXqloDC02l9pnSKQt5mbL4latqs3Umi/FITcLJJbUjB4199pL51AIY/GH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116634"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:25 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233873"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233873"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/20] wifi: ieee80211: add helper to validate ML element type and size
Date:   Sun, 18 Jun 2023 21:49:46 +0300
Message-Id: <20230618214435.1b50e7a3b3cf.I9385514d8eb6d6d3c82479a6fa732ef65313e554@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The helper functions to retrieve the EML capabilities and medium
synchronization delay both assume that the type is correct. Instead of
assuming the length is correct and still checking the type, add a new
helper to check both and don't do any verification.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h | 50 ++++++++++++++++++++++++---------------
 net/mac80211/mlme.c       |  3 ++-
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 97edc3b404dd..b107f21e1233 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4639,10 +4639,10 @@ static inline u8 ieee80211_mle_common_size(const u8 *data)
  * ieee80211_mle_get_eml_sync_delay - returns the medium sync delay
  * @data: pointer to the multi link EHT IE
  *
- * The element is assumed to be big enough. This must be checked by
- * ieee80211_mle_size_ok().
- * If the medium synchronization can't be found (the type is not basic, or
- * the medium sync presence bit is clear), 0 will be returned.
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the medium synchronization is not present, then 0 is returned.
  */
 static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 {
@@ -4650,13 +4650,7 @@ static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
 	u16 control = le16_to_cpu(mle->control);
 	const u8 *common = mle->variable;
 
-	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
-	    IEEE80211_ML_CONTROL_TYPE_BASIC)
-		return 0;
-
-	/* common points now at the beginning of
-	 * ieee80211_mle_basic_common_info
-	 */
+	/* common points now at the beginning of ieee80211_mle_basic_common_info */
 	common += sizeof(struct ieee80211_mle_basic_common_info);
 
 	if (!(control & IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
@@ -4674,10 +4668,10 @@ static inline u16 ieee80211_mle_get_eml_med_sync_delay(const u8 *data)
  * ieee80211_mle_get_eml_cap - returns the EML capability
  * @data: pointer to the multi link EHT IE
  *
- * The element is assumed to be big enough. This must be checked by
- * ieee80211_mle_size_ok().
- * If the EML capability can't be found (the type is not basic, or
- * the EML capability presence bit is clear), 0 will be returned.
+ * The element is assumed to be of the correct type (BASIC) and big enough,
+ * this must be checked using ieee80211_mle_type_ok().
+ *
+ * If the EML capability is not present, 0 will be returned.
  */
 static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
 {
@@ -4685,10 +4679,6 @@ static inline u16 ieee80211_mle_get_eml_cap(const u8 *data)
 	u16 control = le16_to_cpu(mle->control);
 	const u8 *common = mle->variable;
 
-	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
-	    IEEE80211_ML_CONTROL_TYPE_BASIC)
-		return 0;
-
 	/* common points now at the beginning of ieee80211_mle_basic_common_info */
 	common += sizeof(struct ieee80211_mle_basic_common_info);
 
@@ -4773,6 +4763,28 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 	return mle->variable[0] >= common;
 }
 
+/**
+ * ieee80211_mle_type_ok - validate multi-link element type and size
+ * @data: pointer to the element data
+ * @type: expected type of the element
+ * @len: length of the containing element
+ */
+static inline bool ieee80211_mle_type_ok(const u8 *data, u8 type, size_t len)
+{
+	const struct ieee80211_multi_link_elem *mle = (const void *)data;
+	u16 control;
+
+	if (!ieee80211_mle_size_ok(data, len))
+		return false;
+
+	control = le16_to_cpu(mle->control);
+
+	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) == type)
+		return true;
+
+	return false;
+}
+
 enum ieee80211_mle_subelems {
 	IEEE80211_MLE_SUBELEM_PER_STA_PROFILE		= 0,
 	IEEE80211_MLE_SUBELEM_FRAGMENT		        = 254,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b8f8220cd9ff..30588703ffd3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4852,7 +4852,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 		/* data + 1 / datalen - 1 since it's an extended element */
 		if (eht_ml_elem &&
-		    ieee80211_mle_size_ok(eht_ml_elem->data + 1,
+		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
+					  IEEE80211_ML_CONTROL_TYPE_BASIC,
 					  eht_ml_elem->datalen - 1)) {
 			sdata->vif.cfg.eml_cap =
 				ieee80211_mle_get_eml_cap(eht_ml_elem->data + 1);
-- 
2.38.1

