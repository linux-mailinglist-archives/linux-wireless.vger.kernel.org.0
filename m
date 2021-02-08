Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C725A3132BC
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 13:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBHMub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 07:50:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:44468 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230104AbhBHMtu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 07:49:50 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l95yF-0047PC-4O; Mon, 08 Feb 2021 14:48:51 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  8 Feb 2021 14:48:39 +0200
Message-Id: <iwlwifi.20210208144305.991948b50ee3.I82f6c1bdb9fe351ce46e8cc8ec6da221908dec45@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208124847.1934441-1-luca@coelho.fi>
References: <20210208124847.1934441-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/12] iwlwifi: declare support for triggered SU/MU beamforming feedback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

The NIC supports this, so set the relevant bits in the HE PHY
capabilities.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 720193d16539..fd3aeb5c0c58 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -585,6 +585,8 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
 					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
 				.phy_cap_info[6] =
+					IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMER_FB |
+					IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB |
 					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
 				.phy_cap_info[7] =
 					IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
-- 
2.30.0

