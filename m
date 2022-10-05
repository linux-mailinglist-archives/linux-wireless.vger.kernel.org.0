Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC05F54E6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJENB0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJENA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:58 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E3F7332A
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IKPJSlQGXfxUM9lm+G8gRSwLdq5YtAR7FbJ6wt9C2Y4=;
        t=1664974857; x=1666184457; b=ccEWIWhykasrAdvsFz4kPPeeg+avYd50PnjOH+36gj3Oa6O
        NfIIujEoHCoDO3LKj87Ua+IZ/Bm3d6AM3f5aGoU1Plw3qiscni48BFwfvAjdhaahavY1hvqm1OKct
        31uaMgym0ToPQ9lUbqBv1Th2P1Gzyig2qzDGtjnW/NDzbAQux60C+WHEM45bpr//iz2aHJ/N/PdnM
        FDAKoxN6Twff9p9J36AZBQ1aAlmQkY5Wanc2O6//n88pqZtJ1x0srxy2uIi1JmEk1PvwBx06V2q+V
        8GmRp+l2SGtNo/b4H/M7WUORQr1ifbZY7XwQE3kcppVenqlBPY2RBbuHtjwxX6gQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og419-00G2RL-1r;
        Wed, 05 Oct 2022 15:00:55 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 20/28] wifi: mac80211: mlme: fix null-ptr deref on failed assoc
Date:   Wed,  5 Oct 2022 15:00:40 +0200
Message-Id: <20221005145226.9c36543a1a23.I8591bee1fc964ac6b37f94e5a9501e0cf5432f2c@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If association to an AP without a link 0 fails, then we crash in
tracing because it assumes that either ap_mld_addr or link 0 BSS
is valid, since we clear sdata->vif.valid_links and then don't
add the ap_mld_addr to the struct.

Since we clear also sdata->vif.cfg.ap_addr, keep a local copy of
it and assign it earlier, before clearing valid_links, to fix
this.

Fixes: 81151ce462e5 ("wifi: mac80211: support MLO authentication/association with one link")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b6f378e7edea..1ad0bf3bfcae 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5082,6 +5082,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_rx_assoc_resp resp = {
 		.uapsd_queues = -1,
 	};
+	u8 ap_mld_addr[ETH_ALEN] __aligned(2);
 	unsigned int link_id;
 
 	sdata_assert_lock(sdata);
@@ -5251,6 +5252,11 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 				resp.uapsd_queues |= ieee80211_ac_to_qos_mask[ac];
 	}
 
+	if (sdata->vif.valid_links) {
+		ether_addr_copy(ap_mld_addr, sdata->vif.cfg.ap_addr);
+		resp.ap_mld_addr = ap_mld_addr;
+	}
+
 	ieee80211_destroy_assoc_data(sdata,
 				     status_code == WLAN_STATUS_SUCCESS ?
 					ASSOC_SUCCESS :
@@ -5260,8 +5266,6 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	resp.len = len;
 	resp.req_ies = ifmgd->assoc_req_ies;
 	resp.req_ies_len = ifmgd->assoc_req_ies_len;
-	if (sdata->vif.valid_links)
-		resp.ap_mld_addr = sdata->vif.cfg.ap_addr;
 	cfg80211_rx_assoc_resp(sdata->dev, &resp);
 notify_driver:
 	drv_mgd_complete_tx(sdata->local, sdata, &info);
-- 
2.37.3

