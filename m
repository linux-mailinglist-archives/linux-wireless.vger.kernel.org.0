Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAF5AD53
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfF2UJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 16:09:47 -0400
Received: from 2.mo69.mail-out.ovh.net ([178.33.251.80]:48009 "EHLO
        2.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfF2UJr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 16:09:47 -0400
X-Greylist: delayed 1142 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 16:09:46 EDT
Received: from player755.ha.ovh.net (unknown [10.109.146.132])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0B1125EA56
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 21:50:50 +0200 (CEST)
Received: from awhome.eu (p579AA414.dip0.t-ipconnect.de [87.154.164.20])
        (Authenticated sender: postmaster@awhome.eu)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id B104B77B80A1;
        Sat, 29 Jun 2019 19:50:48 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1561837847;
        bh=6jjhbtpztc+bLEnBQyExs4hD1cne98KDodnayP8hfSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zf5JlY3fTpFrQ52DcDstNNeluWLyl3cYW7rWZphV13cruPlPKZndrmumaVgz/smPC
         uoZK25M4q6NMkU/GS1nAZ+traX9zmjLHCRCcooo17uiy2SFQQeRELw7Wg+T54wHsal
         4TSPrkZnF/1OYMIvNVRzJmHcHzN4NRd3IWGSVKy8=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>,
        Luca Coelho <luca@coelho.fi>
Subject: [PATCH 4/4] iwlwifi: Enable Extended Key ID for mvm and dvm
Date:   Sat, 29 Jun 2019 21:50:15 +0200
Message-Id: <20190629195015.19680-4-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190629195015.19680-1-alexander@wetzel-home.de>
References: <20190629195015.19680-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13914433999912901884
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddvgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All iwlwifi cards are able to handle multiple keyids per STA and are
therefore fully compatible with the Extended Key ID implementation
provided by mac80211.

Allow Extended Key ID to be used for all mvm and dvm cards.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is basically the v2 patch of https://patchwork.kernel.org/patch/10931879/
which Luca still has in his review queue. It just uses the new proposed
simplified Extended Key ID API from this patch series instead.

Merging (parts) of this series will of course break the older patch
still queued to Luca, so this may need some coordination.

 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 6c170636110a..ac88c19f4f18 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -200,6 +200,7 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 	iwl_leds_init(priv);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EXT_KEY_ID);
 
 	ret = ieee80211_register_hw(priv->hw);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fdbabca0280e..c752fe6970e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -599,6 +599,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_EXT_KEY_ID);
 	hw->wiphy->features |= NL80211_FEATURE_HT_IBSS;
 
 	hw->wiphy->regulatory_flags |= REGULATORY_ENABLE_RELAX_NO_IR;
-- 
2.22.0

