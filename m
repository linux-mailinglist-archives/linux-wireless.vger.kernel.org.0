Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9646CD28B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjC2HHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjC2HHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0F3C10
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073613; x=1711609613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wgMR7C43qgMiv9HwQ+NtlNyshs2hciIK+blsihfGr7Y=;
  b=VeK2WCrfBB9MUsgqmoXKCPbRz8f9IkUXc6Coh+pJHZ3woXnPn4CFyO+e
   ZDgQXum4WvfIPYw4rB6X3UFIqSDtoZNqjrbUfKBLEQmdVDDeRMBqMQLNE
   UZtdW8JHGiNVVNIaJzRvtYQgtnbBHAgpas8jmDneO+riz+CVyw8JiqlLH
   zG3+UUkbhrV/TVIWJsxgCjc9/Mm0WwLAmXWS3baUi/HO1dbQerjAVY+aY
   jF+2cODBMLM3NqzQD7ASLH/yFSROXw4IBIJ4Q91QUlf4fhfXWO300+i1w
   tGFsS7qL0wca+xaEIAWSvcJMqa/P/30rne2CtgI3wABqZnz6hRU0cC+NM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450783"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450783"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111259"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111259"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/34] wifi: iwlwifi: mvm: adjust radar detection to MLO
Date:   Wed, 29 Mar 2023 10:05:15 +0300
Message-Id: <20230329100039.a61b1d3f681a.I27bb8726d8806ad725c22bc7256856b1b6636745@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Make the decision about radar detection status depending
on each active MLO link.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 45a652cce491..2033d89dc9e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -279,18 +279,24 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 static bool iwl_mvm_power_is_radar(struct ieee80211_vif *vif)
 {
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	struct ieee80211_channel *chan;
+	struct ieee80211_bss_conf *link_conf;
 	bool radar_detect = false;
+	unsigned int link_id;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
-	WARN_ON(!chanctx_conf);
-	if (chanctx_conf) {
-		chan = chanctx_conf->def.chan;
-		radar_detect = chan->flags & IEEE80211_CHAN_RADAR;
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
+		if (WARN_ON(!chanctx_conf))
+			continue;
+
+		radar_detect = !!(chanctx_conf->def.chan->flags &
+				  IEEE80211_CHAN_RADAR);
+		if (radar_detect)
+			goto out;
 	}
-	rcu_read_unlock();
 
+out:
+	rcu_read_unlock();
 	return radar_detect;
 }
 
-- 
2.38.1

