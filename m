Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C34EF0FB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiDAOg5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347608AbiDAOdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 10:33:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E349256640;
        Fri,  1 Apr 2022 07:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D1F9B82515;
        Fri,  1 Apr 2022 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC0C2BBE4;
        Fri,  1 Apr 2022 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823408;
        bh=y5iZjuzgrRz546+vtyJdXA0k4Yb5zv7HJ+OnbQJvTLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eL8iVazPQHmEFFsfaKckK3Sr5hbIB6ayDdY6vcHt8/6lffSYxPDcfg4GUUIMEJeCG
         F68fMXGEPWXdj5h79xcz+o+XI0qX2VfjbKVbYe014a082etD0vIrIWS+eIu5sp2ggk
         ZcWJP8LEnjb6xQNWqJZjQJKf/ll4Su4l974wDqPBPuRC/GDn19ySaSi8IpI1X2jsaY
         +6H5RXYYRbCtAhv06JGi51/2XprfU6AF0FBPCJt2WT1yqHLZMy8dIO8LcGmbKal8m2
         sAm8m1r7TVx+L9OZMQt/OjriDoOeyjV7+8hvUGiCDAr8OIp2LQ8+rm8Jl5x4dUfoVW
         7EB3sp9DD4gEQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        johannes.berg@intel.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 081/149] iwlwifi: mvm: move only to an enabled channel
Date:   Fri,  1 Apr 2022 10:24:28 -0400
Message-Id: <20220401142536.1948161-81-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401142536.1948161-1-sashal@kernel.org>
References: <20220401142536.1948161-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit e04135c07755d001b5cde61048c69a7cc84bb94b ]

During disassociation we're decreasing the phy's ref count.
If the ref count becomes 0, we're configuring the phy ctxt
to the default channel (the lowest channel which the device
can operate on). Currently we're not checking whether the
the default channel is enabled or not. Fix it by configuring
the phy ctxt to the lowest channel which is enabled.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20220210181930.03f281b6a6bc.I5b63d43ec41996d599e6f37ec3f32e878b3e405e@changeid
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 31 +++++++++++++------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 9af40b0fa37a..a6e6673bf4ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -349,18 +349,31 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 	 * otherwise we might not be able to reuse this phy.
 	 */
 	if (ctxt->ref == 0) {
-		struct ieee80211_channel *chan;
+		struct ieee80211_channel *chan = NULL;
 		struct cfg80211_chan_def chandef;
-		struct ieee80211_supported_band *sband = NULL;
-		enum nl80211_band band = NL80211_BAND_2GHZ;
+		struct ieee80211_supported_band *sband;
+		enum nl80211_band band;
+		int channel;
 
-		while (!sband && band < NUM_NL80211_BANDS)
-			sband = mvm->hw->wiphy->bands[band++];
+		for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
+			sband = mvm->hw->wiphy->bands[band];
 
-		if (WARN_ON(!sband))
-			return;
+			if (!sband)
+				continue;
+
+			for (channel = 0; channel < sband->n_channels; channel++)
+				if (!(sband->channels[channel].flags &
+						IEEE80211_CHAN_DISABLED)) {
+					chan = &sband->channels[channel];
+					break;
+				}
 
-		chan = &sband->channels[0];
+			if (chan)
+				break;
+		}
+
+		if (WARN_ON(!chan))
+			return;
 
 		cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
 		iwl_mvm_phy_ctxt_changed(mvm, ctxt, &chandef, 1, 1);
-- 
2.34.1

