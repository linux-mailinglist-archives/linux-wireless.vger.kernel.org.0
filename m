Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C863B15487
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEFTmg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 15:42:36 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:52630 "EHLO
        15.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEFTmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 15:42:36 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 15:42:35 EDT
Received: from player788.ha.ovh.net (unknown [10.109.160.25])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id E94BD1E6FBE
        for <linux-wireless@vger.kernel.org>; Mon,  6 May 2019 21:05:05 +0200 (CEST)
Received: from awhome.eu (p4FF91A34.dip0.t-ipconnect.de [79.249.26.52])
        (Authenticated sender: postmaster@awhome.eu)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id 62924571F5C1;
        Mon,  6 May 2019 19:05:04 +0000 (UTC)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1557169503;
        bh=ofNF27r8U1mELQ60h5TXL26VDFVwpogkymOu+Px5LkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ke7PdJyuJ0IS+eruGzX7gUKtnMqfeN/b0PRdRbPn2vtSqwgTc4d24gUY45QVO8pVb
         w3x1lFxCZlJsb4mkeoYW13LDpOOjVrSVYQFus8zOKQmHcn/IBNvMMHDkdbKWqlOHQo
         XyBzK2DcNj88shd/SuGTflVSaJq2kCMYI6FYTDfQ=
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH 2/2] iwlwifi: Extended Key ID support
Date:   Mon,  6 May 2019 21:01:49 +0200
Message-Id: <20190506190149.3624-2-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506190149.3624-1-alexander@wetzel-home.de>
References: <20190506190149.3624-1-alexander@wetzel-home.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9610963083876310215
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrjeekgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iwlwifi cards are all able to support Extended Key ID as long as
mac80211 stops A-MPDU aggregation when replacing the unicast key.

Enable Extended Key ID support and tell mac80211 that it has to tear
down any running Tx aggregation sessions during rekey when using
Extended Key ID.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c | 2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 54b759cec8b3..160c3fd04399 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -111,6 +111,8 @@ int iwlagn_mac_setup_register(struct iwl_priv *priv,
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, WANT_MONITOR_VIF);
+	ieee80211_hw_set(hw, EXT_KEY_ID_NATIVE);
+	ieee80211_hw_set(hw, NO_AMPDU_KEYBORDER_SUPPORT);
 
 	if (priv->trans->max_skb_frags)
 		hw->netdev_features = NETIF_F_HIGHDMA | NETIF_F_SG;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5c52469288be..6475adbe60e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -470,6 +470,8 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	ieee80211_hw_set(hw, STA_MMPDU_TXQ);
 	ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, TX_FRAG_LIST);
+	ieee80211_hw_set(hw, EXT_KEY_ID_NATIVE);
+	ieee80211_hw_set(hw, NO_AMPDU_KEYBORDER_SUPPORT);
 
 	if (iwl_mvm_has_tlc_offload(mvm)) {
 		ieee80211_hw_set(hw, TX_AMPDU_SETUP_IN_HW);
-- 
2.21.0

