Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41A572E376
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbjFMM5v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241164AbjFMM5s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A6198D
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661066; x=1718197066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgRwDGsyj9LsTitWBWTUPxY4xsbZ+/HeOIW/vkoMmhM=;
  b=lIkuoMSp0KpQToum1vIxV+TOfQDVgfZtTZH1x/vG8fIqVS2T2Wg8yBzM
   NtCrRfn/9KmTRwUfmfGwFMPJ/Xan+KIZsy1HYXs/V/biLProsDZ3Y9gYb
   0C5/1YBmCcftZsTtqyskYhrkvnBw14FWnHMHcQyT7brTvcTv+qwqNIEbx
   czg44lfjIy385fMjJB+EKt+YkFd+snW8qVJRg5OKAJVvEs7LIe2ol2PA0
   ADt8/qpVQzv+KkMZNlQXMC8hnEjwYGoDb49G76qrRRN1EGTUrrudksA52
   a/mOs2Y0x3xKVoz5JRKZnyZz5SuHUetvpsjQqC2csW6vhsjNHi/CrQB4o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973719"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973719"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880782"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880782"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:45 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: mvm: initialize the rx_vec before using it.
Date:   Tue, 13 Jun 2023 15:57:16 +0300
Message-Id: <20230613155501.a6bb856f04bc.I9a15075f3dad61dcabdcd1ed0d34cf3e8ec5453f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Initialize the phy_data.rx_vec for both version-3 and above
where it is 4-byte data size and below version which has
data size of 2-byte.
The data will be sent uninitialized in called function if
notification version is less than three.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 70db4fef6290..9d8d9def9391 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2642,6 +2642,8 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	phy_data.energy_b = u32_get_bits(rssi, RX_NO_DATA_CHAIN_B_MSK);
 	phy_data.channel = u32_get_bits(rssi, RX_NO_DATA_CHANNEL_MSK);
 	phy_data.with_data = false;
+	phy_data.rx_vec[0] = desc->rx_vec[0];
+	phy_data.rx_vec[1] = desc->rx_vec[1];
 
 	if (iwl_fw_lookup_notif_ver(mvm->fw, DATA_PATH_GROUP,
 				    RX_NO_DATA_NOTIF, 0) < 2) {
@@ -2660,7 +2662,8 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 		    sizeof(struct iwl_rx_no_data_ver_3)))
 		/* invalid len for ver 3 */
 			return;
-		memcpy(phy_data.rx_vec, desc->rx_vec, sizeof(phy_data.rx_vec));
+		phy_data.rx_vec[2] = desc->rx_vec[2];
+		phy_data.rx_vec[3] = desc->rx_vec[3];
 	} else {
 		if (format == RATE_MCS_EHT_MSK)
 			/* no support for EHT before version 3 API */
-- 
2.38.1

