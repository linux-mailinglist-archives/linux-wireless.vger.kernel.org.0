Return-Path: <linux-wireless+bounces-30771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 781BAD1B408
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A93530754F3
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF092BCF6C;
	Tue, 13 Jan 2026 20:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="mlE982bP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B3276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336691; cv=none; b=LgKL/MCccF9J6EODt2ZCusDHMCcXiJp67UAPyLDs14L0HW759tgvP3e/HdQCZ6wewaN1kX7T5i9Ui89cbVX7eag8GgMPdQM1MNLZ0VD/I0z6fwRrDc7J4svlHHTD/nPZXtQXiUDGJ/4tA6C1HxTwWMNIyVBEaqfTCzTuQAX2QKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336691; c=relaxed/simple;
	bh=8DUVEbBnvUJRmbvEODrLya6jwcGVIGDpnZbFD7+V3yQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HykCT6cBoE31PmUxiJ5T9Ymos6+bi5ADWXgDN7qDGuYzWu4e/5p9j2woyH0OuML1APip06To/nyE+FmHjl3RMCM3wk44MJljXNAeUt3qGxQunX8odGq3b9RffcLoDr3cd62kbV2NA/VS2FhCjAb0/l2LQJUs3mFX8BsSIlQ+51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=mlE982bP; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336685; x=1799872685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8DUVEbBnvUJRmbvEODrLya6jwcGVIGDpnZbFD7+V3yQ=;
  b=mlE982bP/aNcSV089WFw1ziaa5VIHCAl0WMU6gYt7qZ1HuTM6YHmVhEI
   0zLoPF3otHFmveFjrqq1EYs5QczvLYkAU9StpBhySwz/tS12U82ZuRguv
   bYLVqfx0kq6lu73JBExbWmHEG3uZZphjcnphmHiB0glby1VneCIVbg4WI
   k=;
X-CSE-ConnectionGUID: 9f+zyXbXSNSH9q+KofO8Sw==
X-CSE-MsgGUID: SPAtDqwXQf+1BO//d53A2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568409"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568409"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:38:03 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:38:02 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:37:59 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 16/34] wifi: inffmac: add cfg80211.c/h
Date: Wed, 14 Jan 2026 02:03:29 +0530
Message-ID: <20260113203350.16734-17-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Integrate the driver with cfg80211 subsystem. Also define the cfg80211 ops
and driver functions that utilize the cfg80211 callbacks for notifications.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/cfg80211.c  | 4984 +++++++++++++++++
 .../net/wireless/infineon/inffmac/cfg80211.h  |  346 ++
 2 files changed, 5330 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/cfg80211.h

diff --git a/drivers/net/wireless/infineon/inffmac/cfg80211.c b/drivers/net/wireless/infineon/inffmac/cfg80211.c
new file mode 100644
index 000000000000..e0817feb1845
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/cfg80211.c
@@ -0,0 +1,4984 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/etherdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <net/cfg80211.h>
+#include <net/netlink.h>
+
+#include "main.h"
+#include "net.h"
+#include "cfg80211.h"
+#include "utils.h"
+#include "debug.h"
+#include "bus_proto.h"
+#include "dev_cmd.h"
+#include "interface.h"
+#include "fwsignal.h"
+#include "p2p.h"
+#include "feature.h"
+#include "vendor.h"
+#include "he.h"
+#include "twt.h"
+#include "pmsr.h"
+
+#define MGMT_AUTH_FRAME_DWELL_TIME	4000
+#define MGMT_AUTH_FRAME_WAIT_TIME	(MGMT_AUTH_FRAME_DWELL_TIME + 100)
+
+#define INFF_ASSOC_PARAMS_FIXED_SIZE \
+	(sizeof(struct inff_assoc_params_le) - sizeof(u16))
+
+/* This is to override regulatory domains defined in cfg80211 module (reg.c)
+ * By default world regulatory domain defined in reg.c puts the flags
+ * NL80211_RRF_NO_IR for 5GHz channels (for * 36..48 and 149..165).
+ * With respect to these flags, wpa_supplicant doesn't * start p2p
+ * operations on 5GHz channels. All the changes in world regulatory
+ * domain are to be done here.
+ */
+static const struct ieee80211_regdomain inff_regdom = {
+	.n_reg_rules = 5,
+	.alpha2 =  "99",
+	.reg_rules = {
+		/* IEEE 802.11b/g, channels 1..11 */
+		REG_RULE(2412 - 10, 2472 + 10, 40, 6, 20, 0),
+		/* If any */
+		/* IEEE 802.11 channel 14 - Only JP enables
+		 * this and for 802.11b only
+		 */
+		REG_RULE(2484 - 10, 2484 + 10, 20, 6, 20, 0),
+		/* IEEE 802.11a, channel 36..64 */
+		REG_RULE(5150 - 10, 5350 + 10, 160, 6, 20, 0),
+		/* IEEE 802.11a, channel 100..165 */
+		REG_RULE(5470 - 10, 5850 + 10, 160, 6, 20, 0),
+		/* IEEE 802.11ax, 6E */
+		REG_RULE(5935 - 10, 7115 + 10, 160, 6, 20, 0),
+	}
+};
+
+/* Note: inff_cipher_suites is an array of int defining which cipher suites
+ * are supported. A pointer to this array and the number of entries is passed
+ * on to upper layers. AES_CMAC defines whether or not the driver supports MFP.
+ * So the cipher suite AES_CMAC has to be the last one in the array, and when
+ * device does not support MFP then the number of suites will be decreased by 4
+ */
+static const u32 inff_cipher_suites[] = {
+	WLAN_CIPHER_SUITE_WEP40,
+	WLAN_CIPHER_SUITE_WEP104,
+	WLAN_CIPHER_SUITE_TKIP,
+	WLAN_CIPHER_SUITE_CCMP,
+	WLAN_CIPHER_SUITE_CCMP_256,
+	WLAN_CIPHER_SUITE_GCMP,
+	WLAN_CIPHER_SUITE_GCMP_256,
+	/* Keep as last entry: */
+	WLAN_CIPHER_SUITE_AES_CMAC,
+	WLAN_CIPHER_SUITE_BIP_CMAC_256,
+	WLAN_CIPHER_SUITE_BIP_GMAC_128,
+	WLAN_CIPHER_SUITE_BIP_GMAC_256
+};
+
+static void
+inff_fill_bss_param(struct inff_if *ifp, struct station_info *si)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct {
+		__le32 len;
+		struct inff_bss_info_le bss_le;
+	} *buf;
+	u16 capability;
+	int err;
+
+	buf = kzalloc(WL_BSS_INFO_MAX, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	buf->len = cpu_to_le32(WL_BSS_INFO_MAX);
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BSS_INFO, buf,
+				      WL_BSS_INFO_MAX);
+	if (err) {
+		iphy_err(drvr, "Failed to get bss info (%d)\n", err);
+		goto out_kfree;
+	}
+	si->filled |= BIT_ULL(NL80211_STA_INFO_BSS_PARAM);
+	si->bss_param.beacon_interval = le16_to_cpu(buf->bss_le.beacon_period);
+	si->bss_param.dtim_period = buf->bss_le.dtim_period;
+	capability = le16_to_cpu(buf->bss_le.capability);
+	if (capability & IEEE80211_HT_STBC_PARAM_DUAL_CTS_PROT)
+		si->bss_param.flags |= BSS_PARAM_FLAGS_CTS_PROT;
+	if (capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
+		si->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_PREAMBLE;
+	if (capability & WLAN_CAPABILITY_SHORT_SLOT_TIME)
+		si->bss_param.flags |= BSS_PARAM_FLAGS_SHORT_SLOT_TIME;
+
+out_kfree:
+	kfree(buf);
+}
+
+s32
+inff_inform_single_bss(struct inff_cfg80211_info *cfg,
+		       struct inff_bss_info_le *bi)
+{
+	struct wiphy *wiphy = cfg->wiphy;
+	struct inff_pub *drvr = cfg->pub;
+	struct cfg80211_bss *bss;
+	enum nl80211_band band;
+	struct inff_chan ch;
+	u16 channel;
+	u32 freq;
+	u16 notify_capability;
+	u16 notify_interval;
+	u8 *notify_ie;
+	size_t notify_ielen;
+	struct cfg80211_inform_bss bss_data = {};
+	const struct inff_tlv *ssid = NULL;
+
+	if (le32_to_cpu(bi->length) > WL_BSS_INFO_MAX) {
+		iphy_err(drvr, "Bss info is larger than buffer. Discarding\n");
+		return -EINVAL;
+	}
+
+	ch.chspec = le16_to_cpu(bi->chanspec);
+	inff_chan_decchspec(&ch);
+
+	if (!bi->ctl_ch)
+		bi->ctl_ch = ch.control_ch_num;
+
+	channel = bi->ctl_ch;
+	band = inff_chan_band_to_nl80211(ch.band);
+
+	freq = ieee80211_channel_to_frequency(channel, band);
+	if (!freq)
+		return -EINVAL;
+
+	bss_data.chan = ieee80211_get_channel(wiphy, freq);
+	if (!bss_data.chan)
+		return -EINVAL;
+
+	bss_data.boottime_ns = ktime_to_ns(ktime_get_boottime());
+
+	notify_capability = le16_to_cpu(bi->capability);
+	notify_interval = le16_to_cpu(bi->beacon_period);
+	notify_ie = (u8 *)bi + le16_to_cpu(bi->ie_offset);
+	notify_ielen = le32_to_cpu(bi->ie_length);
+	bss_data.signal = (s16)le16_to_cpu(bi->RSSI) * 100;
+
+	ssid = inff_parse_tlvs(notify_ie, notify_ielen, WLAN_EID_SSID);
+	if (ssid && ssid->data[0] == '\0' && ssid->len == bi->SSID_len) {
+		/* Update SSID for hidden AP */
+		memcpy((u8 *)ssid->data, bi->SSID, bi->SSID_len);
+	}
+
+	inff_dbg(CONN, "bssid: %pM\n", bi->BSSID);
+	inff_dbg(CONN, "Channel: %d(%d)\n", channel, freq);
+	inff_dbg(CONN, "Capability: %X\n", notify_capability);
+	inff_dbg(CONN, "Beacon interval: %d\n", notify_interval);
+	inff_dbg(CONN, "Signal: %d\n", bss_data.signal);
+
+	bss = cfg80211_inform_bss_data(wiphy, &bss_data,
+				       CFG80211_BSS_FTYPE_PRESP,
+				       (const u8 *)bi->BSSID,
+				       0, notify_capability,
+				       notify_interval, notify_ie,
+				       notify_ielen, GFP_KERNEL);
+
+	if (!bss)
+		return -ENOMEM;
+
+	cfg80211_put_bss(wiphy, bss);
+
+	return 0;
+}
+
+static struct inff_bss_info_le *
+next_bss_le(struct inff_scan_results *list, struct inff_bss_info_le *bss)
+{
+	if (!bss)
+		return list->bss_info_le;
+	return (struct inff_bss_info_le *)((unsigned long)bss +
+					    le32_to_cpu(bss->length));
+}
+
+s32
+inff_inform_bss(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_scan_results *bss_list;
+	struct inff_bss_info_le *bi = NULL;	/* must be initialized */
+	s32 err = 0;
+	int i;
+
+	bss_list = (struct inff_scan_results *)cfg->escan_info.escan_buf;
+	if (bss_list->count != 0 &&
+	    bss_list->version != INFF_BSS_INFO_VERSION) {
+		iphy_err(drvr, "Version %d != WL_BSS_INFO_VERSION\n",
+			 bss_list->version);
+		return -EOPNOTSUPP;
+	}
+
+	inff_dbg(SCAN, "scanned AP count (%d)\n", bss_list->count);
+	for (i = 0; i < bss_list->count; i++) {
+		bi = next_bss_le(bss_list, bi);
+		err = inff_inform_single_bss(cfg, bi);
+		if (err)
+			break;
+	}
+	return err;
+}
+
+s32
+inff_inform_ibss(struct inff_cfg80211_info *cfg,
+		 struct net_device *ndev, const u8 *bssid)
+{
+	struct wiphy *wiphy = cfg->wiphy;
+	struct inff_pub *drvr = cfg->pub;
+	struct ieee80211_channel *notify_channel;
+	struct inff_bss_info_le *bi = NULL;
+	struct ieee80211_supported_band *band;
+	struct cfg80211_bss *bss;
+	struct inff_chan ch;
+	u8 *buf = NULL;
+	s32 err = 0;
+	u32 freq;
+	u16 notify_capability;
+	u16 notify_interval;
+	u8 *notify_ie;
+	size_t notify_ielen;
+	s32 notify_signal;
+
+	buf = kzalloc(WL_BSS_INFO_MAX, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	*(__le32 *)buf = cpu_to_le32(WL_BSS_INFO_MAX);
+
+	err = inff_fwcmd_cmd_data_get(netdev_priv(ndev), INFF_C_GET_BSS_INFO,
+				      buf, WL_BSS_INFO_MAX);
+	if (err) {
+		iphy_err(drvr, "WLC_GET_BSS_INFO failed: %d\n", err);
+		goto cleanup;
+	}
+
+	bi = (struct inff_bss_info_le *)(buf + 4);
+
+	ch.chspec = le16_to_cpu(bi->chanspec);
+	inff_chan_decchspec(&ch);
+
+	band = wiphy->bands[inff_chan_band_to_nl80211(ch.band)];
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band->band);
+	if (!freq) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+	cfg->channel = freq;
+	notify_channel = ieee80211_get_channel(wiphy, freq);
+	if (!notify_channel) {
+		err = -EINVAL;
+		goto cleanup;
+	}
+
+	notify_capability = le16_to_cpu(bi->capability);
+	notify_interval = le16_to_cpu(bi->beacon_period);
+	notify_ie = (u8 *)bi + le16_to_cpu(bi->ie_offset);
+	notify_ielen = le32_to_cpu(bi->ie_length);
+	notify_signal = (s16)le16_to_cpu(bi->RSSI) * 100;
+
+	inff_dbg(CONN, "channel: %d(%d)\n", ch.control_ch_num, freq);
+	inff_dbg(CONN, "capability: %X\n", notify_capability);
+	inff_dbg(CONN, "beacon interval: %d\n", notify_interval);
+	inff_dbg(CONN, "signal: %d\n", notify_signal);
+
+	bss = cfg80211_inform_bss(wiphy, notify_channel,
+				  CFG80211_BSS_FTYPE_UNKNOWN, bssid, 0,
+				  notify_capability, notify_interval,
+				  notify_ie, notify_ielen, notify_signal,
+				  GFP_KERNEL);
+
+	if (!bss) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+
+	cfg80211_put_bss(wiphy, bss);
+
+cleanup:
+
+	kfree(buf);
+
+	return err;
+}
+
+static const struct inff_bss_info_le *
+inff_update_bss_info(struct inff_cfg80211_info *cfg, struct inff_if *ifp)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_bss_info_le *bi = NULL;
+	s32 err = 0;
+	u8 null_mac[6] = {0};
+
+	if (inff_vif_is_ibssmode(ifp->vif))
+		return NULL;
+
+	*(__le32 *)cfg->extra_buf = cpu_to_le32(WL_EXTRA_BUF_MAX);
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BSS_INFO,
+				      cfg->extra_buf, WL_EXTRA_BUF_MAX);
+	if (err) {
+		iphy_err(drvr, "Could not get bss info %d\n", err);
+		goto update_bss_info_out;
+	}
+	bi = (struct inff_bss_info_le *)(cfg->extra_buf + 4);
+
+	if (!memcmp(null_mac, bi->BSSID, ETH_ALEN)) {
+		iphy_err(drvr, "NULL mac, don't update bss\n");
+		goto update_bss_info_out;
+	}
+
+	err = inff_inform_single_bss(cfg, bi);
+
+	return bi;
+
+update_bss_info_out:
+	return NULL;
+}
+
+s32
+inff_compare_update_same_bss(struct inff_cfg80211_info *cfg,
+			     struct inff_bss_info_le *bss,
+			      struct inff_bss_info_le *bss_info_le)
+{
+	struct inff_chan ch_bss, ch_bss_info_le;
+
+	ch_bss.chspec = le16_to_cpu(bss->chanspec);
+	inff_chan_decchspec(&ch_bss);
+	ch_bss_info_le.chspec = le16_to_cpu(bss_info_le->chanspec);
+	inff_chan_decchspec(&ch_bss_info_le);
+
+	if (!memcmp(&bss_info_le->BSSID, &bss->BSSID, ETH_ALEN) &&
+	    ch_bss.band == ch_bss_info_le.band &&
+	    bss_info_le->SSID_len == bss->SSID_len &&
+	    !memcmp(bss_info_le->SSID, bss->SSID, bss_info_le->SSID_len)) {
+		if ((bss->flags & INFF_BSS_RSSI_ON_CHANNEL) ==
+			(bss_info_le->flags & INFF_BSS_RSSI_ON_CHANNEL)) {
+			s16 bss_rssi = le16_to_cpu(bss->RSSI);
+			s16 bss_info_rssi = le16_to_cpu(bss_info_le->RSSI);
+
+			/* preserve max RSSI if the measurements are
+			 * both on-channel or both off-channel
+			 */
+			if (bss_info_rssi > bss_rssi)
+				bss->RSSI = bss_info_le->RSSI;
+		} else if ((bss->flags & INFF_BSS_RSSI_ON_CHANNEL) &&
+			(bss_info_le->flags & INFF_BSS_RSSI_ON_CHANNEL) == 0) {
+			/* preserve the on-channel rssi measurement
+			 * if the new measurement is off channel
+			 */
+			bss->RSSI = bss_info_le->RSSI;
+			bss->flags |= INFF_BSS_RSSI_ON_CHANNEL;
+		}
+		return 1;
+	}
+	return 0;
+}
+
+s32
+inff_bss_roaming_done(struct inff_cfg80211_info *cfg,
+		      struct net_device *ndev,
+		      const struct inff_event_msg *e)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+	struct wiphy *wiphy = cfg->wiphy;
+	struct ieee80211_channel *notify_channel = NULL;
+	struct ieee80211_supported_band *band;
+	struct inff_bss_info_le *bi;
+	struct inff_chan ch;
+	struct cfg80211_roam_info roam_info = {};
+	u32 freq;
+	s32 err = 0;
+
+	inff_get_assoc_ies(cfg, ifp);
+	memcpy(profile->bssid, e->addr, ETH_ALEN);
+	bi = (struct inff_bss_info_le *)inff_update_bss_info(cfg, ifp);
+	if (!bi)
+		goto done;
+
+	ch.chspec = le16_to_cpu(bi->chanspec);
+	inff_chan_decchspec(&ch);
+
+	band = wiphy->bands[inff_chan_band_to_nl80211(ch.band)];
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band->band);
+	if (!freq)
+		err = -EINVAL;
+	notify_channel = ieee80211_get_channel(wiphy, freq);
+	if (!notify_channel)
+		err = -EINVAL;
+
+done:
+
+	roam_info.links[0].channel = notify_channel;
+	roam_info.links[0].bssid = profile->bssid;
+	roam_info.req_ie = conn_info->req_ie;
+	roam_info.req_ie_len = conn_info->req_ie_len;
+	roam_info.resp_ie = conn_info->resp_ie;
+	roam_info.resp_ie_len = conn_info->resp_ie_len;
+
+	cfg80211_roamed(ndev, &roam_info, GFP_KERNEL);
+	inff_dbg(CONN, "Report roaming result\n");
+
+	if (((profile->use_fwsup == INFF_PROFILE_FWSUP_1X ||
+	      profile->use_fwsup == INFF_PROFILE_FWSUP_ROAM) &&
+	    (inff_has_pmkid(roam_info.req_ie, roam_info.req_ie_len, NULL) ||
+	     profile->is_ft || profile->is_okc)) ||
+	     profile->use_fwsup == INFF_PROFILE_FWSUP_PSK ||
+	     profile->use_fwsup == INFF_PROFILE_FWSUP_SAE) {
+		cfg80211_port_authorized(ndev, profile->bssid, NULL, 0, GFP_KERNEL);
+		inff_dbg(CONN, "Report port authorized\n");
+	}
+
+	clear_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	set_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state);
+	return err;
+}
+
+s32
+inff_bss_connect_done(struct inff_cfg80211_info *cfg,
+		      struct net_device *ndev, const struct inff_event_msg *e,
+		      bool completed)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct inff_cfg80211_connect_info *conn_info = &cfg->conn_info;
+	struct cfg80211_connect_resp_params conn_params;
+
+	if (test_and_clear_bit(INFF_VIF_STATUS_CONNECTING,
+			       &ifp->vif->sme_state)) {
+		memset(&conn_params, 0, sizeof(conn_params));
+		if (completed) {
+			inff_get_assoc_ies(cfg, ifp);
+			inff_update_bss_info(cfg, ifp);
+			set_bit(INFF_VIF_STATUS_CONNECTED,
+				&ifp->vif->sme_state);
+			conn_params.status = WLAN_STATUS_SUCCESS;
+		} else {
+			clear_bit(INFF_VIF_STATUS_EAP_SUCCESS,
+				  &ifp->vif->sme_state);
+			clear_bit(INFF_VIF_STATUS_ASSOC_SUCCESS,
+				  &ifp->vif->sme_state);
+			conn_params.status = WLAN_STATUS_AUTH_TIMEOUT;
+		}
+		conn_params.links[0].bssid = profile->bssid;
+		conn_params.req_ie = conn_info->req_ie;
+		conn_params.req_ie_len = conn_info->req_ie_len;
+		conn_params.resp_ie = conn_info->resp_ie;
+		conn_params.resp_ie_len = conn_info->resp_ie_len;
+
+		cfg80211_connect_done(ndev, &conn_params, GFP_KERNEL);
+		inff_dbg(CONN, "Report connect result\n");
+
+		if ((profile->use_fwsup == INFF_PROFILE_FWSUP_1X &&
+		     inff_has_pmkid(conn_params.req_ie, conn_params.req_ie_len, NULL)) ||
+		     profile->use_fwsup == INFF_PROFILE_FWSUP_PSK ||
+		     profile->use_fwsup == INFF_PROFILE_FWSUP_SAE) {
+			cfg80211_port_authorized(ndev, profile->bssid, NULL, 0, GFP_KERNEL);
+			inff_dbg(CONN, "Report port authorized\n");
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support
+inff_wowlan_support = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = INFF_WOWL_MAXPATTERNS,
+	.pattern_max_len = INFF_WOWL_MAXPATTERNSIZE,
+	.pattern_min_len = 1,
+	.max_pkt_offset = 1500,
+};
+
+static void
+inff_wiphy_wowl_params(struct wiphy *wiphy, struct inff_if *ifp)
+{
+	struct wiphy_wowlan_support *wowl;
+	struct cfg80211_wowlan *inff_wowlan_config = NULL;
+
+	wowl = kmemdup(&inff_wowlan_support, sizeof(inff_wowlan_support),
+		       GFP_KERNEL);
+	if (!wowl) {
+		wiphy->wowlan = &inff_wowlan_support;
+		return;
+	}
+
+	/* for backward compatibility, retain INFF_FEAT_WOWL_GTK */
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL_GTK) ||
+	    inff_feat_is_enabled(ifp, INFF_FEAT_GTKO))
+		wowl->flags |= WIPHY_WOWLAN_SUPPORTS_GTK_REKEY;
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL_GTK))
+		wowl->flags |= WIPHY_WOWLAN_GTK_REKEY_FAILURE;
+
+	wiphy->wowlan = wowl;
+
+	/* wowlan_config structure report for kernels */
+	inff_wowlan_config = kzalloc(sizeof(*inff_wowlan_config),
+				     GFP_KERNEL);
+	if (inff_wowlan_config) {
+		inff_wowlan_config->any = false;
+		inff_wowlan_config->disconnect = true;
+		inff_wowlan_config->eap_identity_req = true;
+		inff_wowlan_config->four_way_handshake = true;
+		inff_wowlan_config->rfkill_release = false;
+		inff_wowlan_config->patterns = NULL;
+		inff_wowlan_config->n_patterns = 0;
+		inff_wowlan_config->tcp = NULL;
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL_GTK))
+			inff_wowlan_config->gtk_rekey_failure = true;
+		else
+			inff_wowlan_config->gtk_rekey_failure = false;
+	} else {
+		inff_err("Can not allocate memory for inff_wowlan_config\n");
+	}
+	wiphy->wowlan_config = inff_wowlan_config;
+}
+
+static void
+inff_report_wowl_wakeind(struct wiphy *wiphy, struct inff_if *ifp)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_wowl_wakeind_le wake_ind_le;
+	struct cfg80211_wowlan_wakeup wakeup_data;
+	struct cfg80211_wowlan_wakeup *wakeup;
+	u32 wakeind;
+	s32 err;
+
+	err = inff_fwcmd_iovar_data_get(ifp, "wowl_wakeind", &wake_ind_le,
+					sizeof(wake_ind_le));
+	if (err) {
+		iphy_err(drvr, "Get wowl_wakeind failed, err = %d\n", err);
+		return;
+	}
+
+	wakeind = le32_to_cpu(wake_ind_le.ucode_wakeind);
+	if (wakeind & (INFF_WOWL_MAGIC | INFF_WOWL_DIS | INFF_WOWL_BCN |
+		       INFF_WOWL_RETR | INFF_WOWL_NET)) {
+		wakeup = &wakeup_data;
+		memset(&wakeup_data, 0, sizeof(wakeup_data));
+		wakeup_data.pattern_idx = -1;
+
+		if (wakeind & INFF_WOWL_MAGIC) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_MAGIC\n");
+			wakeup_data.magic_pkt = true;
+		}
+		if (wakeind & INFF_WOWL_DIS) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_DIS\n");
+			wakeup_data.disconnect = true;
+		}
+		if (wakeind & INFF_WOWL_BCN) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_BCN\n");
+			wakeup_data.disconnect = true;
+		}
+		if (wakeind & INFF_WOWL_RETR) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_RETR\n");
+			wakeup_data.disconnect = true;
+		}
+		if (wakeind & INFF_WOWL_NET) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_NET\n");
+			/* For now always map to pattern 0, no API to get
+			 * correct information available at the moment.
+			 */
+			wakeup_data.pattern_idx = 0;
+		}
+		if (wakeind & INFF_WOWL_GTK_FAILURE) {
+			inff_dbg(INFO, "WOWL Wake indicator: INFF_WOWL_GTK_FAILURE\n");
+			wakeup_data.gtk_rekey_failure = true;
+		}
+	} else {
+		wakeup = NULL;
+	}
+	cfg80211_report_wowlan_wakeup(&ifp->vif->wdev, wakeup, GFP_KERNEL);
+}
+
+#endif /* CONFIG_PM */
+
+static s32
+inff_config_wowl_pattern(struct inff_if *ifp, u8 cmd[4],
+			 u8 *pattern, u32 patternsize, u8 *mask,
+			 u32 packet_offset)
+{
+	struct inff_fwcmd_wowl_pattern_le *filter;
+	u32 masksize;
+	u32 patternoffset;
+	u8 *buf;
+	u32 bufsize;
+	s32 ret;
+
+	masksize = (patternsize + 7) / 8;
+	patternoffset = sizeof(*filter) - sizeof(filter->cmd) + masksize;
+
+	bufsize = sizeof(*filter) + patternsize + masksize;
+	buf = kzalloc(bufsize, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	filter = (struct inff_fwcmd_wowl_pattern_le *)buf;
+
+	memcpy(filter->cmd, cmd, 4);
+	filter->masksize = cpu_to_le32(masksize);
+	filter->offset = cpu_to_le32(packet_offset);
+	filter->patternoffset = cpu_to_le32(patternoffset);
+	filter->patternsize = cpu_to_le32(patternsize);
+	filter->type = cpu_to_le32(INFF_WOWL_PATTERN_TYPE_BITMAP);
+
+	if ((mask) && (masksize))
+		memcpy(buf + sizeof(*filter), mask, masksize);
+	if ((pattern) && (patternsize))
+		memcpy(buf + sizeof(*filter) + masksize, pattern, patternsize);
+
+	ret = inff_fwcmd_iovar_data_set(ifp, "wowl_pattern", buf, bufsize);
+
+	kfree(buf);
+	return ret;
+}
+
+static void
+inff_configure_wowl(struct inff_cfg80211_info *cfg,
+		    struct inff_if *ifp,
+		    struct cfg80211_wowlan *wowl)
+{
+	u32 wowl_config;
+	struct inff_wowl_wakeind_le wowl_wakeind;
+	u32 i;
+	s32 err;
+
+	inff_dbg(TRACE, "Suspend, wowl config.\n");
+
+	inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_PM, INFF_PM_MAX);
+
+	wowl_config = 0;
+	if (wowl->disconnect)
+		wowl_config = INFF_WOWL_DIS | INFF_WOWL_BCN | INFF_WOWL_RETR;
+	if (wowl->magic_pkt)
+		wowl_config |= INFF_WOWL_MAGIC;
+	if (wowl->patterns && wowl->n_patterns) {
+		wowl_config |= INFF_WOWL_NET;
+		for (i = 0; i < wowl->n_patterns; i++) {
+			inff_config_wowl_pattern(ifp, "add",
+						 (u8 *)wowl->patterns[i].pattern,
+						 wowl->patterns[i].pattern_len,
+						 (u8 *)wowl->patterns[i].mask,
+						 wowl->patterns[i].pkt_offset);
+		}
+	}
+	if (wowl->gtk_rekey_failure)
+		wowl_config |= INFF_WOWL_GTK_FAILURE;
+	if (!test_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state))
+		wowl_config |= INFF_WOWL_UNASSOC;
+
+	memcpy(&wowl_wakeind, "clear", 6);
+	err = inff_fwcmd_iovar_data_set(ifp, "wowl_wakeind", &wowl_wakeind,
+					sizeof(wowl_wakeind));
+	if (err)
+		iphy_err(ifp->drvr, "wowl_wakeind iovar failed: err=%d\n", err);
+
+	inff_fwcmd_iovar_int_set(ifp, "wowl", wowl_config);
+	inff_fwcmd_iovar_int_set(ifp, "wowl_activate", 1);
+	inff_bus_wowl_config(cfg->pub->bus_if, true);
+	cfg->wowl.active = true;
+
+	/* enable packet filters */
+	inff_pktfilter_enable(ifp->ndev, true);
+}
+
+void
+inff_set_mpc(struct inff_if *ifp, int mpc)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+
+	ifp->drvr->req_mpc = mpc;
+	if (inff_check_vif_up(ifp->vif)) {
+		err = inff_fwcmd_iovar_int_set(ifp, "mpc",
+					       ifp->drvr->req_mpc);
+		if (err) {
+			iphy_err(drvr, "fail to set mpc\n");
+			return;
+		}
+		inff_dbg(INFO, "MPC : %d\n", mpc);
+	}
+}
+
+static void
+inff_ht_update_wiphy_cap(struct inff_if *ifp,
+			 u32 bw_cap[2], u32 nchain)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct wiphy *wiphy = drvr->wiphy;
+	struct ieee80211_supported_band *band;
+	u32 nmode = 0, sgi_rx = 1;
+	int i = 0;
+
+	/* HT mode */
+	if (inff_fwcmd_iovar_int_get(ifp, "nmode", &nmode))
+		iphy_err(drvr, "nmode error\n");
+
+	if (!nmode)
+		return;
+
+	inff_dbg(INFO, "HT Enabled\n");
+
+	if (inff_fwcmd_iovar_int_get(ifp, "sgi_rx", &sgi_rx))
+		iphy_err(drvr, "sgi_rx error\n");
+
+	/* Update HT Capab for each Band */
+	for (i = 0; i < ARRAY_SIZE(wiphy->bands); i++) {
+		band = wiphy->bands[i];
+		if (!band)
+			continue;
+
+		switch (band->band) {
+		case NL80211_BAND_6GHZ:
+			break;
+
+		case NL80211_BAND_5GHZ:
+			/* Band 5GHz supports HT, so */
+			fallthrough;
+
+		case NL80211_BAND_2GHZ:
+			/* Band 2GHz supports HT */
+			band->ht_cap.ht_supported = true;
+
+			/* Bit 0 represents HT SGI 20MHz */
+			if ((sgi_rx & BIT(0)) &&
+			    (bw_cap[band->band] & WLC_BW_20MHZ_BIT))
+				band->ht_cap.cap |= IEEE80211_HT_CAP_SGI_20;
+
+			/* Bit 1 represents HT SGI 40MHz */
+			if ((sgi_rx & BIT(1)) &&
+			    (bw_cap[band->band] & WLC_BW_40MHZ_BIT)) {
+				band->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
+				band->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+			}
+
+			band->ht_cap.cap |= IEEE80211_HT_CAP_DSSSCCK40;
+			band->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
+			band->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
+			memset(band->ht_cap.mcs.rx_mask, 0xff, nchain);
+			band->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+			break;
+
+		default:
+			break;
+		}
+	}
+}
+
+static __le16
+inff_vht_get_mcs_map(u32 nchain, enum ieee80211_vht_mcs_support supp)
+{
+	u16 mcs_map;
+	int i;
+
+	for (i = 0, mcs_map = 0xFFFF; i < nchain; i++)
+		mcs_map = (mcs_map << 2) | supp;
+
+	return cpu_to_le16(mcs_map);
+}
+
+static void
+inff_vht_update_wiphy_cap(struct inff_if *ifp,
+			  u32 bw_cap[2], u32 nchain)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct wiphy *wiphy = drvr->wiphy;
+	struct ieee80211_supported_band *band;
+	u32 vhtmode = 0;
+	u32 txstreams = 0;
+	u32 txbf_bfe_cap = 0;
+	u32 txbf_bfr_cap = 0;
+	__le16 mcs_map;
+	int i = 0;
+
+	/* VHT mode */
+	if (inff_fwcmd_iovar_int_get(ifp, "vhtmode", &vhtmode))
+		iphy_err(drvr, "vhtmode error\n");
+
+	if (!vhtmode)
+		return;
+
+	inff_dbg(INFO, "VHT Enabled\n");
+
+	/* Create a MAP with MCS for each Stream */
+	mcs_map = inff_vht_get_mcs_map(nchain, IEEE80211_VHT_MCS_SUPPORT_0_9);
+
+	if (inff_fwcmd_iovar_int_get(ifp, "txstreams", &txstreams))
+		iphy_err(drvr, "txstreams error\n");
+
+	/* Beamforming support information */
+	if (inff_fwcmd_iovar_int_get(ifp, "txbf_bfe_cap", &txbf_bfe_cap))
+		iphy_err(drvr, "txbf_bfe_cap error\n");
+	if (inff_fwcmd_iovar_int_get(ifp, "txbf_bfr_cap", &txbf_bfr_cap))
+		iphy_err(drvr, "txbf_bfw_cap error\n");
+
+	/* Update VHT Capab for each Band */
+	for (i = 0; i < ARRAY_SIZE(wiphy->bands); i++) {
+		band = wiphy->bands[i];
+		if (!band)
+			continue;
+
+		switch (band->band) {
+		case NL80211_BAND_6GHZ:
+			break;
+
+		case NL80211_BAND_5GHZ:
+			/* Band 5GHz supports VHT */
+			band->vht_cap.vht_supported = true;
+			band->vht_cap.vht_mcs.rx_mcs_map = mcs_map;
+			band->vht_cap.vht_mcs.tx_mcs_map = mcs_map;
+
+			if (bw_cap[band->band] & WLC_BW_80MHZ_BIT)
+				band->vht_cap.cap |= IEEE80211_VHT_CAP_SHORT_GI_80;
+
+			if (txbf_bfe_cap & INFF_TXBF_SU_BFE_CAP)
+				band->vht_cap.cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
+			if (txbf_bfe_cap & INFF_TXBF_MU_BFE_CAP)
+				band->vht_cap.cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+			if (txbf_bfr_cap & INFF_TXBF_SU_BFR_CAP)
+				band->vht_cap.cap |= IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE;
+			if (txbf_bfr_cap & INFF_TXBF_MU_BFR_CAP)
+				band->vht_cap.cap |= IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE;
+
+			if ((txbf_bfe_cap || txbf_bfr_cap) && txstreams > 1) {
+				band->vht_cap.cap |=
+					(2 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
+				band->vht_cap.cap |= ((txstreams - 1) <<
+						IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT);
+				band->vht_cap.cap |=
+					IEEE80211_VHT_CAP_VHT_LINK_ADAPTATION_VHT_MRQ_MFB;
+			}
+			break;
+
+		case NL80211_BAND_2GHZ:
+			break;
+
+		default:
+			break;
+		}
+	}
+}
+
+static int
+inff_setup_wiphybands(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	u32 rxchain = 0, nchain = 1;
+	u32 bw_cap[4] = { WLC_BW_20MHZ_BIT,  /* 2GHz  */
+			  WLC_BW_20MHZ_BIT,  /* 5GHz  */
+			  0,                 /* 60GHz */
+			  0 };		     /* 6GHz  */
+	int err;
+
+	inff_nl80211_chan_get_bwcap(ifp, bw_cap);
+	inff_dbg(INFO, "bw_cap=[2G(%d), 5G(%d), 6G(%d)]\n",
+		 bw_cap[NL80211_BAND_2GHZ], bw_cap[NL80211_BAND_5GHZ],
+		 bw_cap[NL80211_BAND_6GHZ]);
+
+	err = inff_fwcmd_iovar_int_get(ifp, "rxchain", &rxchain);
+	if (err)
+		iphy_err(drvr, "rxchain error (%d)\n", err);
+	else
+		for (nchain = 0; rxchain; nchain++)
+			rxchain = rxchain & (rxchain - 1);
+	inff_dbg(INFO, "nchain=%d\n", nchain);
+
+	err = inff_nl80211_chan_populate(cfg, bw_cap);
+	if (err) {
+		iphy_err(drvr, "inff_construct_chaninfo failed (%d)\n", err);
+		return err;
+	}
+
+	/* HT Capability Registration */
+	inff_ht_update_wiphy_cap(ifp, bw_cap, nchain);
+
+	/* VHT Capability Registration */
+	inff_vht_update_wiphy_cap(ifp, bw_cap, nchain);
+
+	/* HE Capability Registration */
+	inff_he_update_wiphy_cap(ifp);
+
+	return 0;
+}
+
+void
+inff_cfg80211_update_proto_addr_mode(struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	if (wdev->iftype == NL80211_IFTYPE_ADHOC ||
+	    wdev->iftype == NL80211_IFTYPE_AP ||
+	    wdev->iftype == NL80211_IFTYPE_P2P_GO)
+		inff_proto_configure_addr_mode(ifp->drvr, ifp->ifidx,
+					       ADDR_DIRECT);
+	else
+		inff_proto_configure_addr_mode(ifp->drvr, ifp->ifidx,
+					       ADDR_INDIRECT);
+}
+
+static s32
+inff_cfg80211_get_station_ibss(struct inff_if *ifp,
+			       struct station_info *sinfo,
+			       const u8 *mac)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_scb_val_le scbval;
+	struct inff_pktcnt_le pktcnt;
+	s32 err;
+	u32 rate = 0;
+	u32 rssi;
+
+	/* Get the current tx rate */
+	err = inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_RATE, &rate);
+	if (err < 0) {
+		iphy_err(drvr, "INFF_C_GET_RATE error (%d)\n", err);
+		return err;
+	}
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+	sinfo->txrate.legacy = rate * 5;
+
+	memset(&scbval, 0, sizeof(scbval));
+	memcpy(&scbval.ea[0], mac, ETH_ALEN);
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_RSSI, &scbval,
+				      sizeof(scbval));
+	if (err) {
+		iphy_err(drvr, "INFF_C_GET_RSSI error (%d)\n", err);
+		return err;
+	}
+	rssi = le32_to_cpu(scbval.val);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+	sinfo->signal = rssi;
+
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_GET_PKTCNTS, &pktcnt,
+				      sizeof(pktcnt));
+	if (err) {
+		iphy_err(drvr, "INFF_C_GET_GET_PKTCNTS error (%d)\n", err);
+		return err;
+	}
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS) |
+			 BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC) |
+			 BIT_ULL(NL80211_STA_INFO_TX_PACKETS) |
+			 BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+	sinfo->rx_packets = le32_to_cpu(pktcnt.rx_good_pkt);
+	sinfo->rx_dropped_misc = le32_to_cpu(pktcnt.rx_bad_pkt);
+	sinfo->tx_packets = le32_to_cpu(pktcnt.tx_good_pkt);
+	sinfo->tx_failed  = le32_to_cpu(pktcnt.tx_bad_pkt);
+
+	return 0;
+}
+
+static bool
+wl_cfg80211_is_oce_ap(struct inff_if *ifp,
+		      struct wiphy *wiphy, const u8 *bssid_hint)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	const struct inff_tlv *ie;
+	const struct cfg80211_bss_ies *ies;
+	struct cfg80211_bss *bss;
+	const u8 *parse = NULL;
+	u32 len;
+
+	bss = cfg80211_get_bss(wiphy, NULL, bssid_hint, NULL, 0,
+			       IEEE80211_BSS_TYPE_ANY, IEEE80211_PRIVACY_ANY);
+	if (!bss) {
+		iphy_err(drvr, "Unable to find AP in the cache");
+		return false;
+	}
+
+	if (rcu_access_pointer(bss->ies)) {
+		ies = rcu_access_pointer(bss->ies);
+		parse = ies->data;
+		len = ies->len;
+	} else {
+		iphy_err(drvr, "ies is NULL");
+		return false;
+	}
+
+	while ((ie = inff_parse_tlvs(parse, len, WLAN_EID_VENDOR_SPECIFIC))) {
+		if (wl_cfgoce_is_oce_ie((const u8 *)ie,
+					(u8 const **)&parse, &len) == true) {
+			return true;
+		}
+	}
+	inff_dbg(TRACE, "OCE IE NOT found");
+	return false;
+}
+
+static s32
+inff_set_rts(struct net_device *ndev, u32 rts_threshold)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+
+	err = inff_fwcmd_iovar_int_set(ifp, "rtsthresh", rts_threshold);
+	if (err)
+		iphy_err(drvr, "Error (%d)\n", err);
+
+	return err;
+}
+
+static s32
+inff_set_frag(struct net_device *ndev, u32 frag_threshold)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+
+	err = inff_fwcmd_iovar_int_set(ifp, "fragthresh", frag_threshold);
+	if (err)
+		iphy_err(drvr, "Error (%d)\n", err);
+
+	return err;
+}
+
+static s32
+inff_set_retry(struct net_device *ndev, u32 retry, bool l)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err = 0;
+	u32 cmd = (l ? INFF_C_SET_LRL : INFF_C_SET_SRL);
+
+	err = inff_fwcmd_cmd_int_set(ifp, cmd, retry);
+	if (err) {
+		iphy_err(drvr, "cmd (%d) , error (%d)\n", cmd, err);
+		return err;
+	}
+	return err;
+}
+
+static void
+inff_set_join_pref(struct inff_if *ifp,
+		   struct cfg80211_bss_selection *bss_select)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_join_pref_params join_pref_params[2];
+	enum nl80211_band band;
+	int err, i = 0;
+
+	join_pref_params[i].len = 2;
+	join_pref_params[i].rssi_gain = 0;
+
+	if (bss_select->behaviour != NL80211_BSS_SELECT_ATTR_BAND_PREF)
+		inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_ASSOC_PREFER, WLC_BAND_AUTO);
+
+	switch (bss_select->behaviour) {
+	case __NL80211_BSS_SELECT_ATTR_INVALID:
+		inff_set_joinpref_default(ifp);
+		return;
+	case NL80211_BSS_SELECT_ATTR_BAND_PREF:
+		join_pref_params[i].type = INFF_JOIN_PREF_BAND;
+		band = bss_select->param.band_pref;
+		join_pref_params[i].band = inff_nl80211_band_to_fwil(band);
+		i++;
+		break;
+	case NL80211_BSS_SELECT_ATTR_RSSI_ADJUST:
+		join_pref_params[i].type = INFF_JOIN_PREF_RSSI_DELTA;
+		band = bss_select->param.adjust.band;
+		join_pref_params[i].band = inff_nl80211_band_to_fwil(band);
+		join_pref_params[i].rssi_gain = bss_select->param.adjust.delta;
+		i++;
+		break;
+	case NL80211_BSS_SELECT_ATTR_RSSI:
+	default:
+		break;
+	}
+	join_pref_params[i].type = INFF_JOIN_PREF_RSSI;
+	join_pref_params[i].len = 2;
+	join_pref_params[i].rssi_gain = 0;
+	join_pref_params[i].band = 0;
+	err = inff_fwcmd_iovar_data_set(ifp, "join_pref", join_pref_params,
+					sizeof(join_pref_params));
+	if (err)
+		iphy_err(drvr, "Set join_pref error (%d)\n", err);
+}
+
+static int
+inff_set_keepalive(struct inff_if *ifp, unsigned int interval)
+{
+	struct inff_mkeep_alive_pkt_le kalive = {0};
+	int ret = 0;
+
+	/* Configure Null function/data keepalive */
+	kalive.version = cpu_to_le16(1);
+	kalive.period_msec = cpu_to_le32(interval * MSEC_PER_SEC);
+	kalive.len_bytes = cpu_to_le16(0);
+	kalive.keep_alive_id = 0;
+
+	ret = inff_fwcmd_iovar_data_set(ifp, "mkeep_alive", &kalive, sizeof(kalive));
+	if (ret)
+		inff_err("keep-alive packet config failed, ret=%d\n", ret);
+
+	return ret;
+}
+
+static int
+inff_mgmt_probe_resp_tx(struct inff_cfg80211_info *cfg,
+			struct wireless_dev *wdev,
+			struct cfg80211_mgmt_tx_params *params,
+			u64 *cookie)
+{
+	struct inff_cfg80211_vif *vif;
+	const u8 *buf = params->buf;
+	size_t len = params->len;
+	s32 ie_offset;
+	s32 ie_len;
+	s32 err = 0;
+
+	*cookie = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+
+	ie_offset = DOT11_MGMT_HDR_LEN +
+		    DOT11_BCN_PRB_FIXED_LEN;
+	ie_len = len - ie_offset;
+
+	err = inff_vif_set_mgmt_ie(vif, INFF_VNDR_IE_PRBRSP_FLAG,
+				   &buf[ie_offset], ie_len);
+	cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, true,
+				GFP_KERNEL);
+
+	return err;
+}
+
+/**
+ * inff_ieee80211_is_dpp_pub_action() - true if dpp public type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is dpp public action type
+ */
+bool
+inff_ieee80211_is_dpp_pub_action(void *frame, u32 frame_len)
+{
+	struct inff_pub_act_frame *pact_frm;
+
+	if (!frame)
+		return false;
+
+	pact_frm = (struct inff_pub_act_frame *)frame;
+	if (frame_len < sizeof(struct inff_pub_act_frame) - 1)
+		return false;
+
+	if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
+	    pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
+	    pact_frm->oui_type == WLAN_OUI_TYPE_WFA_DPP &&
+	    memcmp(pact_frm->oui, WFA_OUI, TLV_OUI_LEN) == 0)
+		return true;
+
+	return false;
+}
+
+/**
+ * inff_ieee80211_is_gas_pub_action() - true if gas public type frame.
+ *
+ * @frame: action frame data.
+ * @frame_len: length of action frame data.
+ *
+ * Determine if action frame is gas public action type
+ */
+bool
+inff_ieee80211_is_gas_pub_action(void *frame, u32 frame_len)
+{
+	struct inff_gas_pub_act_frame *act_frm;
+
+	if (!frame)
+		return false;
+
+	act_frm = (struct inff_gas_pub_act_frame *)frame;
+	if (frame_len < sizeof(*act_frm))
+		return false;
+
+	if (act_frm->category != WLAN_CATEGORY_PUBLIC)
+		return false;
+
+	if (act_frm->action == WLAN_PUB_ACTION_GAS_INITIAL_REQ ||
+	    act_frm->action == WLAN_PUB_ACTION_GAS_INITIAL_RESP ||
+	    act_frm->action == WLAN_PUB_ACTION_GAS_COMEBACK_REQ ||
+	    act_frm->action == WLAN_PUB_ACTION_GAS_COMEBACK_RESP)
+		return true;
+
+	return false;
+}
+
+static bool
+inff_send_action_frame(struct inff_cfg80211_info *cfg,
+		       struct net_device *ndev,
+		       struct inff_fwcmd_af_params_le *af_params,
+		       struct inff_cfg80211_vif *vif,
+		       struct ieee80211_channel *peer_listen_chan)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_fwcmd_action_frame_le *action_frame;
+	struct inff_pub *drvr = cfg->pub;
+	u16 action_frame_len;
+	bool ack = false;
+	u8 action;
+	struct inff_fwcmd_af_params_v2_le *af_params_v2;
+	s32 timeout;
+	s32 err = 0;
+
+	action_frame = &af_params->action_frame;
+	action_frame_len = le16_to_cpu(action_frame->len);
+	action = action_frame->data[DOT11_ACTION_ACT_OFF];
+
+	/* Add the default dwell time. Dwell time to stay off-channel */
+	/* to wait for a response action frame after transmitting an  */
+	/* GO Negotiation action frame                                */
+	af_params->dwell_time = cpu_to_le32(IEEE80211_AF_DWELL_TIME);
+
+	if (inff_ieee80211_is_gas_pub_action(action_frame->data,
+					     action_frame_len)) {
+		/* service discovery process */
+		if (action == WLAN_PUB_ACTION_GAS_INITIAL_REQ ||
+		    action == WLAN_PUB_ACTION_GAS_COMEBACK_REQ) {
+			af_params->dwell_time =
+				cpu_to_le32(IEEE80211_AF_MED_DWELL_TIME);
+		} else if (action == WLAN_PUB_ACTION_GAS_INITIAL_RESP ||
+			   action == WLAN_PUB_ACTION_GAS_COMEBACK_RESP) {
+			/* configure service discovery response frame */
+			af_params->dwell_time =
+				cpu_to_le32(IEEE80211_AF_MIN_DWELL_TIME);
+		}
+	} else if (inff_ieee80211_is_dpp_pub_action(action_frame->data,
+						    action_frame_len)) {
+		/* do not configure anything. it will be */
+		/* sent with a default configuration     */
+	}
+
+	/* if scan is ongoing, abort current scan. */
+	if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status))
+		inff_abort_scanning(cfg);
+
+	if (drvr->wlc_ver.wlc_ver_major == INFF_AF_PARAM_V2_FW_MAJOR &&
+	    drvr->wlc_ver.wlc_ver_minor >= INFF_AF_PARAM_V2_FW_MINOR) {
+		af_params_v2 = kzalloc(sizeof(*af_params_v2), GFP_KERNEL);
+		if (!af_params_v2) {
+			err = -ENOMEM;
+			goto exit;
+		}
+
+		reinit_completion(&vif->mgmt_tx);
+		clear_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+		clear_bit(INFF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+		clear_bit(INFF_MGMT_TX_OFF_CHAN_COMPLETED,
+			  &vif->mgmt_tx_status);
+
+		/* set actframe iovar with af_params_v2 */
+		af_params_v2->band = inff_nl80211_band_to_fwil(peer_listen_chan->band);
+		af_params_v2->channel = af_params->channel;
+		af_params_v2->dwell_time = af_params->dwell_time;
+		memcpy(af_params_v2->bssid, af_params->bssid, ETH_ALEN);
+		memcpy(&af_params_v2->action_frame, &af_params->action_frame,
+		       sizeof(af_params_v2->action_frame));
+
+		set_bit(INFF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
+
+		err = inff_fwcmd_bsscfg_data_set(ifp, "actframe", af_params_v2,
+						 sizeof(*af_params_v2));
+		kfree(af_params_v2);
+	} else {
+		set_bit(INFF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
+		/* set actframe iovar with af_params */
+		err = inff_fwcmd_bsscfg_data_set(ifp, "actframe", af_params,
+						 sizeof(*af_params));
+	}
+
+	timeout = wait_for_completion_timeout(&vif->mgmt_tx,
+					      MGMT_AUTH_FRAME_WAIT_TIME);
+	if (test_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status)) {
+		inff_dbg(TRACE, "TX Action frame operation is success\n");
+		ack = true;
+	} else {
+		iphy_err(drvr, "TX Action frame operation is failed: status=%ld)\n",
+			 vif->mgmt_tx_status);
+	}
+
+exit:
+	if (err)
+		iphy_err(drvr, " sending action frame has failed\n");
+
+	return ack;
+}
+
+static int
+inff_mgmt_action_tx(struct inff_cfg80211_info *cfg,
+		    struct wireless_dev *wdev,
+		    struct cfg80211_mgmt_tx_params *params,
+		    u64 *cookie)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct ieee80211_channel *chan = params->chan;
+	struct inff_cfg80211_vif *vif;
+	struct inff_fwcmd_action_frame_le *action_frame;
+	struct inff_fwcmd_af_params_le *af_params;
+	const struct ieee80211_mgmt *mgmt;
+	const u8 *buf = params->buf;
+	size_t len = params->len;
+	__le32 hw_ch;
+	bool ack = false;
+	s32 err = 0;
+
+	*cookie = 0;
+
+	if (len > INFF_FIL_ACTION_FRAME_SIZE + DOT11_MGMT_HDR_LEN) {
+		iphy_err(drvr, "invalid action frame length\n");
+		err = -EINVAL;
+		goto exit;
+	}
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	mgmt = (const struct ieee80211_mgmt *)buf;
+
+	af_params = kzalloc(sizeof(*af_params), GFP_KERNEL);
+	if (!af_params) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	action_frame = &af_params->action_frame;
+	/* Add the packet Id */
+	action_frame->packet_id = cpu_to_le32(*cookie);
+	/* Add BSSID */
+	memcpy(&action_frame->da[0], &mgmt->da[0], ETH_ALEN);
+	memcpy(&af_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
+	/* Add the length exepted for 802.11 header  */
+	action_frame->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
+
+	/* Add the channel. Use the one specified as parameter if any or
+	 * the current one (got from the firmware) otherwise
+	 */
+	if (chan) {
+		hw_ch = cpu_to_le32(chan->hw_value);
+	} else {
+		err = inff_fwcmd_cmd_data_get(vif->ifp,
+					      INFF_C_GET_CHANNEL,
+					      &hw_ch, sizeof(hw_ch));
+		if (err) {
+			iphy_err(drvr,
+				 "unable to get current hw channel\n");
+			kfree(af_params);
+			goto exit;
+		}
+	}
+	af_params->channel = hw_ch;
+
+	af_params->dwell_time = cpu_to_le32(params->wait);
+	memcpy(action_frame->data, &buf[DOT11_MGMT_HDR_LEN],
+	       le16_to_cpu(action_frame->len));
+
+	inff_dbg(TRACE, "Action frame, cookie=%lld, len=%d, channel=%d\n",
+		 *cookie, le16_to_cpu(action_frame->len),
+		 le32_to_cpu(af_params->channel));
+	inff_print_action_frame(true, action_frame->data, le16_to_cpu(action_frame->len));
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		ack = inff_send_action_frame(cfg, cfg_to_ndev(cfg),
+					     af_params, vif, chan);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		ack = inff_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
+						 af_params, vif, chan);
+		break;
+	default:
+		inff_err("Unsupported iface for sending action frame\n");
+		kfree(af_params);
+		goto exit;
+	}
+
+	cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
+				GFP_KERNEL);
+	kfree(af_params);
+exit:
+	return err;
+}
+
+static int
+inff_mgmt_auth_tx(struct inff_cfg80211_info *cfg,
+		  struct wireless_dev *wdev,
+		  struct cfg80211_mgmt_tx_params *params,
+		  u64 *cookie)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct ieee80211_channel *chan = params->chan;
+	struct inff_cfg80211_vif *vif;
+	struct inff_mf_params_le *mf_params;
+	const struct ieee80211_mgmt *mgmt;
+	const u8 *buf = params->buf;
+	size_t len = params->len;
+	u32 mf_params_len;
+	s32 timeout;
+	__le16 hw_ch;
+	bool ack = false;
+	s32 err = 0;
+
+	*cookie = 0;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	mgmt = (const struct ieee80211_mgmt *)buf;
+
+	reinit_completion(&vif->mgmt_tx);
+	clear_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status);
+	clear_bit(INFF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
+	clear_bit(INFF_MGMT_TX_OFF_CHAN_COMPLETED,
+		  &vif->mgmt_tx_status);
+
+	mf_params_len = offsetof(struct inff_mf_params_le, data) +
+			(len - DOT11_MGMT_HDR_LEN);
+	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
+	if (!mf_params) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	mf_params->dwell_time = cpu_to_le32(MGMT_AUTH_FRAME_DWELL_TIME);
+	mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
+	mf_params->frame_control = mgmt->frame_control;
+
+	if (chan) {
+		hw_ch = cpu_to_le16(chan->hw_value);
+	} else {
+		err = inff_fwcmd_cmd_data_get(vif->ifp, INFF_C_GET_CHANNEL,
+					      &hw_ch, sizeof(hw_ch));
+		if (err) {
+			iphy_err(drvr, "unable to get current hw channel\n");
+			kfree(mf_params);
+			goto exit;
+		}
+	}
+	mf_params->channel = hw_ch;
+
+	memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
+	memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
+	*cookie = (u64)mf_params->data;
+	mf_params->packet_id = cpu_to_le32(*cookie);
+	unsafe_memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
+		      le16_to_cpu(mf_params->len), /* alloc enough buf*/);
+
+	inff_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
+		 le32_to_cpu(mf_params->packet_id),
+		 le16_to_cpu(mf_params->frame_control),
+		 le16_to_cpu(mf_params->len),
+		 le16_to_cpu(mf_params->channel));
+
+	vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
+	set_bit(INFF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
+
+	err = inff_fwcmd_bsscfg_data_set(vif->ifp, "mgmt_frame",
+					 mf_params, mf_params_len);
+	if (err) {
+		iphy_err(drvr, "Failed to send Auth frame: err=%d\n",
+			 err);
+		goto tx_status;
+	}
+
+	timeout = wait_for_completion_timeout(&vif->mgmt_tx,
+					      MGMT_AUTH_FRAME_WAIT_TIME);
+	if (test_bit(INFF_MGMT_TX_ACK, &vif->mgmt_tx_status)) {
+		inff_dbg(TRACE, "TX Auth frame operation is success\n");
+		ack = true;
+	} else {
+		iphy_err(drvr, "TX Auth frame operation is failed: status=%ld)\n",
+			 vif->mgmt_tx_status);
+	}
+
+tx_status:
+	cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
+				GFP_KERNEL);
+	kfree(mf_params);
+exit:
+	return err;
+}
+
+static s32
+inff_cfg80211_suspend(struct wiphy *wiphy,
+		      struct cfg80211_wowlan *wowl)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_vif *vif;
+	struct inff_cfg80211_info *config = ifp->drvr->config;
+
+	config->pm_state = INFF_CFG80211_PM_STATE_SUSPENDING;
+
+	/* if the primary net_device is not READY there is nothing
+	 * we can do but pray resume goes smoothly.
+	 */
+	if (!inff_check_vif_up(ifp->vif))
+		goto exit;
+
+	/* end any scanning */
+	if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status))
+		inff_abort_scanning(cfg);
+
+	if (!wowl || !test_bit(INFF_VIF_STATUS_CONNECTED,
+			       &ifp->vif->sme_state)) {
+		inff_bus_wowl_config(cfg->pub->bus_if, false);
+		list_for_each_entry(vif, &cfg->vif_list, list) {
+			if (!test_bit(INFF_VIF_STATUS_READY, &vif->sme_state))
+				continue;
+			/* While going to suspend if associated with AP
+			 * disassociate from AP to save power while system is
+			 * in suspended state
+			 */
+			inff_link_down(vif, WLAN_REASON_UNSPECIFIED, true);
+			/* Make sure WPA_Supplicant receives all the event
+			 * generated due to DISASSOC call to the fw to keep
+			 * the state fw and WPA_Supplicant state consistent
+			 */
+			inff_delay(500);
+		}
+		/* Configure MPC */
+		inff_set_mpc(ifp, 1);
+
+	} else {
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL)) {
+			/* Configure WOWL parameters */
+			inff_configure_wowl(cfg, ifp, wowl);
+
+			/* Prevent disassociation due to inactivity with keep-alive */
+			inff_set_keepalive(ifp, 30);
+		}
+	}
+
+exit:
+	/* set cfg80211 pm state to cfg80211 suspended state */
+	config->pm_state = INFF_CFG80211_PM_STATE_SUSPENDED;
+
+	/* clear any scanning activity */
+	cfg->scan_status = 0;
+
+	return 0;
+}
+
+static s32
+inff_cfg80211_resume(struct wiphy *wiphy)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_bus *bus_if = drvr->bus_if;
+	struct inff_cfg80211_info *config = drvr->config;
+	int retry = INFF_PM_WAIT_MAXRETRY;
+	s32 power_mode;
+
+	power_mode = cfg->pwr_save ? INFF_PM_FAST : INFF_PM_OFF;
+
+	config->pm_state = INFF_CFG80211_PM_STATE_RESUMING;
+
+	if (cfg->wowl.active) {
+		/* wait for bus resumed */
+		while (retry && bus_if->state != INFF_BUS_UP) {
+			usleep_range(10000, 20000);
+			retry--;
+		}
+		if (!retry && bus_if->state != INFF_BUS_UP)
+			inff_err("timed out wait for bus resume\n");
+#ifdef CONFIG_PM
+		inff_report_wowl_wakeind(wiphy, ifp);
+#endif /* CONFIG_PM */
+		inff_fwcmd_iovar_int_set(ifp, "wowl_clear", 0);
+		inff_config_wowl_pattern(ifp, "clr", NULL, 0, NULL, 0);
+		inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_PM,
+				       power_mode);
+		cfg->wowl.active = false;
+
+		/* disable packet filters */
+		inff_pktfilter_enable(ifp->ndev, false);
+	}
+
+	config->pm_state = INFF_CFG80211_PM_STATE_RESUMED;
+	return 0;
+}
+
+static struct wireless_dev *
+inff_cfg80211_add_iface(struct wiphy *wiphy,
+			const char *name,
+			unsigned char name_assign_type,
+			enum nl80211_iftype type,
+			struct vif_params *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct wireless_dev *wdev = NULL;
+	int err;
+
+	inff_dbg(TRACE, "%s type %d\n", name, type);
+	err = inff_vif_add_validate(wiphy_to_cfg(wiphy), type);
+	if (err) {
+		iphy_err(drvr, "iface validation failed: err=%d\n", err);
+		return ERR_PTR(err);
+	}
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		wdev = inff_apsta_add_vif(wiphy, name, params, type);
+		break;
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		wdev = inff_p2p_gosta_add_vif(wiphy, name, name_assign_type,
+					      params, type);
+		break;
+	case NL80211_IFTYPE_P2P_DEVICE:
+		wdev = inff_p2p_device_add_vif(wiphy, params, type);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_UNSPECIFIED:
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR_OR_NULL(wdev))
+		iphy_err(drvr, "add iface %s type %d failed: err=%d\n", name,
+			 type, (int)PTR_ERR(wdev));
+	else
+		inff_cfg80211_update_proto_addr_mode(wdev);
+
+	return wdev;
+}
+
+static int
+inff_cfg80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = wdev->netdev;
+
+	if (ndev && ndev == cfg_to_ndev(cfg))
+		return -EOPNOTSUPP;
+
+	/* vif event pending in firmware */
+	if (inff_vif_event_armed(cfg))
+		return -EBUSY;
+
+	if (ndev) {
+		if (test_bit(INFF_SCAN_STATUS_BUSY, &cfg->scan_status) &&
+		    cfg->escan_info.ifp == netdev_priv(ndev))
+			inff_notify_escan_complete(cfg, netdev_priv(ndev),
+						   true, true);
+
+		inff_fwcmd_iovar_int_set(netdev_priv(ndev), "mpc", 1);
+	}
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+		fallthrough;
+	case NL80211_IFTYPE_AP:
+		return inff_apsta_del_vif(wiphy, wdev);
+	case NL80211_IFTYPE_P2P_CLIENT:
+		fallthrough;
+	case NL80211_IFTYPE_P2P_GO:
+		return inff_p2p_gosta_del_vif(wiphy, wdev);
+	case NL80211_IFTYPE_P2P_DEVICE:
+		return inff_p2p_device_del_vif(wiphy, wdev);
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_UNSPECIFIED:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static s32
+inff_cfg80211_change_iface(struct wiphy *wiphy, struct net_device *ndev,
+			   enum nl80211_iftype type,
+			   struct vif_params *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_vif *vif = ifp->vif;
+	struct inff_pub *drvr = cfg->pub;
+	s32 infra = 0;
+	s32 ap = 0;
+	s32 err = 0;
+
+	inff_dbg(TRACE, "bsscfgidx=%d, type=%d\n", ifp->bsscfgidx,
+		 type);
+
+	if (type == NL80211_IFTYPE_STATION &&
+	    (vif->wdev.iftype == NL80211_IFTYPE_P2P_CLIENT ||
+	     vif->wdev.iftype == NL80211_IFTYPE_P2P_GO ||
+	     vif->wdev.iftype == NL80211_IFTYPE_P2P_DEVICE)) {
+		inff_err("change iface not supported for P2P\n");
+		return -EOPNOTSUPP;
+	}
+	err = inff_vif_change_validate(wiphy_to_cfg(wiphy), vif, type);
+	if (err) {
+		iphy_err(drvr, "iface validation failed: err=%d\n", err);
+		return err;
+	}
+	switch (type) {
+	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_WDS:
+		iphy_err(drvr, "type (%d) : currently we do not support this type\n",
+			 type);
+		return -EOPNOTSUPP;
+	case NL80211_IFTYPE_ADHOC:
+		infra = 0;
+		break;
+	case NL80211_IFTYPE_STATION:
+		infra = 1;
+		break;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		ap = 1;
+		break;
+	default:
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (ap) {
+		if (type == NL80211_IFTYPE_P2P_GO) {
+			inff_dbg(INFO, "IF Type = P2P GO\n");
+			err = inff_p2p_ifchange(cfg, INFF_FIL_P2P_IF_GO);
+		}
+		if (!err)
+			inff_dbg(INFO, "IF Type = AP\n");
+	} else {
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_INFRA, infra);
+		if (err) {
+			iphy_err(drvr, "WLC_SET_INFRA error (%d)\n", err);
+			err = -EAGAIN;
+			goto done;
+		}
+		inff_dbg(INFO, "IF Type = %s\n", inff_vif_is_ibssmode(vif) ?
+			  "Adhoc" : "Infra");
+	}
+	ndev->ieee80211_ptr->iftype = type;
+
+	inff_cfg80211_update_proto_addr_mode(&vif->wdev);
+	inff_setup_wiphybands(cfg);
+done:
+	return err;
+}
+
+static s32
+inff_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+		      int link_id, u8 key_idx, bool pairwise,
+		      const u8 *mac_addr, struct key_params *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_wsec_key *key;
+	s32 val;
+	s32 wsec;
+	s32 err;
+	u8 keybuf[8];
+	bool ext_key;
+	u32 algos = 0, mask = 0;
+
+	inff_dbg(CONN, "key index (%d)\n", key_idx);
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	if (key_idx >= INFF_MAX_DEFAULT_KEYS) {
+		/* we ignore this key index in this case */
+		iphy_err(drvr, "invalid key index (%d)\n", key_idx);
+		return -EINVAL;
+	}
+
+	if (params->key_len == 0)
+		return drvr->ops->del_key(wiphy, ndev, -1, key_idx,
+					  pairwise, mac_addr);
+
+	if (params->key_len > sizeof(key->data)) {
+		iphy_err(drvr, "Too long key length (%u)\n", params->key_len);
+		return -EINVAL;
+	}
+
+	ext_key = false;
+	if (mac_addr && params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
+	    params->cipher != WLAN_CIPHER_SUITE_WEP104) {
+		inff_dbg(TRACE, "Ext key, mac %pM", mac_addr);
+		ext_key = true;
+	}
+
+	key = &ifp->vif->profile.key[key_idx];
+	memset(key, 0, sizeof(*key));
+	if ((ext_key) && (!is_multicast_ether_addr(mac_addr)))
+		memcpy((char *)&key->ea, (void *)mac_addr, ETH_ALEN);
+	key->len = params->key_len;
+	key->index = key_idx;
+	memcpy(key->data, params->key, key->len);
+	if (!ext_key)
+		key->flags = INFF_PRIMARY_KEY;
+
+	if (params->seq && params->seq_len == 6) {
+		/* rx iv */
+		u8 *ivptr;
+
+		ivptr = (u8 *)params->seq;
+		key->rxiv.hi = (ivptr[5] << 24) | (ivptr[4] << 16) |
+			(ivptr[3] << 8) | ivptr[2];
+		key->rxiv.lo = (ivptr[1] << 8) | ivptr[0];
+		key->iv_initialized = true;
+	}
+
+	switch (params->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		key->algo = CRYPTO_ALGO_WEP1;
+		val = WEP_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_WEP40\n");
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		key->algo = CRYPTO_ALGO_WEP128;
+		val = WEP_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_WEP104\n");
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (!inff_vif_is_apmode(ifp->vif)) {
+			inff_dbg(CONN, "Swapping RX/TX MIC key\n");
+			memcpy(keybuf, &key->data[24], sizeof(keybuf));
+			memcpy(&key->data[24], &key->data[16], sizeof(keybuf));
+			memcpy(&key->data[16], keybuf, sizeof(keybuf));
+		}
+		key->algo = CRYPTO_ALGO_TKIP;
+		val = TKIP_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_TKIP\n");
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		key->algo = CRYPTO_ALGO_AES_CCM;
+		val = AES_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_AES_CMAC\n");
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		key->algo = CRYPTO_ALGO_AES_CCM;
+		val = AES_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_CCMP\n");
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (!inff_feat_is_enabled(ifp, INFF_FEAT_GCMP)) {
+			inff_err("the low layer not support GCMP\n");
+			err = -EOPNOTSUPP;
+			goto done;
+		}
+		key->algo = CRYPTO_ALGO_AES_GCM256;
+		val = AES_ENABLED;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_GCMP_256\n");
+		algos = KEY_ALGO_MASK(CRYPTO_ALGO_AES_GCM256);
+		mask = algos | KEY_ALGO_MASK(CRYPTO_ALGO_AES_CCM);
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		if (!inff_feat_is_enabled(ifp, INFF_FEAT_GCMP)) {
+			inff_err("the low layer not support GCMP\n");
+			err = -EOPNOTSUPP;
+			goto done;
+		}
+		key->algo = CRYPTO_ALGO_BIP_GMAC256;
+		val = AES_ENABLED;
+		algos = KEY_ALGO_MASK(CRYPTO_ALGO_BIP_GMAC256);
+		mask = algos | KEY_ALGO_MASK(CRYPTO_ALGO_AES_CCM);
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_BIP_GMAC_256\n");
+		break;
+	default:
+		iphy_err(drvr, "Invalid cipher (0x%x)\n", params->cipher);
+		err = -EINVAL;
+		goto done;
+	}
+
+	err = inff_send_key_to_dongle(ifp, key);
+	if (ext_key || err)
+		goto done;
+
+	err = inff_fwcmd_bsscfg_int_get(ifp, "wsec", &wsec);
+	if (err) {
+		iphy_err(drvr, "get wsec error (%d)\n", err);
+		goto done;
+	}
+	wsec |= val;
+	err = inff_fwcmd_bsscfg_int_set(ifp, "wsec", wsec);
+	if (err) {
+		iphy_err(drvr, "set wsec error (%d)\n", err);
+		goto done;
+	}
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_GCMP)) {
+		inff_dbg(CONN,
+			 "set_wsdec_info algos (0x%x) mask (0x%x)\n",
+			 algos, mask);
+		err = inff_set_wsec_info_algos(ifp, algos, mask);
+		if (err) {
+			inff_err("set wsec_info error (%d)\n", err);
+			return err;
+		}
+	}
+done:
+	return err;
+}
+
+static s32
+inff_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
+		      int link_id, u8 key_idx, bool pairwise,
+		      const u8 *mac_addr, void *cookie,
+		      void (*callback)(void *cookie,
+				       struct key_params *params))
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct key_params params;
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_security *sec;
+	s32 wsec = 0;
+	s32 err = 0;
+
+	inff_dbg(CONN, "key index (%d)\n", key_idx);
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	memset(&params, 0, sizeof(params));
+
+	err = inff_fwcmd_bsscfg_int_get(ifp, "wsec", &wsec);
+	if (err) {
+		iphy_err(drvr, "WLC_GET_WSEC error (%d)\n", err);
+		/* Ignore this error, may happen during DISASSOC */
+		err = -EAGAIN;
+		goto done;
+	}
+	if (wsec & WEP_ENABLED) {
+		sec = &profile->sec;
+		if (sec->cipher_pairwise & WLAN_CIPHER_SUITE_WEP40) {
+			params.cipher = WLAN_CIPHER_SUITE_WEP40;
+			inff_dbg(CONN, "WLAN_CIPHER_SUITE_WEP40\n");
+		} else if (sec->cipher_pairwise & WLAN_CIPHER_SUITE_WEP104) {
+			params.cipher = WLAN_CIPHER_SUITE_WEP104;
+			inff_dbg(CONN, "WLAN_CIPHER_SUITE_WEP104\n");
+		}
+	} else if (wsec & TKIP_ENABLED) {
+		params.cipher = WLAN_CIPHER_SUITE_TKIP;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_TKIP\n");
+	} else if (wsec & AES_ENABLED) {
+		params.cipher = WLAN_CIPHER_SUITE_AES_CMAC;
+		inff_dbg(CONN, "WLAN_CIPHER_SUITE_AES_CMAC\n");
+	} else  {
+		iphy_err(drvr, "Invalid algo (0x%x)\n", wsec);
+		err = -EINVAL;
+		goto done;
+	}
+	callback(cookie, &params);
+done:
+	return err;
+}
+
+static s32
+inff_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
+		      int link_id, u8 key_idx, bool pairwise,
+		      const u8 *mac_addr)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_wsec_key *key;
+	s32 err;
+
+	inff_dbg(CONN, "key index (%d)\n", key_idx);
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	if (key_idx >= INFF_MAX_DEFAULT_KEYS) {
+		/* we ignore this key index in this case */
+		return -EINVAL;
+	}
+
+	key = &ifp->vif->profile.key[key_idx];
+
+	if (key->algo == CRYPTO_ALGO_OFF) {
+		inff_dbg(CONN, "Ignore clearing of (never configured) key\n");
+		return -EINVAL;
+	}
+
+	memset(key, 0, sizeof(*key));
+	key->index = (u32)key_idx;
+	key->flags = INFF_PRIMARY_KEY;
+
+	/* Clear the key/index */
+	err = inff_send_key_to_dongle(ifp, key);
+
+	return err;
+}
+
+static s32
+inff_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
+				 int link_id, u8 key_idx, bool unicast,
+				 bool multicast)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = ifp->drvr;
+	u32 index;
+	u32 wsec = 0;
+	s32 err = 0;
+
+	inff_dbg(CONN, "key index (%d)\n", key_idx);
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	err = inff_fwcmd_bsscfg_int_get(ifp, "wsec", &wsec);
+	if (err) {
+		iphy_err(drvr, "WLC_GET_WSEC error (%d)\n", err);
+		goto done;
+	}
+
+	if (wsec & WEP_ENABLED) {
+		/* Just select a new current key */
+		index = key_idx;
+		err = inff_fwcmd_cmd_int_set(ifp,
+					     INFF_C_SET_KEY_PRIMARY, index);
+		if (err)
+			iphy_err(drvr, "error (%d)\n", err);
+	}
+done:
+	return err;
+}
+
+static s32
+inff_cfg80211_config_default_mgmt_key(struct wiphy *wiphy,
+				      struct net_device *ndev, int link_id,
+				      u8 key_idx)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	inff_dbg(TRACE, "key_idx %d\n", key_idx);
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_MFP))
+		return 0;
+
+	inff_dbg(INFO, "Not supported\n");
+
+	return -EOPNOTSUPP;
+}
+
+static s32
+inff_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
+		       struct cfg80211_ap_settings *settings)
+{
+	s32 ie_offset;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct cfg80211_crypto_settings *crypto = &settings->crypto;
+	const struct inff_tlv *ssid_ie;
+	const struct inff_tlv *country_ie;
+	struct inff_ssid_le ssid_le;
+	s32 err = -EPERM;
+	struct inff_join_params join_params;
+	enum nl80211_iftype dev_role;
+	struct inff_fwcmd_bss_enable_le bss_enable;
+	u16 chanspec = inff_nl80211_chandef_to_chanspec(&settings->chandef);
+	bool mbss = false;
+	int is_11d;
+	bool supports_11d;
+	bool closednet;
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	inff_dbg(TRACE, "ctrlchn=%d, center=%d, bw=%d, beacon_interval=%d, dtim_period=%d,\n",
+		 settings->chandef.chan->hw_value,
+		 settings->chandef.center_freq1, settings->chandef.width,
+		 settings->beacon_interval, settings->dtim_period);
+	inff_dbg(TRACE, "ssid=%s(%zu), auth_type=%d, inactivity_timeout=%d\n",
+		 settings->ssid, settings->ssid_len, settings->auth_type,
+		 settings->inactivity_timeout);
+	dev_role = ifp->vif->wdev.iftype;
+
+	if (dev_role == NL80211_IFTYPE_AP &&
+	    inff_feat_is_enabled(ifp, INFF_FEAT_MBSS)) {
+		struct inff_cfg80211_vif *vif_walk;
+
+		list_for_each_entry(vif_walk, &cfg->vif_list, list) {
+			if (inff_vif_is_apmode(vif_walk) &&
+			    inff_check_vif_up(vif_walk) &&
+			    vif_walk != ifp->vif) {
+				/* found a vif is with the 1st AP type,
+				 * and it doesn't equal to the currect vif calls start_ap.
+				 * then it is mbss case.
+				 */
+				mbss = true;
+				break;
+			}
+		}
+	}
+	inff_dbg(TRACE, "mbss %s\n", mbss ? "enabled" : "disabled");
+
+	/* store current 11d setting */
+	if (inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_REGULATORY,
+				   &ifp->vif->is_11d)) {
+		is_11d = false;
+		supports_11d = false;
+	} else {
+		country_ie = inff_parse_tlvs((u8 *)settings->beacon.tail,
+					     settings->beacon.tail_len,
+					     WLAN_EID_COUNTRY);
+		is_11d = country_ie ? 1 : 0;
+		supports_11d = true;
+	}
+
+	memset(&ssid_le, 0, sizeof(ssid_le));
+	if (!settings->ssid || settings->ssid_len == 0) {
+		ie_offset = DOT11_MGMT_HDR_LEN + DOT11_BCN_PRB_FIXED_LEN;
+		ssid_ie = inff_parse_tlvs((u8 *)&settings->beacon.head[ie_offset],
+					  settings->beacon.head_len - ie_offset,
+					  WLAN_EID_SSID);
+		if (!ssid_ie || ssid_ie->len > IEEE80211_MAX_SSID_LEN)
+			return -EINVAL;
+
+		memcpy(ssid_le.SSID, ssid_ie->data, ssid_ie->len);
+		ssid_le.SSID_len = cpu_to_le32(ssid_ie->len);
+		inff_dbg(TRACE, "SSID is (%s) in Head\n", ssid_le.SSID);
+	} else {
+		memcpy(ssid_le.SSID, settings->ssid, settings->ssid_len);
+		ssid_le.SSID_len = cpu_to_le32((u32)settings->ssid_len);
+	}
+
+	if (!mbss)
+		inff_set_mpc(ifp, 0);
+
+	/* Parameters shared by all radio interfaces */
+	if (!mbss) {
+		if ((supports_11d) && is_11d != ifp->vif->is_11d) {
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_REGULATORY,
+						     is_11d);
+			if (err < 0) {
+				iphy_err(drvr, "Regulatory Set Error, %d\n",
+					 err);
+				goto exit;
+			}
+		}
+		if (settings->beacon_interval) {
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_BCNPRD,
+						     settings->beacon_interval);
+			if (err < 0) {
+				iphy_err(drvr, "Beacon Interval Set Error, %d\n",
+					 err);
+				goto exit;
+			}
+		}
+		if (settings->dtim_period) {
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_DTIMPRD,
+						     settings->dtim_period);
+			if (err < 0) {
+				iphy_err(drvr, "DTIM Interval Set Error, %d\n",
+					 err);
+				goto exit;
+			}
+		}
+
+		if (dev_role == NL80211_IFTYPE_AP &&
+		    (ifp->ifidx == 0 ||
+		     (!inff_feat_is_enabled(ifp, INFF_FEAT_RSDB) &&
+		      !inff_feat_is_enabled(ifp, INFF_FEAT_MCHAN)))) {
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_DOWN, 1);
+			if (err < 0) {
+				iphy_err(drvr, "INFF_C_DOWN error %d\n",
+					 err);
+				goto exit;
+			}
+			inff_fwcmd_iovar_int_set(ifp, "apsta", 0);
+		}
+
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_INFRA, 1);
+		if (err < 0) {
+			iphy_err(drvr, "SET INFRA error %d\n", err);
+			goto exit;
+		}
+	} else if (WARN_ON(supports_11d && (is_11d != ifp->vif->is_11d))) {
+		/* Multiple-BSS should use same 11d configuration */
+		err = -EINVAL;
+		goto exit;
+	}
+	ifp->isap = false;
+	/* Interface specific setup */
+	if (dev_role == NL80211_IFTYPE_AP) {
+		u32 is_up = 0;
+
+		if ((inff_feat_is_enabled(ifp, INFF_FEAT_MBSS)) && !mbss) {
+			err = inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_UP, &is_up);
+			if (err < 0) {
+				iphy_err(drvr, "INFF_C_GET_UP error (%d)\n", err);
+				goto exit;
+			}
+
+			/* mbss must be set in DOWN state. */
+			if (is_up) {
+				err = inff_fwcmd_cmd_int_set(ifp, INFF_C_DOWN, 1);
+				if (err < 0) {
+					iphy_err(drvr, "INFF_C_DOWN error (%d)\n", err);
+					goto exit;
+				}
+			}
+			err = inff_fwcmd_iovar_int_set(ifp, "mbss", 1);
+			if (err < 0) {
+				iphy_err(drvr, "set mbss error (%d)\n", err);
+				goto exit;
+			}
+		}
+
+		if (!test_bit(INFF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state)) {
+			bss_enable.bsscfgidx = cpu_to_le32(ifp->bsscfgidx);
+			bss_enable.enable = cpu_to_le32(WL_IOV_OP_MANUAL_AP_BSSCFG_CREATE);
+			err = inff_fwcmd_iovar_data_set(ifp, "bss", &bss_enable,
+							sizeof(bss_enable));
+			if (err < 0) {
+				iphy_err(drvr, "bss_enable config failed %d\n", err);
+				goto exit;
+			}
+		}
+
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_AP, 1);
+		if (err < 0) {
+			iphy_err(drvr, "setting AP mode failed %d\n",
+				 err);
+			goto exit;
+		}
+
+		/* Firmware 10.x requires setting channel after enabling
+		 * AP and before bringing interface up.
+		 */
+		err = inff_fwcmd_iovar_int_set(ifp, "chanspec", chanspec);
+		if (err < 0) {
+			iphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
+				 chanspec, err);
+			goto exit;
+		}
+
+		err = inff_fwcmd_cmd_int_get(ifp, INFF_C_GET_UP, &is_up);
+		if (err < 0) {
+			iphy_err(drvr, "INFF_C_GET_UP error (%d)\n", err);
+			goto exit;
+		}
+
+		if (!is_up)
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_UP, 1);
+		if (err < 0) {
+			iphy_err(drvr, "INFF_C_UP error (%d)\n", err);
+			goto exit;
+		}
+
+		if (crypto->psk) {
+			inff_dbg(INFO, "using PSK offload\n");
+			profile->use_fwauth |= BIT(INFF_PROFILE_FWAUTH_PSK);
+			err = inff_set_pmk(ifp, crypto->psk,
+					   INFF_WSEC_MAX_PSK_LEN);
+			if (err < 0)
+				goto exit;
+		}
+		if (crypto->sae_pwd) {
+			inff_dbg(INFO, "using SAE offload\n");
+			profile->use_fwauth |= BIT(INFF_PROFILE_FWAUTH_SAE);
+			err = inff_set_sae_password(ifp, crypto->sae_pwd,
+						    crypto->sae_pwd_len);
+			if (err < 0)
+				goto exit;
+		}
+		if (profile->use_fwauth == 0)
+			profile->use_fwauth = BIT(INFF_PROFILE_FWAUTH_NONE);
+
+		err = inff_parse_configure_security(ifp, settings,
+						    NL80211_IFTYPE_AP);
+		if (err < 0) {
+			iphy_err(drvr, "inff_parse_configure_security error\n");
+			goto exit;
+		}
+
+		/* On DOWN the firmware removes the WEP keys, reconfigure
+		 * them if they were set.
+		 */
+		inff_reconfigure_wep(ifp);
+
+		memset(&join_params, 0, sizeof(join_params));
+		/* join parameters starts with ssid */
+		memcpy(&join_params.ssid_le, &ssid_le, sizeof(ssid_le));
+		/* create softap */
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SSID,
+					      &join_params, sizeof(join_params));
+		if (err < 0) {
+			iphy_err(drvr, "SET SSID error (%d)\n", err);
+			goto exit;
+		}
+
+		closednet =
+			(settings->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE);
+		err = inff_fwcmd_iovar_int_set(ifp, "closednet",	closednet);
+		if (err) {
+			iphy_err(drvr, "%s closednet error (%d)\n",
+				 (closednet ? "enabled" : "disabled"),
+				 err);
+			goto exit;
+		}
+		ifp->isap = true;
+		inff_dbg(TRACE, "AP mode configuration complete\n");
+	} else if (dev_role == NL80211_IFTYPE_P2P_GO) {
+		err = inff_fwcmd_iovar_int_set(ifp, "chanspec", chanspec);
+		if (err < 0) {
+			iphy_err(drvr, "Set Channel failed: chspec=%d, %d\n",
+				 chanspec, err);
+			goto exit;
+		}
+
+		err = inff_parse_configure_security(ifp, settings,
+						    NL80211_IFTYPE_P2P_GO);
+		if (err < 0) {
+			inff_err("inff_parse_configure_security error\n");
+			goto exit;
+		}
+
+		err = inff_fwcmd_bsscfg_data_set(ifp, "ssid", &ssid_le,
+						 sizeof(ssid_le));
+		if (err < 0) {
+			iphy_err(drvr, "setting ssid failed %d\n", err);
+			goto exit;
+		}
+		bss_enable.bsscfgidx = cpu_to_le32(ifp->bsscfgidx);
+		bss_enable.enable = cpu_to_le32(WL_IOV_OP_BSSCFG_ENABLE);
+		err = inff_fwcmd_iovar_data_set(ifp, "bss", &bss_enable,
+						sizeof(bss_enable));
+		if (err < 0) {
+			iphy_err(drvr, "bss_enable config failed %d\n", err);
+			goto exit;
+		}
+
+		p2p->afx_hdl.my_listen_chan = chanspec;
+		ifp->isap = true;
+		inff_dbg(TRACE, "GO mode configuration complete\n");
+	} else {
+		WARN_ON(1);
+	}
+
+	/* Set HE BSS Color */
+	if (settings->beacon.he_bss_color.enabled)
+		inff_he_set_bss_color(ifp, settings->beacon.he_bss_color.color);
+
+	inff_vif_clear_mgmt_ies(ifp->vif);
+	inff_config_ap_mgmt_ie(ifp->vif, &settings->beacon);
+	set_bit(INFF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state);
+	inff_net_setcarrier(ifp, true);
+
+exit:
+	if ((err) && !mbss) {
+		inff_set_mpc(ifp, 1);
+	} else {
+		cfg->num_softap++;
+		inff_dbg(TRACE, "Num of SoftAP %u\n", cfg->num_softap);
+	}
+	return err;
+}
+
+static s32
+inff_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
+			    struct cfg80211_ap_update *info)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	return inff_config_ap_mgmt_ie(ifp->vif, &info->beacon);
+}
+
+static int
+inff_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
+		      unsigned int link_id)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	s32 err;
+	struct inff_fwcmd_bss_enable_le bss_enable;
+	struct inff_join_params join_params;
+	s32 apsta = 0;
+
+	if (ifp->vif->wdev.iftype == NL80211_IFTYPE_AP) {
+		/* Due to most likely deauths outstanding we sleep */
+		/* first to make sure they get processed by fw. */
+		msleep(400);
+
+		if (profile->use_fwauth != BIT(INFF_PROFILE_FWAUTH_NONE)) {
+			if (profile->use_fwauth & BIT(INFF_PROFILE_FWAUTH_PSK))
+				inff_set_pmk(ifp, NULL, 0);
+			if (profile->use_fwauth & BIT(INFF_PROFILE_FWAUTH_SAE))
+				inff_set_sae_password(ifp, NULL, 0);
+			profile->use_fwauth = BIT(INFF_PROFILE_FWAUTH_NONE);
+		}
+
+		cfg->num_softap--;
+
+		/* Clear bss configuration and SSID */
+		bss_enable.bsscfgidx = cpu_to_le32(ifp->bsscfgidx);
+		bss_enable.enable = cpu_to_le32(WL_IOV_OP_BSSCFG_DISABLE);
+		err = inff_fwcmd_iovar_data_set(ifp, "bss", &bss_enable,
+						sizeof(bss_enable));
+		if (err < 0)
+			inff_err("bss_enable config failed %d\n", err);
+
+		memset(&join_params, 0, sizeof(join_params));
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SSID,
+					      &join_params, sizeof(join_params));
+		if (err < 0)
+			iphy_err(drvr, "SET SSID error (%d)\n", err);
+
+		if (cfg->num_softap) {
+			inff_dbg(TRACE, "Num of SoftAP %u\n", cfg->num_softap);
+			return 0;
+		}
+
+		/* First BSS doesn't get a full reset */
+		if (ifp->bsscfgidx == 0)
+			inff_fwcmd_iovar_int_set(ifp, "closednet", 0);
+
+		err = inff_fwcmd_iovar_int_get(ifp, "apsta", &apsta);
+		if (err < 0)
+			inff_err("wl apsta failed (%d)\n", err);
+
+		if (!apsta) {
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_DOWN, 1);
+			if (err < 0)
+				iphy_err(drvr, "INFF_C_DOWN error %d\n", err);
+			err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_AP, 0);
+			if (err < 0)
+				iphy_err(drvr, "Set AP mode error %d\n", err);
+		}
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_MBSS))
+			inff_fwcmd_iovar_int_set(ifp, "mbss", 0);
+		inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_REGULATORY,
+				       ifp->vif->is_11d);
+		/* Bring device back up so it can be used again */
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_UP, 1);
+		if (err < 0)
+			iphy_err(drvr, "INFF_C_UP error %d\n", err);
+
+		inff_vif_clear_mgmt_ies(ifp->vif);
+	} else {
+		bss_enable.bsscfgidx = cpu_to_le32(ifp->bsscfgidx);
+		bss_enable.enable = cpu_to_le32(WL_IOV_OP_BSSCFG_DISABLE);
+		err = inff_fwcmd_iovar_data_set(ifp, "bss", &bss_enable,
+						sizeof(bss_enable));
+		if (err < 0)
+			iphy_err(drvr, "bss_enable config failed %d\n", err);
+	}
+	inff_set_mpc(ifp, 1);
+	clear_bit(INFF_VIF_STATUS_AP_CREATED, &ifp->vif->sme_state);
+	inff_net_setcarrier(ifp, false);
+
+	return err;
+}
+
+static int
+inff_cfg80211_del_station(struct wiphy *wiphy, struct net_device *ndev,
+			  struct station_del_parameters *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_scb_val_le scbval;
+	struct inff_if *ifp = netdev_priv(ndev);
+	s32 err;
+
+	if (!params->mac)
+		return -EFAULT;
+
+	inff_dbg(TRACE, "Deleting STA %pM\n", params->mac);
+
+	if (ifp->vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		ifp = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	memcpy(&scbval.ea, params->mac, ETH_ALEN);
+	scbval.val = cpu_to_le32(params->reason_code);
+	err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SCB_DEAUTHENTICATE_FOR_REASON,
+				      &scbval, sizeof(scbval));
+	if (err)
+		iphy_err(drvr, "SCB_DEAUTHENTICATE_FOR_REASON failed %d\n",
+			 err);
+
+	return err;
+}
+
+static int
+inff_cfg80211_change_station(struct wiphy *wiphy, struct net_device *ndev,
+			     const u8 *mac, struct station_parameters *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp = netdev_priv(ndev);
+	s32 err = 0;
+
+	inff_dbg(TRACE, "Changing STA %pM, mask 0x%04x set 0x%04x\n", mac,
+		 params->sta_flags_mask, params->sta_flags_set);
+
+	/* Ignore all 00 MAC */
+	if (is_zero_ether_addr(mac))
+		return 0;
+
+	if (!(params->sta_flags_mask & BIT(NL80211_STA_FLAG_AUTHORIZED)))
+		return 0;
+
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		if (params->sta_flags_set & BIT(NL80211_STA_FLAG_AUTHORIZED))
+			err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SCB_AUTHORIZE,
+						      (void *)mac, ETH_ALEN);
+		else
+			err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SCB_DEAUTHORIZE,
+						      (void *)mac, ETH_ALEN);
+		if (err < 0)
+			iphy_err(drvr, "Setting SCB (de-)authorize failed, %d\n", err);
+	}
+
+	return err;
+}
+
+static s32
+inff_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
+			  const u8 *mac, struct station_info *sinfo)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_scb_val_le scb_val;
+	s32 err = 0;
+	struct inff_sta_info_le sta_info_le;
+	u32 sta_flags;
+	s32 total_rssi_avg = 0;
+	s32 total_rssi = 0;
+	s32 count_rssi = 0;
+	int rssi;
+	u32 i;
+
+	inff_dbg(TRACE, "GET STA %pM\n", mac);
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	if (inff_vif_is_ibssmode(ifp->vif))
+		return inff_cfg80211_get_station_ibss(ifp, sinfo, mac);
+
+	memset(&sta_info_le, 0, sizeof(sta_info_le));
+	memcpy(&sta_info_le, mac, ETH_ALEN);
+
+	err = inff_fwcmd_iovar_data_get(ifp, "sta_info",
+					&sta_info_le,
+					sizeof(sta_info_le));
+	if (err < 0) {
+		iphy_err(drvr, "GET STA INFO failed, %d\n", err);
+		goto done;
+	}
+
+	inff_dbg(TRACE, "version %d\n", le16_to_cpu(sta_info_le.ver));
+	sinfo->filled = BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME);
+	sinfo->inactive_time = le32_to_cpu(sta_info_le.idle) * 1000;
+	sta_flags = le32_to_cpu(sta_info_le.flags);
+
+	inff_dbg(TRACE, "STA flags %08x\n", sta_flags);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_STA_FLAGS);
+	sinfo->sta_flags.mask = BIT(NL80211_STA_FLAG_WME) |
+		    BIT(NL80211_STA_FLAG_AUTHENTICATED) |
+		    BIT(NL80211_STA_FLAG_ASSOCIATED) |
+		    BIT(NL80211_STA_FLAG_AUTHORIZED);
+	if (sta_flags & INFF_STA_WME)
+		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_WME);
+	if (sta_flags & INFF_STA_AUTHE)
+		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_AUTHENTICATED);
+	if (sta_flags & INFF_STA_ASSOC)
+		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_ASSOCIATED);
+	if (sta_flags & INFF_STA_AUTHO)
+		sinfo->sta_flags.set |= BIT(NL80211_STA_FLAG_AUTHORIZED);
+
+	if (sta_flags & INFF_STA_ASSOC) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CONNECTED_TIME);
+		sinfo->connected_time = le32_to_cpu(sta_info_le.in);
+		inff_fill_bss_param(ifp, sinfo);
+	}
+	if (sta_flags & INFF_STA_SCBSTATS) {
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+		sinfo->tx_failed = le32_to_cpu(sta_info_le.tx_failures);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+		sinfo->tx_packets = le32_to_cpu(sta_info_le.tx_pkts);
+		sinfo->tx_packets += le32_to_cpu(sta_info_le.tx_mcast_pkts);
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		sinfo->rx_packets = le32_to_cpu(sta_info_le.rx_ucast_pkts);
+		sinfo->rx_packets += le32_to_cpu(sta_info_le.rx_mcast_pkts);
+		if (sinfo->tx_packets) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+			sinfo->txrate.legacy =
+				le32_to_cpu(sta_info_le.tx_rate) / 100;
+		}
+		if (sinfo->rx_packets) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
+			sinfo->rxrate.legacy =
+				le32_to_cpu(sta_info_le.rx_rate) / 100;
+		}
+		if (le16_to_cpu(sta_info_le.ver) >= 4) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES);
+			sinfo->tx_bytes = le64_to_cpu(sta_info_le.tx_tot_bytes);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES);
+			sinfo->rx_bytes = le64_to_cpu(sta_info_le.rx_tot_bytes);
+		}
+		for (i = 0; i < INFF_ANT_MAX; i++) {
+			if (sta_info_le.rssi[i] == 0 ||
+			    sta_info_le.rx_lastpkt_rssi[i] == 0)
+				continue;
+			sinfo->chains |= BIT(count_rssi);
+			sinfo->chain_signal[count_rssi] =
+				sta_info_le.rx_lastpkt_rssi[i];
+			sinfo->chain_signal_avg[count_rssi] =
+				sta_info_le.rssi[i];
+			total_rssi += sta_info_le.rx_lastpkt_rssi[i];
+			total_rssi_avg += sta_info_le.rssi[i];
+			count_rssi++;
+		}
+		if (count_rssi) {
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
+			sinfo->filled |=
+				BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL_AVG);
+			sinfo->signal = total_rssi / count_rssi;
+			sinfo->signal_avg = total_rssi_avg / count_rssi;
+		} else if (test_bit(INFF_VIF_STATUS_CONNECTED,
+			&ifp->vif->sme_state)) {
+			memset(&scb_val, 0, sizeof(scb_val));
+			memcpy(&scb_val.ea[0], mac, ETH_ALEN);
+			err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_RSSI,
+						      &scb_val, sizeof(scb_val));
+			if (err) {
+				iphy_err(drvr, "Could not get rssi (%d)\n",
+					 err);
+				goto done;
+			} else {
+				rssi = le32_to_cpu(scb_val.val);
+				sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
+				sinfo->signal = rssi;
+				inff_dbg(CONN, "RSSI %d dBm\n", rssi);
+			}
+		}
+	}
+done:
+	return err;
+}
+
+static int
+inff_cfg80211_dump_station(struct wiphy *wiphy, struct net_device *ndev,
+			   int idx, u8 *mac, struct station_info *sinfo)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	s32 err;
+
+	inff_dbg(TRACE, "Dump STA idx %d\n", idx);
+
+	if (idx == 0) {
+		cfg->assoclist.count = cpu_to_le32(INFF_MAX_ASSOCLIST);
+		err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_ASSOCLIST,
+					      &cfg->assoclist,
+					      sizeof(cfg->assoclist));
+		if (err) {
+			/* GET_ASSOCLIST unsupported by firmware of older chips */
+			if (err == -EBADE)
+				iphy_info_once(drvr, "INFF_C_GET_ASSOCLIST unsupported\n");
+			else
+				iphy_err(drvr, "INFF_C_GET_ASSOCLIST failed, err=%d\n",
+					 err);
+
+			cfg->assoclist.count = 0;
+			return -EOPNOTSUPP;
+		}
+	}
+	if (idx < le32_to_cpu(cfg->assoclist.count)) {
+		memcpy(mac, cfg->assoclist.mac[idx], ETH_ALEN);
+		return inff_cfg80211_get_station(wiphy, ndev, mac, sinfo);
+	}
+	return -ENOENT;
+}
+
+static s32
+inff_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
+		      struct cfg80211_connect_params *sme)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct ieee80211_channel *chan = sme->channel;
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_join_params join_params;
+	struct inff_cp_connect_le connect;
+	size_t join_params_size;
+	const struct inff_tlv *rsn_ie;
+	const struct inff_vs_tlv *wpa_ie;
+	const void *ie;
+	u32 ie_len;
+	struct inff_ext_join_params_le *ext_join_params;
+	u16 chanspec;
+	s32 err = 0;
+	u32 ssid_len;
+	bool skip_hints;
+	u32 security_type = 0;
+	u32 option = 0;
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	if (!sme->ssid) {
+		iphy_err(drvr, "Invalid ssid\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (inff_socitype_is_cp(drvr->bus_if)) {
+		set_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+
+		memset(&connect, 0, sizeof(connect));
+
+		connect.ssid_length = min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);
+		memcpy(connect.ssid, sme->ssid, connect.ssid_length);
+
+		inff_dbg(CONN, "SSID \"%s\", len (%d)\n",
+			 connect.ssid, connect.ssid_length);
+
+		inff_dbg(CONN, "BSSID \"%pM\"\n", sme->bssid);
+
+		if (sme->bssid)
+			memcpy(connect.macaddr, sme->bssid, ETH_ALEN);
+
+	} else if (inff_socitype_is_ai(drvr->bus_if)) {
+		/* override bssid_hint for oce networks */
+		skip_hints = wl_cfg80211_is_oce_ap(ifp, wiphy, sme->bssid_hint);
+		if (skip_hints) {
+			/* Let fw choose the best AP */
+			inff_dbg(TRACE, "Skipping bssid & channel hint\n");
+		} else {
+			if (sme->channel_hint)
+				chan = sme->channel_hint;
+
+			if (sme->bssid_hint)
+				sme->bssid = sme->bssid_hint;
+		}
+
+		/* FT Cert: Handling the roam request from supplicant for FT roaming */
+		if (sme->prev_bssid && sme->bssid &&
+		    inff_feat_is_enabled(ifp, INFF_FEAT_FBT) &&
+		    wpa_akm_ft(sme->crypto.akm_suites[0])) {
+			/* Only reassoc IOVAR required for Roam skip additional IOVAR */
+			struct inff_assoc_params_le ext_roam_params;
+
+			inff_dbg(CONN, "Trying to REASSOC For FT\n");
+			memset(&ext_roam_params, 0, sizeof(ext_roam_params));
+			memcpy(&ext_roam_params.bssid, sme->bssid, ETH_ALEN);
+			set_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+
+			err = inff_fwcmd_cmd_data_set(ifp, INFF_C_REASSOC,
+						      &ext_roam_params,
+						      sizeof(ext_roam_params));
+			goto done;
+		}
+
+		if (ifp->vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif) {
+			/* A normal (non P2P) connection request setup. */
+			ie = NULL;
+			ie_len = 0;
+			/* find the WPA_IE */
+			wpa_ie = inff_find_wpaie((u8 *)sme->ie, sme->ie_len);
+			if (wpa_ie) {
+				ie = wpa_ie;
+				ie_len = wpa_ie->len + TLV_HDR_LEN;
+			} else {
+				/* find the RSN_IE */
+				rsn_ie = inff_parse_tlvs((const u8 *)sme->ie,
+							 sme->ie_len,
+							 WLAN_EID_RSN);
+				if (rsn_ie) {
+					ie = rsn_ie;
+					ie_len = rsn_ie->len + TLV_HDR_LEN;
+				}
+			}
+			inff_fwcmd_iovar_data_set(ifp, "wpaie", ie, ie_len);
+			if (err)
+				iphy_err(drvr, "wpaie failed: err=%d\n", err);
+		}
+
+		err = inff_vif_set_mgmt_ie(ifp->vif, INFF_VNDR_IE_ASSOCREQ_FLAG,
+					   sme->ie, sme->ie_len);
+		if (err)
+			iphy_err(drvr, "Set Assoc REQ IE Failed\n");
+		else
+			inff_dbg(TRACE, "Applied Vndr IEs for Assoc request\n");
+
+		set_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	}
+
+	if (chan) {
+		cfg->channel =
+			ieee80211_frequency_to_channel(chan->center_freq);
+		chanspec = inff_nl80211_chan_to_chanspec(chan);
+		inff_dbg(CONN, "channel=%d, center_req=%d, chanspec=0x%04x\n",
+			 cfg->channel, chan->center_freq, chanspec);
+	} else {
+		cfg->channel = 0;
+		chanspec = 0;
+	}
+
+	inff_dbg(INFO, "ie (%p), ie_len (%zd)\n", sme->ie, sme->ie_len);
+
+	if (inff_socitype_is_cp(drvr->bus_if)) {
+		err = inff_cp_cfg80211_get_security_mode(ifp, sme, &security_type);
+		if (err)
+			goto done;
+
+		if (security_type & AES_ENABLED) {
+			if (security_type & WPA2_SECURITY) {
+				if (!sme->crypto.psk) {
+					inff_err("PSK is null\n");
+					err = -EINVAL;
+					goto done;
+				}
+				option |= JOIN_OP_PMK;
+				memcpy(connect.password, sme->crypto.psk, WLAN_PMK_LEN);
+			}
+
+			if (security_type & WPA3_SECURITY) {
+				if (!sme->crypto.sae_pwd) {
+					inff_err("SAE password is null\n");
+					err = -EINVAL;
+					goto done;
+				}
+				memcpy(connect.password, sme->crypto.sae_pwd,
+				       sme->crypto.sae_pwd_len);
+			}
+		}
+
+		connect.security_type = cpu_to_le32(security_type);
+		connect.option = cpu_to_le32(option);
+		err = inff_cpcmd_data_set(ifp, INFF_CP_C_CONNECT, &connect,
+					  sizeof(connect));
+		if (err)
+			goto done;
+
+		return 0;
+	}
+
+	err = inff_set_wpa_version(ndev, sme);
+	if (err) {
+		iphy_err(drvr, "SET wpa_version failed (%d)\n", err);
+		goto done;
+	}
+
+	sme->auth_type = inff_war_auth_type(ifp, sme->auth_type);
+	err = inff_set_auth_type(ndev, sme);
+	if (err) {
+		iphy_err(drvr, "SET auth_type failed (%d)\n", err);
+		goto done;
+	}
+
+	err = inff_set_wsec_mode(ndev, sme);
+	if (err) {
+		iphy_err(drvr, "SET set_cipher failed (%d)\n", err);
+		goto done;
+	}
+
+	err = inff_set_key_mgmt(ndev, sme);
+	if (err) {
+		iphy_err(drvr, "SET key_mgmt failed (%d)\n", err);
+		goto done;
+	}
+
+	err = inff_set_sharedkey(ndev, sme);
+	if (err) {
+		iphy_err(drvr, "SET sharedkey failed (%d)\n", err);
+		goto done;
+	}
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FWSUP)) {
+		if (sme->crypto.psk) {
+			if (profile->use_fwsup != INFF_PROFILE_FWSUP_SAE) {
+				if (WARN_ON(profile->use_fwsup !=
+					INFF_PROFILE_FWSUP_NONE)) {
+					err = -EINVAL;
+					goto done;
+				}
+				inff_dbg(INFO, "using PSK offload\n");
+				profile->use_fwsup = INFF_PROFILE_FWSUP_PSK;
+			}
+		}
+
+		if (profile->use_fwsup != INFF_PROFILE_FWSUP_NONE) {
+			/* enable firmware supplicant for this interface */
+			err = inff_fwcmd_iovar_int_set(ifp, "sup_wpa", 1);
+			if (err < 0) {
+				iphy_err(drvr, "failed to enable fw supplicant\n");
+				goto done;
+			}
+		} else {
+			err = inff_fwcmd_iovar_int_set(ifp, "sup_wpa", 0);
+		}
+
+		if (sme->crypto.psk) {
+			if (profile->use_fwsup == INFF_PROFILE_FWSUP_PSK) {
+				err = inff_set_pmk(ifp, sme->crypto.psk,
+						   INFF_WSEC_MAX_PSK_LEN);
+			}
+		}
+
+		/* if upper layer has passed sae_password,
+		 * set it to firmware for the potential transit up roaming use.
+		 */
+		if (sme->crypto.sae_pwd && inff_feat_is_enabled(ifp, INFF_FEAT_SAE)) {
+			/* clean up user-space RSNE */
+			if (inff_fwcmd_iovar_data_set(ifp, "wpaie", NULL, 0)) {
+				iphy_err(drvr, "failed to clean up user-space RSNE\n");
+				goto done;
+			}
+			err = inff_set_sae_password(ifp, sme->crypto.sae_pwd,
+						    sme->crypto.sae_pwd_len);
+			if (!err && sme->crypto.psk)
+				err = inff_set_pmk(ifp, sme->crypto.psk,
+						   INFF_WSEC_MAX_PSK_LEN);
+		}
+		if (err)
+			goto done;
+
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_OWE) &&
+		    sme->crypto.akm_suites[0] == WLAN_AKM_SUITE_OWE) {
+			/* clean up user-space RSNE */
+			if (inff_fwcmd_iovar_data_set(ifp, "wpaie", NULL, 0)) {
+				iphy_err(drvr, "failed to clean up user-space RSNE\n");
+				goto done;
+			}
+		}
+	}
+	/* Join with specific BSSID and cached SSID
+	 * If SSID is zero join based on BSSID only
+	 */
+	join_params_size = offsetof(struct inff_ext_join_params_le, assoc_le) +
+		offsetof(struct inff_assoc_params_le, chanspec_list);
+	if (cfg->channel)
+		join_params_size += sizeof(u16);
+	ext_join_params = kzalloc(sizeof(*ext_join_params), GFP_KERNEL);
+	if (!ext_join_params) {
+		err = -ENOMEM;
+		goto done;
+	}
+	ssid_len = min_t(u32, sme->ssid_len, IEEE80211_MAX_SSID_LEN);
+	ext_join_params->ssid_le.SSID_len = cpu_to_le32(ssid_len);
+	memcpy(&ext_join_params->ssid_le.SSID, sme->ssid, ssid_len);
+	if (ssid_len < IEEE80211_MAX_SSID_LEN)
+		inff_dbg(CONN, "SSID \"%s\", len (%d)\n",
+			 ext_join_params->ssid_le.SSID, ssid_len);
+
+	/* Set up join scan parameters */
+	ext_join_params->scan_le.scan_type = -1;
+	ext_join_params->scan_le.home_time = cpu_to_le32(-1);
+
+	if (sme->bssid)
+		memcpy(&ext_join_params->assoc_le.bssid, sme->bssid, ETH_ALEN);
+	else
+		eth_broadcast_addr(ext_join_params->assoc_le.bssid);
+
+	if (cfg->channel) {
+		ext_join_params->assoc_le.chanspec_num = cpu_to_le32(1);
+		ext_join_params->assoc_le.chanspec_list =
+			cpu_to_le16(chanspec);
+
+		/* Increase dwell time to receive probe response or detect
+		 * beacon from target AP at a noisy air only during connect
+		 * command.
+		 */
+		if (INFF_CHSPEC_IS6G(chanspec)) {
+			ext_join_params->scan_le.active_time =
+				cpu_to_le32(INFF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS_6E);
+			ext_join_params->scan_le.passive_time =
+				cpu_to_le32(INFF_SCAN_JOIN_PASSIVE_DWELL_TIME_MS_6E);
+		} else {
+			ext_join_params->scan_le.active_time =
+				cpu_to_le32(INFF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS);
+			ext_join_params->scan_le.passive_time =
+				cpu_to_le32(INFF_SCAN_JOIN_PASSIVE_DWELL_TIME_MS);
+		}
+
+		/* To sync with presence period of VSDB GO send probe request
+		 * more frequently. Probe request will be stopped when it gets
+		 * probe response from target AP/GO.
+		 */
+		ext_join_params->scan_le.nprobes =
+			cpu_to_le32(INFF_SCAN_JOIN_ACTIVE_DWELL_TIME_MS /
+				    INFF_SCAN_JOIN_PROBE_INTERVAL_MS);
+	} else {
+		ext_join_params->scan_le.active_time = cpu_to_le32(-1);
+		ext_join_params->scan_le.passive_time = cpu_to_le32(-1);
+		ext_join_params->scan_le.nprobes = cpu_to_le32(-1);
+	}
+
+	inff_set_join_pref(ifp, &sme->bss_select);
+
+	/* The internal supplicant judges to use assoc or reassoc itself.
+	 * it is not necessary to specify REASSOC
+	 */
+	if (sme->prev_bssid && !inff_feat_is_enabled(ifp, INFF_FEAT_FWSUP)) {
+		inff_dbg(CONN, "Trying to REASSOC\n");
+		join_params_size = sizeof(ext_join_params->assoc_le);
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_REASSOC,
+					      &ext_join_params->assoc_le, join_params_size);
+	} else {
+		err  = inff_fwcmd_bsscfg_data_set(ifp, "join", ext_join_params,
+						  join_params_size);
+	}
+	kfree(ext_join_params);
+	if (!err)
+		/* This is it. join command worked, we are done */
+		goto done;
+
+	/* join command failed, fallback to set ssid */
+	memset(&join_params, 0, sizeof(join_params));
+	join_params_size = sizeof(join_params.ssid_le);
+
+	memcpy(&join_params.ssid_le.SSID, sme->ssid, ssid_len);
+	join_params.ssid_le.SSID_len = cpu_to_le32(ssid_len);
+
+	if (sme->bssid)
+		memcpy(join_params.params_le.bssid, sme->bssid, ETH_ALEN);
+	else
+		eth_broadcast_addr(join_params.params_le.bssid);
+
+	if (cfg->channel) {
+		join_params.params_le.chanspec_list = cpu_to_le16(chanspec);
+		join_params.params_le.chanspec_num = cpu_to_le32(1);
+		join_params_size += sizeof(join_params.params_le);
+	}
+	err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SSID,
+				      &join_params, join_params_size);
+	if (err)
+		iphy_err(drvr, "INFF_C_SET_SSID failed (%d)\n", err);
+done:
+	if (err)
+		clear_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	return err;
+}
+
+static int
+inff_cfg80211_update_conn_params(struct wiphy *wiphy,
+				 struct net_device *ndev,
+				 struct cfg80211_connect_params *sme,
+				 u32 changed)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp;
+	int err;
+
+	if (!(changed & UPDATE_ASSOC_IES))
+		return 0;
+
+	ifp = netdev_priv(ndev);
+	err = inff_vif_set_mgmt_ie(ifp->vif, INFF_VNDR_IE_ASSOCREQ_FLAG,
+				   sme->ie, sme->ie_len);
+	if (err)
+		iphy_err(drvr, "Set Assoc REQ IE Failed\n");
+	else
+		inff_dbg(TRACE, "Applied Vndr IEs for Assoc request\n");
+
+	return err;
+}
+
+static s32
+inff_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev,
+			 u16 reason_code)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_scb_val_le scbval;
+	s32 err = 0;
+
+	inff_dbg(TRACE, "Disconnect, reason code = %d\n", reason_code);
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	clear_bit(INFF_VIF_STATUS_CONNECTED, &ifp->vif->sme_state);
+	clear_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	clear_bit(INFF_VIF_STATUS_EAP_SUCCESS, &ifp->vif->sme_state);
+	clear_bit(INFF_VIF_STATUS_ASSOC_SUCCESS, &ifp->vif->sme_state);
+	cfg80211_disconnected(ndev, reason_code, NULL, 0, true, GFP_KERNEL);
+
+	if (inff_socitype_is_cp(ifp->drvr->bus_if)) {
+		err = inff_cpcmd_data_set(ifp, INFF_CP_C_DISCONNECT, NULL, 0);
+		if (err) {
+			iphy_err(drvr, "Disconnect failed %d\n", err);
+			return -EINVAL;
+		}
+	} else {
+		memcpy(&scbval.ea, &profile->bssid, ETH_ALEN);
+		scbval.val = cpu_to_le32(reason_code);
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_DISASSOC,
+					      &scbval, sizeof(scbval));
+		if (err) {
+			iphy_err(drvr, "error (%d)\n", err);
+		} else {
+			if (inff_feat_is_enabled(ifp, INFF_FEAT_TWT)) {
+				/* Cleanup TWT Session list */
+				inff_twt_cleanup_all_sess(ifp);
+			}
+		}
+	}
+	return err;
+}
+
+static s32
+inff_cfg80211_join_ibss(struct wiphy *wiphy, struct net_device *ndev,
+			struct cfg80211_ibss_params *params)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_profile *profile = &ifp->vif->profile;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_join_params join_params;
+	size_t join_params_size = 0;
+	s32 err = 0;
+	s32 wsec = 0;
+	s32 bcnprd;
+	u16 chanspec;
+	u32 ssid_len;
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	if (params->ssid) {
+		inff_dbg(CONN, "SSID: %s\n", params->ssid);
+	} else {
+		inff_dbg(CONN, "SSID: NULL, Not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	set_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+
+	if (params->bssid)
+		inff_dbg(CONN, "BSSID: %pM\n", params->bssid);
+	else
+		inff_dbg(CONN, "No BSSID specified\n");
+
+	if (params->chandef.chan)
+		inff_dbg(CONN, "channel: %d\n",
+			 params->chandef.chan->center_freq);
+	else
+		inff_dbg(CONN, "no channel specified\n");
+
+	if (params->channel_fixed)
+		inff_dbg(CONN, "fixed channel required\n");
+	else
+		inff_dbg(CONN, "no fixed channel required\n");
+
+	if (params->ie && params->ie_len)
+		inff_dbg(CONN, "ie len: %d\n", params->ie_len);
+	else
+		inff_dbg(CONN, "no ie specified\n");
+
+	if (params->beacon_interval)
+		inff_dbg(CONN, "beacon interval: %d\n",
+			 params->beacon_interval);
+	else
+		inff_dbg(CONN, "no beacon interval specified\n");
+
+	if (params->basic_rates)
+		inff_dbg(CONN, "basic rates: %08X\n", params->basic_rates);
+	else
+		inff_dbg(CONN, "no basic rates specified\n");
+
+	if (params->privacy)
+		inff_dbg(CONN, "privacy required\n");
+	else
+		inff_dbg(CONN, "no privacy required\n");
+
+	/* Configure Privacy for starter */
+	if (params->privacy)
+		wsec |= WEP_ENABLED;
+
+	err = inff_fwcmd_iovar_int_set(ifp, "wsec", wsec);
+	if (err) {
+		iphy_err(drvr, "wsec failed (%d)\n", err);
+		goto done;
+	}
+
+	/* Configure Beacon Interval for starter */
+	if (params->beacon_interval)
+		bcnprd = params->beacon_interval;
+	else
+		bcnprd = 100;
+
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_BCNPRD, bcnprd);
+	if (err) {
+		iphy_err(drvr, "WLC_SET_BCNPRD failed (%d)\n", err);
+		goto done;
+	}
+
+	/* Configure required join parameter */
+	memset(&join_params, 0, sizeof(struct inff_join_params));
+
+	/* SSID */
+	ssid_len = min_t(u32, params->ssid_len, IEEE80211_MAX_SSID_LEN);
+	memcpy(join_params.ssid_le.SSID, params->ssid, ssid_len);
+	join_params.ssid_le.SSID_len = cpu_to_le32(ssid_len);
+	join_params_size = sizeof(join_params.ssid_le);
+
+	/* BSSID */
+	if (params->bssid) {
+		memcpy(join_params.params_le.bssid, params->bssid, ETH_ALEN);
+		join_params_size += INFF_ASSOC_PARAMS_FIXED_SIZE;
+		memcpy(profile->bssid, params->bssid, ETH_ALEN);
+	} else {
+		eth_broadcast_addr(join_params.params_le.bssid);
+		eth_zero_addr(profile->bssid);
+	}
+
+	/* Channel */
+	if (params->chandef.chan) {
+		u32 target_channel;
+
+		cfg->channel =
+			ieee80211_frequency_to_channel(params->chandef.chan->center_freq);
+		if (params->channel_fixed) {
+			/* adding chanspec */
+			chanspec = inff_nl80211_chandef_to_chanspec(&params->chandef);
+			join_params.params_le.chanspec_list =
+				cpu_to_le16(chanspec);
+			join_params.params_le.chanspec_num = cpu_to_le32(1);
+			join_params_size += sizeof(join_params.params_le);
+		}
+
+		/* set channel for starter */
+		target_channel = cfg->channel;
+		err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_CHANNEL,
+					     target_channel);
+		if (err) {
+			iphy_err(drvr, "WLC_SET_CHANNEL failed (%d)\n", err);
+			goto done;
+		}
+	} else {
+		cfg->channel = 0;
+	}
+
+	cfg->ibss_starter = false;
+
+	err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_SSID,
+				      &join_params, join_params_size);
+	if (err) {
+		iphy_err(drvr, "WLC_SET_SSID failed (%d)\n", err);
+		goto done;
+	}
+done:
+	if (err)
+		clear_bit(INFF_VIF_STATUS_CONNECTING, &ifp->vif->sme_state);
+	return err;
+}
+
+static s32
+inff_cfg80211_leave_ibss(struct wiphy *wiphy, struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	if (!inff_check_vif_up(ifp->vif)) {
+		/* When driver is being unloaded, it can end up here. If an
+		 * error is returned then later on a debug trace in the wireless
+		 * core module will be printed. To avoid this 0 is returned.
+		 */
+		return 0;
+	}
+
+	inff_link_down(ifp->vif, WLAN_REASON_DEAUTH_LEAVING, true);
+	inff_net_setcarrier(ifp, false);
+
+	return 0;
+}
+
+static s32 inff_cfg80211_set_wiphy_params(struct wiphy *wiphy, int radio_idx,
+					  u32 changed)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	s32 err = 0;
+
+	if (inff_socitype_is_ai(ifp->drvr->bus_if))
+		if (!inff_check_vif_up(ifp->vif))
+			return -EIO;
+
+	if (changed & WIPHY_PARAM_RTS_THRESHOLD &&
+	    cfg->conf.rts_threshold != wiphy->rts_threshold) {
+		cfg->conf.rts_threshold = wiphy->rts_threshold;
+		err = inff_set_rts(ndev, cfg->conf.rts_threshold);
+		if (!err)
+			goto done;
+	}
+	if (changed & WIPHY_PARAM_FRAG_THRESHOLD &&
+	    cfg->conf.frag_threshold != wiphy->frag_threshold) {
+		cfg->conf.frag_threshold = wiphy->frag_threshold;
+		err = inff_set_frag(ndev, cfg->conf.frag_threshold);
+		if (!err)
+			goto done;
+	}
+	if (changed & WIPHY_PARAM_RETRY_LONG &&
+	    cfg->conf.retry_long != wiphy->retry_long) {
+		cfg->conf.retry_long = wiphy->retry_long;
+		err = inff_set_retry(ndev, cfg->conf.retry_long, true);
+		if (!err)
+			goto done;
+	}
+	if (changed & WIPHY_PARAM_RETRY_SHORT &&
+	    cfg->conf.retry_short != wiphy->retry_short) {
+		cfg->conf.retry_short = wiphy->retry_short;
+		err = inff_set_retry(ndev, cfg->conf.retry_short, false);
+		if (!err)
+			goto done;
+	}
+done:
+	return err;
+}
+
+static s32
+inff_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+			   int radio_idx, enum nl80211_tx_power_setting type,
+			   s32 mbm)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	s32 err;
+	s32 disable;
+	u32 qdbm = 127;
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	switch (type) {
+	case NL80211_TX_POWER_AUTOMATIC:
+		break;
+	case NL80211_TX_POWER_LIMITED:
+	case NL80211_TX_POWER_FIXED:
+		if (mbm < 0) {
+			iphy_err(drvr, "TX_POWER_FIXED - dbm is negative\n");
+			err = -EINVAL;
+			goto done;
+		}
+		qdbm =  MBM_TO_DBM(4 * mbm);
+		if (qdbm > 127)
+			qdbm = 127;
+		qdbm |= WL_TXPWR_OVERRIDE;
+		break;
+	default:
+		iphy_err(drvr, "Unsupported type %d\n", type);
+		err = -EINVAL;
+		goto done;
+	}
+	/* Make sure radio is off or on as far as software is concerned */
+	disable = WL_RADIO_SW_DISABLE << 16;
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_RADIO, disable);
+	if (err)
+		iphy_err(drvr, "WLC_SET_RADIO error (%d)\n", err);
+
+	err = inff_fwcmd_iovar_int_set(ifp, "qtxpower", qdbm);
+	if (err)
+		iphy_err(drvr, "qtxpower error (%d)\n", err);
+done:
+	inff_dbg(TRACE, "Set TX power %ld (qdbm)\n", qdbm & ~WL_TXPWR_OVERRIDE);
+	return err;
+}
+
+static s32
+inff_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+			   int radio_idx, unsigned int link_id, s32 *dbm)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+	struct inff_pub *drvr = cfg->pub;
+	s32 qdbm = 0;
+	s32 err;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	if (!inff_check_vif_up(vif))
+		return -EIO;
+
+	err = inff_fwcmd_iovar_int_get(vif->ifp, "qtxpower", &qdbm);
+	if (err) {
+		iphy_err(drvr, "error (%d)\n", err);
+		goto done;
+	}
+	*dbm = (qdbm & ~WL_TXPWR_OVERRIDE) / 4;
+done:
+	inff_dbg(TRACE, "Get TX power (0x%x %d)\n", qdbm, *dbm);
+	return err;
+}
+
+static int
+inff_cfg80211_set_bitrate(struct wiphy *wiphy, struct net_device *ndev,
+			  unsigned int link_id, const u8 *addr,
+			  const struct cfg80211_bitrate_mask *mask)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	s32 ret = TIME_OK;
+	u8 he, band;
+
+	ret = inff_he_get_enable(ifp, &he, sizeof(he));
+	if (!ret && !he) {
+		inff_dbg(INFO, "Only HE mode rate setting supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		if (band != NL80211_BAND_2GHZ && band != NL80211_BAND_5GHZ &&
+		    band != NL80211_BAND_6GHZ) {
+			continue;
+		}
+
+		/* Skip setting HE rates if legacy rate set is called from userspace.
+		 * Also if any one of 2.4, 5 or 6GHz is being called then other two will have
+		 * an invalid he mask of 0xFFF so skip setting he rates for other two bands.
+		 */
+		if (!mask->control[band].he_mcs[0] || mask->control[band].he_mcs[0] == 0xFFF)
+			continue;
+
+		ret = inff_he_set_bitrate(ifp, mask, band);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static s32
+inff_cfg80211_set_pmksa(struct wiphy *wiphy, struct net_device *ndev,
+			struct cfg80211_pmksa *pmksa)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	s32 err;
+
+	if (inff_socitype_is_cp(drvr->bus_if)) {
+		inff_err("Not supported yet for CP\n");
+		return 0;
+	}
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	inff_dbg(CONN, "set_pmksa - PMK bssid: %pM =\n", pmksa->bssid);
+	inff_dbg(CONN, "%*ph\n", WLAN_PMKID_LEN, pmksa->pmkid);
+
+	err = inff_update_pmksa(cfg, ifp, pmksa->bssid, pmksa->pmkid, PMKSA_SET);
+	if (err < 0) {
+		iphy_err(drvr,
+			 "PMKSA_SET inff_update_pmksa failed: ret=%d\n",
+			 err);
+		goto exit;
+	}
+
+	if (pmksa->pmk_len && pmksa->pmk_len < INFF_WSEC_PMK_LEN_SUITEB_192) {
+		/* external supplicant stores SUITEB-192 PMK */
+		if (ifp->vif->profile.is_okc) {
+			err = inff_fwcmd_iovar_data_set(ifp, "okc_info_pmk", pmksa->pmk,
+							pmksa->pmk_len);
+			if (err < 0)
+				iphy_err(drvr, "okc_info_pmk iovar failed: ret=%d\n", err);
+		} else {
+			inff_set_pmk(ifp, pmksa->pmk, pmksa->pmk_len);
+		}
+	}
+exit:
+	return err;
+}
+
+static s32
+inff_cfg80211_del_pmksa(struct wiphy *wiphy, struct net_device *ndev,
+			struct cfg80211_pmksa *pmksa)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+	s32 err;
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	inff_dbg(CONN, "del_pmksa - PMK bssid = %pM\n", pmksa->bssid);
+
+	/* TODO: implement PMKID_V2 */
+	err = inff_update_pmksa(cfg, ifp, pmksa->bssid, pmksa->pmkid, PMKSA_DELETE);
+	if (err < 0) {
+		iphy_err(drvr,
+			 "PMKSA_DELETE inff_update_pmksa failed: ret=%d\n",
+			 err);
+		return err;
+	}
+
+	return err;
+}
+
+static s32
+inff_cfg80211_flush_pmksa(struct wiphy *wiphy, struct net_device *ndev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	s32 err;
+
+	if (inff_socitype_is_cp(ifp->drvr->bus_if))
+		return 0;
+
+	if (!inff_check_vif_up(ifp->vif))
+		return -EIO;
+
+	memset(&cfg->pmk_list, 0, sizeof(cfg->pmk_list));
+	err = inff_update_pmklist(cfg, ifp);
+
+	return err;
+}
+
+static int
+inff_cfg80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+				struct ieee80211_channel *channel,
+				unsigned int duration, u64 *cookie)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	if (wdev->iftype != NL80211_IFTYPE_P2P_DEVICE)
+		return -EOPNOTSUPP;
+
+	return inff_p2p_remain_on_channel(p2p, wdev, channel,
+					  duration, cookie);
+}
+
+static int
+inff_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
+				       struct wireless_dev *wdev,
+				       u64 cookie)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	if (wdev->iftype != NL80211_IFTYPE_P2P_DEVICE)
+		return -EOPNOTSUPP;
+
+	return inff_p2p_cancel_remain_on_channel(p2p, wdev);
+}
+
+static int
+inff_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+		      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_pub *drvr = cfg->pub;
+	const struct ieee80211_mgmt *mgmt;
+	const u8 *buf = params->buf;
+	size_t len = params->len;
+
+	mgmt = (const struct ieee80211_mgmt *)buf;
+
+	if (!ieee80211_is_mgmt(mgmt->frame_control)) {
+		iphy_err(drvr, "Driver only allows MGMT packet type\n");
+		return -EPERM;
+	}
+
+	if (ieee80211_is_probe_resp(mgmt->frame_control))
+		return inff_mgmt_probe_resp_tx(cfg, wdev, params, cookie);
+
+	if (ieee80211_is_action(mgmt->frame_control))
+		return inff_mgmt_action_tx(cfg, wdev, params, cookie);
+
+	if (ieee80211_is_auth(mgmt->frame_control))
+		return inff_mgmt_auth_tx(cfg, wdev, params, cookie);
+
+	inff_dbg(TRACE, "Unhandled, fc=%04x!!\n", mgmt->frame_control);
+	inff_dbg_hex_dump(INFF_MSGLVL_ON(TRACE), buf, len,
+			  "payload, len=%zu\n", len);
+
+	return 0;
+}
+
+static s32
+inff_cfg80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *ndev,
+			     bool enabled, s32 timeout)
+{
+	s32 pm;
+	s32 err = 0;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pub *drvr = cfg->pub;
+
+	if (inff_socitype_is_cp(drvr->bus_if))
+		return 0;
+	/*
+	 * Powersave enable/disable request is coming from the
+	 * cfg80211 even before the interface is up. In that
+	 * scenario, driver will be storing the power save
+	 * preference in cfg struct to apply this to
+	 * FW later while initializing the dongle
+	 */
+	cfg->pwr_save = enabled;
+	if (!inff_check_vif_up(ifp->vif)) {
+		inff_dbg(INFO, "Device is not ready, storing the value in cfg_info struct\n");
+		goto done;
+	}
+
+	pm = enabled ? INFF_PM_FAST : INFF_PM_OFF;
+	/* Do not enable the power save after assoc if it is a p2p interface */
+	if (ifp->vif->wdev.iftype == NL80211_IFTYPE_P2P_CLIENT) {
+		inff_dbg(INFO, "Do not enable power save for P2P clients\n");
+		pm = INFF_PM_OFF;
+	}
+
+	inff_dbg(INFO, "power save %s\n", (pm ? "enabled" : "disabled"));
+
+	err = inff_fwcmd_cmd_int_set(ifp, INFF_C_SET_PM, pm);
+	if (err) {
+		if (err == -ENODEV)
+			iphy_err(drvr, "net_device is not ready yet\n");
+		else
+			iphy_err(drvr, "error (%d)\n", err);
+	}
+done:
+	return err;
+}
+
+static int
+inff_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev,
+				  s32 rssi_thold, u32 rssi_hyst)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp;
+	struct inff_rssi_new_event_le rssi = {0};
+	int err = 0;
+
+	ifp = netdev_priv(dev);
+	if (rssi_thold == cfg->cqm_info.rssi_threshold)
+		return err;
+
+	if (rssi_thold == 0) {
+		rssi.rate_limit_msec = cpu_to_le32(0);
+		rssi.num_rssi_levels = 0;
+		rssi.version = WL_RSSI_EVENT_VERSION_NEW;
+	} else {
+		rssi.rate_limit_msec = cpu_to_le32(0);
+		rssi.num_rssi_levels = 3;
+		rssi.rssi_levels[0] = S8_MIN;
+		rssi.rssi_levels[1] = rssi_thold;
+		rssi.rssi_levels[2] = S8_MAX;
+		rssi.version = WL_RSSI_EVENT_VERSION_OLD;
+	}
+
+	err = inff_fwcmd_iovar_data_set(ifp, "rssi_event", &rssi, sizeof(rssi));
+	if (err < 0) {
+		inff_err("set rssi_event iovar failed (%d)\n", err);
+	} else {
+		cfg->cqm_info.enable = rssi_thold ? 1 : 0;
+		cfg->cqm_info.rssi_threshold = rssi_thold;
+	}
+
+	inff_dbg(TRACE, "enable = %d, rssi_threshold = %d\n",
+		 cfg->cqm_info.enable, cfg->cqm_info.rssi_threshold);
+	return err;
+}
+
+static int
+inff_cfg80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
+					struct net_device *ndev,
+					s32 rssi_low, s32 rssi_high)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	int err = 0;
+
+	inff_dbg(TRACE, "low=%d high=%d", rssi_low, rssi_high);
+
+	ifp = netdev_priv(ndev);
+	vif = ifp->vif;
+
+	if (rssi_low != vif->cqm_rssi_low || rssi_high != vif->cqm_rssi_high) {
+		/* The firmware will send an event when the RSSI is less than or
+		 * equal to a configured level and the previous RSSI event was
+		 * less than or equal to a different level. Set a third level
+		 * so that we also detect the transition from rssi <= rssi_high
+		 * to rssi > rssi_high.
+		 */
+		struct inff_rssi_old_event_le config = {
+			.rate_limit_msec = cpu_to_le32(0),
+			.rssi_level_num = 3,
+			.rssi_levels = {
+				clamp_val(rssi_low, S8_MIN, S8_MAX - 2),
+				clamp_val(rssi_high, S8_MIN + 1, S8_MAX - 1),
+				S8_MAX,
+			},
+		};
+
+		err = inff_fwcmd_iovar_data_set(ifp, "rssi_event", &config,
+						sizeof(config));
+		if (err) {
+			err = -EINVAL;
+		} else {
+			vif->cqm_rssi_low = rssi_low;
+			vif->cqm_rssi_high = rssi_high;
+		}
+	}
+
+	return err;
+}
+
+static void
+inff_cfg80211_update_mgmt_frame_registrations(struct wiphy *wiphy,
+					      struct wireless_dev *wdev,
+					      struct mgmt_frame_regs *upd)
+{
+	struct inff_cfg80211_vif *vif;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+
+	vif->mgmt_rx_reg = upd->interface_stypes;
+}
+
+int
+inff_cfg80211_get_channel(struct wiphy *wiphy,
+			  struct wireless_dev *wdev,
+			  unsigned int link_id,
+			  struct cfg80211_chan_def *chandef)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+	struct net_device *ndev = wdev->netdev;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_chan ch;
+	enum nl80211_band band = 0;
+	enum nl80211_chan_width width = 0;
+	u32 chanspec = 0;
+	int freq, err;
+
+	if (!ndev || drvr->bus_if->state != INFF_BUS_UP)
+		return -ENODEV;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	if (!inff_check_vif_up(vif))
+		return -EIO;
+
+	err = inff_fwcmd_iovar_int_get(netdev_priv(ndev), "chanspec", &chanspec);
+	if (err) {
+		iphy_err(drvr, "chanspec failed (%d)\n", err);
+		return err;
+	}
+
+	ch.chspec = chanspec;
+	inff_chan_decchspec(&ch);
+	band = inff_chan_band_to_nl80211(ch.band);
+
+	switch (ch.bw) {
+	case INFF_CHAN_BW_80:
+		width = NL80211_CHAN_WIDTH_80;
+		break;
+	case INFF_CHAN_BW_40:
+		width = NL80211_CHAN_WIDTH_40;
+		break;
+	case INFF_CHAN_BW_20:
+		width = NL80211_CHAN_WIDTH_20;
+		break;
+	case INFF_CHAN_BW_80P80:
+		width = NL80211_CHAN_WIDTH_80P80;
+		break;
+	case INFF_CHAN_BW_160:
+		width = NL80211_CHAN_WIDTH_160;
+		break;
+	}
+
+	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band);
+	if (!freq)
+		return -EINVAL;
+	chandef->chan = ieee80211_get_channel(wiphy, freq);
+	if (!chandef->chan)
+		return -EINVAL;
+	chandef->width = width;
+	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
+	chandef->center_freq2 = 0;
+
+	return 0;
+}
+
+static int
+inff_cfg80211_start_p2p_device(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	lockdep_assert_held(wiphy);
+
+	return inff_p2p_start_device(p2p, wdev);
+}
+
+static void
+inff_cfg80211_stop_p2p_device(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_p2p_info *p2p = &cfg->p2p;
+
+	lockdep_assert_held(wiphy);
+
+	inff_p2p_stop_device(p2p, wdev);
+}
+
+static int
+inff_cfg80211_crit_proto_start(struct wiphy *wiphy,
+			       struct wireless_dev *wdev,
+			       enum nl80211_crit_proto_id proto,
+			       u16 duration)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_cfg80211_vif *vif;
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+
+	/* only DHCP support for now */
+	if (proto != NL80211_CRIT_PROTO_DHCP)
+		return -EINVAL;
+
+	/* suppress and abort scanning */
+	set_bit(INFF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
+	inff_abort_scanning(cfg);
+
+	return 0;
+}
+
+static void
+inff_cfg80211_crit_proto_stop(struct wiphy *wiphy,
+			      struct wireless_dev *wdev)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+
+	clear_bit(INFF_SCAN_STATUS_SUPPRESS, &cfg->scan_status);
+}
+
+static int
+inff_cfg80211_set_pmk(struct wiphy *wiphy, struct net_device *dev,
+		      const struct cfg80211_pmk_conf *conf)
+{
+	struct inff_if *ifp;
+	struct inff_pub *drvr;
+	int ret;
+
+	/* expect using firmware supplicant for 1X */
+	ifp = netdev_priv(dev);
+	drvr = ifp->drvr;
+	if (WARN_ON(ifp->vif->profile.use_fwsup != INFF_PROFILE_FWSUP_1X &&
+		    ifp->vif->profile.use_fwsup != INFF_PROFILE_FWSUP_ROAM &&
+		    !ifp->vif->profile.is_ft &&
+		    !ifp->vif->profile.is_okc))
+		return -EINVAL;
+
+	if (conf->pmk_len > INFF_WSEC_MAX_PMK_LEN)
+		return -ERANGE;
+
+	if (ifp->vif->profile.is_okc) {
+		ret = inff_fwcmd_iovar_data_set(ifp, "okc_info_pmk", conf->pmk,
+						conf->pmk_len);
+		if (ret < 0)
+			iphy_err(drvr, "okc_info_pmk iovar failed: ret=%d\n", ret);
+	}
+
+	return inff_set_pmk(ifp, conf->pmk, conf->pmk_len);
+}
+
+static int
+inff_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
+		      const u8 *aa)
+{
+	struct inff_if *ifp;
+
+	ifp = netdev_priv(dev);
+	if (WARN_ON(ifp->vif->profile.use_fwsup != INFF_PROFILE_FWSUP_1X))
+		return -EINVAL;
+
+	return inff_set_pmk(ifp, NULL, 0);
+}
+
+static int
+inff_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+			 struct bss_parameters *params)
+{
+	struct inff_if *ifp;
+	int ret = 0;
+	u32 ap_isolate, val = 0;
+
+	ifp = netdev_priv(dev);
+	if (params->ap_isolate >= 0) {
+		ap_isolate = (u32)params->ap_isolate;
+		ret = inff_fwcmd_iovar_int_set(ifp, "ap_isolate", ap_isolate);
+		if (ret < 0)
+			inff_err("ap_isolate iovar failed: ret=%d\n", ret);
+	}
+
+	/* Get ap_isolate value from firmware to detemine whether fmac */
+	/* driver supports packet forwarding. */
+	if (inff_fwcmd_iovar_int_get(ifp, "ap_isolate", &val) == 0) {
+		ifp->fmac_pkt_fwd_en =
+			((params->ap_isolate == 0) && (val == 1)) ?
+			true : false;
+	} else {
+		inff_err("get ap_isolate iovar failed: ret=%d\n", ret);
+		ifp->fmac_pkt_fwd_en = false;
+	}
+
+	return ret;
+}
+
+static int
+inff_cfg80211_external_auth(struct wiphy *wiphy, struct net_device *dev,
+			    struct cfg80211_external_auth_params *params)
+{
+	struct inff_if *ifp;
+	struct inff_pub *drvr;
+	struct inff_auth_req_status_le auth_status;
+	int ret = 0;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	u32 ssid_len;
+
+	ifp = netdev_priv(dev);
+	drvr = ifp->drvr;
+	if (params->status == WLAN_STATUS_SUCCESS) {
+		auth_status.flags = cpu_to_le16(INFF_EXTAUTH_SUCCESS);
+	} else {
+		iphy_err(drvr, "External authentication failed: status=%d\n",
+			 params->status);
+		auth_status.flags = cpu_to_le16(INFF_EXTAUTH_FAIL);
+	}
+
+	memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
+	ssid_len = min_t(u8, params->ssid.ssid_len, IEEE80211_MAX_SSID_LEN);
+	auth_status.ssid_len = cpu_to_le32(ssid_len);
+	memcpy(auth_status.ssid, params->ssid.ssid, ssid_len);
+	memset(auth_status.pmkid, 0, WLAN_PMKID_LEN);
+	if (params->pmkid)
+		memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);
+
+	ret = inff_fwcmd_iovar_data_set(ifp, "auth_status", &auth_status,
+					sizeof(auth_status));
+	if (ret < 0)
+		iphy_err(drvr, "auth_status iovar failed: ret=%d\n", ret);
+
+	if (params->pmkid) {
+		ret = inff_update_pmksa(cfg, ifp, params->bssid,
+					params->pmkid, PMKSA_SET);
+		if (ret < 0) {
+			iphy_err(drvr,
+				 "PMKSA_SET inff_update_pmksa failed: ret=%d\n",
+				 ret);
+		}
+	}
+
+	return ret;
+}
+
+static int
+inff_cfg80211_update_owe_info(struct wiphy *wiphy, struct net_device *dev,
+			      struct cfg80211_update_owe_info *owe_info)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp;
+	int err = 0;
+	struct inff_owe_info_buf *owe_info_buf;
+	u8  *curr_ie_buf;
+	struct parsed_extension_ies owe_ecdh_ie;
+	struct parsed_ext_ie_info *extie_info;
+	u32 del_add_ie_buf_len = 0;
+	u32 total_owe_info_len = 0;
+	u32 pmkid_offset = 0;
+	struct inff_pub *drvr;
+
+	ifp = netdev_priv(dev);
+	if (owe_info) {
+		owe_info_buf = kzalloc(WL_EXTRA_BUF_MAX, GFP_KERNEL);
+		if (!owe_info_buf)
+			return -ENOMEM;
+
+		curr_ie_buf = owe_info_buf->ecdh_ie_info;
+
+		memcpy(owe_info_buf->peer_mac, owe_info->peer, ETH_ALEN);
+		owe_info_buf->status_le16 = cpu_to_le16(owe_info->status);
+
+		owe_info_buf->with_ecdh = false;
+		if (owe_info->ie) {
+			drvr = ifp->drvr;
+			if (inff_has_pmkid(owe_info->ie,
+					   owe_info->ie_len,
+					   &pmkid_offset)) {
+				err = inff_update_pmksa(cfg,
+							ifp,
+							owe_info_buf->peer_mac,
+							owe_info->ie + pmkid_offset,
+							PMKSA_SET);
+				if (err < 0) {
+					iphy_err(drvr,
+						 "PMKSA_SET inff_update_pmksa failed: ret=%d\n",
+						 err);
+					return err;
+				}
+
+				owe_info_buf->with_pmkid = true;
+				memcpy(owe_info_buf->pmkid,
+				       owe_info->ie + pmkid_offset,
+				       WLAN_PMKID_LEN);
+			}
+
+			inff_parse_extension_ies(owe_info->ie, owe_info->ie_len, &owe_ecdh_ie);
+			if (owe_ecdh_ie.count > 1) {
+				inff_err("more ecdh_cnt found in info: %d\n", owe_ecdh_ie.count);
+				return -EINVAL;
+			}
+
+			if (owe_ecdh_ie.count == 1) {
+				owe_info_buf->with_ecdh = true;
+				extie_info = &owe_ecdh_ie.ie_info[0];
+
+				del_add_ie_buf_len = inff_vndr_ie(curr_ie_buf,
+								  INFF_VNDR_IE_ASSOCRSP_FLAG |
+								  INFF_VNDR_IE_CUSTOM_FLAG,
+								  extie_info->ie_ptr,
+								  extie_info->ie_len,
+								  "add");
+			}
+		}
+
+		total_owe_info_len = sizeof(struct inff_owe_info_buf) + del_add_ie_buf_len;
+		err = inff_fwcmd_bsscfg_data_set(ifp, "owe_info", owe_info_buf,
+						 total_owe_info_len);
+
+		kfree(owe_info_buf);
+	}
+
+	if (err)
+		inff_err("update owe_info error :%d\n", err);
+
+	return err;
+}
+
+static struct cfg80211_ops inff_cfg80211_ops = {
+	.suspend = inff_cfg80211_suspend,
+	.resume = inff_cfg80211_resume,
+	.add_virtual_intf = inff_cfg80211_add_iface,
+	.del_virtual_intf = inff_cfg80211_del_iface,
+	.change_virtual_intf = inff_cfg80211_change_iface,
+	.add_key = inff_cfg80211_add_key,
+	.get_key = inff_cfg80211_get_key,
+	.del_key = inff_cfg80211_del_key,
+	.set_default_key = inff_cfg80211_config_default_key,
+	.set_default_mgmt_key = inff_cfg80211_config_default_mgmt_key,
+	.start_ap = inff_cfg80211_start_ap,
+	.change_beacon = inff_cfg80211_change_beacon,
+	.stop_ap = inff_cfg80211_stop_ap,
+	.del_station = inff_cfg80211_del_station,
+	.change_station = inff_cfg80211_change_station,
+	.get_station = inff_cfg80211_get_station,
+	.dump_station = inff_cfg80211_dump_station,
+	.scan = inff_cfg80211_scan,
+	.connect = inff_cfg80211_connect,
+	.update_connect_params = inff_cfg80211_update_conn_params,
+	.disconnect = inff_cfg80211_disconnect,
+	.join_ibss = inff_cfg80211_join_ibss,
+	.leave_ibss = inff_cfg80211_leave_ibss,
+	.set_wiphy_params = inff_cfg80211_set_wiphy_params,
+	.set_tx_power = inff_cfg80211_set_tx_power,
+	.get_tx_power = inff_cfg80211_get_tx_power,
+	.set_bitrate_mask = inff_cfg80211_set_bitrate,
+	.set_pmksa = inff_cfg80211_set_pmksa,
+	.del_pmksa = inff_cfg80211_del_pmksa,
+	.flush_pmksa = inff_cfg80211_flush_pmksa,
+	.remain_on_channel = inff_cfg80211_remain_on_channel,
+	.cancel_remain_on_channel = inff_cfg80211_cancel_remain_on_channel,
+	.mgmt_tx = inff_cfg80211_mgmt_tx,
+	.set_power_mgmt = inff_cfg80211_set_power_mgmt,
+	.set_cqm_rssi_config = inff_cfg80211_set_cqm_rssi_config,
+	.set_cqm_rssi_range_config = inff_cfg80211_set_cqm_rssi_range_config,
+	.update_mgmt_frame_registrations =
+		inff_cfg80211_update_mgmt_frame_registrations,
+	.get_channel = inff_cfg80211_get_channel,
+	.start_p2p_device = inff_cfg80211_start_p2p_device,
+	.stop_p2p_device = inff_cfg80211_stop_p2p_device,
+	.crit_proto_start = inff_cfg80211_crit_proto_start,
+	.crit_proto_stop = inff_cfg80211_crit_proto_stop,
+	.set_pmk = inff_cfg80211_set_pmk,
+	.del_pmk = inff_cfg80211_del_pmk,
+	.change_bss = inff_cfg80211_change_bss,
+	.external_auth = inff_cfg80211_external_auth,
+	.start_pmsr = inff_cfg80211_start_pmsr,
+	.abort_pmsr = inff_cfg80211_abort_pmsr,
+	.update_owe_info = inff_cfg80211_update_owe_info,
+};
+
+struct cfg80211_ops *
+inff_cfg80211_get_ops(struct inff_mp_device *settings)
+{
+	struct cfg80211_ops *ops;
+
+	ops = kmemdup(&inff_cfg80211_ops, sizeof(inff_cfg80211_ops),
+		      GFP_KERNEL);
+
+	if (ops && settings->roamoff)
+		ops->update_connect_params = NULL;
+
+	return ops;
+}
+
+void
+inff_cfg80211_free_netdev_priv(struct net_device *ndev)
+{
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+
+	ifp = netdev_priv(ndev);
+	vif = ifp->vif;
+
+	if (vif) {
+		inff_free_vif(vif);
+		ifp->vif = NULL;
+	}
+}
+
+u8
+inff_map_prio_to_prec(void *config, u8 prio)
+{
+	struct inff_cfg80211_info *cfg = (struct inff_cfg80211_info *)config;
+
+	if (!cfg)
+		return (prio == PRIO_8021D_NONE || prio == PRIO_8021D_BE) ?
+		       (prio ^ 2) : prio;
+
+	/* For those AC(s) with ACM flag set to 1, convert its 4-level priority
+	 * to an 8-level precedence which is the same as BE's
+	 */
+	if (prio > PRIO_8021D_EE &&
+	    cfg->ac_priority[prio] == cfg->ac_priority[PRIO_8021D_BE])
+		return cfg->ac_priority[prio] * 2;
+
+	/* Conversion of 4-level priority to 8-level precedence */
+	if (prio == PRIO_8021D_BE || prio == PRIO_8021D_BK ||
+	    prio == PRIO_8021D_CL || prio == PRIO_8021D_VO)
+		return cfg->ac_priority[prio] * 2;
+	else
+		return cfg->ac_priority[prio] * 2 + 1;
+}
+
+u8
+inff_map_prio_to_aci(void *config, u8 prio)
+{
+	/* Prio here refers to the 802.1d priority in range of 0 to 7.
+	 * ACI here refers to the WLAN AC Index in range of 0 to 3.
+	 * This function will return ACI corresponding to input prio.
+	 */
+	struct inff_cfg80211_info *cfg = (struct inff_cfg80211_info *)config;
+
+	if (cfg)
+		return cfg->ac_priority[prio];
+
+	return prio;
+}
+
+static void
+inff_init_wmm_prio(u8 *priority)
+{
+	/* Initialize AC priority array to default
+	 * 802.1d priority as per following table:
+	 * 802.1d prio 0,3 maps to BE
+	 * 802.1d prio 1,2 maps to BK
+	 * 802.1d prio 4,5 maps to VI
+	 * 802.1d prio 6,7 maps to VO
+	 */
+	priority[0] = INFF_FWS_FIFO_AC_BE;
+	priority[3] = INFF_FWS_FIFO_AC_BE;
+	priority[1] = INFF_FWS_FIFO_AC_BK;
+	priority[2] = INFF_FWS_FIFO_AC_BK;
+	priority[4] = INFF_FWS_FIFO_AC_VI;
+	priority[5] = INFF_FWS_FIFO_AC_VI;
+	priority[6] = INFF_FWS_FIFO_AC_VO;
+	priority[7] = INFF_FWS_FIFO_AC_VO;
+}
+
+void
+inff_wifi_prioritize_acparams(const struct inff_cfg80211_edcf_acparam *acp,
+			      u8 *priority)
+{
+	u8 aci;
+	u8 aifsn;
+	u8 ecwmin;
+	u8 ecwmax;
+	u8 acm;
+	u8 ranking_basis[EDCF_AC_COUNT];
+	u8 aci_prio[EDCF_AC_COUNT]; /* AC_BE, AC_BK, AC_VI, AC_VO */
+	u8 index;
+
+	for (aci = 0; aci < EDCF_AC_COUNT; aci++, acp++) {
+		aifsn  = acp->ACI & EDCF_AIFSN_MASK;
+		acm = (acp->ACI & EDCF_ACM_MASK) ? 1 : 0;
+		ecwmin = acp->ECW & EDCF_ECWMIN_MASK;
+		ecwmax = (acp->ECW & EDCF_ECWMAX_MASK) >> EDCF_ECWMAX_SHIFT;
+		inff_dbg(CONN, "ACI %d aifsn %d acm %d ecwmin %d ecwmax %d\n",
+			 aci, aifsn, acm, ecwmin, ecwmax);
+		/* Default AC_VO will be the lowest ranking value */
+		ranking_basis[aci] = aifsn + ecwmin + ecwmax;
+		/* Initialise priority starting at 0 (AC_BE) */
+		aci_prio[aci] = 0;
+
+		/* If ACM is set, STA can't use this AC as per 802.11.
+		 * Change the ranking to BE
+		 */
+		if (aci != AC_BE && aci != AC_BK && acm == 1)
+			ranking_basis[aci] = ranking_basis[AC_BE];
+	}
+
+	/* Ranking method which works for AC priority
+	 * swapping when values for cwmin, cwmax and aifsn are varied
+	 * Compare each aci_prio against each other aci_prio
+	 */
+	for (aci = 0; aci < EDCF_AC_COUNT; aci++) {
+		for (index = 0; index < EDCF_AC_COUNT; index++) {
+			if (index != aci) {
+				/* Smaller ranking value has higher priority,
+				 * so increment priority for each ACI which has
+				 * a higher ranking value
+				 */
+				if (ranking_basis[aci] < ranking_basis[index])
+					aci_prio[aci]++;
+			}
+		}
+	}
+
+	/* By now, aci_prio[] will be in range of 0 to 3.
+	 * Use ACI prio to get the new priority value for
+	 * each 802.1d traffic type, in this range.
+	 */
+	if (!(aci_prio[AC_BE] == aci_prio[AC_BK] &&
+	      aci_prio[AC_BK] == aci_prio[AC_VI] &&
+	      aci_prio[AC_VI] == aci_prio[AC_VO])) {
+		/* 802.1d 0,3 maps to BE */
+		priority[0] = aci_prio[AC_BE];
+		priority[3] = aci_prio[AC_BE];
+
+		/* 802.1d 1,2 maps to BK */
+		priority[1] = aci_prio[AC_BK];
+		priority[2] = aci_prio[AC_BK];
+
+		/* 802.1d 4,5 maps to VO */
+		priority[4] = aci_prio[AC_VI];
+		priority[5] = aci_prio[AC_VI];
+
+		/* 802.1d 6,7 maps to VO */
+		priority[6] = aci_prio[AC_VO];
+		priority[7] = aci_prio[AC_VO];
+	} else {
+		/* Initialize to default priority */
+		inff_init_wmm_prio(priority);
+	}
+
+	inff_dbg(CONN, "Adj prio BE 0->%d, BK 1->%d, BK 2->%d, BE 3->%d\n",
+		 priority[0], priority[1], priority[2], priority[3]);
+
+	inff_dbg(CONN, "Adj prio VI 4->%d, VI 5->%d, VO 6->%d, VO 7->%d\n",
+		 priority[4], priority[5], priority[6], priority[7]);
+}
+
+static s32
+inff_dongle_roam(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	s32 err;
+	u32 bcn_timeout;
+	__le32 roamtrigger[2];
+	__le32 roam_delta[2];
+	__le32 bandlist[4];
+	u32 n_bands;
+	int i;
+
+	/* Configure beacon timeout value based upon roaming setting */
+	if (ifp->drvr->settings->roamoff < INFF_ROAMOFF_DISABLE ||
+	    ifp->drvr->settings->roamoff >= INFF_ROAMOFF_MAX) {
+		iphy_err(drvr,
+			 "roamoff setting is incorrect (%d), reset it\n",
+			 ifp->drvr->settings->roamoff);
+		ifp->drvr->settings->roamoff = INFF_ROAMOFF_DISABLE;
+	}
+
+	if (ifp->drvr->settings->roamoff)
+		bcn_timeout = INFF_DEFAULT_BCN_TIMEOUT_ROAM_OFF;
+	else
+		bcn_timeout = INFF_DEFAULT_BCN_TIMEOUT_ROAM_ON;
+	err = inff_fwcmd_iovar_int_set(ifp, "bcn_timeout", bcn_timeout);
+	if (err) {
+		iphy_err(drvr, "bcn_timeout error (%d)\n", err);
+		goto roam_setup_done;
+	}
+
+	/* Enable/Disable built-in roaming to allow supplicant to take care of
+	 * roaming.
+	 */
+	inff_dbg(INFO, "Internal Roaming = %s, Mode:%d\n",
+		 ifp->drvr->settings->roamoff ? "Off" : "On", ifp->drvr->settings->roamoff);
+	err = inff_fwcmd_iovar_int_set(ifp, "roam_off",
+				       ifp->drvr->settings->roamoff ? 1 : 0);
+	if (err) {
+		iphy_err(drvr, "roam_off error (%d)\n", err);
+		goto roam_setup_done;
+	}
+
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BANDLIST, &bandlist,
+				      sizeof(bandlist));
+	if (err) {
+		iphy_err(drvr, "could not obtain band info: err=%d\n", err);
+		goto roam_setup_done;
+	}
+	/* To enhance compatibility set each band's roam properties instead of
+	 * using all band. BAND_5G is 1, BAND_2G is 2 and BAND_6G is 3.
+	 */
+	n_bands = le32_to_cpu(bandlist[0]);
+	for (i = 1; i <= n_bands; i++) {
+		roamtrigger[0] = cpu_to_le32(WL_ROAM_TRIGGER_LEVEL);
+		roamtrigger[1] = bandlist[i];
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_ROAM_TRIGGER,
+					      (void *)roamtrigger, sizeof(roamtrigger));
+		if (err)
+			iphy_err(drvr, "WLC_SET_ROAM_TRIGGER error (%d), band %d\n",
+				 err, bandlist[i]);
+
+		roam_delta[0] = cpu_to_le32(WL_ROAM_DELTA);
+		roam_delta[1] = bandlist[i];
+		err = inff_fwcmd_cmd_data_set(ifp, INFF_C_SET_ROAM_DELTA,
+					      (void *)roam_delta, sizeof(roam_delta));
+		if (err)
+			iphy_err(drvr, "WLC_SET_ROAM_DELTA error (%d), band %d\n",
+				 err, bandlist[i]);
+	}
+
+	return 0;
+
+roam_setup_done:
+	return err;
+}
+
+s32
+inff_cfg80211_up(struct net_device *ndev)
+{
+	struct inff_if *pri_ifp, *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_pub *drvr = cfg->pub;
+	struct net_device *pri_ndev;
+	struct wireless_dev *pri_wdev;
+	s32 power_mode;
+	s32 err = 0;
+
+	lockdep_assert_held(cfg->wiphy);
+
+	set_bit(INFF_VIF_STATUS_READY, &ifp->vif->sme_state);
+
+	if (cfg->dongle_up ||
+	    inff_socitype_is_cp(drvr->bus_if))
+		goto exit;
+
+	pri_ndev = cfg_to_ndev(cfg);
+	pri_wdev = pri_ndev->ieee80211_ptr;
+	pri_ifp = netdev_priv(pri_ndev);
+
+	/* make sure RF is ready for work */
+	inff_fwcmd_cmd_int_set(pri_ifp, INFF_C_UP, 0);
+
+	inff_dongle_scantime(pri_ifp);
+
+	power_mode = cfg->pwr_save ? INFF_PM_FAST : INFF_PM_OFF;
+	err = inff_fwcmd_cmd_int_set(pri_ifp, INFF_C_SET_PM, power_mode);
+	if (err)
+		goto exit;
+	inff_dbg(INFO, "power save set to %s\n",
+		 (power_mode ? "enabled" : "disabled"));
+
+	err = inff_dongle_roam(pri_ifp);
+	if (err)
+		goto exit;
+
+	err = inff_cfg80211_change_iface(pri_wdev->wiphy, pri_ndev,
+					 pri_wdev->iftype, NULL);
+	if (err)
+		goto exit;
+
+	err = inff_fwcmd_cmd_int_set(pri_ifp, INFF_C_SET_FAKEFRAG, 1);
+	if (err) {
+		iphy_err(drvr, "failed to set frameburst mode\n");
+		goto exit;
+	}
+
+	cfg->dongle_up = true;
+exit:
+	return err;
+}
+
+s32
+inff_cfg80211_down(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+
+	lockdep_assert_held(cfg->wiphy);
+
+	/*
+	 * While going down, if associated with AP disassociate
+	 * from AP to save power
+	 */
+	if (inff_check_vif_up(ifp->vif)) {
+		inff_link_down(ifp->vif, WLAN_REASON_UNSPECIFIED, true);
+
+		/* Make sure WPA_Supplicant receives all the event
+		 * generated due to DISASSOC call to the fw to keep
+		 * the state fw and WPA_Supplicant state consistent
+		 */
+		inff_delay(500);
+		cfg->dongle_up = false;
+	}
+
+	inff_abort_scanning(cfg);
+	clear_bit(INFF_VIF_STATUS_READY, &ifp->vif->sme_state);
+
+	return 0;
+}
+
+static const struct ieee80211_txrx_stypes
+inff_txrx_stypes[NUM_NL80211_IFTYPES] = {
+	[NL80211_IFTYPE_STATION] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_P2P_CLIENT] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_P2P_GO] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4)
+	},
+	[NL80211_IFTYPE_P2P_DEVICE] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_AP] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4)
+	}
+};
+
+static int
+inff_setup_wiphy_params(struct wiphy *wiphy, struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	const struct ieee80211_iface_combination *combo;
+	u16 max_interfaces = 0;
+	int err, i;
+	enum nl80211_band band;
+
+	wiphy->max_scan_ssids = WL_NUM_SCAN_MAX;
+	wiphy->max_scan_ie_len = INFF_SCAN_IE_LEN_MAX;
+	wiphy->max_num_pmkids = INFF_MAXPMKID;
+
+	err = inff_setup_ifmodes(wiphy, ifp);
+	if (err)
+		return err;
+
+	for (i = 0, combo = wiphy->iface_combinations;
+	     i < wiphy->n_iface_combinations; i++, combo++) {
+		max_interfaces = max(max_interfaces, combo->max_interfaces);
+	}
+
+	for (i = 0; i < max_interfaces && i < ARRAY_SIZE(drvr->addresses);
+	     i++) {
+		u8 *addr = drvr->addresses[i].addr;
+
+		memcpy(addr, drvr->mac, ETH_ALEN);
+		if (i) {
+			addr[0] |= BIT(1);
+			addr[ETH_ALEN - 1] ^= i;
+		}
+	}
+	wiphy->addresses = drvr->addresses;
+	wiphy->n_addresses = i;
+
+	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
+	wiphy->cipher_suites = inff_cipher_suites;
+	wiphy->n_cipher_suites = ARRAY_SIZE(inff_cipher_suites);
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_MFP))
+		wiphy->n_cipher_suites -= 4;
+	wiphy->bss_select_support = BIT(NL80211_BSS_SELECT_ATTR_RSSI) |
+				    BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
+				    BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
+
+	wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
+
+	wiphy->flags |= WIPHY_FLAG_NETNS_OK |
+			WIPHY_FLAG_PS_ON_BY_DEFAULT |
+			WIPHY_FLAG_HAVE_AP_SME |
+			WIPHY_FLAG_OFFCHAN_TX |
+			WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
+			WIPHY_FLAG_SPLIT_SCAN_6GHZ;
+
+	if (ifp->drvr->settings->roamoff == INFF_ROAMOFF_DISABLE)
+		wiphy->flags |= WIPHY_FLAG_SUPPORTS_FW_ROAM;
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FWSUP)) {
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_PSK);
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_STA_1X);
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_OWE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_OWE_OFFLOAD);
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_SAE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_SAE_OFFLOAD);
+	}
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FWAUTH)) {
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_4WAY_HANDSHAKE_AP_PSK);
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_SAE))
+			wiphy_ext_feature_set(wiphy,
+					      NL80211_EXT_FEATURE_SAE_OFFLOAD_AP);
+	}
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_SAE_EXT)) {
+		wiphy->features |= NL80211_FEATURE_SAE;
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_AP_PMKSA_CACHING);
+	}
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+
+	wiphy->mgmt_stypes = inff_txrx_stypes;
+	wiphy->max_remain_on_channel_duration = 5000;
+
+	/* vendor commands/events support */
+	wiphy->vendor_commands = inff_vendor_cmds;
+	wiphy->n_vendor_commands = get_inff_num_vndr_cmds();
+
+#ifdef CONFIG_PM
+	inff_wiphy_wowl_params(wiphy, ifp);
+#endif /* CONFIG_PM */
+
+	/* first entry in bandlist is number of bands */
+	for (band = 0; band < NUM_NL80211_BANDS; band++)
+		wiphy->bands[band] = NULL;
+	err = inff_fill_band_with_default_chanlist(wiphy, ifp);
+	if (err) {
+		iphy_err(drvr, "could not retrore band and channels: err=%d\n", err);
+		return err;
+	}
+
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+		inff_wiphy_pmsr_params(wiphy, ifp);
+	}
+
+	wiphy_read_of_freq_limits(wiphy);
+	return 0;
+}
+
+static void
+inff_free_wiphy_params(struct wiphy *wiphy)
+{
+	int i;
+
+	if (!wiphy)
+		return;
+
+	if (wiphy->iface_combinations) {
+		for (i = 0; i < wiphy->n_iface_combinations; i++)
+			kfree(wiphy->iface_combinations[i].limits);
+	}
+	kfree(wiphy->iface_combinations);
+	if (wiphy->bands[NL80211_BAND_2GHZ]) {
+		kfree(wiphy->bands[NL80211_BAND_2GHZ]->channels);
+		kfree(wiphy->bands[NL80211_BAND_2GHZ]);
+	}
+	if (wiphy->bands[NL80211_BAND_5GHZ]) {
+		kfree(wiphy->bands[NL80211_BAND_5GHZ]->channels);
+		kfree(wiphy->bands[NL80211_BAND_5GHZ]);
+	}
+	if (wiphy->bands[NL80211_BAND_6GHZ]) {
+		kfree(wiphy->bands[NL80211_BAND_6GHZ]->channels);
+		kfree(wiphy->bands[NL80211_BAND_6GHZ]);
+	}
+
+#if IS_ENABLED(CONFIG_PM)
+	if (wiphy->wowlan != &inff_wowlan_support)
+		kfree(wiphy->wowlan);
+#endif
+	kfree(wiphy->pmsr_capa);
+}
+
+int
+inff_alloc_wiphy(struct device *dev, struct inff_mp_device *settings)
+{
+	struct wiphy *wiphy;
+	struct cfg80211_ops *ops;
+	struct inff_pub *drvr = NULL;
+
+	ops = inff_cfg80211_get_ops(settings);
+	if (!ops)
+		return -ENOMEM;
+
+	wiphy = wiphy_new(ops, sizeof(*drvr));
+	if (!wiphy) {
+		kfree(ops);
+		return -ENOMEM;
+	}
+
+	set_wiphy_dev(wiphy, dev);
+	drvr = wiphy_priv(wiphy);
+	drvr->wiphy = wiphy;
+	drvr->ops = ops;
+	drvr->bus_if = dev_get_drvdata(dev);
+	drvr->bus_if->drvr = drvr;
+	drvr->settings = settings;
+
+	return 0;
+}
+
+void
+inff_free_wiphy(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+
+	if (!drvr)
+		return;
+
+	bus_if->drvr = NULL;
+
+	kfree(drvr->ops);
+
+	wiphy_free(drvr->wiphy);
+}
+
+static void
+inff_cfg80211_reg_notifier(struct wiphy *wiphy,
+			   struct regulatory_request *req)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_if *ifp = inff_get_ifp(cfg->pub, 0);
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_fwcmd_country_le ccreq;
+	s32 err;
+	int i;
+
+	/* The country code gets set to "00" by default at boot, ignore */
+	if (req->alpha2[0] == '0' && req->alpha2[1] == '0')
+		return;
+
+	/* ignore non-ISO3166 country codes */
+	for (i = 0; i < 2; i++)
+		if (req->alpha2[i] < 'A' || req->alpha2[i] > 'Z') {
+			iphy_err(drvr, "not an ISO3166 code (0x%02x 0x%02x)\n",
+				 req->alpha2[0], req->alpha2[1]);
+			return;
+		}
+
+	inff_dbg(INFO, "initiator=%d, alpha=%c%c\n", req->initiator,
+		 req->alpha2[0], req->alpha2[1]);
+
+	err = inff_fwcmd_iovar_data_get(ifp, "country", &ccreq, sizeof(ccreq));
+	if (err) {
+		iphy_err(drvr, "Country code iovar returned err = %d\n", err);
+		return;
+	}
+
+	if (req->alpha2[0] == ccreq.country_abbrev[0] &&
+	    req->alpha2[1] == ccreq.country_abbrev[1]) {
+		inff_dbg(INFO, "Country code already set\n");
+		return;
+	}
+
+	inff_dbg(INFO, "For Country code, using ISO3166 code and 0 rev\n");
+	memset(&ccreq, 0, sizeof(ccreq));
+	ccreq.country_abbrev[0] = req->alpha2[0];
+	ccreq.country_abbrev[1] = req->alpha2[1];
+	ccreq.ccode[0] = req->alpha2[0];
+	ccreq.ccode[1] = req->alpha2[1];
+
+	/* Abort on-going scan before changing ccode */
+	inff_abort_scanning(cfg);
+
+	err = inff_fwcmd_iovar_data_set(ifp, "country", &ccreq, sizeof(ccreq));
+	if (err) {
+		iphy_err(drvr, "Firmware rejected country setting\n");
+		return;
+	}
+	inff_setup_wiphybands(cfg);
+}
+
+struct inff_cfg80211_info *
+inff_cfg80211_attach(struct inff_pub *drvr,
+		     struct cfg80211_ops *ops)
+{
+	struct wiphy *wiphy = drvr->wiphy;
+	struct net_device *ndev = inff_get_ifp(drvr, 0)->ndev;
+	struct inff_cfg80211_info *cfg;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	s32 err = 0;
+	u16 *cap = NULL;
+
+	if (!ndev) {
+		iphy_err(drvr, "ndev is invalid\n");
+		return NULL;
+	}
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return NULL;
+
+	cfg->wiphy = wiphy;
+	cfg->pub = drvr;
+	cfg->pm_state = INFF_CFG80211_PM_STATE_RESUMED;
+	cfg->num_softap = 0;
+	cfg->mchan_conf = INFF_MCHAN_CONF_DEFAULT;
+	cfg->pwr_save = true;
+	cfg->dongle_up = false;		/* dongle is not up yet */
+	cfg->conf.frag_threshold = (u32)-1;
+	cfg->conf.rts_threshold =  (u32)-1;
+	cfg->conf.retry_short = (u32)-1;
+	cfg->conf.retry_long = (u32)-1;
+
+	init_waitqueue_head(&cfg->vif_event.vif_wq);
+	spin_lock_init(&cfg->vif_event.vif_event_lock);
+	INIT_LIST_HEAD(&cfg->vif_list);
+
+	/* allocated primary vif */
+	vif = inff_alloc_vif(cfg, NL80211_IFTYPE_STATION);
+	if (IS_ERR(vif))
+		goto wiphy_out;
+
+	ifp = netdev_priv(ndev);
+	ifp->vif = vif;
+	vif->ifp = ifp;
+	vif->wdev.netdev = ndev;
+	ndev->ieee80211_ptr = &vif->wdev;
+	SET_NETDEV_DEV(ndev, wiphy_dev(cfg->wiphy));
+	init_completion(&cfg->vif_disabled);
+
+	cfg->extra_buf = kzalloc(WL_EXTRA_BUF_MAX, GFP_KERNEL);
+	if (!cfg->extra_buf)
+		goto wiphy_out;
+
+	if (inff_socitype_is_cp(drvr->bus_if)) {
+		err = inff_cp_scan_init(cfg);
+		if (err) {
+			inff_err("Failed to init the priv (%d)\n", err);
+			kfree(cfg->scan.bss_buf);
+			cfg->scan.bss_buf = NULL;
+			goto priv_buf_out;
+		}
+	} else if (inff_socitype_is_ai(drvr->bus_if)) {
+		inff_fwevt_register_handlers(cfg);
+
+		err = inff_init_escan(cfg);
+		if (err)
+			goto priv_buf_out;
+
+		inff_init_wmm_prio(cfg->ac_priority);
+	}
+	/* regulatory notifier below needs access to cfg so
+	 * assign it now.
+	 */
+	drvr->config = cfg;
+
+	err = inff_setup_wiphy_params(wiphy, ifp);
+	if (err < 0)
+		goto scan_out;
+
+	inff_dbg(INFO, "Registering custom regulatory\n");
+	wiphy->reg_notifier = inff_cfg80211_reg_notifier;
+	wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG;
+	wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
+	wiphy_apply_custom_regulatory(wiphy, &inff_regdom);
+
+	if (inff_socitype_is_ai(drvr->bus_if)) {
+		/* firmware defaults to 40MHz disabled in 2G band. We signal
+		 * cfg80211 here that we do and have it decide we can enable
+		 * it. But first check if device does support 2G operation.
+		 */
+		if (wiphy->bands[NL80211_BAND_2GHZ]) {
+			cap = &wiphy->bands[NL80211_BAND_2GHZ]->ht_cap.cap;
+			*cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		}
+#ifdef CONFIG_PM
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_WOWL_GTK))
+			ops->set_rekey_data = inff_cfg80211_set_rekey_data;
+#endif
+		/* if the firmware has GTKO cap,
+		 * user space can use NL80211_CMD_SET_REKEY_OFFLOAD command to pass gtk data.
+		 */
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_GTKO))
+			ops->set_rekey_data = inff_cfg80211_set_rekey_data;
+
+		if (inff_feat_is_enabled(ifp, INFF_FEAT_DUMP_OBSS))
+			ops->dump_survey = inff_cfg80211_dump_survey;
+		else if (inff_feat_is_enabled(ifp, INFF_FEAT_SURVEY_DUMP))
+			ops->dump_survey = inff_cfg80211_dump_survey_2;
+		else
+			ops->dump_survey = NULL;
+	}
+	err = inff_setup_wiphybands(cfg);
+	if (err) {
+		iphy_err(drvr, "Setting wiphy bands failed (%d)\n", err);
+		goto wiphy_out;
+	}
+
+	err = wiphy_register(wiphy);
+	if (err < 0) {
+		iphy_err(drvr, "Could not register wiphy device (%d)\n", err);
+		goto priv_buf_out;
+	}
+
+	if (inff_socitype_is_cp(drvr->bus_if))
+		return cfg;
+
+	/* If cfg80211 didn't disable 40MHz HT CAP in wiphy_register(),
+	 * setup 40MHz in 2GHz band and enable OBSS scanning.
+	 */
+	if (cap && (*cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40)) {
+		err = inff_chan_enable_bw40_2g(cfg);
+		if (!err) {
+			err = inff_fwcmd_iovar_int_set(ifp, "obss_coex",
+						       INFF_OBSS_COEX_AUTO);
+			if (err)
+				iphy_err(drvr,
+					 "Failed to configure OBSS coex: (%d)\n",
+					 err);
+		} else {
+			*cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+		}
+	}
+
+	/* activate FWEH event handling */
+	err = inff_fwevt_activate_events(ifp);
+	if (err) {
+		iphy_err(drvr, "FWEH activation failed (%d)\n", err);
+		goto wiphy_unreg_out;
+	}
+
+	err = inff_p2p_attach(cfg);
+	if (err) {
+		iphy_err(drvr, "P2P initialisation failed (%d)\n", err);
+		goto wiphy_unreg_out;
+	}
+
+	err = inff_pmsr_attach(cfg);
+	if (err) {
+		iphy_err(drvr, "PMSR initialisation failed (%d)\n", err);
+		goto detach_p2p;
+	}
+
+	/* (re-) activate FWEH event handling */
+	err = inff_fwevt_activate_events(ifp);
+	if (err) {
+		iphy_err(drvr, "FWEH activation failed (%d)\n", err);
+		goto detach_pmsr;
+	}
+
+	/* Fill in some of the advertised nl80211 supported features */
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_SCAN_RANDOM_MAC)) {
+		wiphy->features |= NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR;
+#ifdef CONFIG_PM
+		if (wiphy->wowlan &&
+		    wiphy->wowlan->flags & WIPHY_WOWLAN_NET_DETECT)
+			wiphy->features |= NL80211_FEATURE_ND_RANDOM_MAC_ADDR;
+#endif
+	}
+
+	return cfg;
+
+detach_pmsr:
+	inff_pmsr_detach(cfg);
+detach_p2p:
+	inff_p2p_detach(&cfg->p2p);
+wiphy_unreg_out:
+	wiphy_unregister(cfg->wiphy);
+scan_out:
+	inff_deinit_escan(cfg);
+	kfree(cfg->scan.bss_buf);
+	cfg->scan.bss_buf = NULL;
+priv_buf_out:
+	kfree(cfg->extra_buf);
+	cfg->extra_buf = NULL;
+	inff_free_vif(vif);
+	ifp->vif = NULL;
+wiphy_out:
+	inff_free_wiphy_params(wiphy);
+	kfree(cfg);
+	return NULL;
+}
+
+void
+inff_cfg80211_detach(struct inff_cfg80211_info *cfg)
+{
+	if (!cfg)
+		return;
+
+	inff_pmsr_detach(cfg);
+	inff_p2p_detach(&cfg->p2p);
+	wiphy_unregister(cfg->wiphy);
+
+	cfg->dongle_up = false;	/* dongle down */
+	inff_deinit_escan(cfg);
+	kfree(cfg->scan.bss_buf);
+	cfg->scan.bss_buf = NULL;
+	kfree(cfg->extra_buf);
+	cfg->extra_buf = NULL;
+
+	inff_clear_assoc_ies(cfg);
+	inff_free_wiphy_params(cfg->wiphy);
+
+	kfree(cfg);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/cfg80211.h b/drivers/net/wireless/infineon/inffmac/cfg80211.h
new file mode 100644
index 000000000000..80808d869017
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/cfg80211.h
@@ -0,0 +1,346 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_CFG80211_H
+#define INFF_CFG80211_H
+
+#include "main.h"
+#include "dev_cmd.h"
+#include "p2p.h"
+#include "scan.h"
+#include "ie.h"
+#include "security.h"
+#include "chan.h"
+
+#define WL_NUM_SCAN_MAX			10
+#define WL_TLV_INFO_MAX			1024
+#define WL_BSS_INFO_MAX			2048
+#define WL_ASSOC_INFO_MAX		512	/* assoc related fil max buf */
+#define WL_EXTRA_BUF_MAX		2048
+#define WL_ROAM_TRIGGER_LEVEL		-75
+#define WL_ROAM_DELTA			20
+
+/* WME Access Category Indices (ACIs) */
+#define AC_BE			0	/* Best Effort */
+#define AC_BK			1	/* Background */
+#define AC_VI			2	/* Video */
+#define AC_VO			3	/* Voice */
+
+#define EDCF_AC_COUNT		4
+#define MAX_8021D_PRIO		8
+
+#define EDCF_ACI_MASK			0x60
+#define EDCF_ACI_SHIFT			5
+#define EDCF_ACM_MASK                  0x10
+#define EDCF_ECWMIN_MASK		0x0f
+#define EDCF_ECWMAX_SHIFT		4
+#define EDCF_AIFSN_MASK			0x0f
+#define EDCF_AIFSN_MAX			15
+#define EDCF_ECWMAX_MASK		0xf0
+
+/* beacon loss timeout defaults */
+#define INFF_DEFAULT_BCN_TIMEOUT_ROAM_ON	2
+#define INFF_DEFAULT_BCN_TIMEOUT_ROAM_OFF	4
+
+#define INFF_PM_WAIT_MAXRETRY			100
+
+#define WFA_OUI                        "\x50\x6F\x9A"  /* WFA OUI */
+
+/* dongle configuration */
+struct inff_cfg80211_conf {
+	u32 frag_threshold;
+	u32 rts_threshold;
+	u32 retry_short;
+	u32 retry_long;
+};
+
+/* security information with currently associated ap */
+struct inff_cfg80211_security {
+	u32 wpa_versions;
+	u32 auth_type;
+	u32 cipher_pairwise;
+	u32 cipher_group;
+};
+
+enum inff_profile_fwsup {
+	INFF_PROFILE_FWSUP_NONE,
+	INFF_PROFILE_FWSUP_PSK,
+	INFF_PROFILE_FWSUP_1X,
+	INFF_PROFILE_FWSUP_SAE,
+	INFF_PROFILE_FWSUP_ROAM,
+	INFF_PROFILE_FWSUP_CP
+};
+
+/**
+ * enum inff_profile_fwauth - firmware authenticator profile
+ *
+ * @INFF_PROFILE_FWAUTH_NONE: no firmware authenticator
+ * @INFF_PROFILE_FWAUTH_PSK: authenticator for WPA/WPA2-PSK
+ * @INFF_PROFILE_FWAUTH_SAE: authenticator for SAE
+ */
+enum inff_profile_fwauth {
+	INFF_PROFILE_FWAUTH_NONE,
+	INFF_PROFILE_FWAUTH_PSK,
+	INFF_PROFILE_FWAUTH_SAE
+};
+
+enum inff_cfg80211_pm_state {
+	INFF_CFG80211_PM_STATE_RESUMED,
+	INFF_CFG80211_PM_STATE_RESUMING,
+	INFF_CFG80211_PM_STATE_SUSPENDED,
+	INFF_CFG80211_PM_STATE_SUSPENDING,
+};
+
+/**
+ * enum inff_mgmt_tx_status - mgmt frame tx status
+ *
+ * @INFF_MGMT_TX_ACK: mgmt frame acked
+ * @INFF_MGMT_TX_NOACK: mgmt frame not acked
+ * @INFF_MGMT_TX_OFF_CHAN_COMPLETED: off-channel complete
+ * @INFF_MGMT_TX_SEND_FRAME: mgmt frame tx is in progress
+ */
+enum inff_mgmt_tx_status {
+	INFF_MGMT_TX_ACK,
+	INFF_MGMT_TX_NOACK,
+	INFF_MGMT_TX_OFF_CHAN_COMPLETED,
+	INFF_MGMT_TX_SEND_FRAME
+};
+
+/* association inform */
+struct inff_cfg80211_connect_info {
+	u8 *req_ie;
+	s32 req_ie_len;
+	u8 *resp_ie;
+	s32 resp_ie_len;
+};
+
+/* assoc ie length */
+struct inff_cfg80211_assoc_ielen_le {
+	__le32 req_len;
+	__le32 resp_len;
+	__le32 flags;
+};
+
+/* Action Frame Constants */
+#define DOT11_ACTION_HDR_LEN	2	/* action frame category + action */
+#define DOT11_ACTION_CAT_OFF	0	/* category offset */
+#define DOT11_ACTION_ACT_OFF	1	/* action offset */
+
+#define IEEE80211_AF_DWELL_TIME			200
+#define IEEE80211_AF_MIN_DWELL_TIME		100
+#define IEEE80211_AF_MED_DWELL_TIME		400
+#define IEEE80211_AF_LONG_DWELL_TIME		1000
+#define IEEE80211_AF_TX_MAX_RETRY		5
+#define IEEE80211_AF_MAX_WAIT_TIME		msecs_to_jiffies(2000)
+
+/**
+ * struct inff_pub_act_frame - WLAN MGMT Public Action Frame
+ *
+ * @category: Category Code
+ * @action: Action Code
+ * @oui: Action frame OUI
+ * @oui_type: Action frame OUI type
+ * @subtype: Action frame subtype
+ * @dialog_token: nonzero, identifies req/rsp transaction
+ * @elts: Variable length information elements
+ */
+struct inff_pub_act_frame {
+	u8	category;
+	u8	action;
+	u8	oui[3];
+	u8	oui_type;
+	u8	subtype;
+	u8	dialog_token;
+	u8	elts[];
+};
+
+/**
+ * struct inff_gas_pub_act_frame - WLAN MGMT GAS Public Action Frame
+ *
+ * @category: 0x04 Public Action Frame
+ * @action: 0x6c Advertisement Protocol
+ * @dialog_token: nonzero, identifies req/rsp transaction
+ * @query_data: Query Data. SD gas ireq SD gas iresp
+ */
+struct inff_gas_pub_act_frame {
+	u8	category;
+	u8	action;
+	u8	dialog_token;
+	u8	query_data[];
+};
+
+struct inff_cfg80211_edcf_acparam {
+	u8 ACI;
+	u8 ECW;
+	u16 TXOP;        /* stored in network order (ls octet first) */
+};
+
+struct cqm_rssi_info {
+	bool enable;
+	s32 rssi_threshold;
+};
+
+/**
+ * struct inff_cfg80211_vif_event - virtual interface event information.
+ *
+ * @vif_wq: waitqueue awaiting interface event from firmware.
+ * @vif_event_lock: protects other members in this structure.
+ * @action: either add, change, or delete.
+ * @vif: virtual interface object related to the event.
+ */
+struct inff_cfg80211_vif_event {
+	wait_queue_head_t vif_wq;
+	spinlock_t vif_event_lock;	/* protects other members in this structure */
+	u8 action;
+	struct inff_cfg80211_vif *vif;
+};
+
+/*
+ * struct inff_cfg80211_wowl - wowl related information
+ *
+ * @active: set on suspend, cleared on resume.
+ * @pre_pmmode: firmware PM mode at entering suspend.
+ */
+struct inff_cfg80211_wowl {
+	bool active;
+	u32 pre_pmmode;
+};
+
+/**
+ * struct inff_cfg80211_info - dongle private data of cfg80211 interface
+ *
+ * @wiphy: wiphy object for cfg80211 interface.
+ * @conf: dongle configuration.
+ * @p2p: peer-to-peer specific information.
+ * @scan_request: cfg80211 scan request object.
+ * @conn_info: association info.
+ * @pmk_list: wpa2 pmk list.
+ * @scan_status: scan activity on the dongle.
+ * @pub: common driver information.
+ * @channel: current channel.
+ * @int_escan_map: bucket map for which internal e-scan is done.
+ * @ibss_starter: indicates this sta is ibss starter.
+ * @pwr_save: indicate whether dongle to support power save mode.
+ * @dongle_up: indicate whether dongle up or not.
+ * @roam_on: on/off switch for dongle self-roaming.
+ * @scan_tried: indicates if first scan attempted.
+ * @dcmd_buf: dcmd buffer.
+ * @extra_buf: mainly to grab assoc information.
+ * @debugfsdir: debugfs folder for this device.
+ * @escan_info: escan information.
+ * @escan_timeout_work: scan timeout delayed work.
+ * @vif_list: linked list of vif instances.
+ * @vif_cnt: number of vif instances.
+ * @vif_event: vif event signalling.
+ * @wowl: wowl related information.
+ */
+struct inff_cfg80211_info {
+	struct wiphy *wiphy;
+	struct inff_cfg80211_conf conf;
+	struct inff_p2p_info p2p;
+	struct cfg80211_scan_request *scan_request;
+	struct inff_cfg80211_connect_info conn_info;
+	struct inff_pmk_list_le pmk_list;
+	unsigned long scan_status;
+	struct inff_pub *pub;
+	u32 channel;
+	u32 int_escan_map;
+	bool ibss_starter;
+	bool pwr_save;
+	bool dongle_up;
+	bool scan_tried;
+	u8 *dcmd_buf;
+	u8 *extra_buf;
+	struct dentry *debugfsdir;
+	struct escan_info escan_info;
+	struct wiphy_delayed_work escan_timeout_work;
+	struct cqm_rssi_info cqm_info;
+	struct list_head vif_list;
+	struct inff_cfg80211_vif_event vif_event;
+	struct completion vif_disabled;
+	struct inff_assoclist_le assoclist;
+	struct inff_cfg80211_wowl wowl;
+	u8 ac_priority[MAX_8021D_PRIO];
+	u8 pm_state;
+	u8 num_softap;
+	struct inff_pmsr_info *pmsr_info;
+	u8 mchan_conf;
+	struct inff_scan_info scan;
+};
+
+static inline struct inff_cfg80211_info *
+wiphy_to_cfg(struct wiphy *wiphy)
+{
+	struct inff_pub *drvr = wiphy_priv(wiphy);
+
+	return drvr->config;
+}
+
+static inline struct inff_cfg80211_info *
+wdev_to_cfg(struct wireless_dev *wdev)
+{
+	return wiphy_to_cfg(wdev->wiphy);
+}
+
+static inline struct net_device *
+cfg_to_ndev(struct inff_cfg80211_info *cfg)
+{
+	return inff_get_ifp(cfg->pub, 0)->ndev;
+}
+
+static inline struct inff_cfg80211_info *
+ndev_to_cfg(struct net_device *ndev)
+{
+	return wdev_to_cfg(ndev->ieee80211_ptr);
+}
+
+static inline struct inff_cfg80211_vif *
+ndev_to_vif(struct net_device *ndev)
+{
+	struct inff_if *ifp = netdev_priv(ndev);
+
+	return ifp->vif;
+}
+
+s32 inff_inform_single_bss(struct inff_cfg80211_info *cfg,
+			   struct inff_bss_info_le *bi);
+s32 inff_inform_bss(struct inff_cfg80211_info *cfg);
+s32 inff_inform_ibss(struct inff_cfg80211_info *cfg,
+		     struct net_device *ndev, const u8 *bssid);
+s32 inff_compare_update_same_bss(struct inff_cfg80211_info *cfg,
+				 struct inff_bss_info_le *bss,
+				 struct inff_bss_info_le *bss_info_le);
+s32 inff_bss_roaming_done(struct inff_cfg80211_info *cfg,
+			  struct net_device *ndev,
+			  const struct inff_event_msg *e);
+s32 inff_bss_connect_done(struct inff_cfg80211_info *cfg,
+			  struct net_device *ndev,
+			  const struct inff_event_msg *e,
+			  bool completed);
+void inff_set_mpc(struct inff_if *ndev, int mpc);
+void inff_cfg80211_update_proto_addr_mode(struct wireless_dev *wdev);
+bool inff_ieee80211_is_dpp_pub_action(void *frame, u32 frame_len);
+bool inff_ieee80211_is_gas_pub_action(void *frame, u32 frame_len);
+int inff_cfg80211_get_channel(struct wiphy *wiphy,
+			      struct wireless_dev *wdev,
+			      unsigned int link_id,
+			      struct cfg80211_chan_def *chandef);
+struct cfg80211_ops *inff_cfg80211_get_ops(struct inff_mp_device *settings);
+void inff_cfg80211_free_netdev_priv(struct net_device *ndev);
+u8 inff_map_prio_to_prec(void *config, u8 prio);
+u8 inff_map_prio_to_aci(void *config, u8 prio);
+void inff_wifi_prioritize_acparams(const struct inff_cfg80211_edcf_acparam *acp,
+				   u8 *priority);
+s32 inff_cfg80211_up(struct net_device *ndev);
+s32 inff_cfg80211_down(struct net_device *ndev);
+int inff_alloc_wiphy(struct device *dev, struct inff_mp_device *settings);
+void inff_free_wiphy(struct device *dev);
+struct inff_cfg80211_info *inff_cfg80211_attach(struct inff_pub *drvr,
+						struct cfg80211_ops *ops);
+void inff_cfg80211_detach(struct inff_cfg80211_info *cfg);
+#endif /* INFF_CFG80211_H */
-- 
2.25.1


