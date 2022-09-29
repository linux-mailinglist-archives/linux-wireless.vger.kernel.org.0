Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1785EEADE
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 03:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiI2BZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 21:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiI2BZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 21:25:38 -0400
Received: from smtp15.infineon.com (smtp15.infineon.com [217.10.52.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB75248F4
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664414737; x=1695950737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMiHBPfJjFsq2uZSrcsQYM1FAANz1Jk322ukaEtW3yc=;
  b=Q4poWaC4HmWZi02Lvv4iiy4BARC4lA6Ra8OPkFjRicTPWmQlQmIXi3e+
   yOBDD37fSvFM3KDgAjAML9sXj88tLyuVWlm3iNunV5yI8Z544bGRkQGMo
   tgFMlzWBZ0h4NJsbU7IzZnRLYDY3uAGeDIi5iFHv/nhYibB25fUfSsVEl
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="143252721"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="143252721"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:25:35 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 03:25:34 +0200 (CEST)
Received: from MUCSE824.infineon.com (172.23.29.55) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 29 Sep
 2022 03:25:34 +0200
Received: from mailrelay-cypress3.infineon.com (172.23.18.46) by
 SMTP-MailRelay3.infineon.com (172.23.29.16) with Microsoft SMTP Server id
 15.2.986.29; Thu, 29 Sep 2022 03:25:34 +0200
mailrelay-external-outbound: True
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="264114137"
X-IronPort-AV: E=Sophos;i="5.93,353,1654552800"; 
   d="scan'208";a="264114137"
Received: from unknown (HELO mail.spansion.com) ([10.248.30.8])
  by mailrelay-cypress3.infineon.com with ESMTP; 29 Sep 2022 03:25:34 +0200
Received: from inf2.aus.cypress.com (10.248.80.6) by BIZ-EXHT102.spansion.com
 (10.248.30.8) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Sep 2022
 20:25:32 -0500
Received: from iot-wlan-dev-u03.aus.cypress.com (iot-wlan-dev-u03
 [10.248.81.193])       by inf2.aus.cypress.com (Postfix) with ESMTP id 8626A1004DF;
        Wed, 28 Sep 2022 20:25:32 -0500 (CDT)
Received: by iot-wlan-dev-u03.aus.cypress.com (Postfix, from userid 27991)      id
 83488980853; Wed, 28 Sep 2022 20:25:32 -0500 (CDT)
From:   Ian Lin <ian.lin@infineon.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <kvalo@kernel.org>,
        <Double.Lo@infineon.com>, <ian.lin@infineon.com>
Subject: [PATCH v3 1/4] brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
Date:   Wed, 28 Sep 2022 20:25:24 -0500
Message-ID: <20220929012527.4152-2-ian.lin@infineon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20220929012527.4152-1-ian.lin@infineon.com>
References: <20220929012527.4152-1-ian.lin@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

To enable ACS feature in Hostap daemon, dump_survey cfg80211 ops and dump
obss survey command in firmware side are needed. This patch is for adding
dump_survey feature and adding DUMP_OBSS feature flag to check if
firmware supports dump_obss iovar.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ian Lin <ian.lin@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 256 ++++++++++++++++++
 .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
 .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
 3 files changed, 261 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dfcfb3333369..bb3380c057d8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -88,9 +88,39 @@
 
 #define BRCMF_PS_MAX_TIMEOUT_MS		2000
 
+/* Dump obss definitions */
+#define ACS_MSRMNT_DELAY		100
+#define CHAN_NOISE_DUMMY		(-80)
+#define OBSS_TOKEN_IDX			15
+#define IBSS_TOKEN_IDX			15
+#define TX_TOKEN_IDX			14
+#define CTG_TOKEN_IDX			13
+#define PKT_TOKEN_IDX			15
+#define IDLE_TOKEN_IDX			12
+
 #define BRCMF_ASSOC_PARAMS_FIXED_SIZE \
 	(sizeof(struct brcmf_assoc_params_le) - sizeof(u16))
 
+struct brcmf_dump_survey {
+	u32 obss;
+	u32 ibss;
+	u32 no_ctg;
+	u32 no_pckt;
+	u32 tx;
+	u32 idle;
+};
+
+struct cca_stats_n_flags {
+	u32 msrmnt_time; /* Time for Measurement (msec) */
+	u32 msrmnt_done; /* flag set when measurement complete */
+	char buf[1];
+};
+
+struct cca_msrmnt_query {
+	u32 msrmnt_query;
+	u32 time_req;
+};
+
 static bool check_vif_up(struct brcmf_cfg80211_vif *vif)
 {
 	if (!test_bit(BRCMF_VIF_STATUS_READY, &vif->sme_state)) {
@@ -7525,6 +7555,229 @@ static s32 brcmf_translate_country_code(struct brcmf_pub *drvr, char alpha2[2],
 	return 0;
 }
 
+static int
+brcmf_parse_dump_obss(char *buf, struct brcmf_dump_survey *survey)
+{
+	int i;
+	char *token;
+	char delim[] = "\n ";
+	unsigned long val;
+	int err = 0;
+
+	token = strsep(&buf, delim);
+	while (token) {
+		if (!strcmp(token, "OBSS")) {
+			for (i = 0; i < OBSS_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->obss = val;
+		}
+
+		if (!strcmp(token, "IBSS")) {
+			for (i = 0; i < IBSS_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->ibss = val;
+		}
+
+		if (!strcmp(token, "TXDur")) {
+			for (i = 0; i < TX_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->tx = val;
+		}
+
+		if (!strcmp(token, "Category")) {
+			for (i = 0; i < CTG_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->no_ctg = val;
+		}
+
+		if (!strcmp(token, "Packet")) {
+			for (i = 0; i < PKT_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->no_pckt = val;
+		}
+
+		if (!strcmp(token, "Opp(time):")) {
+			for (i = 0; i < IDLE_TOKEN_IDX; i++)
+				token = strsep(&buf, delim);
+			err = kstrtoul(token, 10, &val);
+			if (err)
+				break;
+			survey->idle = val;
+		}
+
+		token = strsep(&buf, delim);
+	}
+
+	return err;
+}
+
+static int
+brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
+		struct brcmf_dump_survey *survey)
+{
+	struct cca_stats_n_flags *results;
+	char *buf;
+	int err;
+
+	buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
+	if (unlikely(!buf)) {
+		brcmf_err("%s: buf alloc failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	memcpy(buf, &req, sizeof(struct cca_msrmnt_query));
+	err = brcmf_fil_iovar_data_get(ifp, "dump_obss",
+				       buf, BRCMF_DCMD_MEDLEN);
+	if (err < 0) {
+		brcmf_err("dump_obss error (%d)\n", err);
+		goto exit;
+	}
+	results = (struct cca_stats_n_flags *)(buf);
+
+	if (req.msrmnt_query)
+		brcmf_parse_dump_obss(results->buf, survey);
+
+	kfree(buf);
+	return 0;
+exit:
+	kfree(buf);
+	return -EINVAL;
+}
+
+static s32
+cfg80211_set_channel(struct wiphy *wiphy, struct net_device *dev,
+		     struct ieee80211_channel *chan,
+		     enum nl80211_channel_type channel_type)
+{
+	u16 chspec = 0;
+	int err = 0;
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+
+	/* set_channel */
+	chspec = channel_to_chanspec(&cfg->d11inf, chan);
+	if (chspec != INVCHANSPEC) {
+		err = brcmf_fil_iovar_int_set(ifp, "chanspec", chspec);
+		if (err) {
+			brcmf_err("set chanspec 0x%04x fail, reason %d\n", chspec, err);
+			err = -EINVAL;
+		}
+	} else {
+		brcmf_err("failed to convert host chanspec to fw chanspec\n");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int
+brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
+			   int idx, struct survey_info *info)
+{
+	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct brcmf_dump_survey survey = {};
+	struct ieee80211_supported_band *band;
+	struct ieee80211_channel *chan;
+	struct cca_msrmnt_query req;
+	u32 val, noise;
+	int err;
+
+	brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
+
+	band = wiphy->bands[NL80211_BAND_2GHZ];
+	if (band && idx >= band->n_channels) {
+		idx -= band->n_channels;
+		band = NULL;
+	}
+
+	if (!band || idx >= band->n_channels) {
+		band = wiphy->bands[NL80211_BAND_5GHZ];
+		if (idx >= band->n_channels)
+			return -ENOENT;
+	}
+
+	/* Setting current channel to the requested channel */
+	chan = &band->channels[idx];
+	err = cfg80211_set_channel(wiphy, ndev, chan, NL80211_CHAN_HT20);
+	if (err) {
+		info->channel = chan;
+		info->filled = 0;
+		return 0;
+	}
+
+	if (!idx) {
+		/* Disable mpc */
+		val = 0;
+		brcmf_set_mpc(ifp, val);
+		/* Set interface up, explicitly. */
+		val = 1;
+		err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, val);
+		if (err) {
+			brcmf_err("BRCMF_C_UP error (%d)\n", err);
+			return -EIO;
+		}
+	}
+
+	/* Get noise value */
+	err = brcmf_fil_cmd_int_get(ifp, BRCMF_C_GET_PHY_NOISE, &noise);
+	if (err) {
+		brcmf_err("Get Phy Noise failed, error = %d\n", err);
+		noise = CHAN_NOISE_DUMMY;
+	}
+
+	/* Start Measurement for obss stats on current channel */
+	req.msrmnt_query = 0;
+	req.time_req = ACS_MSRMNT_DELAY;
+	err = brcmf_dump_obss(ifp, req, &survey);
+	if (err)
+		goto exit;
+
+	/* Add 10 ms for IOVAR completion */
+	msleep(ACS_MSRMNT_DELAY + 10);
+
+	/* Issue IOVAR to collect measurement results */
+	req.msrmnt_query = 1;
+	err = brcmf_dump_obss(ifp, req, &survey);
+	if (err < 0)
+		goto exit;
+
+	info->channel = chan;
+	info->noise = noise;
+	info->time = ACS_MSRMNT_DELAY;
+	info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
+	info->time_rx = survey.obss + survey.ibss + survey.no_ctg +
+		survey.no_pckt;
+	info->time_tx = survey.tx;
+	info->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
+		SURVEY_INFO_TIME_BUSY | SURVEY_INFO_TIME_RX |
+		SURVEY_INFO_TIME_TX;
+
+	brcmf_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
+		  ieee80211_frequency_to_channel(chan->center_freq),
+		  ACS_MSRMNT_DELAY);
+	brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
+		  info->noise, info->time_busy, info->time_rx, info->time_tx);
+
+exit:
+	return err;
+}
+
 static void brcmf_cfg80211_reg_notifier(struct wiphy *wiphy,
 					struct regulatory_request *req)
 {
@@ -7676,6 +7929,9 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_WOWL_GTK))
 		ops->set_rekey_data = brcmf_cfg80211_set_rekey_data;
 #endif
+	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DUMP_OBSS))
+		ops->dump_survey = brcmf_cfg80211_dump_survey;
+
 	err = wiphy_register(wiphy);
 	if (err < 0) {
 		bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 2c2f3e026c13..10bac865d724 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -143,7 +143,7 @@ static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
 	ifp->fwil_fwerr = true;
 
 	err = brcmf_fil_iovar_int_get(ifp, name, &data);
-	if (err == 0) {
+	if (err != -BRCMF_FW_UNSUPPORTED) {
 		brcmf_dbg(INFO, "enabling feature: %s\n", brcmf_feat_names[id]);
 		ifp->drvr->feat_flags |= BIT(id);
 	} else {
@@ -281,6 +281,7 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_RSDB, "rsdb_mode");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_TDLS, "tdls_enable");
 	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_MFP, "mfp");
+	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_DUMP_OBSS, "dump_obss");
 
 	pfn_mac.version = BRCMF_PFN_MACADDR_CFG_VER;
 	err = brcmf_fil_iovar_data_get(ifp, "pfn_macaddr", &pfn_mac,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
index d1f4257af696..f1b086a69d73 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
@@ -29,6 +29,7 @@
  * DOT11H: firmware supports 802.11h
  * SAE: simultaneous authentication of equals
  * FWAUTH: Firmware authenticator
+ * DUMP_OBSS: Firmware has capable to dump obss info to support ACS
  */
 #define BRCMF_FEAT_LIST \
 	BRCMF_FEAT_DEF(MBSS) \
@@ -51,7 +52,8 @@
 	BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
 	BRCMF_FEAT_DEF(DOT11H) \
 	BRCMF_FEAT_DEF(SAE) \
-	BRCMF_FEAT_DEF(FWAUTH)
+	BRCMF_FEAT_DEF(FWAUTH) \
+	BRCMF_FEAT_DEF(DUMP_OBSS)
 
 /*
  * Quirks:
-- 
2.25.0

