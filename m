Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591416E42C8
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjDQImO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjDQImJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8834222
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720928; x=1713256928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwDbxVjswkJ182YtooGCQjbgUeREze1G4MrrGfd1ZOU=;
  b=O6VSdrxAolerDsypUXoocUlcHn3FhKYauJ1jlOl3oFusl3/K7aV8GPwl
   cguqFDzkYu4Ks0G0bn0JObrR4tmmyemeaCDD7VB26ghbYEtazZRGO3+tH
   yra7DbpEWQhalnmcZ9E5cPlpKoxmjt2k9HBxOSbUgOLgGskXxzYcl7+ml
   R8FVveIO085RibWZ0X/b4vtGLsgsj2X75NPaowmeasc3EgTrsDSkzj6qQ
   i1kCvc2AtP32kW6a6Y7VzXfNFb5XcHpF3TS+F5RqX9VvNCZNik6EHX+rt
   wqdNDBZLJBMeFFh36dk0SnFCkb8hropLBYOA2J/nr8r6+83sS7StU8dul
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634337"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634337"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173822"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173822"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: remove per-STA MFP setting
Date:   Mon, 17 Apr 2023 11:41:24 +0300
Message-Id: <20230417113648.adbeb0e0bfed.I400d0ee3721dc4f294313be992d277ba4d9c88d9@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we first add the STA before sending an authentication
frame this is false. However, in some cases such as FT or
certainly in MLO link switch scenarios, it will be true.

If it happens to be true, it causes a firmware assert (in
LMAC, 0x2528), because the same bit is used by the firmware
for tracking this setting as well as for tracking if the
management key has been installed, and then we get this
assert from the firmware when installing the MFP key as it
thinks it has already been installed.

Remove the setting for now, until the firmware disentangles
the two. We should be able to set it, in fact we should be
setting it speculatively before authentication/association,
to avoid processing management frames that should have been
protected/encrypted before the key is set.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 65436736f87f..fe362f621777 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -427,7 +427,6 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_sta_cfg_cmd cmd = {
 		.sta_id = cpu_to_le32(mvm_link_sta->sta_id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
-		.mfp = cpu_to_le32(sta->mfp),
 	};
 	u32 agg_size = 0, mpdu_dens = 0;
 
-- 
2.38.1

