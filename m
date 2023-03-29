Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE126CD29C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjC2HIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjC2HI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EAC2D54
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073688; x=1711609688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vxzm5QcpCW/WniHBdUPrsW6yidOZDeqmarkbGhPsyKk=;
  b=gh8wkekwcxDh+Y5o4KSrMEnEdWLWgr24Xg+2yto6kxclF17fLB53JiOU
   np1hA7JNM3LuYrB5khlpErlgBRvg6eP87L5OhHD7mfGpt3g2PEZeLIeJl
   sSoFDrLOy9hAjhWtTVMfWXSsZapH7Rw+jnIyVkezafUZb2k1sCPDIEx/S
   9t+Hxp/QQfiPi1LuJQMTRoMiWha0JKFchVdVWqwVqkrLL7DYoFiQAVSKl
   xWyXhFzKfKYmAhwhBjaml1aUa59dGYzoUuCqLrXPJFb3c3i/GWeRAZmi/
   SW7oIbHVp7NcR/OWMRp5ncamzBo1cfFrbHpJS9Fq55Nz4rsqP4XbUNlnJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450967"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450967"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111433"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111433"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:44 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 26/34] wifi: iwlwifi: mvm: use the correct link queue
Date:   Wed, 29 Mar 2023 10:05:32 +0300
Message-Id: <20230329100040.ccd7218e4be2.I40f608a0441190cc26137b039f7cb7b065fd4e0c@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shaul Triebitz <shaul.triebitz@intel.com>

For bcase/mcast tx frames use the link queue.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ca1284f11f8b..f5b92d99f39d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -604,11 +604,10 @@ static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
 }
 
 static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
+				      struct iwl_mvm_vif_link_info *link,
 				      struct ieee80211_tx_info *info,
 				      struct ieee80211_hdr *hdr)
 {
-	struct iwl_mvm_vif *mvmvif =
-		iwl_mvm_vif_from_mac80211(info->control.vif);
 	__le16 fc = hdr->frame_control;
 
 	switch (info->control.vif->type) {
@@ -631,7 +630,7 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 
 		if (!ieee80211_has_order(fc) && !ieee80211_is_probe_req(fc) &&
 		    is_multicast_ether_addr(hdr->addr1))
-			return mvmvif->deflink.cab_queue;
+			return link->cab_queue;
 
 		WARN_ONCE(info->control.vif->type != NL80211_IFTYPE_ADHOC,
 			  "fc=0x%02x", le16_to_cpu(fc));
@@ -757,7 +756,8 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 			else
 				sta_id = link->mcast_sta.sta_id;
 
-			queue = iwl_mvm_get_ctrl_vif_queue(mvm, &info, hdr);
+			queue = iwl_mvm_get_ctrl_vif_queue(mvm, link, &info,
+							   hdr);
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
 			queue = mvm->snif_queue;
 			sta_id = mvm->snif_sta.sta_id;
-- 
2.38.1

