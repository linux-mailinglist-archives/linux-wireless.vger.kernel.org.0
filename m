Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88426E385C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDPMsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDPMs3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9EA3A81
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649300; x=1713185300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AR3doaIp95BdfkaOIn65lxmv8JmAyvFz4N/Lbt0j1tw=;
  b=dibcrDKu7ASkM3SycaYZQbb3du1YafHTOjkI79m0lVBAe/Nou6fScf2q
   ENnJA8TmEa2U/VYJqBC9crJpK0XCfdF52E0QiniU26bvQ20EtY0KfMHho
   ixP295ujfutrPhHK1OcBod3NFVHn351mhSxYZgfJByaN204vDSvR9WY6R
   o9FMDcx5N8n5CiFeNxcba9mRTZEorkvXMSYUvsbb5jUdf2tGbHJA3n2/U
   53G4pw9JnzPONtWm+lu1sM1iMuE2jfyh524tYR+dRxPDr11rHCACyhDNM
   9GtCOVVJU8gSvoejBfv85MSFG3QVBNSOkMbGKizbCjCAxzHtVNhwUtVoF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520575"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670454"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670454"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: allow number of beacons from FW
Date:   Sun, 16 Apr 2023 15:47:37 +0300
Message-Id: <20230416154301.0d7522533557.Ic6b5992e94446c35cb0f3add019defa6e7aded2a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
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

Newer firmware images have a TLV advertising how many
beacons they support, use that to permit adding more
links in AP mode (FW needs to support at least as many
links as beacons).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h          | 1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h           | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c          | 7 +++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 5 ++++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index b00174c9ebce..cddf09d6be1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -104,6 +104,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_CURRENT_PC		= 68,
 
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
+	IWL_UCODE_TLV_FW_NUM_BEACONS		= IWL_UCODE_TLV_CONST_BASE + 2,
 
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
 	IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION	= IWL_UCODE_TLV_DEBUG_BASE + 1,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index f5c4d93d1033..8d0d58d61892 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -51,6 +51,7 @@ struct iwl_ucode_capabilities {
 	u32 error_log_addr;
 	u32 error_log_size;
 	u32 num_stations;
+	u32 num_beacons;
 	unsigned long _api[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_API)];
 	unsigned long _capa[BITS_TO_LONGS(NUM_IWL_UCODE_TLV_CAPA)];
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 042c06a22f5f..34feb4d29adc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1155,6 +1155,12 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			capa->num_stations =
 				le32_to_cpup((const __le32 *)tlv_data);
 			break;
+		case IWL_UCODE_TLV_FW_NUM_BEACONS:
+			if (tlv_len != sizeof(u32))
+				goto invalid_tlv_len;
+			capa->num_beacons =
+				le32_to_cpup((const __le32 *)tlv_data);
+			break;
 		case IWL_UCODE_TLV_UMAC_DEBUG_ADDRS: {
 			const struct iwl_umac_debug_addrs *dbg_ptrs =
 				(const void *)tlv_data;
@@ -1415,6 +1421,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 			IWL_DEFAULT_STANDARD_PHY_CALIBRATE_TBL_SIZE;
 	fw->ucode_capa.n_scan_channels = IWL_DEFAULT_SCAN_CHANNELS;
 	fw->ucode_capa.num_stations = IWL_MVM_STATION_COUNT_MAX;
+	fw->ucode_capa.num_beacons = 1;
 	/* dump all fw memory areas by default */
 	fw->dbg.dump_mask = 0xffffffff;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 203f2513e7ea..99ef12c530ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -882,7 +882,10 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 				n_active++;
 		}
 
-		if (n_active > 1)
+		if (vif->type == NL80211_IFTYPE_AP &&
+		    n_active > mvm->fw->ucode_capa.num_beacons)
+			return -EOPNOTSUPP;
+		else if (n_active > 1)
 			return -EOPNOTSUPP;
 	}
 
-- 
2.38.1

