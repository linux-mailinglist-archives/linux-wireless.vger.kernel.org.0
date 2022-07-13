Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BD657333F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiGMJpx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGMJpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1BE0279
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Y+moyHGd1IO1bfPODzmquy++uIqfRjJo49y0BrVHo0=;
        t=1657705516; x=1658915116; b=Rpsttx4ljWEiuXxVFtDUrJviZBnLpka65BMvPjuwUCilhSF
        tJVbEKmVOhtyNIRne/eI6xaQl5CwNMaQYHt817P5K5ESrIEgwtBdy6BvQs7+OZv0yKeqkmpRgaS65
        F6IE8YGejIGWBHrI3rek0uxEQtiHwL9M3HXASx0GRTNMH+Ic9txGM4Big8+qUzvF8G+9oEgPEXxpX
        6FVKN/hM9L+t25MLHq7k61us3dyuTWdXWjqb2T30ZfTbjAywDPbqqYhKYcE9RUXphxffc6iJpKHE1
        OBgnvzFItb13ZH4hCTfvpcZLQ9lWjuoJhZij56CLfLonNRdl7vmI9/DKwQNPs2lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvi-00EgvB-1O;
        Wed, 13 Jul 2022 11:45:14 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 32/76] wifi: mac80211: mlme: do IEEE80211_STA_RESET_SIGNAL_AVE per link
Date:   Wed, 13 Jul 2022 11:44:18 +0200
Message-Id: <20220713114425.3604eb6f0df1.I2398433851572c95290b613422cc08d5b5cc9625@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Remove the IEEE80211_STA_RESET_SIGNAL_AVE flag and use
a bool instead, but invert the polarity (now calling it
tracking_signal_avg) so we don't have to initialize it,
and put that into the link instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 699dabaa9f0d..711129edd923 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -361,7 +361,6 @@ enum ieee80211_sta_flags {
 	IEEE80211_STA_MFP_ENABLED	= BIT(6),
 	IEEE80211_STA_UAPSD_ENABLED	= BIT(7),
 	IEEE80211_STA_NULLFUNC_ACKED	= BIT(8),
-	IEEE80211_STA_RESET_SIGNAL_AVE	= BIT(9),
 	IEEE80211_STA_DISABLE_WMM	= BIT(14),
 	IEEE80211_STA_ENABLE_RRM	= BIT(15),
 };
@@ -885,6 +884,7 @@ struct ieee80211_link_data_managed {
 	s16 p2p_noa_index;
 
 	bool have_beacon;
+	bool tracking_signal_avg;
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 52dc336cadfa..bcc817de6bd0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2316,8 +2316,6 @@ static void ieee80211_set_associated(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_check_rate_mask(sdata);
 
-	sdata->u.mgd.flags |= IEEE80211_STA_RESET_SIGNAL_AVE;
-
 	if (sdata->vif.p2p ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_GET_NOA_UPDATE) {
 		const struct cfg80211_bss_ies *ies;
@@ -2522,6 +2520,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.beacon_rate = NULL;
 
 	sdata->deflink.u.mgd.have_beacon = false;
+	sdata->deflink.u.mgd.tracking_signal_avg = false;
 
 	ifmgd->flags = 0;
 	sdata->deflink.u.mgd.conn_flags = 0;
@@ -4051,8 +4050,8 @@ static void ieee80211_handle_beacon_sig(struct ieee80211_sub_if_data *sdata,
 {
 	/* Track average RSSI from the Beacon frames of the current AP */
 
-	if (ifmgd->flags & IEEE80211_STA_RESET_SIGNAL_AVE) {
-		ifmgd->flags &= ~IEEE80211_STA_RESET_SIGNAL_AVE;
+	if (!sdata->deflink.u.mgd.tracking_signal_avg) {
+		sdata->deflink.u.mgd.tracking_signal_avg = true;
 		ewma_beacon_signal_init(&sdata->deflink.u.mgd.ave_beacon_signal);
 		sdata->deflink.u.mgd.last_cqm_event_signal = 0;
 		sdata->deflink.u.mgd.count_beacon_signal = 1;
-- 
2.36.1

