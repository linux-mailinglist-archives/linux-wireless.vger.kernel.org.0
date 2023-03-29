Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1678B6CD290
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC2HH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2HH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328063C04
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073632; x=1711609632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pCTtHSYx8xKbxBReULfEkURAbUoQ+QkoJfMf64QWImQ=;
  b=TesJl0eYY6HjfR9vjBRnfQ/UjGgj8l/ruBbmFrnYc3Sx9VpgLK90FULc
   aki3jKRaZfbIXJCM6jRMpM+yN9c2noyI/JpGSvKwsk+iTmjnUC9541m2m
   saI7Q3WlRibNiSbDg0JezYM9tqpLP5o5fqZIA9jimyISFOX/v0fETF4i7
   ipj8qRFgoAykGM6LRIIvPZfA+A4oLGIwj7b28tw6sEkwoXwFgmLvSiLZn
   r+/yG5S43ASN9S5ocmVGCAx/mEJ7zI9NaFUfBoU2VAG8xfXGvbfyURF6H
   WXiFpPUKG1ahrG/Q2RUUdd/GF2UM5ycYSyr/gSAUSewefBFHrtoBbeMTk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450821"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450821"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111319"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111319"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/34] wifi: iwlwifi: mvm: use bcast/mcast link station id
Date:   Wed, 29 Mar 2023 10:05:20 +0300
Message-Id: <20230329100039.0cffa6c45242.I342e17e7bca87b7f05939eb2ebd36fc2aff0b49f@changeid>
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

For an MLD AP, use the correct link mcast or bcast station id.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 61a95ee3ef2d..ca1284f11f8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -739,10 +739,23 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 		if (info.control.vif->type == NL80211_IFTYPE_P2P_DEVICE ||
 		    info.control.vif->type == NL80211_IFTYPE_AP ||
 		    info.control.vif->type == NL80211_IFTYPE_ADHOC) {
+			u32 link_id = u32_get_bits(info.control.flags,
+						   IEEE80211_TX_CTRL_MLO_LINK);
+			struct iwl_mvm_vif_link_info *link;
+
+			if (link_id == IEEE80211_LINK_UNSPECIFIED) {
+				if (info.control.vif->active_links)
+					link_id = ffs(info.control.vif->active_links) - 1;
+				else
+					link_id = 0;
+			}
+
+			link = mvmvif->link[link_id];
+
 			if (!ieee80211_is_data(hdr->frame_control))
-				sta_id = mvmvif->deflink.bcast_sta.sta_id;
+				sta_id = link->bcast_sta.sta_id;
 			else
-				sta_id = mvmvif->deflink.mcast_sta.sta_id;
+				sta_id = link->mcast_sta.sta_id;
 
 			queue = iwl_mvm_get_ctrl_vif_queue(mvm, &info, hdr);
 		} else if (info.control.vif->type == NL80211_IFTYPE_MONITOR) {
-- 
2.38.1

