Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6107825EA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHUI7N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjHUI7M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 04:59:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2BC0
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=bkvHfm+6X4zSMpcfJWcGeRl6RLd4bM69RVFgbYM474A=; t=1692608350; x=1693817950; 
        b=S45n/pIbIFR74NTHcVk7oHGlKXqap3lpTGtywomFhO8dwM2/tsfkF11JIiRpqk1s7gYcAeXfLTc
        V9EHLpsjEP4+/f/L8qrlF9Q/8/Qn0qb3+I2EQnYXRluXy2KvspERDKBHHIK1NK+qf2Z0DZ7X3aYWv
        zE6eidiikB0jdjETFBq6KS3pDaBBNMvDHAJ56SsI2U8Pf0ioezu7y1hrNTdI0k4QtakK2JMMNjNHo
        vTElg/5o183wA1LSXcOum7AlGSP78MIOClJ8qNv2fRFehlUUCQntP6qOHR+i3nI6m/bB+iN4CTWKL
        km1yZeMGklcHH7w4pxBWjZdwj1g8J/DIpNlA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qY0kc-002vFB-1M;
        Mon, 21 Aug 2023 10:59:06 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz operation information"
Date:   Mon, 21 Aug 2023 10:59:04 +0200
Message-ID: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit cb751b7a57e5 ("mac80211: add parse regulatory info
in 6 GHz operation information") which added a station type bss_conf
assignment in a parsing helper function, which will corrupt mesh data.

Fixes: cb751b7a57e5 ("mac80211: add parse regulatory info in 6 GHz operation information")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  2 --
 net/mac80211/util.c    | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3a8a2d2c58c3..813d4a654470 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -637,7 +637,6 @@ struct ieee80211_fils_discovery {
  *	interval.
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
- * @power_type: power type of BSS for 6 GHz
  * @tx_pwr_env: transmit power envelope array of BSS.
  * @tx_pwr_env_num: number of @tx_pwr_env.
  * @pwr_reduction: power constraint of BSS.
@@ -746,7 +745,6 @@ struct ieee80211_bss_conf {
 	struct ieee80211_fils_discovery fils_discovery;
 	u32 unsol_bcast_probe_resp_interval;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
-	enum ieee80211_ap_reg_power power_type;
 	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
 	u8 tx_pwr_env_num;
 	u8 pwr_reduction;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8a6917cf63cf..7bd3b64ddac6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3841,7 +3841,6 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	bool support_80_80, support_160, support_320;
 	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
@@ -3894,19 +3893,6 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 					      NL80211_BAND_6GHZ);
 	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
 
-	switch (u8_get_bits(he_6ghz_oper->control,
-			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-		bss_conf->power_type = IEEE80211_REG_LPI_AP;
-		break;
-	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-		bss_conf->power_type = IEEE80211_REG_SP_AP;
-		break;
-	default:
-		bss_conf->power_type = IEEE80211_REG_UNSET_AP;
-		break;
-	}
-
 	if (!eht_oper ||
 	    !(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
 		switch (u8_get_bits(he_6ghz_oper->control,
-- 
2.41.0

