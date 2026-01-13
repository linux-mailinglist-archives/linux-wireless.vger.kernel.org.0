Return-Path: <linux-wireless+bounces-30782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64DED1B44C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30A2130734DE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72612BCF6C;
	Tue, 13 Jan 2026 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Rqs6uJzO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B05276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336839; cv=none; b=AP/i5v1UFfFzBamGmD9H/RcDhSrLsb4kfoVXYA/P7DRQfPnYnWnZY4bHbUsGzTlaqXDmihIBF10wbql37Eczv2+H+rg/oZ5z2QAn68YgmLjYlzHpCkCdufIJo6vuAnh0nPUyEgexLEkyvbF9f73qKrTAh7XP1g6cm6xOqDfhLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336839; c=relaxed/simple;
	bh=cXcvn8W302eQVe4Zpr25yhcvoXsgx/qIo0Bwc+spPGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqqTyUyloTtqlf/f2Nx+qECFxW7zV8hecDPqLdga6MHMnhFvWnvJ+3FdmNhtUz2tdK0ybjxN/TcJmWCtCeOriF7fZPTpC3g6R2/O4Uy5LNbDaut/mccRnV7+GK8ifXTxS1xFooYgthlNOLOwlNw35EQAvwm54txKbvCXDnrlzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Rqs6uJzO; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336837; x=1799872837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cXcvn8W302eQVe4Zpr25yhcvoXsgx/qIo0Bwc+spPGM=;
  b=Rqs6uJzOfgdXRIIt4n/iXN8KiQIJEBSTEKipkXh+3R9LWbydj4veqSE/
   H0gbdfpTc9lCHlikrUfHbYXFJCRmMuV0IYU+YwH5Hz7g1Kjs93GEozVoq
   ZT8r1ROPYypj60RF+EaFOb4epf0w/hUZkPT5gDY61xDBTMjyTH6yEa2Jc
   Y=;
X-CSE-ConnectionGUID: T48enl8+QC+zuVkdzgU6qw==
X-CSE-MsgGUID: pZ8ygaL6S0+3Av6gJUG5Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568574"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568574"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:40:35 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:40:34 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:40:32 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 27/34] wifi: inffmac: add scan.c/h
Date: Wed, 14 Jan 2026 02:03:40 +0530
Message-ID: <20260113203350.16734-28-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE827.infineon.com (172.23.29.20)

Driver imeplementation of the SCAN functionality to discover all ctive BSS
in the medium. Also support collecting the channel survery dump.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/scan.c | 1205 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/scan.h |  203 +++
 2 files changed, 1408 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/scan.h

diff --git a/drivers/net/wireless/infineon/inffmac/scan.c b/drivers/net/wireless/infineon/inffmac/scan.c
new file mode 100644
index 000000000000..c2d4df3e6c59
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/scan.c
@@ -0,0 +1,1205 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+
+#include "main.h"
+#include "utils.h"
+#include "chan.h"
+#include "debug.h"
+#include "p2p.h"
+#include "fwsignal.h"
+#include "cfg80211.h"
+#include "interface.h"
+#include "feature.h"
+#include "dev_cmd.h"
+#include "vendor.h"
+#include "he.h"
+#include "pmsr.h"
+#include "security.h"
+
+static int inff_parse_dump_obss(char *buf, struct inff_dump_survey *survey)
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
+static int inff_dump_obss(struct inff_if *ifp, struct cca_msrmnt_query req,
+			  struct inff_dump_survey *survey)
+{
+	struct cca_stats_n_flags *results;
+	char *buf;
+	int err;
+
+	buf = kzalloc(sizeof(char) * INFF_DCMD_MEDLEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy(buf, &req, sizeof(struct cca_msrmnt_query));
+	err = inff_fwcmd_iovar_data_get(ifp, "dump_obss",
+					buf, INFF_DCMD_MEDLEN);
+	if (err) {
+		inff_err("dump_obss error (%d)\n", err);
+		err = -EINVAL;
+		goto exit;
+	}
+	results = (struct cca_stats_n_flags *)(buf);
+
+	if (req.msrmnt_query)
+		inff_parse_dump_obss(results->buf, survey);
+
+exit:
+	kfree(buf);
+	return err;
+}
+
+int
+inff_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
+			  int idx, struct survey_info *info)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct inff_dump_survey survey = {};
+	struct ieee80211_supported_band *band;
+	enum nl80211_band band_id;
+	struct cca_msrmnt_query req;
+	u32 noise = 0;
+	int err;
+
+	if (!inff_vif_is_apmode(ifp->vif))
+		return -ENOENT;
+
+	/* Do not run survey when VIF in CONNECTING / CONNECTED states */
+	if ((test_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)) ||
+	    (test_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))) {
+		return -EBUSY;
+	}
+
+	for (band_id = 0; band_id < NUM_NL80211_BANDS; band_id++) {
+		/* FIXME SWLINUX-4979, the firmware cannot report the survey info of 6GHz,
+		 * once the firmware can report it in someday.
+		 * This condition can be removed.
+		 */
+		if (band_id == NL80211_BAND_6GHZ)
+			continue;
+
+		band = wiphy->bands[band_id];
+		if (!band)
+			continue;
+		if (idx >= band->n_channels) {
+			idx -= band->n_channels;
+			continue;
+		}
+
+		info->channel = &band->channels[idx];
+		break;
+	}
+	if (band_id == NUM_NL80211_BANDS)
+		return -ENOENT;
+
+	/* Setting current channel to the requested channel */
+	info->filled = 0;
+	if (inff_chan_set(cfg, info->channel))
+		return 0;
+
+	/* Disable mpc */
+	inff_set_mpc(ifp, 0);
+
+	/* Set interface up, explicitly. */
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_UP, 1);
+	if (err) {
+		inff_err("set interface up failed, err = %d\n", err);
+		goto exit;
+	}
+
+	/* Get noise value */
+	err = inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_PHY_NOISE, &noise);
+	if (err) {
+		inff_err("Get Phy Noise failed, use dummy value\n");
+		noise = CHAN_NOISE_DUMMY;
+	}
+
+	/* Start Measurement for obss stats on current channel */
+	req.msrmnt_query = 0;
+	req.time_req = ACS_MSRMNT_DELAY;
+	err = inff_dump_obss(ifp, req, &survey);
+	if (err)
+		goto exit;
+
+	/* Add 10 ms for IOVAR completion */
+	msleep(ACS_MSRMNT_DELAY + 10);
+
+	/* Issue IOVAR to collect measurement results */
+	req.msrmnt_query = 1;
+	err = inff_dump_obss(ifp, req, &survey);
+	if (err)
+		goto exit;
+
+	info->noise = noise;
+	info->time = ACS_MSRMNT_DELAY;
+	info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
+	info->time_rx = survey.obss + survey.ibss + survey.no_ctg +
+			survey.no_pckt;
+	info->time_tx = survey.tx;
+	info->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
+			SURVEY_INFO_TIME_BUSY | SURVEY_INFO_TIME_RX |
+			SURVEY_INFO_TIME_TX;
+
+	inff_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
+		 ieee80211_frequency_to_channel(info->channel->center_freq),
+		 ACS_MSRMNT_DELAY);
+	inff_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
+		 info->noise, info->time_busy, info->time_rx, info->time_tx);
+
+exit:
+	if (!inff_vif_is_apmode(ifp->vif))
+		inff_set_mpc(ifp, 1);
+	return err;
+}
+
+int
+inff_cfg80211_dump_survey_2(struct wiphy *wiphy, struct net_device *ndev,
+			    int idx, struct survey_info *info)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+	struct ieee80211_supported_band *band;
+	struct cca_survey_req *survey = NULL;
+	struct cca_survey  *secs;
+	struct cfg80211_chan_def chandef;
+	struct wireless_dev *wdev;
+	enum nl80211_band band_id;
+	int err = 0;
+	u32 noise = 0;
+
+	/* Do not run survey when VIF in CONNECTING / CONNECTED states */
+	if ((test_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state)))
+		return -EBUSY;
+
+	for (band_id = 0; band_id < NUM_NL80211_BANDS; band_id++) {
+		/* FIXME SWLINUX-4979, the firmware cannot report the survey info of 6GHz,
+		 * once the firmware can report it in someday.
+		 * This condition can be removed.
+		 */
+		if (band_id == NL80211_BAND_6GHZ)
+			continue;
+
+		band = wiphy->bands[band_id];
+		if (!band)
+			continue;
+		if (idx >= band->n_channels) {
+			idx -= band->n_channels;
+			continue;
+		}
+
+		info->channel = &band->channels[idx];
+		break;
+	}
+	if (band_id == NUM_NL80211_BANDS)
+		return -ENOENT;
+
+	/* Set interface up, explicitly. */
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_UP, 1);
+	if (err) {
+		inff_err("set interface up failed, err = %d\n", err);
+		return err;
+	}
+
+	/* Get noise value */
+	err = inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_PHY_NOISE, &noise);
+	if (err) {
+		inff_err("Get Phy Noise failed, use dummy value\n");
+	 noise = CHAN_NOISE_DUMMY;
+	}
+
+	survey = kzalloc(sizeof(*survey), GFP_KERNEL);
+	if (!survey)
+		return -ENOMEM;
+
+	survey->chanspec = inff_nl80211_chan_to_chanspec(info->channel);
+	err = inff_fwcmd_iovar_data_get(ifp, "cca_survey_dump",
+					survey, sizeof(struct cca_survey_req));
+	if (err) {
+		inff_err("cca_survey_dump error (%d)\n", err);
+		err = -EINVAL;
+		goto exit;
+	}
+
+	secs = &survey->secs[0];
+
+	info->noise = noise;
+	info->time = secs->usecs;
+	info->time_busy = secs->ibss + secs->txdur + secs->obss
+	       + secs->noctg + secs->nopkt;
+	info->time_rx = secs->obss + secs->ibss + secs->noctg
+	       + secs->nopkt;
+	info->time_tx = secs->txdur;
+	info->time_bss_rx = secs->ibss;
+
+	info->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
+		SURVEY_INFO_TIME_BUSY | SURVEY_INFO_TIME_RX |
+		SURVEY_INFO_TIME_TX | SURVEY_INFO_TIME_BSS_RX;
+
+	wdev = ndev->ieee80211_ptr;
+	memset(&chandef, 0, sizeof(chandef));
+	err = inff_cfg80211_get_channel(wiphy, wdev, 0, &chandef);
+	if (unlikely(err)) {
+		inff_err("Get chandef error: %d\n", err);
+		err = -EINVAL;
+		goto exit;
+	}
+	if (chandef.chan->center_freq == info->channel->center_freq)
+		info->filled = info->filled | SURVEY_INFO_IN_USE;
+
+	inff_dbg(INFO, "survey dump: channel %d: survey duration %llu\n",
+		 ieee80211_frequency_to_channel(info->channel->center_freq),
+		 info->time);
+	inff_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
+		 info->noise, info->time_busy, info->time_rx, info->time_tx);
+
+exit:
+	kfree(survey);
+	return err;
+}
+
+s32
+inff_dongle_scantime(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_SCAN_CHANNEL_TIME,
+				     INFF_SCAN_CHANNEL_TIME);
+	if (err) {
+		iphy_err(drvr, "Scan assoc time error (%d)\n", err);
+		goto dongle_scantime_out;
+	}
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_SCAN_UNASSOC_TIME,
+				     INFF_SCAN_UNASSOC_TIME);
+	if (err) {
+		iphy_err(drvr, "Scan unassoc time error (%d)\n", err);
+		goto dongle_scantime_out;
+	}
+
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_SCAN_PASSIVE_TIME,
+				     INFF_SCAN_PASSIVE_TIME);
+	if (err) {
+		iphy_err(drvr, "Scan passive time error (%d)\n", err);
+		goto dongle_scantime_out;
+	}
+
+dongle_scantime_out:
+	return err;
+}
+
+static void
+inff_cp_scan_reset(struct inff_scan_info *scan)
+{
+	scan->request = NULL;
+	scan->bss_count = 0;
+	scan->used_buf_len = 0;
+	memset(scan->bss_buf, 0, INFF_SCAN_BUF_SIZE);
+}
+
+static void
+inff_cp_scan_complete(struct inff_scan_info *scan, bool aborted)
+{
+	inff_dbg(SCAN, "\n");
+
+	if (scan->request) {
+		struct cfg80211_scan_info info = {
+			.aborted = aborted,
+		};
+
+		inff_dbg(SCAN, "%s\n", aborted ? "aborted" : "done");
+		cfg80211_scan_done(scan->request, &info);
+	}
+	inff_cp_scan_reset(scan);
+}
+
+void
+inff_cp_scan_abort(struct inff_scan_info *scan)
+{
+	inff_cp_scan_complete(scan, true);
+}
+
+static s32
+inff_cp_scan_inform_single_bss(struct inff_scan_info *scan,
+			       struct inff_cp_bss_info *bss)
+{
+	struct wiphy *wiphy = scan->wiphy;
+	struct cfg80211_bss *cfg80211_bss;
+	struct cfg80211_inform_bss bss_data = {};
+	enum nl80211_band band;
+	u16 channel;
+	u32 freq;
+	u8 *ie;
+
+	inff_dbg(SCAN, "SSID: %s\n", bss->ssid);
+	inff_dbg(SCAN, "BSSID: %pM\n", bss->macaddr);
+
+	channel = bss->channel;
+	band = inff_cp_chan_band_to_nl80211(bss->band);
+
+	freq = ieee80211_channel_to_frequency(channel, band);
+	if (!freq) {
+		inff_err("failed to get frequency from channel %d and band %d\n",
+			 channel, band);
+		return -EINVAL;
+	}
+
+	bss_data.chan = ieee80211_get_channel(wiphy, freq);
+	if (!bss_data.chan) {
+		inff_err("failed to get channel from freq %d\n", freq);
+		return -EINVAL;
+	}
+
+	bss_data.boottime_ns = ktime_to_ns(ktime_get_boottime());
+	bss_data.signal = bss->signal_strength * 100;
+
+	inff_dbg(SCAN, "Channel: %d(%d)\n", channel, freq);
+	inff_dbg(SCAN, "Capability: %X\n", bss->capability);
+	inff_dbg(SCAN, "Beacon interval: %d\n", bss->beacon_period);
+	inff_dbg(SCAN, "Signal: %d\n", bss->signal_strength);
+
+	ie = (unsigned char *)bss + sizeof(*bss);
+
+	cfg80211_bss = cfg80211_inform_bss_data(wiphy, &bss_data,
+						CFG80211_BSS_FTYPE_UNKNOWN,
+						(const u8 *)bss->macaddr,
+						0, bss->capability,
+						bss->beacon_period, ie,
+						bss->ie_len, GFP_KERNEL);
+	if (!cfg80211_bss)
+		return -ENOMEM;
+
+	cfg80211_put_bss(wiphy, cfg80211_bss);
+
+	return 0;
+}
+
+static void
+inff_cp_scan_inform_bss(struct inff_scan_info *scan)
+{
+	struct inff_cp_bss_info *bss = (struct inff_cp_bss_info *)scan->bss_buf;
+	s32 err = 0;
+	int i;
+
+	inff_dbg(SCAN, "scanned AP count (%d)\n", scan->bss_count);
+	for (i = 0; i < scan->bss_count; i++) {
+		err = inff_cp_scan_inform_single_bss(scan, bss);
+		if (err == -ENOMEM)
+			break;
+
+		bss = (struct inff_cp_bss_info *)
+			((unsigned char *)bss + bss->length);
+	}
+}
+
+static void
+inff_cp_scan_save_bss(struct inff_scan_info *scan, struct inff_cpevt_scan *new_bss)
+{
+	struct inff_cp_bss_info *bss = (struct inff_cp_bss_info *)scan->bss_buf;
+	u32 new_bss_len;
+	u8 i;
+
+	new_bss_len = sizeof(*bss) + new_bss->ie_len;
+
+	for (i = 0; i < scan->bss_count; i++) {
+		if (!memcmp(&bss->macaddr, &new_bss->macaddr, ETH_ALEN))
+			return;
+
+		bss = (struct inff_cp_bss_info *)((unsigned char *)bss + bss->length);
+	}
+
+	if (scan->used_buf_len + new_bss_len > INFF_SCAN_BUF_SIZE) {
+		inff_err("scan buffer is not enough\n");
+		return;
+	}
+
+	bss->length = new_bss_len;
+	bss->ssid_length = new_bss->ssid_length;
+	memcpy(bss->ssid, new_bss->ssid, new_bss->ssid_length);
+	memcpy(bss->macaddr, new_bss->macaddr, ETH_ALEN);
+	bss->signal_strength = new_bss->signal_strength;
+	bss->channel = new_bss->channel;
+	bss->band = new_bss->band;
+	bss->beacon_period = new_bss->beacon_period;
+	bss->capability = new_bss->capability;
+	bss->ie_len = new_bss->ie_len;
+
+	memcpy((u8 *)bss + sizeof(*bss), new_bss->ie, new_bss->ie_len);
+
+	inff_dbg(SCAN, "BSS Idx %d\n", scan->bss_count);
+	inff_dbg(SCAN, "SSID: %s\n", bss->ssid);
+	inff_dbg(SCAN, "BSSID: %pM\n", bss->macaddr);
+
+	scan->bss_count++;
+	scan->used_buf_len += new_bss_len;
+	inff_dbg(SCAN, "used_buf_len: %d\n", scan->used_buf_len);
+}
+
+/*
+ * inff_cp_scan_event_handler() - handle scan event.
+ *
+ * @scan: scan info context.
+ * @event: scan event.
+ */
+int
+inff_cp_scan_event_handler(struct inff_scan_info *scan,
+			   struct inff_cpevt_scan *scan_event)
+{
+	int ret = 0;
+
+	inff_dbg(SCAN, "\n");
+
+	if (!scan->request)
+		return 0;
+
+	if (scan_event->scan_complete) {
+		inff_cp_scan_inform_bss(scan);
+		inff_cp_scan_complete(scan, false);
+	} else {
+		inff_cp_scan_save_bss(scan, scan_event);
+	}
+
+	return ret;
+}
+
+int
+inff_cp_scan_init(struct inff_cfg80211_info *cfg)
+{
+	struct inff_scan_info *scan = &cfg->scan;
+
+	scan->wiphy = cfg->wiphy;
+
+	scan->bss_buf = kzalloc(INFF_SCAN_BUF_SIZE, GFP_KERNEL);
+	if (!scan->bss_buf)
+		return -ENOMEM;
+
+	inff_cp_scan_reset(scan);
+
+	return 0;
+}
+
+int
+inff_cp_scan_start(struct inff_scan_info *scan, struct cfg80211_scan_request *request)
+{
+	struct inff_cfg80211_vif *vif = NULL;
+	int err;
+
+	inff_dbg(SCAN, "\n");
+
+	if (scan->request) {
+		inff_err("Scan in-progress\n");
+		return -EAGAIN;
+	}
+
+	vif = container_of(request->wdev, struct inff_cfg80211_vif, wdev);
+
+	scan->request = request;
+
+	err = inff_cpcmd_data_set(vif->ifp, INFF_CP_C_SCAN, NULL, 0);
+	if (err) {
+		inff_err("scan failed %d\n", err);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+s32
+inff_run_escan(struct inff_cfg80211_info *cfg, struct inff_if *ifp,
+	       struct cfg80211_scan_request *request)
+{
+	s32 params_size = INFF_SCAN_PARAMS_V2_FIXED_SIZE +
+			  offsetof(struct inff_escan_params_le, params_v2_le);
+	struct inff_escan_params_le *params;
+	s32 err = 0;
+
+	inff_dbg(SCAN, "E-SCAN START\n");
+
+	if (request) {
+		/* Allocate space for populating ssids in struct */
+		params_size += sizeof(u32) * ((request->n_channels + 1) / 2);
+
+		/* Allocate space for populating ssids in struct */
+		params_size += sizeof(struct inff_ssid_le) * request->n_ssids;
+	}
+
+	params = kzalloc(params_size, GFP_KERNEL);
+	if (!params) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	WARN_ON_ONCE(params_size + sizeof("escan") >= INFF_DCMD_MEDLEN);
+	inff_escan_prep(cfg, &params->params_v2_le, request);
+
+	params->version = cpu_to_le32(INFF_ESCAN_REQ_VERSION_V2);
+
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_SCAN_V2)) {
+		struct inff_escan_params_le *params_v1;
+
+		params_size -= INFF_SCAN_PARAMS_V2_FIXED_SIZE;
+		params_size += INFF_SCAN_PARAMS_FIXED_SIZE;
+		params_v1 = kzalloc(params_size, GFP_KERNEL);
+		if (!params_v1) {
+			err = -ENOMEM;
+			goto exit_params;
+		}
+		params_v1->version = cpu_to_le32(INFF_ESCAN_REQ_VERSION);
+		inff_scan_params_v2_to_v1(&params->params_v2_le, &params_v1->params_le);
+		kfree(params);
+		params = params_v1;
+	}
+
+	params->action = cpu_to_le16(WL_ESCAN_ACTION_START);
+	params->sync_id = cpu_to_le16(0x1234);
+
+	err = inff_fwcmd_iovar_data_set(ifp, "escan", params, params_size);
+	if (err) {
+		if (err == -EBUSY)
+			inff_dbg(INFO, "system busy : escan canceled\n");
+		else
+			iphy_err(ifp->drvr, "error (%d)\n", err);
+	}
+
+exit_params:
+	kfree(params);
+exit:
+	return err;
+}
+
+static s32
+inff_do_escan(struct inff_if *ifp, struct cfg80211_scan_request *request)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	s32 err;
+	struct inff_scan_results *results;
+	struct escan_info *escan = &cfg->escan_info;
+
+	escan->ifp = ifp;
+	escan->wiphy = cfg->wiphy;
+	escan->escan_state = WL_ESCAN_STATE_SCANNING;
+
+	inff_scan_config_mpc(ifp, 0);
+	results = (struct inff_scan_results *)cfg->escan_info.escan_buf;
+	results->version = 0;
+	results->count = 0;
+	results->buflen = WL_ESCAN_RESULTS_FIXED_SIZE;
+
+	err = escan->run(cfg, ifp, request);
+	if (err)
+		inff_scan_config_mpc(ifp, 1);
+	return err;
+}
+
+int inff_start_internal_escan(struct inff_if *ifp, u32 fwmap,
+			      struct cfg80211_scan_request *request)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	int err;
+
+	if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status)) {
+		if (cfg->int_escan_map)
+			inff_dbg(SCAN, "aborting internal scan: map=%u\n",
+				 cfg->int_escan_map);
+		/* Abort any on-going scan */
+		inff_abort_scanning(cfg);
+	}
+
+	inff_dbg(SCAN, "start internal scan: map=%u\n", fwmap);
+	set_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status);
+	cfg->escan_info.run = inff_run_escan;
+	err = inff_do_escan(ifp, request);
+	if (err) {
+		clear_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status);
+		return err;
+	}
+	cfg->int_escan_map = fwmap;
+	return 0;
+}
+
+void inff_abort_scanning(struct inff_cfg80211_info *cfg)
+{
+	struct escan_info *escan = &cfg->escan_info;
+
+	set_bit(INFF_SCAN_STATUS_ABORT, &cfg->scan_status);
+	if (cfg->int_escan_map || cfg->scan_request) {
+		escan->escan_state = WL_ESCAN_STATE_IDLE;
+		inff_notify_escan_complete(cfg, escan->ifp, true, true);
+	}
+	clear_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status);
+	clear_bit(INFF_SCAN_STATUS_ABORT, &cfg->scan_status);
+}
+
+void inff_escan_prep(struct inff_cfg80211_info *cfg,
+		     struct inff_scan_params_v2_le *params_le,
+		     struct cfg80211_scan_request *request)
+{
+	u32 n_ssids;
+	u32 n_channels;
+	s32 i;
+	s32 offset;
+	u16 chanspec;
+	char *ptr;
+	int length;
+	struct inff_ssid_le ssid_le;
+
+	eth_broadcast_addr(params_le->bssid);
+
+	length = INFF_SCAN_PARAMS_V2_FIXED_SIZE;
+
+	params_le->version = cpu_to_le16(INFF_SCAN_PARAMS_VERSION_V2);
+	params_le->bss_type = DOT11_BSSTYPE_ANY;
+	params_le->scan_type = cpu_to_le32(INFF_SCANTYPE_ACTIVE);
+	params_le->channel_num = 0;
+	params_le->nprobes = cpu_to_le32(-1);
+	params_le->active_time = cpu_to_le32(-1);
+	params_le->passive_time = cpu_to_le32(-1);
+	params_le->home_time = cpu_to_le32(-1);
+	memset(&params_le->ssid_le, 0, sizeof(params_le->ssid_le));
+
+	/* Scan abort */
+	if (!request) {
+		length += sizeof(u16);
+		params_le->channel_num = cpu_to_le32(1);
+		params_le->channel_list[0] = cpu_to_le16(-1);
+		params_le->length = cpu_to_le16(length);
+		return;
+	}
+
+	n_ssids = request->n_ssids;
+	n_channels = request->n_channels;
+
+	/* Copy channel array if applicable */
+	inff_dbg(SCAN, "### List of channelspecs to scan ### %d\n",
+		 n_channels);
+	if (n_channels > 0) {
+		length += roundup(sizeof(u16) * n_channels, sizeof(u32));
+		for (i = 0; i < n_channels; i++) {
+			chanspec = inff_nl80211_chan_to_chanspec(request->channels[i]);
+			inff_dbg(SCAN, "Chan : %d, Channel spec: %x\n",
+				 request->channels[i]->hw_value, chanspec);
+			params_le->channel_list[i] = cpu_to_le16(chanspec);
+		}
+	} else {
+		inff_dbg(SCAN, "Scanning all channels\n");
+	}
+
+	/* Copy ssid array if applicable */
+	inff_dbg(SCAN, "### List of SSIDs to scan ### %d\n", n_ssids);
+	if (n_ssids > 0) {
+		offset = offsetof(struct inff_scan_params_v2_le, channel_list) +
+				n_channels * sizeof(u16);
+		offset = roundup(offset, sizeof(u32));
+		length += sizeof(ssid_le) * n_ssids;
+		ptr = (char *)params_le + offset;
+		for (i = 0; i < n_ssids; i++) {
+			memset(&ssid_le, 0, sizeof(ssid_le));
+			ssid_le.SSID_len =
+					cpu_to_le32(request->ssids[i].ssid_len);
+			memcpy(ssid_le.SSID, request->ssids[i].ssid,
+			       request->ssids[i].ssid_len);
+			if (!ssid_le.SSID_len)
+				inff_dbg(SCAN, "%d: Broadcast scan\n", i);
+			else
+				inff_dbg(SCAN, "%d: scan for  %.32s size=%d\n",
+					 i, ssid_le.SSID, ssid_le.SSID_len);
+			memcpy(ptr, &ssid_le, sizeof(ssid_le));
+			ptr += sizeof(ssid_le);
+		}
+	} else {
+		inff_dbg(SCAN, "Performing passive scan\n");
+		params_le->scan_type = cpu_to_le32(INFF_SCANTYPE_PASSIVE);
+	}
+	params_le->length = cpu_to_le16(length);
+	/* Adding mask to channel numbers */
+	params_le->channel_num =
+		cpu_to_le32((n_ssids << INFF_SCAN_PARAMS_NSSID_SHIFT) |
+			(n_channels & INFF_SCAN_PARAMS_COUNT_MASK));
+}
+
+s32
+inff_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_vif *vif;
+	s32 err = 0;
+	struct inff_tlv *interworking_ie = NULL;
+
+	vif = container_of(request->wdev, struct inff_cfg80211_vif, wdev);
+	if (!inff_check_vif_up(vif))
+		return -EIO;
+
+	if (inff_socitype_is_cp(drvr->bus_if)) {
+		err = inff_cp_scan_start(&cfg->scan, request);
+		if (err)
+			goto scan_out;
+		else
+			return 0;
+	}
+
+	if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status)) {
+		iphy_err(drvr, "Scanning already: status (%lu)\n",
+			 cfg->scan_status);
+		return -EAGAIN;
+	}
+	if (test_bit(INFF_SCAN_STATUS_ABORT, &cfg->scan_status)) {
+		iphy_err(drvr, "Scanning being aborted: status (%lu)\n",
+			 cfg->scan_status);
+		return -EAGAIN;
+	}
+	if (test_bit(INFF_SCAN_STATUS_SUPPRESS, &cfg->scan_status)) {
+		iphy_err(drvr, "Scanning suppressed: status (%lu)\n",
+			 cfg->scan_status);
+		return -EAGAIN;
+	}
+	if (test_bit(INFF_VIF_STATUS_CONNECTING, &vif->sme_state)) {
+		iphy_err(drvr, "Connecting: status (%lu)\n", vif->sme_state);
+		return -EAGAIN;
+	}
+
+	inff_dbg(SCAN, "START ESCAN\n");
+
+	cfg->scan_request = request;
+	set_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status);
+
+	interworking_ie = inff_find_iwie(request->ie, request->ie_len);
+	if (interworking_ie) {
+		err = inff_add_iwie(cfg, vif->ifp,
+				    INFF_VNDR_IE_CUSTOM_FLAG,
+				    interworking_ie->id,
+				    interworking_ie->data,
+				    interworking_ie->len);
+		if (err)
+			inff_err("Failed to add interworking IE");
+	} else {
+		/* we have to clear IW IE  */
+		inff_clear_iwie(cfg, vif->ifp);
+	}
+
+	cfg->escan_info.run = inff_run_escan;
+	err = inff_p2p_scan_prep(wiphy, request, vif);
+	if (err)
+		goto scan_out;
+
+	/* If scan req comes for p2p0, send it over primary I/F */
+	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
+	err = inff_do_escan(vif->ifp, request);
+	if (err)
+		goto scan_out;
+
+	/* Arm scan timeout timer */
+	wiphy_delayed_work_queue(cfg->wiphy, &cfg->escan_timeout_work,
+				 msecs_to_jiffies(INFF_ESCAN_TIMER_INTERVAL_MS));
+
+	return 0;
+
+scan_out:
+	iphy_err(drvr, "scan error (%d)\n", err);
+	clear_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status);
+	cfg->scan_request = NULL;
+	return err;
+}
+
+static s32
+inff_cfg80211_escan_handler(struct inff_if *ifp,
+			    const struct inff_event_msg *e, void *data)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_cfg80211_info *cfg = drvr->config;
+	s32 status;
+	struct inff_escan_result_le *escan_result_le;
+	u32 escan_buflen;
+	struct inff_bss_info_le *bss_info_le;
+	struct inff_bss_info_le *bss = NULL;
+	u32 bi_length;
+	struct inff_scan_results *list;
+	u32 i;
+	bool aborted;
+
+	status = e->status;
+
+	if (status == INFF_E_STATUS_ABORT)
+		goto exit;
+
+	if (!test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status)) {
+		iphy_err(drvr, "scan not ready, bsscfgidx=%d\n",
+			 ifp->bsscfgidx);
+		return -EPERM;
+	}
+
+	if (status == INFF_E_STATUS_PARTIAL) {
+		inff_dbg(SCAN, "ESCAN Partial result\n");
+		if (e->datalen < sizeof(*escan_result_le)) {
+			iphy_err(drvr, "invalid event data length\n");
+			goto exit;
+		}
+		escan_result_le = (struct inff_escan_result_le *)data;
+		if (!escan_result_le) {
+			iphy_err(drvr, "Invalid escan result (NULL pointer)\n");
+			goto exit;
+		}
+		escan_buflen = le32_to_cpu(escan_result_le->buflen);
+		if (escan_buflen > INFF_ESCAN_BUF_SIZE ||
+		    escan_buflen > e->datalen ||
+		    escan_buflen < sizeof(*escan_result_le)) {
+			iphy_err(drvr, "Invalid escan buffer length: %d\n",
+				 escan_buflen);
+			goto exit;
+		}
+		if (le16_to_cpu(escan_result_le->bss_count) != 1) {
+			iphy_err(drvr, "Invalid bss_count %d: ignoring\n",
+				 escan_result_le->bss_count);
+			goto exit;
+		}
+		bss_info_le = &escan_result_le->bss_info_le;
+
+		if (inff_p2p_scan_finding_common_channel(cfg, bss_info_le))
+			goto exit;
+
+		if (!cfg->int_escan_map && !cfg->scan_request) {
+			inff_dbg(SCAN, "result without cfg80211 request\n");
+			goto exit;
+		}
+
+		bi_length = le32_to_cpu(bss_info_le->length);
+		if (bi_length != escan_buflen -	WL_ESCAN_RESULTS_FIXED_SIZE) {
+			iphy_err(drvr, "Ignoring invalid bss_info length: %d\n",
+				 bi_length);
+			goto exit;
+		}
+
+		if (!(cfg->wiphy->interface_modes &
+		      BIT(NL80211_IFTYPE_ADHOC))) {
+			if (le16_to_cpu(bss_info_le->capability) &
+						WLAN_CAPABILITY_IBSS) {
+				iphy_err(drvr, "Ignoring IBSS result\n");
+				goto exit;
+			}
+		}
+
+		list = (struct inff_scan_results *)
+				cfg->escan_info.escan_buf;
+
+		if (bi_length > INFF_ESCAN_BUF_SIZE - list->buflen) {
+			iphy_err(drvr, "Buffer is too small: ignoring\n");
+			goto exit;
+		}
+
+		for (i = 0; i < list->count; i++) {
+			bss = bss ? (struct inff_bss_info_le *)
+				((unsigned char *)bss +
+				le32_to_cpu(bss->length)) : list->bss_info_le;
+			if (inff_compare_update_same_bss(cfg, bss,
+							 bss_info_le))
+				goto exit;
+		}
+		memcpy(&cfg->escan_info.escan_buf[list->buflen], bss_info_le,
+		       bi_length);
+		list->version = le32_to_cpu(bss_info_le->version);
+		list->buflen += bi_length;
+		list->count++;
+	} else {
+		cfg->escan_info.escan_state = WL_ESCAN_STATE_IDLE;
+		if (inff_p2p_scan_finding_common_channel(cfg, NULL))
+			goto exit;
+		if (cfg->int_escan_map || cfg->scan_request) {
+			inff_inform_bss(cfg);
+			aborted = status != INFF_E_STATUS_SUCCESS;
+			inff_notify_escan_complete(cfg, ifp, aborted, false);
+		} else {
+			inff_dbg(SCAN, "Ignored scan complete result 0x%x\n",
+				 status);
+		}
+	}
+exit:	return 0;
+}
+
+static void inff_cfg80211_escan_timeout_worker(struct wiphy *wiphy,
+					       struct wiphy_work *work)
+{
+	struct inff_cfg80211_info *cfg =
+			container_of(work, struct inff_cfg80211_info,
+				     escan_timeout_work.work);
+
+	lockdep_assert_wiphy(wiphy);
+
+	if (cfg->int_escan_map || cfg->scan_request) {
+		iphy_err(cfg->pub, "ESCAN Request timed out\n");
+		inff_inform_bss(cfg);
+		inff_notify_escan_complete(cfg, cfg->escan_info.ifp, true, true);
+	}
+}
+
+int inff_init_escan(struct inff_cfg80211_info *cfg)
+{
+	cfg->scan_request = NULL;
+
+	cfg->escan_info.escan_buf = kzalloc(INFF_ESCAN_BUF_SIZE, GFP_KERNEL);
+	if (!cfg->escan_info.escan_buf)
+		return -ENOMEM;
+
+	inff_fwevt_register(cfg->pub, INFF_E_ESCAN_RESULT,
+			    inff_cfg80211_escan_handler);
+	cfg->escan_info.escan_state = WL_ESCAN_STATE_IDLE;
+
+	/* Init scan timeout delayed work */
+	wiphy_delayed_work_init(&cfg->escan_timeout_work,
+				inff_cfg80211_escan_timeout_worker);
+
+	return 0;
+}
+
+void inff_deinit_escan(struct inff_cfg80211_info *cfg)
+{
+	kfree(cfg->escan_info.escan_buf);
+	cfg->escan_info.escan_buf = NULL;
+
+	inff_abort_scanning(cfg);
+
+	wiphy_delayed_work_cancel(cfg->wiphy, &cfg->escan_timeout_work);
+}
+
+void inff_scan_params_v2_to_v1(struct inff_scan_params_v2_le *params_v2_le,
+			       struct inff_scan_params_le *params_le)
+{
+	size_t params_size;
+	u32 ch;
+	int n_channels, n_ssids;
+
+	memcpy(&params_le->ssid_le, &params_v2_le->ssid_le,
+	       sizeof(params_le->ssid_le));
+	memcpy(&params_le->bssid, &params_v2_le->bssid,
+	       sizeof(params_le->bssid));
+
+	params_le->bss_type = params_v2_le->bss_type;
+	params_le->scan_type = le32_to_cpu(params_v2_le->scan_type);
+	params_le->nprobes = params_v2_le->nprobes;
+	params_le->active_time = params_v2_le->active_time;
+	params_le->passive_time = params_v2_le->passive_time;
+	params_le->home_time = params_v2_le->home_time;
+	params_le->channel_num = params_v2_le->channel_num;
+
+	ch = le32_to_cpu(params_v2_le->channel_num);
+	n_channels = ch & INFF_SCAN_PARAMS_COUNT_MASK;
+	n_ssids = ch >> INFF_SCAN_PARAMS_NSSID_SHIFT;
+
+	params_size = sizeof(u16) * n_channels;
+	if (n_ssids > 0) {
+		params_size = roundup(params_size, sizeof(u32));
+		params_size += sizeof(struct inff_ssid_le) * n_ssids;
+	}
+
+	memcpy(&params_le->channel_list[0],
+	       &params_v2_le->channel_list[0], params_size);
+}
+
+struct cfg80211_scan_request *
+inff_alloc_internal_escan_request(struct wiphy *wiphy, u32 n_netinfo)
+{
+	struct cfg80211_scan_request *req;
+	size_t req_size;
+	size_t size_sanity = ~0;
+
+	if (n_netinfo > ((size_sanity - sizeof(*req)) /
+			(sizeof(req->channels[0]) + sizeof(*req->ssids)))) {
+		inff_err("requesting a huge count:%d\n", n_netinfo);
+		return NULL;
+	}
+
+	req_size = sizeof(*req) +
+		   n_netinfo * sizeof(req->channels[0]) +
+		   n_netinfo * sizeof(*req->ssids);
+
+	req = kzalloc(req_size, GFP_KERNEL);
+	if (req) {
+		req->wiphy = wiphy;
+		req->ssids = (void *)(&req->channels[0]) +
+			     n_netinfo * sizeof(req->channels[0]);
+	}
+	return req;
+}
+
+void inff_scan_config_mpc(struct inff_if *ifp, int mpc)
+{
+	if (inff_feat_is_quirk_enabled(ifp, INFF_FEAT_QUIRK_NEED_MPC))
+		inff_set_mpc(ifp, mpc);
+}
+
+s32 inff_notify_escan_complete(struct inff_cfg80211_info *cfg,
+			       struct inff_if *ifp, bool aborted,
+				bool fw_abort)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_scan_params_v2_le params_v2_le;
+	struct cfg80211_scan_request *scan_request;
+	s32 err = 0;
+
+	/* clear scan request, because the FW abort can cause a second call */
+	/* to this functon and might cause a double cfg80211_scan_done      */
+	scan_request = cfg->scan_request;
+	cfg->scan_request = NULL;
+
+	wiphy_delayed_work_cancel(cfg->wiphy, &cfg->escan_timeout_work);
+
+	if (fw_abort) {
+		/* Do a scan abort to stop the driver's scan engine */
+		inff_dbg(SCAN, "ABORT scan in firmware\n");
+
+		inff_escan_prep(cfg, &params_v2_le, NULL);
+
+		/* E-Scan (or anyother type) can be aborted by SCAN */
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_SCAN_V2)) {
+			err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SCAN,
+						      &params_v2_le,
+						      sizeof(params_v2_le));
+		} else {
+			struct inff_scan_params_le params_le;
+
+			inff_scan_params_v2_to_v1(&params_v2_le, &params_le);
+			err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SCAN,
+						      &params_le,
+						      sizeof(params_le));
+		}
+
+		if (err)
+			iphy_err(drvr, "Scan abort failed\n");
+	}
+
+	inff_scan_config_mpc(ifp, 1);
+
+	if (scan_request) {
+		struct cfg80211_scan_info info = {
+			.aborted = aborted,
+		};
+
+		inff_dbg(SCAN, "ESCAN Completed scan: %s\n",
+			 aborted ? "Aborted" : "Done");
+		cfg80211_scan_done(scan_request, &info);
+	}
+	if (!test_and_clear_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status))
+		inff_dbg(SCAN, "Scan complete, probably P2P scan\n");
+
+	return err;
+}
+
+int inff_internal_escan_add_info(struct cfg80211_scan_request *req,
+				 u8 *ssid, u8 ssid_len, u8 channel)
+{
+	struct ieee80211_channel *chan;
+	enum nl80211_band band;
+	int freq, i;
+
+	if (channel <= CH_MAX_2G_CHANNEL)
+		band = NL80211_BAND_2GHZ;
+	else
+		band = NL80211_BAND_5GHZ;
+
+	freq = ieee80211_channel_to_frequency(channel, band);
+	if (!freq)
+		return -EINVAL;
+
+	chan = ieee80211_get_channel(req->wiphy, freq);
+	if (!chan)
+		return -EINVAL;
+
+	for (i = 0; i < req->n_channels; i++) {
+		if (req->channels[i] == chan)
+			break;
+	}
+	if (i == req->n_channels) {
+		req->n_channels++;
+		req->channels[i] = chan;
+	}
+
+	for (i = 0; i < req->n_ssids; i++) {
+		if (req->ssids[i].ssid_len == ssid_len &&
+		    !memcmp(req->ssids[i].ssid, ssid, ssid_len))
+			break;
+	}
+	if (i == req->n_ssids) {
+		memcpy(req->ssids[req->n_ssids].ssid, ssid, ssid_len);
+		req->ssids[req->n_ssids++].ssid_len = ssid_len;
+	}
+	return 0;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/scan.h b/drivers/net/wireless/infineon/inffmac/scan.h
new file mode 100644
index 000000000000..fb10dd4d4e0a
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/scan.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_SCAN_H
+#define INFF_SCAN_H
+
+#define INFF_SCAN_IE_LEN_MAX            2048
+
+#define INFF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS             320
+#define INFF_SCAN_JOIN_PASSIVE_DWELL_TIME_MS            400
+#define INFF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS_6E          80
+#define INFF_SCAN_JOIN_PASSIVE_DWELL_TIME_MS_6E 130
+#define INFF_SCAN_JOIN_PROBE_INTERVAL_MS        20
+
+#define INFF_SCAN_CHANNEL_TIME          40
+#define INFF_SCAN_UNASSOC_TIME          40
+#define INFF_SCAN_PASSIVE_TIME          120
+
+/* Dump obss definitions */
+#define ACS_MSRMNT_DELAY                80
+#define CHAN_NOISE_DUMMY                (-80)
+#define OBSS_TOKEN_IDX                  15
+#define IBSS_TOKEN_IDX                  15
+#define TX_TOKEN_IDX                    14
+#define CTG_TOKEN_IDX                   13
+#define PKT_TOKEN_IDX                   15
+#define IDLE_TOKEN_IDX                  12
+
+/* Keep SCAN_BUF_SIZE below 64K (65536). Allocing over 64K can be
+ * problematic on some systems and should be avoided.
+ */
+#define INFF_SCAN_BUF_SIZE		65000
+#define INFF_ESCAN_BUF_SIZE		65000
+#define INFF_ESCAN_TIMER_INTERVAL_MS	10000	/* E-Scan timeout */
+
+#define WL_ESCAN_ACTION_START		1
+#define WL_ESCAN_ACTION_CONTINUE	2
+#define WL_ESCAN_ACTION_ABORT		3
+
+/**
+ * enum inff_scan_status - scan engine status
+ *
+ * @INFF_SCAN_STATUS_BUSY: scanning in progress on dongle.
+ * @INFF_SCAN_STATUS_ABORT: scan being aborted on dongle.
+ * @INFF_SCAN_STATUS_SUPPRESS: scanning is suppressed in driver.
+ */
+enum inff_scan_status {
+	INFF_SCAN_STATUS_BUSY,
+	INFF_SCAN_STATUS_ABORT,
+	INFF_SCAN_STATUS_SUPPRESS,
+};
+
+/* dongle escan state */
+enum wl_escan_state {
+	WL_ESCAN_STATE_IDLE,
+	WL_ESCAN_STATE_SCANNING
+};
+
+struct inff_dump_survey {
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
+	char buf[];
+};
+
+struct cca_msrmnt_query {
+	u32 msrmnt_query;
+	u32 time_req;
+};
+
+enum cca_survey_config {
+	CCA_SURVEY_READ_CLEAR = 1,	/* previous data only */
+	CCA_SURVEY_READ = 2,		/* sum for each of data */
+	CCA_SURVEY_RESET = 3,		/* Set for each of data */
+};
+
+struct cca_survey {
+	u32 usecs;   /**< millisecs spent sampling this channel */
+	u32 ibss;    /**< millisecs spent ibss */
+	u32 obss;    /**< millisecs spent obss */
+	u32 txdur;   /**< millisecs spent txdur */
+	u32 noctg;   /**< millisecs spent 802.11 of unknown type */
+	u32 nopkt;   /**< millisecs spent non 802.11 */
+	u32 PM;      /**< usecs MAC spent in doze mode for PM */
+};
+
+struct cca_survey_req {
+	u16 chanspec;    /**< Which channel? */
+	u16 num_secs;	/**< How many secs worth of data */
+	struct cca_survey  secs[1];  /**< Data */
+	enum cca_survey_config config;     /**< enum */
+};
+
+/**
+ * BSS info structure
+ * Applications MUST CHECK ie_offset field and length field to access IEs and
+ * next bss_info structure in a vector (in struct inff_scan_results)
+ */
+struct inff_cp_bss_info {
+	/* byte length of data in this record, starting at version and including IEs */
+	u32    length;
+	/* SSID length */
+	u8     ssid_length;
+	/* SSID of the access point */
+	char   ssid[IEEE80211_MAX_SSID_LEN + 1];
+	/* MAC Address of the access point */
+	u8     macaddr[ETH_ALEN];
+	/* signal strength */
+	s16    signal_strength;
+	/* channel number */
+	u8     channel;
+	/* WiFi band of access point */
+	u8     band;
+	/* Interval b/w two consecutive beacon frames. Units are Kusec */
+	u16    beacon_period;
+	/* Capability information */
+	u16    capability;
+	/* Length of the IE.  */
+	u32    ie_len;
+};
+
+struct inff_scan_info {
+	struct wiphy *wiphy;
+	struct cfg80211_scan_request *request;
+	u32 bss_count;
+	u8 *bss_buf;
+	u32 used_buf_len;
+};
+
+struct escan_info {
+	u32 escan_state;
+	u8 *escan_buf;
+	struct wiphy *wiphy;
+	struct inff_if *ifp;
+	s32 (*run)(struct inff_cfg80211_info *cfg, struct inff_if *ifp,
+		   struct cfg80211_scan_request *request);
+};
+
+int inff_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
+			      int idx, struct survey_info *info);
+
+int inff_cfg80211_dump_survey_2(struct wiphy *wiphy, struct net_device *ndev,
+				int idx, struct survey_info *info);
+
+s32 inff_dongle_scantime(struct inff_if *ifp);
+
+s32 inff_run_escan(struct inff_cfg80211_info *cfg, struct inff_if *ifp,
+		   struct cfg80211_scan_request *request);
+
+s32 inff_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request);
+
+int inff_start_internal_escan(struct inff_if *ifp, u32 fwmap,
+			      struct cfg80211_scan_request *request);
+
+void inff_escan_prep(struct inff_cfg80211_info *cfg,
+		     struct inff_scan_params_v2_le *params_le,
+		     struct cfg80211_scan_request *request);
+
+int inff_init_escan(struct inff_cfg80211_info *cfg);
+void inff_deinit_escan(struct inff_cfg80211_info *cfg);
+
+int inff_cfg80211_sched_scan_stop(struct wiphy *wiphy,
+				  struct net_device *ndev, u64 reqid);
+
+int inff_cfg80211_sched_scan_start(struct wiphy *wiphy,
+				   struct net_device *ndev,
+				   struct cfg80211_sched_scan_request *req);
+
+void inff_scan_params_v2_to_v1(struct inff_scan_params_v2_le *params_v2_le,
+			       struct inff_scan_params_le *params_le);
+
+struct cfg80211_scan_request *inff_alloc_internal_escan_request(struct wiphy *wiphy, u32 n_netinfo);
+
+int inff_internal_escan_add_info(struct cfg80211_scan_request *req,
+				 u8 *ssid, u8 ssid_len, u8 channel);
+
+s32 inff_notify_escan_complete(struct inff_cfg80211_info *cfg,
+			       struct inff_if *ifp, bool aborted,
+			       bool fw_abort);
+void inff_scan_config_mpc(struct inff_if *ifp, int mpc);
+void inff_abort_scanning(struct inff_cfg80211_info *cfg);
+
+int
+inff_cp_scan_init(struct inff_cfg80211_info *cfg);
+int
+inff_cp_scan_start(struct inff_scan_info *scan, struct cfg80211_scan_request *request);
+int
+inff_cp_scan_event_handler(struct inff_scan_info *scan, struct inff_cpevt_scan *result);
+void inff_cp_scan_abort(struct inff_scan_info *scan);
+#endif /* INFF_SCAN_H */
-- 
2.25.1


