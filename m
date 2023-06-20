Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD17368C0
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjFTKFG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 06:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjFTKEq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 06:04:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085EF10F3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687255483; x=1718791483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6lQEsTHq+3GFW5u5F7WEXDtyI5zVIvNGeTq7OGDRKFI=;
  b=dbghnl0MXRoTPN4Y/0lzPVuZsG0jjgHU4MscFKYVZOEYtn1P1rRLbkXN
   Bn4olFdpQ5lGwgcp0CbRro4Hdtz+AKf6RSxRY70oVDK7saFR1bAg1BEu7
   +Jc7gzMSRsSWIxG98KF0rGH/KWaSa64vvikeA/Aqn+I/N02wXIPsLLdEy
   V78eRMaz6zzuVpZwPoBSP1hmPq4T8VL7vG7CjIU2Tyz7RMNSbTYv30R9u
   9whGgGS2vbcan+HO2Q8Mom5gaXXhND13Jt/ksCHDOvr/m/2FxVH65t9mM
   qfi/cLiezJrA7RaXploFj2Lg6TX5kytxOxc+YIsu6udtA9+gXzaW47BXV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="359819614"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="359819614"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="838143521"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="838143521"
Received: from rafist-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.208.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 03:04:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/19] wifi: iwlwifi: limit EHT capabilities based on PCIe link speed
Date:   Tue, 20 Jun 2023 13:03:56 +0300
Message-Id: <20230620125813.b77a1574a0a7.Id4120c161fb7df6dedc70d5f3e3829e9117b8cb1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230620100405.45117-1-gregory.greenman@intel.com>
References: <20230620100405.45117-1-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

If a discrete NIC is connected to a PCIe link hat isn't at least
Gen3 (8.0 GT/s), then we cannot sustain 320 MHz traffic, so remove
that from EHT capabilities in that case.

While at it, also move setting 320 MHz beamformee to the right
place in the code so it's not set while not supporting 320 MHz.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    | 15 +++++++++++----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h    |  4 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c     |  9 +++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 39f13518ca5b..8c23f57f5c89 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -680,8 +680,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_eht_capa[] = {
 					IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ_MASK,
 				.phy_cap_info[1] =
 					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_80MHZ_MASK  |
-					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK |
-					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK,
+					IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MHZ_MASK,
 				.phy_cap_info[3] =
 					IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
 					IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
@@ -890,6 +889,10 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			 const struct iwl_fw *fw)
 {
 	bool is_ap = iftype_data->types_mask & BIT(NL80211_IFTYPE_AP);
+	bool no_320;
+
+	no_320 = !trans->trans_cfg->integrated &&
+		 trans->pcie_link_speed < PCI_EXP_LNKSTA_CLS_8_0GB;
 
 	if (!data->sku_cap_11be_enable || iwlwifi_mod_params.disable_11be)
 		iftype_data->eht_cap.has_eht = false;
@@ -916,8 +919,12 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 				       IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK);
 		break;
 	case NL80211_BAND_6GHZ:
-		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
-			IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+		if (!no_320) {
+			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[0] |=
+				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			iftype_data->eht_cap.eht_cap_elem.phy_cap_info[1] |=
+				IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MASK;
+		}
 		fallthrough;
 	case NL80211_BAND_5GHZ:
 		iftype_data->he_cap.he_cap_elem.phy_cap_info[0] |=
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 1fa035decc03..d02943d0ea62 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1067,6 +1067,8 @@ struct iwl_trans_txqs {
  * @iwl_trans_txqs: transport tx queues data.
  * @mbx_addr_0_step: step address data 0
  * @mbx_addr_1_step: step address data 1
+ * @pcie_link_speed: current PCIe link speed (%PCI_EXP_LNKSTA_CLS_*),
+ *	only valid for discrete (not integrated) NICs
  */
 struct iwl_trans {
 	bool csme_own;
@@ -1129,6 +1131,8 @@ struct iwl_trans {
 	u32 mbx_addr_0_step;
 	u32 mbx_addr_1_step;
 
+	u8 pcie_link_speed;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fcc0f3319bcd..18550c03f870 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1760,6 +1760,15 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
 	}
 
+	if (!iwl_trans->trans_cfg->integrated) {
+		u16 link_status;
+
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &link_status);
+
+		iwl_trans->pcie_link_speed =
+			u16_get_bits(link_status, PCI_EXP_LNKSTA_CLS);
+	}
+
 	ret = iwl_trans_init(iwl_trans);
 	if (ret)
 		goto out_free_trans;
-- 
2.38.1

