Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083E529D7B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbiEQJIC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A654B237C6
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778405; x=1684314405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pxzImEr2FqVezDKIsh+BgClOxH9/kQuTHkdbYQzNPZ4=;
  b=c0WlRuoMGqffEQ3HinjcIG/su6bdzuNodVcslyoI1q/mtIDnZTfDeb1T
   z5MYmu06miyR5Rkcmh6RiIlgjh3U4KmkalP9pCdS96ntsVJwiHpxv/YZ9
   NpkKMT/mytlPjz9OkSiHfUsta9dqbxy8o9Vs1WKSuD5D+h4P6O7CyrBBy
   6djGP8Y7gGgfg5cPK3Wl1LqLzpIEA4YztCL+ihP96nvYHfmQ/ZDYTePz2
   tIzi4JXco3ZN9cHrrq1XiOIN3YkXUGFez4LHnVHvy5AFHMNIHrGr3BVcd
   r/FQ4X9Z+qQ8+12bqbuHtOgpzmJLxF3mF2mtUFLcf6gaR6EMiCnUbmoiA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064778"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064778"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679730"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:25 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 05/10] iwlwifi: mvm: fix assert 1F04 upon reconfig
Date:   Tue, 17 May 2022 12:05:09 +0300
Message-Id: <20220517120044.ed2ffc8ce732.If786e19512d0da4334a6382ea6148703422c7d7b@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we reconfig we must not send the MAC_POWER command that relates to
a MAC that was not yet added to the firmware.

Ignore those in the iterator.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index b2ea2fca5376..b9bd81242b21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -563,6 +563,9 @@ static void iwl_mvm_power_get_vifs_iterator(void *_data, u8 *mac,
 	struct iwl_power_vifs *power_iterator = _data;
 	bool active = mvmvif->phy_ctxt && mvmvif->phy_ctxt->id < NUM_PHY_CTX;
 
+	if (!mvmvif->uploaded)
+		return;
+
 	switch (ieee80211_vif_type_p2p(vif)) {
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
-- 
2.35.1

