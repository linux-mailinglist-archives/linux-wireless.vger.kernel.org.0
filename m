Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FE78D99C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjH3Sdg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbjH3Iba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429F1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384287; x=1724920287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpU8F6vWcsBUgbTP6D5NSxSCYNccpPch3oEVmMIJKGQ=;
  b=nJI/6dQJOAioOShbgJwpgFay0PRTWYuqdzTp1OkDGorsNvsbKJRlgoUb
   vPDxhM3E0vO9QlowvJM7b7mkv6awOTg/Ck8+/b5DdXooJL1KbpXwA40C9
   Cu0TpCLowqLvsm1VNG8EaZTs5gfCPIP/XX0DTK9Aw/rAGaxE2ig/gzOZM
   +gm73ZAx7vRx9OAsmJg/C1cmarE3y7WEcFiLD8xyKMhNZ5qKlLUaOLxNk
   jiGnhCLaLY/ZiYLqV7T7pdgVDhR4/+yBYoTlV3ZVKJNwPg01fhKa4zZ4I
   OAzA1wMqJ0sK2xYVw3bFBORxzaYOOePHvFcbbpoo7ul2ZxP184lxHRqYo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958863"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958863"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152017"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152017"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/16] wifi: iwlwifi: mvm: disconnect long CSA only w/o alternative
Date:   Wed, 30 Aug 2023 11:30:51 +0300
Message-Id: <20230830112059.dd1b96a37e51.Idafdcbfcb36ca4c486f4221aef77643869331514@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
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

If there's an alternative link to use while the CSA is in
progress, there's no need to disconnect since another link
is still usable during the switching time. Change the code
here to handle that accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6bb3b1f51913..b4f2b018388c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5459,7 +5459,8 @@ int iwl_mvm_pre_channel_switch(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX)
+		if (chsw->delay > IWL_MAX_CSA_BLOCK_TX &&
+		    hweight16(vif->valid_links) <= 1)
 			schedule_delayed_work(&mvmvif->csa_work, 0);
 
 		if (chsw->block_tx) {
-- 
2.38.1

