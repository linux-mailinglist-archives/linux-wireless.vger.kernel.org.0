Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6946424BB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiLEIgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiLEIgi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9806167E9
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229397; x=1701765397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGKVIzE59FVad3tp7Qsn6Yt/SmItQT3t7bKakcovB98=;
  b=GWD0CWEvJqK7A8du5BavZ4KfEnY+tMFV4LyNRZAtlXmB8GrAWKAfFAbI
   JW9GFL3JzS7E2sE0ckSUkexmDZEMLzwO1VPcWEVvDZ8KmRxevCmQb8FEX
   msoHAgWsFxMRpYAqJcRPY31VQy3QI8ngs5pkKWG/133mIKzfRNeo1Voew
   ogOpHSbenGvbAmK6o9fZAxt8pZUFNFSERof4G3e5aku5j5y3N6SHXfJqR
   YjQZ05tzc+s2UuWfi40Z7fdWK4Z8TllPlZDY9ZoIS5w4zReXBjiwwYnWf
   uzMZG1KPTqwUsDKCwgjktO9TOzLVIjwTSNq9kHMGT+KgvRfd4Y0lHmd/h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323182"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100443"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100443"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:34 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/11] wifi: iwlwifi: mvm: d3: add TKIP to the GTK iterator
Date:   Mon,  5 Dec 2022 10:35:46 +0200
Message-Id: <20221205102808.746f40250502.Ieef45ffc617726cb47b3a4ec625d513d16082f4b@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

This was missed when this function was refactored out of
iwl_mvm_wowlan_program_keys.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 919b1f478b4c..c5ad34b063df 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -599,6 +599,11 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 	switch (key->cipher) {
 	default:
 		return;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (!sta)
+			data->kek_kck_cmd->gtk_cipher =
+				cpu_to_le32(STA_KEY_FLG_TKIP);
+		return;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
 		data->kek_kck_cmd->igtk_cipher = cpu_to_le32(STA_KEY_FLG_GCMP);
@@ -610,13 +615,13 @@ static void iwl_mvm_wowlan_gtk_type_iter(struct ieee80211_hw *hw,
 		if (!sta)
 			data->kek_kck_cmd->gtk_cipher =
 				cpu_to_le32(STA_KEY_FLG_CCM);
-		break;
+		return;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		if (!sta)
 			data->kek_kck_cmd->gtk_cipher =
 				cpu_to_le32(STA_KEY_FLG_GCMP);
-		break;
+		return;
 	}
 }
 
-- 
2.35.3

