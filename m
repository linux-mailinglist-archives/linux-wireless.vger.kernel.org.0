Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A260D94D3D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfHSSom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 14:44:42 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:51110 "EHLO
        15.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSSom (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 14:44:42 -0400
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 14:44:40 EDT
Received: from player788.ha.ovh.net (unknown [10.109.159.48])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id AC6AD18AF3B
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2019 20:06:53 +0200 (CEST)
Received: from awhome.eu (p4FF9179D.dip0.t-ipconnect.de [79.249.23.157])
        (Authenticated sender: postmaster@awhome.eu)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 498A98EB14C7;
        Mon, 19 Aug 2019 18:06:50 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1566238008;
        bh=IddNShrhf9ncBaqJWvhcL0BWHygrC/HHcqlUbJrsxx8=;
        h=From:To:Cc:Subject:Date;
        b=r1Xf1I0h0d3gHrISYbwEg9LSx594jzL+vcjPDg4ApR2MO1+oM7SsyTTjwYFr0YTg+
         O+HgT3CqUeBTnswoR36GOTQY4ZL8m9/0Ro9BlnlerzIc6xXasmyLNXrNiFlx+f+I8J
         01OGHEyz1DcTbinJ/y0QxSIgZ51LVREkiVUoLJn0=
To:     johannes@sipsolutions.net, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
Date:   Mon, 19 Aug 2019 20:05:40 +0200
Message-Id: <20190819180540.2855-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16518359012007156936
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudefledguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All iwlwifi cards below the 22000 series are able to handle multiple
keyids per STA and allow the selection of the encryption key per MPDU.

These are therefore fully compatible with the Extended Key ID support
implementation in mac80211.

Enable Extended Key ID support for all dvm cards and the mvm cards not
using the incompatible new Tx API introduced for the 22000 series.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is basically the V3 of the patch, but the other patches were part
of series and this here is the first standalone version.

V1: https://patchwork.kernel.org/patch/10931879/
V2: https://patchwork.kernel.org/patch/11024137/

V1 become deprecated due to redesigning the Extended Key ID support API.
V2 became deprecated due to the discovery that the 22000 is not (yet)
able to support Extended Key ID.

The patch is still super trivial, but I cross checked that Extended Key
ID support is enabled with my old 3168 card and disabled with my new
AX200 card.

 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 ++++++++
 2 files changed, 9 insertions(+)

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
index b74bd58f3f45..034bf959153b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -617,6 +617,14 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 
 	hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
+
+	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
+	 * the hw, preventing us to control which key(id) to use per MPDU.
+	 * Till that's fixed we can't use Extended Key ID for the newer cards.
+	 */
+	if (!iwl_mvm_has_new_tx_api(mvm))
+		wiphy_ext_feature_set(hw->wiphy,
+				      NL80211_EXT_FEATURE_EXT_KEY_ID);
 	hw->wiphy->features |= NL80211_FEATURE_HT_IBSS;
 
 	hw->wiphy->regulatory_flags |= REGULATORY_ENABLE_RELAX_NO_IR;
-- 
2.22.0

