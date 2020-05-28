Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476F41E5C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387479AbgE1Joc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbgE1Joa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:44:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1231C08C5C5
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 02:44:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeF5Q-004mD7-W2; Thu, 28 May 2020 11:44:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [RFC 10/10] mac80211: do not allow HT/VHT IEs in 6 GHz mesh mode
Date:   Thu, 28 May 2020 11:44:16 +0200
Message-Id: <20200528094428.23474-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
References: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajkumar Manoharan <rmanohar@codeaurora.org>

As HT/VHT elements are not allowed in 6 GHz band, do not include
them in mesh beacon template formation.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Link: https://lore.kernel.org/r/1589399105-25472-9-git-send-email-rmanohar@codeaurora.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mesh.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6378d9cb70d3..afbb5d6df936 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -415,6 +415,10 @@ int mesh_add_ht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	/* HT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!sband->ht_cap.ht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -452,6 +456,10 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	sband = local->hw.wiphy->bands[channel->band];
 	ht_cap = &sband->ht_cap;
 
+	/* HT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!ht_cap->ht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -479,6 +487,10 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	/* VHT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!sband->vht_cap.vht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -516,6 +528,10 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	sband = local->hw.wiphy->bands[channel->band];
 	vht_cap = &sband->vht_cap;
 
+	/* VHT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!vht_cap->vht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-- 
2.26.2

