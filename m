Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80403612BC4
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ3RS1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJ3RSZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50931A0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150301; x=1698686301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrFHSrUtdCf/zRSKM10z3jUmosPd32dBe54zXsN5lFk=;
  b=dyGUr3jwxAsyR/eOHzovNzmkVpo0ZepTIFXPifx8bJhorWmdN7ctrG+4
   wNKfQHVFQWl2+YWzIbzsYFlCnO8fVzZuAUI3XYLtgVeXk4KvedbCaJa22
   fI7Jt7FSVSdxDv2i/PRX9rETqeYKuOFiM3aXXaELATItQloYi2GDIYmWR
   30eZSi867AzuncyPgvR3BGMiZ5VgV48IwFEPgWCL6Pg7RkLHGprZw/flT
   kyvjEIZmFbypzZ8T+XDt0QxUA0jM+mS3nXxK2Z6O6KzpR5oRLeEUUR1uL
   +t3tkJxTDr3BzginP9TyYdfVSIbTW1BSqZtihctAvmfkqvejWqsvJyebW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973220"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973220"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290211"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290211"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:19 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/6] wifi: iwlwifi: mvm: send TKIP connection status to csme
Date:   Sun, 30 Oct 2022 19:17:40 +0200
Message-Id: <20221030191011.cea63e4a355c.If6cdfa52529a79b923191c89dad7ed871d2ad2c6@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221030171745.132081-1-gregory.greenman@intel.com>
References: <20221030171745.132081-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Notify csme when associated with TKIP cipher. TKIP is supported
by csme.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h  | 2 ++
 drivers/net/wireless/intel/iwlwifi/mei/sap.h      | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 67122cfa2292..bea61c8fb526 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -220,6 +220,7 @@ struct iwl_mei_nvm {
 /**
  * enum iwl_mei_pairwise_cipher - cipher for UCAST key
  * @IWL_MEI_CIPHER_NONE: none
+ * @IWL_MEI_CIPHER_TKIP: tkip
  * @IWL_MEI_CIPHER_CCMP: ccmp
  * @IWL_MEI_CIPHER_GCMP: gcmp
  * @IWL_MEI_CIPHER_GCMP_256: gcmp 256
@@ -228,6 +229,7 @@ struct iwl_mei_nvm {
  */
 enum iwl_mei_pairwise_cipher {
 	IWL_MEI_CIPHER_NONE	= 0,
+	IWL_MEI_CIPHER_TKIP	= 2,
 	IWL_MEI_CIPHER_CCMP	= 4,
 	IWL_MEI_CIPHER_GCMP	= 8,
 	IWL_MEI_CIPHER_GCMP_256 = 9,
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index be1456dea484..ef2664589fc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021 - 2022 Intel Corporation
  */
 
 #ifndef __sap_h__
@@ -334,12 +334,14 @@ enum iwl_sap_wifi_auth_type {
 /**
  * enum iwl_sap_wifi_cipher_alg
  * @SAP_WIFI_CIPHER_ALG_NONE: TBD
+ * @SAP_WIFI_CIPHER_ALG_TKIP: TBD
  * @SAP_WIFI_CIPHER_ALG_CCMP: TBD
  * @SAP_WIFI_CIPHER_ALG_GCMP: TBD
  * @SAP_WIFI_CIPHER_ALG_GCMP_256: TBD
  */
 enum iwl_sap_wifi_cipher_alg {
 	SAP_WIFI_CIPHER_ALG_NONE	= IWL_MEI_CIPHER_NONE,
+	SAP_WIFI_CIPHER_ALG_TKIP	= IWL_MEI_CIPHER_TKIP,
 	SAP_WIFI_CIPHER_ALG_CCMP	= IWL_MEI_CIPHER_CCMP,
 	SAP_WIFI_CIPHER_ALG_GCMP	= IWL_MEI_CIPHER_GCMP,
 	SAP_WIFI_CIPHER_ALG_GCMP_256	= IWL_MEI_CIPHER_GCMP_256,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8464c9b7baf1..156283237e2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3059,6 +3059,9 @@ static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
 		return;
 
 	switch (mvm_sta->pairwise_cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		conn_info.pairwise_cipher = IWL_MEI_CIPHER_TKIP;
+		break;
 	case WLAN_CIPHER_SUITE_CCMP:
 		conn_info.pairwise_cipher = IWL_MEI_CIPHER_CCMP;
 		break;
-- 
2.35.3

