Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6414EBB7
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgAaL2n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:28:43 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55934 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaL2n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:28:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEe-0002GC-Ow; Fri, 31 Jan 2020 13:13:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:50 +0200
Message-Id: <20200131111300.891737-14-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 13/23] mac80211: Accept broadcast probe responses on 6GHz band
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

An AP that operates on 6GHz may respond with a broadcast probe response.
Don't ignore such frames.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/mlme.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bb20a5d8a172..92efc3676c70 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3683,13 +3683,28 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_if_managed *ifmgd;
 	struct ieee80211_rx_status *rx_status = (void *) skb->cb;
+	struct ieee80211_channel *channel;
 	size_t baselen, len = skb->len;
 
 	ifmgd = &sdata->u.mgd;
 
 	sdata_assert_lock(sdata);
 
-	if (!ether_addr_equal(mgmt->da, sdata->vif.addr))
+	/*
+	 * According to Draft P802.11ax D6.0 clause 26.17.2.3.2:
+	 * "If a 6 GHz AP receives a Probe Request frame  and responds with
+	 * a Probe Response frame [..], the Address 1 field of the Probe
+	 * Response frame shall be set to the broadcast address [..]"
+	 * So, on 6GHz band we should also accept broadcast responses.
+	 */
+	channel = ieee80211_get_channel(sdata->local->hw.wiphy,
+					rx_status->freq);
+	if (!channel)
+		return;
+
+	if (!ether_addr_equal(mgmt->da, sdata->vif.addr) &&
+	    (channel->band != NL80211_BAND_6GHZ ||
+	     !is_broadcast_ether_addr(mgmt->da)))
 		return; /* ignore ProbeResp to foreign address */
 
 	baselen = (u8 *) mgmt->u.probe_resp.variable - (u8 *) mgmt;
-- 
2.24.1

