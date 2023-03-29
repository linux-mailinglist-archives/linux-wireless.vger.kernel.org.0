Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC496CD28E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjC2HH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2HHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4F2D55
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073629; x=1711609629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ysQgr9oNgszYW25yiZpIrKhz44gV0UFroSUhcaCuPw=;
  b=R2sHG6NYJevHxQAhRnAv6dXtuiNZDCp1ic0aiFqSM0pbMllQa00nRJOx
   3FrefEkgG50ctPKe3YOBivrFt7r8O7DgIYP/oKFnss+9whorGvkVhl8N9
   8xkupLYFk5loz5BwwSGLnmCibuknBNJiUaDYl/5xJDGWcETp+cmqjTth+
   Y+ylQZl5HA8LlmKMlvtO6dIDf5gzXWooOpe4cJolowwrLlXgwo+H6BNZA
   lE2LE6UKT/q13ObsFtLFV4NjRXsm0ZcDkZmDBuizX/2L6aysOGqnsFuYy
   eTV6c5INCYyT8tBfOxhM73/mL0Lf1MJGKuYtwV6u2zSv+x86lqHzwpzkM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450814"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450814"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111316"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111316"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/34] wifi: iwlwifi: mvm: translate management frame address
Date:   Wed, 29 Mar 2023 10:05:19 +0300
Message-Id: <20230329100039.3cb4292f51e8.Ia662c00ff271c70eda927c12ed49b045b1eb8489@changeid>
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

For management frames sent by an AP interface, translate
the MLD addresses to LINK addresses (for an MLD AP).
AP (non-bufferable) management frames are sent via
the broadcast station so the translation cannot be
done by the firmware.

Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 92567ab34b88..4c8ab1db1f19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -722,6 +722,9 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	bool offchannel = IEEE80211_SKB_CB(skb)->flags &
 		IEEE80211_TX_CTL_TX_OFFCHAN;
+	u32 link_id = u32_get_bits(info->control.flags,
+				   IEEE80211_TX_CTRL_MLO_LINK);
+	struct ieee80211_sta *tmp_sta = sta;
 
 	if (iwl_mvm_is_radio_killed(mvm)) {
 		IWL_DEBUG_DROP(mvm, "Dropping - RF/CT KILL\n");
@@ -755,6 +758,25 @@ void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 		}
 	}
 
+	if (tmp_sta && !sta && link_id != IEEE80211_LINK_UNSPECIFIED &&
+	    !ieee80211_is_probe_resp(hdr->frame_control)) {
+		/* translate MLD addresses to LINK addresses */
+		struct ieee80211_link_sta *link_sta =
+			rcu_dereference(tmp_sta->link[link_id]);
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference(info->control.vif->link_conf[link_id]);
+		struct ieee80211_mgmt *mgmt;
+
+		if (WARN_ON(!link_sta || !link_conf))
+			goto drop;
+
+		/* if sta is NULL, the frame is a management frame */
+		mgmt = (void *)hdr;
+		memcpy(mgmt->da, link_sta->addr, ETH_ALEN);
+		memcpy(mgmt->sa, link_conf->addr, ETH_ALEN);
+		memcpy(mgmt->bssid, link_conf->bssid, ETH_ALEN);
+	}
+
 	iwl_mvm_tx_skb(mvm, skb, sta);
 	return;
  drop:
-- 
2.38.1

