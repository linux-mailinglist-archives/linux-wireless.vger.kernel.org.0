Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B27CBEC0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjJQJRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343496AbjJQJRT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 05:17:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB41E8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534237; x=1729070237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AXiCUqtSoOu7lhY2fEX1jxTvaaLbbFr2jw2P4ZWcCaU=;
  b=i67p6oK1jO9SLbOV7yY+bhRv2RJT2Bj7qVdTJM1ilfh+JVVGyw5+G4QP
   iDQZEGfKynDZiMzeo/TgjAHo4qkxc4c7uF5N2rN9sYW65s2GjNW2KS4Hs
   LgCdokUR72PwIm8Z7wJaecxH4JQcotHCYFx8O4wqnQfY3zjn+CIJ/c5Ww
   pLeBqpNWqDQVhgXQa7j/d+7txfaXzKeSI735l4FqwecYCgG+2w3JyrTt/
   pEG9P5xyRtcD3I0vwR7DmCwu1VqhyTl3B/3Rm0B/IWBlZLhscNnN+xBED
   iu79WtcN5v8JjmmDSSOq6bDjGNqG6lgN63GO0Ma3eGYaUG+xaNKba4fWa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="370808544"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="370808544"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759731905"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759731905"
Received: from obarinsh-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.213.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:17:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: fix netif csum flags
Date:   Tue, 17 Oct 2023 12:16:41 +0300
Message-Id: <20231017115047.e37327f1a129.Iaee86b00db4db791cd90adaf15384b8c87d2ad49@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231017091649.65090-1-gregory.greenman@intel.com>
References: <20231017091649.65090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't advertise arbitrary checksum flags since we had
to remove support for it due to broken hardware.

Fixes: ec18e7d4d20d ("wifi: iwlwifi: mvm: use old checksum for Bz A-step")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c     | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 5 +----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b2ebc8146465..ed097dd394c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -158,7 +158,7 @@ const struct iwl_cfg iwl_cfg_bz = {
 	.fw_name_mac = "bz",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
@@ -166,7 +166,7 @@ const struct iwl_cfg iwl_cfg_gl = {
 	.fw_name_mac = "gl",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_BZ_EHT,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index fea4551ea86a..bc1e75ee946a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -151,7 +151,7 @@ const struct iwl_cfg iwl_cfg_sc = {
 	.fw_name_mac = "sc",
 	.uhb_supported = true,
 	IWL_DEVICE_SC,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
 	.num_rbds = IWL_NUM_RBDS_SC_EHT,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 90bebdf85c06..02ded22295c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -86,10 +86,7 @@ enum iwl_nvm_type {
 #define IWL_DEFAULT_MAX_TX_POWER 22
 #define IWL_TX_CSUM_NETIF_FLAGS (NETIF_F_IPV6_CSUM | NETIF_F_IP_CSUM |\
 				 NETIF_F_TSO | NETIF_F_TSO6)
-#define IWL_TX_CSUM_NETIF_FLAGS_BZ (NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6)
-#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | \
-				   IWL_TX_CSUM_NETIF_FLAGS_BZ | \
-				   NETIF_F_RXCSUM)
+#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM)
 
 /* Antenna presence definitions */
 #define	ANT_NONE	0x0
-- 
2.38.1

