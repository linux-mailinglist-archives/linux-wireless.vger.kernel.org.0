Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791E878D9E7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjH3Se2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbjH3Ib2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29A1A4
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384285; x=1724920285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJ9PtvbQAlR80Gua0c2WoVmnIhEQZ61659ukoiNhL4s=;
  b=C1hPerp31MZjW+5p8m7wmXTq7DYxnWhWUZpU2CCocBZgb4N4u6Vn5ITc
   Vq7TnpwGvU9pzhu84WIAvbKnCEKjPWACAERQybpX4YPsNAm2G96UlQVmt
   dOxK50NSKrgznuPcvMgHQ2UFhLIUwZ1zsCN2EGKk34abWV/Haud61u502
   WF547sX2ycmTlrIUDC35UfFy3Xp3DOZZcTdtML2ymREoUi8Q0rFr4vmUa
   HQBMxn4q/NbvlpE4+eqZ8988fP1J3rbLhlajdZeBxNfzfrpwLZB3PeU3e
   e0cOlSnOFZiTonTgd+P5zOyC7YNMJVjYrIeG3rypcimJ58DpIlCmc8CMb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958847"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958847"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152008"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152008"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/16] wifi: iwlwifi: mvm: increase session protection after CSA
Date:   Wed, 30 Aug 2023 11:30:50 +0300
Message-Id: <20230830112059.a74176bac37c.I029a2ebcd1b5012327c728ffa1d33fac19cfdf4b@changeid>
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

In the spec, CSA is defined roughly as follows:
 - TBTT x:     beacon with CSA, count=n   (old channel)
 - TBTT x+1:   beacon with CSA, count=n-1 (old channel)
 - TBTT x+n-1: beacon with CSA, count=1   (old channel)
 "A Channel Switch Count field set to 1 indicates that the switch
  occurs immediately before the next TBTT.
 - TBTT x+n:   beacon without CSA         (new channel)

When we detect it, we currently schedule the CSA event to
be at 10 TUs before TBTT x+n-1, for a beacon interval, to
give us quiet time.

When this event *starts*, we currently notify mac80211
that the channel switch happened, which causes us to add
a session protection event to listen for the first beacon
(and enable TX etc. when that arrives).

We don't even ask for a notification when this event ends
so the code that handles that is effectively dead code.

The session protection duration is 3 beacon intervals,
scheduled at 10 TU before TBTT x+n-1. It will thus end
just before TBTT x+n+2.

Unfortunately, if the AP doesn't transmit or we miss just
the first two beacons on the new channel, then this will
cause us to disconnect. Or even just one, if the AP isn't
quite aligned with the TBTT after the switch.

However, listening to the _end_ of the time event isn't
what we want either, because we want all the new PHY and
other config that needs to come from mac80211 to start
early, so we have a head-start for the new channel, since
we're not going to use the old one anyway for this time.

So since we don't really have anything better to do at
this time, and this is relatively rare, just make the
session protection use 5x the beacon interval instead of
just 3x, so it's more likely we catch a beacon even if
the AP neglected to send it, or we just miss it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4b3d84213466..6bb3b1f51913 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4953,7 +4953,7 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 
 		if (!fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
-			u32 duration = 3 * vif->bss_conf.beacon_int;
+			u32 duration = 5 * vif->bss_conf.beacon_int;
 
 			/* Protect the session to make sure we hear the first
 			 * beacon on the new channel.
-- 
2.38.1

