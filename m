Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592E54E2EFD
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351802AbiCURYl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 13:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351792AbiCURYj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 13:24:39 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC700ABF54
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647883393; x=1679419393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bq0v/3TG9AMXPt9tj4Gz+54g8j0GQNiV2+yRV5+SM8g=;
  b=clnxvPSd49a26WLEpvC/DdN4VOS0t1MdVuGoxxJIzuSZEl0ogCs/M/ec
   +aINTF4sl7Ybt5C94KSOGCEPUzd16TfJwip2MgjgSdWm58mb8lPGK09cd
   mmjsj+4useUtTR5vunrDxmhigtqfVDyNDcWIoSzUAb4aTrk6GlaXSQH/g
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Mar 2022 10:23:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:23:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 10:23:11 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 03:17:27 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH v4 2/3] ath11k: Refactor update channel list function
Date:   Mon, 21 Mar 2022 15:46:36 +0530
Message-ID: <1647857797-19749-3-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
References: <1647857797-19749-1-git-send-email-quic_ppranees@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For sending scan channel list command to firmware through wmi, remain on
channel's scan request parameter needs to be updated. Add scan_req_params
as an argument to the existing update_scan_chan_list to update scan request
parameter through wmi.

Co-developed-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c |  2 +-
 drivers/net/wireless/ath/ath11k/reg.c | 49 +++++++++++++++++++++++------------
 drivers/net/wireless/ath/ath11k/reg.h |  2 +-
 drivers/net/wireless/ath/ath11k/wmi.h |  2 ++
 4 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d5b83f9..bde669c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5808,7 +5808,7 @@ static int ath11k_mac_op_start(struct ieee80211_hw *hw)
 
 	/* TODO: Do we need to enable ANI? */
 
-	ath11k_reg_update_chan_list(ar);
+	ath11k_reg_update_chan_list(ar, NULL);
 
 	ar->num_started_vdevs = 0;
 	ar->num_created_vdevs = 0;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 81e11cd..46720a3 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -102,18 +102,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ar->regdom_set_by_user = true;
 }
 
-int ath11k_reg_update_chan_list(struct ath11k *ar)
+int ath11k_reg_update_chan_list(struct ath11k *ar, const struct scan_req_params *arg)
 {
 	struct ieee80211_supported_band **bands;
 	struct scan_chan_list_params *params;
-	struct ieee80211_channel *channel;
-	struct ieee80211_hw *hw = ar->hw;
 	struct channel_param *ch;
+	struct cfg80211_chan_def *chandef;
+	struct ieee80211_channel *channel, *req_channel;
 	enum nl80211_band band;
 	int num_channels = 0;
-	int i, ret;
+	int params_len, i, ret;
+	bool found = false;
 
-	bands = hw->wiphy->bands;
+	bands = ar->hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		if (!bands[band])
 			continue;
@@ -130,8 +131,10 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 	if (WARN_ON(!num_channels))
 		return -EINVAL;
 
-	params = kzalloc(struct_size(params, ch_param, num_channels),
-			 GFP_KERNEL);
+	params_len = sizeof(struct scan_chan_list_params) +
+			    num_channels * sizeof(struct channel_param);
+
+	params = kzalloc(params_len, GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
 
@@ -139,6 +142,8 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 	params->nallchans = num_channels;
 
 	ch = params->ch_param;
+	chandef = arg ? arg->chandef : NULL;
+	req_channel = chandef ? chandef->chan : NULL;
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		if (!bands[band])
@@ -150,6 +155,22 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 			if (channel->flags & IEEE80211_CHAN_DISABLED)
 				continue;
 
+			if (req_channel && !found &&
+			    req_channel->center_freq == channel->center_freq) {
+				ch->mhz = chandef->chan->center_freq;
+				ch->cfreq1 = chandef->center_freq1;
+				ch->cfreq2 = chandef->center_freq2;
+
+				ch->phy_mode = arg->phymode;
+				channel = req_channel;
+				found = true;
+			} else {
+				ch->mhz = channel->center_freq;
+				ch->cfreq1 = channel->center_freq;
+				ch->phy_mode = (channel->band == NL80211_BAND_2GHZ) ?
+						MODE_11G : MODE_11A;
+			}
+
 			/* TODO: Set to true/false based on some condition? */
 			ch->allow_ht = true;
 			ch->allow_vht = true;
@@ -163,15 +184,9 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
 			ch->mhz = channel->center_freq;
 			ch->cfreq1 = channel->center_freq;
 			ch->minpower = 0;
-			ch->maxpower = channel->max_power * 2;
-			ch->maxregpower = channel->max_reg_power * 2;
-			ch->antennamax = channel->max_antenna_gain * 2;
-
-			/* TODO: Use appropriate phymodes */
-			if (channel->band == NL80211_BAND_2GHZ)
-				ch->phy_mode = MODE_11G;
-			else
-				ch->phy_mode = MODE_11A;
+			ch->maxpower = channel->max_power;
+			ch->maxregpower = channel->max_reg_power;
+			ch->antennamax = channel->max_antenna_gain;
 
 			if (channel->band == NL80211_BAND_6GHZ &&
 			    cfg80211_channel_is_psc(channel))
@@ -282,7 +297,7 @@ int ath11k_regd_update(struct ath11k *ar)
 		goto err;
 
 	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar);
+		ret = ath11k_reg_update_chan_list(ar, NULL);
 		if (ret)
 			goto err;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 5fb9dc0..00c0d82 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -32,5 +32,5 @@ struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
 		      struct cur_regulatory_info *reg_info, bool intersect);
 int ath11k_regd_update(struct ath11k *ar);
-int ath11k_reg_update_chan_list(struct ath11k *ar);
+int ath11k_reg_update_chan_list(struct ath11k *ar, const struct scan_req_params *arg);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 587f423..89a743b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3323,6 +3323,8 @@ struct scan_req_params {
 	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
 	struct wmi_mac_addr mac_addr;
 	struct wmi_mac_addr mac_mask;
+	u32 phymode;
+	struct cfg80211_chan_def *chandef;
 };
 
 struct wmi_ssid_arg {
-- 
2.7.4

