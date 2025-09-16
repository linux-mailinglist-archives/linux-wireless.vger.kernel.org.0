Return-Path: <linux-wireless+bounces-27401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1DB7E91B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CD8188680A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2A32F462;
	Tue, 16 Sep 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="mS+CW+3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504232E2DC
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061751; cv=none; b=oMIhWdRgVnXyKz9ElisImyZXUDsef/CdFJgn01mIt7KUWHj1yySUCNf0tTKYK7VW0s4ShKhF7CpH+qC4PTw6T/wDgN6i6JDDMcwfVtkU6TNybFaxl+KxMDMDYALmLvpHwImqUU042oio1jw8f4tU4eNqjcOlDQo5XkyCg4wzllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061751; c=relaxed/simple;
	bh=BIepjhTd6yjDC1bHaijXmWrWi/bs3+9yZ+l1/6z600g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHeCwWDwx3lxDqebO2C9asLvOwtnodTDCom3UquyM6Mn2d/ju1nmjxIm0YmFYmMsRXQtiRhTFr7HpK3u9BdzixQq8GGJHhHm+JcdZF07AOgoMcSX5DQeYdxWFXi4XLCgzNJYr6dJmHIeu/bswtOb+s7K35uIORNMl5JOdAY2uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=mS+CW+3s; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061748; x=1789597748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIepjhTd6yjDC1bHaijXmWrWi/bs3+9yZ+l1/6z600g=;
  b=mS+CW+3sjvvRdvWoqFpPk7HqKE212EUwQQphEAV3VWnbEpjykun0CAc9
   zzxOfujN0hmASx+LSdWoSgiH0wLFTT5O4O5xwTE4MTEMPaMOEKeOE5XNt
   vY3m7YYnApbARL3/lmt1q7Vr7hWStnwP2qUoDdTyWfC6bURX5byYvj5b5
   k=;
X-CSE-ConnectionGUID: IqqkN0JMQRyWp2U2EqNFPw==
X-CSE-MsgGUID: 91YO8im3RoCXNZy6PQGKdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783933"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:29:06 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:29:06 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:29:02 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 46/57] wifi: inffmac: add pno.c/h
Date: Wed, 17 Sep 2025 03:48:06 +0530
Message-ID: <20250916221821.4387-52-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for the Preferred Network Offload (PNO) feature.
This helps in offload the preferred BSS profiles to the Device firmware.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/pno.c | 770 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/pno.h | 140 ++++
 2 files changed, 910 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/pno.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pno.h

diff --git a/drivers/net/wireless/infineon/inffmac/pno.c b/drivers/net/wireless/infineon/inffmac/pno.c
new file mode 100644
index 000000000000..5d4026745f03
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pno.c
@@ -0,0 +1,770 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2016 Broadcom
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/netdevice.h>
+#include <linux/gcd.h>
+#include <net/cfg80211.h>
+
+#include "core.h"
+#include "debug.h"
+#include "fwil.h"
+#include "fwil_types.h"
+#include "cfg80211.h"
+#include "pno.h"
+#include "feature.h"
+#include "vendor_inf.h"
+#include "chanspec.h"
+#include "security.h"
+
+#define INFF_PNO_VERSION		2
+#define INFF_PNO_REPEAT		4
+#define INFF_PNO_FREQ_EXPO_MAX		3
+#define INFF_PNO_IMMEDIATE_SCAN_BIT	3
+#define INFF_PNO_ENABLE_BD_SCAN_BIT	5
+#define INFF_PNO_ENABLE_ADAPTSCAN_BIT	6
+#define INFF_PNO_REPORT_SEPARATELY_BIT	11
+#define INFF_PNO_SCAN_INCOMPLETE	0
+#define INFF_PNO_WPA_AUTH_ANY		0xFFFFFFFF
+#define INFF_PNO_HIDDEN_BIT		2
+#define INFF_PNO_SCHED_SCAN_PERIOD	30
+
+#define INFF_PNO_MAX_BUCKETS		16
+#define GSCAN_BATCH_NO_THR_SET			101
+#define GSCAN_RETRY_THRESHOLD			3
+
+struct inff_pno_info {
+	int n_reqs;
+	struct cfg80211_sched_scan_request *reqs[INFF_PNO_MAX_BUCKETS];
+	struct mutex req_lock;	/* used to protect pno resource */
+};
+
+#define ifp_to_pno(_ifp)	((_ifp)->drvr->config->pno)
+
+static int inff_pno_store_request(struct inff_pno_info *pi,
+				  struct cfg80211_sched_scan_request *req)
+{
+	if (WARN(pi->n_reqs == INFF_PNO_MAX_BUCKETS,
+		 "pno request storage full\n"))
+		return -ENOSPC;
+
+	inff_dbg(SCAN, "reqid=%llu\n", req->reqid);
+	mutex_lock(&pi->req_lock);
+	pi->reqs[pi->n_reqs++] = req;
+	mutex_unlock(&pi->req_lock);
+	return 0;
+}
+
+static int inff_pno_remove_request(struct inff_pno_info *pi, u64 reqid)
+{
+	int i, err = 0;
+
+	mutex_lock(&pi->req_lock);
+
+	/* Nothing to do if we have no requests */
+	if (pi->n_reqs == 0)
+		goto done;
+
+	/* find request */
+	for (i = 0; i < pi->n_reqs; i++) {
+		if (pi->reqs[i]->reqid == reqid)
+			break;
+	}
+	/* request not found */
+	if (WARN(i == pi->n_reqs, "reqid not found\n")) {
+		err = -ENOENT;
+		goto done;
+	}
+
+	inff_dbg(SCAN, "reqid=%llu\n", reqid);
+	pi->n_reqs--;
+
+	/* if last we are done */
+	if (!pi->n_reqs || i == pi->n_reqs)
+		goto done;
+
+	/* fill the gap with remaining requests */
+	while (i <= pi->n_reqs - 1) {
+		pi->reqs[i] = pi->reqs[i + 1];
+		i++;
+	}
+
+done:
+	mutex_unlock(&pi->req_lock);
+	return err;
+}
+
+static int inff_pno_channel_config(struct inff_if *ifp,
+				   struct inff_pno_config_le *cfg)
+{
+	cfg->reporttype = 0;
+	cfg->flags = 0;
+
+	return inff_fil_iovar_data_set(ifp, "pfn_cfg", cfg, sizeof(*cfg));
+}
+
+static int inff_pno_config(struct inff_if *ifp, u32 scan_freq,
+			   u32 mscan, u32 bestn)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pno_param_le pfn_param;
+	u16 flags;
+	u32 pfnmem;
+	s32 err;
+
+	memset(&pfn_param, 0, sizeof(pfn_param));
+	pfn_param.version = cpu_to_le32(INFF_PNO_VERSION);
+
+	/* set extra pno params */
+	flags = BIT(INFF_PNO_IMMEDIATE_SCAN_BIT) |
+		BIT(INFF_PNO_ENABLE_ADAPTSCAN_BIT);
+	pfn_param.repeat = INFF_PNO_REPEAT;
+	pfn_param.exp = INFF_PNO_FREQ_EXPO_MAX;
+
+	/* set up pno scan fr */
+	pfn_param.scan_freq = cpu_to_le32(scan_freq);
+
+	if (mscan) {
+		pfnmem = bestn;
+
+		/* set bestn in firmware */
+		err = inff_fil_iovar_int_set(ifp, "pfnmem", pfnmem);
+		if (err < 0) {
+			iphy_err(drvr, "failed to set pfnmem\n");
+			goto exit;
+		}
+		/* get max mscan which the firmware supports */
+		err = inff_fil_iovar_int_get(ifp, "pfnmem", &pfnmem);
+		if (err < 0) {
+			iphy_err(drvr, "failed to get pfnmem\n");
+			goto exit;
+		}
+		mscan = min_t(u32, mscan, pfnmem);
+		pfn_param.mscan = mscan;
+		pfn_param.bestn = bestn;
+		flags |= BIT(INFF_PNO_ENABLE_BD_SCAN_BIT);
+		inff_dbg(INFO, "mscan=%d, bestn=%d\n", mscan, bestn);
+	}
+
+	pfn_param.flags = cpu_to_le16(flags);
+	err = inff_fil_iovar_data_set(ifp, "pfn_set", &pfn_param,
+				      sizeof(pfn_param));
+	if (err)
+		iphy_err(drvr, "pfn_set failed, err=%d\n", err);
+
+exit:
+	return err;
+}
+
+static int inff_pno_set_random(struct inff_if *ifp, struct inff_pno_info *pi)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pno_macaddr_le pfn_mac;
+	u8 *mac_addr = NULL;
+	u8 *mac_mask = NULL;
+	int err, i, ri;
+
+	for (ri = 0; ri < pi->n_reqs; ri++)
+		if (pi->reqs[ri]->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+			mac_addr = pi->reqs[ri]->mac_addr;
+			mac_mask = pi->reqs[ri]->mac_addr_mask;
+			break;
+		}
+
+	/* no random mac requested */
+	if (!mac_addr)
+		return 0;
+
+	pfn_mac.version = INFF_PFN_MACADDR_CFG_VER;
+	pfn_mac.flags = INFF_PFN_MAC_OUI_ONLY | INFF_PFN_SET_MAC_UNASSOC;
+
+	memcpy(pfn_mac.mac, mac_addr, ETH_ALEN);
+	for (i = 0; i < ETH_ALEN; i++) {
+		pfn_mac.mac[i] &= mac_mask[i];
+		pfn_mac.mac[i] |= get_random_u8() & ~(mac_mask[i]);
+	}
+	/* Clear multi bit */
+	pfn_mac.mac[0] &= 0xFE;
+	/* Set locally administered */
+	pfn_mac.mac[0] |= 0x02;
+
+	inff_dbg(SCAN, "enabling random mac: reqid=%llu mac=%pM\n",
+		 pi->reqs[ri]->reqid, pfn_mac.mac);
+	err = inff_fil_iovar_data_set(ifp, "pfn_macaddr", &pfn_mac,
+				      sizeof(pfn_mac));
+	if (err)
+		iphy_err(drvr, "pfn_macaddr failed, err=%d\n", err);
+
+	return err;
+}
+
+static int inff_pno_add_ssid(struct inff_if *ifp, struct cfg80211_ssid *ssid,
+			     bool active)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pno_net_param_le pfn;
+	int err;
+
+	pfn.auth = cpu_to_le32(WLAN_AUTH_OPEN);
+	pfn.wpa_auth = cpu_to_le32(INFF_PNO_WPA_AUTH_ANY);
+	pfn.wsec = cpu_to_le32(0);
+	pfn.infra = cpu_to_le32(1);
+	pfn.flags = 0;
+	if (active)
+		pfn.flags = cpu_to_le32(1 << INFF_PNO_HIDDEN_BIT);
+	pfn.ssid.SSID_len = cpu_to_le32(ssid->ssid_len);
+	memcpy(pfn.ssid.SSID, ssid->ssid, ssid->ssid_len);
+
+	inff_dbg(SCAN, "adding ssid=%.32s (active=%d)\n", ssid->ssid, active);
+	err = inff_fil_iovar_data_set(ifp, "pfn_add", &pfn, sizeof(pfn));
+	if (err < 0)
+		iphy_err(drvr, "adding failed: err=%d\n", err);
+	return err;
+}
+
+static int inff_pno_add_bssid(struct inff_if *ifp, const u8 *bssid)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pno_bssid_le bssid_cfg;
+	int err;
+
+	memcpy(bssid_cfg.bssid, bssid, ETH_ALEN);
+	bssid_cfg.flags = 0;
+
+	inff_dbg(SCAN, "adding bssid=%pM\n", bssid);
+	err = inff_fil_iovar_data_set(ifp, "pfn_add_bssid", &bssid_cfg,
+				      sizeof(bssid_cfg));
+	if (err < 0)
+		iphy_err(drvr, "adding failed: err=%d\n", err);
+	return err;
+}
+
+static bool inff_is_ssid_active(struct cfg80211_ssid *ssid,
+				struct cfg80211_sched_scan_request *req)
+{
+	int i;
+
+	if (!ssid || !req->ssids || !req->n_ssids)
+		return false;
+
+	for (i = 0; i < req->n_ssids; i++) {
+		if (ssid->ssid_len == req->ssids[i].ssid_len) {
+			if (!strncmp(ssid->ssid, req->ssids[i].ssid,
+				     ssid->ssid_len))
+				return true;
+		}
+	}
+	return false;
+}
+
+static int inff_pno_clean(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	int ret;
+
+	/* Disable pfn */
+	ret = inff_fil_iovar_int_set(ifp, "pfn", 0);
+	if (ret == 0) {
+		/* clear pfn */
+		ret = inff_fil_iovar_data_set(ifp, "pfnclear", NULL, 0);
+	}
+	if (ret < 0)
+		iphy_err(drvr, "failed code %d\n", ret);
+
+	return ret;
+}
+
+static int inff_pno_get_bucket_channels(struct cfg80211_sched_scan_request *r,
+					struct inff_pno_config_le *pno_cfg)
+{
+	u32 n_chan = le32_to_cpu(pno_cfg->channel_num);
+	u16 chan;
+	int i, err = 0;
+
+	for (i = 0; i < r->n_channels; i++) {
+		if (n_chan >= INFF_NUMCHANNELS) {
+			err = -ENOSPC;
+			goto done;
+		}
+		chan = r->channels[i]->hw_value;
+		inff_dbg(SCAN, "[%d] Chan : %u\n", n_chan, chan);
+		pno_cfg->channel_list[n_chan++] = cpu_to_le16(chan);
+	}
+	/* return number of channels */
+	err = n_chan;
+done:
+	pno_cfg->channel_num = cpu_to_le32(n_chan);
+	return err;
+}
+
+static int inff_pno_prep_fwconfig(struct inff_pno_info *pi,
+				  struct inff_pno_config_le *pno_cfg,
+				   struct inff_gscan_bucket_config **buckets,
+				   u32 *scan_freq)
+{
+	struct cfg80211_sched_scan_request *sr;
+	struct inff_gscan_bucket_config *fw_buckets;
+	int i, err, chidx;
+
+	inff_dbg(SCAN, "n_reqs=%d\n", pi->n_reqs);
+	if (WARN_ON(!pi->n_reqs))
+		return -ENODATA;
+
+	/*
+	 * actual scan period is determined using gcd() for each
+	 * scheduled scan period.
+	 */
+	*scan_freq = pi->reqs[0]->scan_plans[0].interval;
+	for (i = 1; i < pi->n_reqs; i++) {
+		sr = pi->reqs[i];
+		*scan_freq = gcd(sr->scan_plans[0].interval, *scan_freq);
+	}
+	if (*scan_freq < INFF_PNO_SCHED_SCAN_MIN_PERIOD) {
+		inff_dbg(SCAN, "scan period too small, using minimum\n");
+		*scan_freq = INFF_PNO_SCHED_SCAN_MIN_PERIOD;
+	}
+
+	*buckets = NULL;
+	fw_buckets = kcalloc(pi->n_reqs, sizeof(*fw_buckets), GFP_KERNEL);
+	if (!fw_buckets)
+		return -ENOMEM;
+
+	memset(pno_cfg, 0, sizeof(*pno_cfg));
+	for (i = 0; i < pi->n_reqs; i++) {
+		sr = pi->reqs[i];
+		chidx = inff_pno_get_bucket_channels(sr, pno_cfg);
+		if (chidx < 0) {
+			err = chidx;
+			goto fail;
+		}
+		fw_buckets[i].bucket_end_index = chidx - 1;
+		fw_buckets[i].bucket_freq_multiple =
+			sr->scan_plans[0].interval / *scan_freq;
+		/* assure period is non-zero */
+		if (!fw_buckets[i].bucket_freq_multiple)
+			fw_buckets[i].bucket_freq_multiple = 1;
+		fw_buckets[i].flag = INFF_PNO_REPORT_NO_BATCH;
+	}
+
+	if (INFF_SCAN_ON()) {
+		inff_err("base period=%u\n", *scan_freq);
+		for (i = 0; i < pi->n_reqs; i++) {
+			inff_err("[%d] period %u max %u repeat %u flag %x idx %u\n",
+				 i, fw_buckets[i].bucket_freq_multiple,
+				 le16_to_cpu(fw_buckets[i].max_freq_multiple),
+				 fw_buckets[i].repeat, fw_buckets[i].flag,
+				 fw_buckets[i].bucket_end_index);
+		}
+	}
+	*buckets = fw_buckets;
+	return pi->n_reqs;
+
+fail:
+	kfree(fw_buckets);
+	return err;
+}
+
+static int inff_pno_config_networks(struct inff_if *ifp,
+				    struct inff_pno_info *pi)
+{
+	struct cfg80211_sched_scan_request *r;
+	struct cfg80211_match_set *ms;
+	bool active;
+	int i, j, err = 0;
+
+	for (i = 0; i < pi->n_reqs; i++) {
+		r = pi->reqs[i];
+
+		for (j = 0; j < r->n_match_sets; j++) {
+			ms = &r->match_sets[j];
+			if (ms->ssid.ssid_len) {
+				active = inff_is_ssid_active(&ms->ssid, r);
+				err = inff_pno_add_ssid(ifp, &ms->ssid,
+							active);
+			}
+			if (!err && is_valid_ether_addr(ms->bssid))
+				err = inff_pno_add_bssid(ifp, ms->bssid);
+
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int inff_pno_config_sched_scans(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct inff_pno_info *pi;
+	struct inff_gscan_config *gscan_cfg;
+	struct inff_gscan_bucket_config *buckets;
+	struct inff_pno_config_le pno_cfg;
+	size_t gsz;
+	u32 scan_freq;
+	int err, n_buckets;
+
+	pi = ifp_to_pno(ifp);
+	n_buckets = inff_pno_prep_fwconfig(pi, &pno_cfg, &buckets,
+					   &scan_freq);
+	if (n_buckets < 0)
+		return n_buckets;
+
+	gsz = struct_size(gscan_cfg, bucket, n_buckets);
+	gscan_cfg = kzalloc(gsz, GFP_KERNEL);
+	if (!gscan_cfg) {
+		err = -ENOMEM;
+		goto free_buckets;
+	}
+
+	/* clean up everything */
+	err = inff_pno_clean(ifp);
+	if  (err < 0) {
+		iphy_err(drvr, "failed error=%d\n", err);
+		goto free_gscan;
+	}
+
+	/* configure pno */
+	err = inff_pno_config(ifp, scan_freq, 0, 0);
+	if (err < 0)
+		goto free_gscan;
+
+	err = inff_pno_channel_config(ifp, &pno_cfg);
+	if (err < 0)
+		goto clean;
+
+	gscan_cfg->version = cpu_to_le16(INFF_GSCAN_CFG_VERSION);
+	gscan_cfg->retry_threshold = GSCAN_RETRY_THRESHOLD;
+	gscan_cfg->buffer_threshold = GSCAN_BATCH_NO_THR_SET;
+	gscan_cfg->flags = INFF_GSCAN_CFG_ALL_BUCKETS_IN_1ST_SCAN;
+
+	gscan_cfg->count_of_channel_buckets = n_buckets;
+	memcpy(gscan_cfg->bucket, buckets,
+	       array_size(n_buckets, sizeof(*buckets)));
+
+	err = inff_fil_iovar_data_set(ifp, "pfn_gscan_cfg", gscan_cfg, gsz);
+
+	if (err < 0)
+		goto clean;
+
+	/* configure random mac */
+	err = inff_pno_set_random(ifp, pi);
+	if (err < 0)
+		goto clean;
+
+	err = inff_pno_config_networks(ifp, pi);
+	if (err < 0)
+		goto clean;
+
+	/* Enable the PNO */
+	err = inff_fil_iovar_int_set(ifp, "pfn", 1);
+
+clean:
+	if (err < 0)
+		inff_pno_clean(ifp);
+free_gscan:
+	kfree(gscan_cfg);
+free_buckets:
+	kfree(buckets);
+	return err;
+}
+
+int inff_pno_start_sched_scan(struct inff_if *ifp,
+			      struct cfg80211_sched_scan_request *req)
+{
+	struct inff_pno_info *pi;
+	int ret;
+
+	inff_dbg(TRACE, "reqid=%llu\n", req->reqid);
+
+	pi = ifp_to_pno(ifp);
+	ret = inff_pno_store_request(pi, req);
+	if (ret < 0)
+		return ret;
+
+	ret = inff_pno_config_sched_scans(ifp);
+	if (ret < 0) {
+		inff_pno_remove_request(pi, req->reqid);
+		if (pi->n_reqs)
+			(void)inff_pno_config_sched_scans(ifp);
+		return ret;
+	}
+	return 0;
+}
+
+int inff_pno_stop_sched_scan(struct inff_if *ifp, u64 reqid)
+{
+	struct inff_pno_info *pi;
+	int err;
+
+	inff_dbg(TRACE, "reqid=%llu\n", reqid);
+
+	pi = ifp_to_pno(ifp);
+
+	/* No PNO request */
+	if (!pi->n_reqs)
+		return 0;
+
+	err = inff_pno_remove_request(pi, reqid);
+	if (err)
+		return err;
+
+	inff_pno_clean(ifp);
+
+	if (pi->n_reqs)
+		(void)inff_pno_config_sched_scans(ifp);
+
+	return 0;
+}
+
+int inff_pno_attach(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pno_info *pi;
+
+	inff_dbg(TRACE, "enter\n");
+	pi = kzalloc(sizeof(*pi), GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	cfg->pno = pi;
+	mutex_init(&pi->req_lock);
+	return 0;
+}
+
+void inff_pno_detach(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pno_info *pi;
+
+	inff_dbg(TRACE, "enter\n");
+	pi = cfg->pno;
+	cfg->pno = NULL;
+
+	WARN_ON(pi->n_reqs);
+	mutex_destroy(&pi->req_lock);
+	kfree(pi);
+}
+
+void inff_pno_wiphy_params(struct wiphy *wiphy, bool gscan)
+{
+	/* scheduled scan settings */
+	wiphy->max_sched_scan_reqs = gscan ? INFF_PNO_MAX_BUCKETS : 1;
+	wiphy->max_sched_scan_ssids = INFF_PNO_MAX_PFN_COUNT;
+	wiphy->max_match_sets = INFF_PNO_MAX_PFN_COUNT;
+	wiphy->max_sched_scan_ie_len = INFF_SCAN_IE_LEN_MAX;
+	wiphy->max_sched_scan_plan_interval = INFF_PNO_SCHED_SCAN_MAX_PERIOD;
+}
+
+u64 inff_pno_find_reqid_by_bucket(struct inff_pno_info *pi, u32 bucket)
+{
+	u64 reqid = 0;
+
+	mutex_lock(&pi->req_lock);
+
+	if (bucket < pi->n_reqs)
+		reqid = pi->reqs[bucket]->reqid;
+
+	mutex_unlock(&pi->req_lock);
+	return reqid;
+}
+
+u32 inff_pno_get_bucket_map(struct inff_pno_info *pi,
+			    struct inff_pno_net_info_le *ni)
+{
+	struct cfg80211_sched_scan_request *req;
+	struct cfg80211_match_set *ms;
+	u32 bucket_map = 0;
+	int i, j;
+
+	mutex_lock(&pi->req_lock);
+	for (i = 0; i < pi->n_reqs; i++) {
+		req = pi->reqs[i];
+
+		if (!req->n_match_sets)
+			continue;
+		for (j = 0; j < req->n_match_sets; j++) {
+			ms = &req->match_sets[j];
+			if (ms->ssid.ssid_len == ni->SSID_len &&
+			    !memcmp(ms->ssid.ssid, ni->SSID, ni->SSID_len)) {
+				bucket_map |= BIT(i);
+				break;
+			}
+			if (is_valid_ether_addr(ms->bssid) &&
+			    !memcmp(ms->bssid, ni->bssid, ETH_ALEN)) {
+				bucket_map |= BIT(i);
+				break;
+			}
+		}
+	}
+	mutex_unlock(&pi->req_lock);
+	return bucket_map;
+}
+
+int pfn_send_network_blob_fw(struct wiphy *wiphy,
+			     struct wireless_dev *wdev)
+{
+	int i, ret;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct network_blob *network_blob_data;
+	struct inff_pfn_param pfn_param;
+	struct inff_pfn *pfn_list_buffer = NULL, *pssidnet;
+	int inff_pfn_length = 0;
+	u32 offset;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+
+	vif = container_of(wdev, struct inff_cfg80211_vif, wdev);
+	ifp = vif->ifp;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	ret = inff_fil_cmd_data_set(vif->ifp,
+				    INFF_C_DISASSOC, NULL, 0);
+	if (ret) {
+		inff_err("INFF_C_DISASSOC error:%d\n", ret);
+		return ret;
+	}
+	inff_pno_clean(ifp);
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FWSUP)) {
+		ret = inff_fil_iovar_int_set(ifp, "sup_wpa", 1);
+		if (ret) {
+			inff_err("sup_wpa set error:%d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!cfg->pfn_data.count)
+		return 0;
+
+	pfn_param.flags = (PFN_LIST_ORDER << SORT_CRITERIA_BIT | ENABLE << IMMEDIATE_SCAN_BIT);
+	pfn_param.bestn = DEFAULT_BESTN;
+	pfn_param.mscan = DEFAULT_MSCAN;
+	pfn_param.repeat = DEFAULT_REPEAT;
+	pfn_param.exp = DEFAULT_EXP;
+
+	if (cfg->pfn_data.pfn_config == PFN_CONFIG_AUTOCONNECT) {
+		pfn_param.flags |= AUTO_CONNECT_MASK;
+
+	} else if (cfg->pfn_data.pfn_config == PFN_CONFIG_AUTOSWITCH_LISTORDER) {
+		pfn_param.flags |= AUTO_NET_SWITCH_MASK;
+		pfn_param.flags |= (PFN_LIST_ORDER << SORT_CRITERIA_BIT);
+
+	} else if (cfg->pfn_data.pfn_config == PFN_CONFIG_AUTOSWITCH_RSSI) {
+		pfn_param.flags |= AUTO_NET_SWITCH_MASK;
+		pfn_param.flags |= (PFN_RSSI << SORT_CRITERIA_BIT);
+	}
+
+	pfn_param.version = cpu_to_le32(PFN_VERSION);
+	pfn_param.scan_freq = cpu_to_le32(30);
+	pfn_param.lost_network_timeout = cpu_to_le32(60);
+	pfn_param.flags = cpu_to_le16(pfn_param.flags);
+	pfn_param.rssi_margin = cpu_to_le16(10);
+	pfn_param.slow_freq = cpu_to_le32(0);
+
+	ret = inff_fil_iovar_data_set(ifp, "pfn_set", (void *)&pfn_param,
+				      sizeof(struct inff_pfn_param));
+	if (ret) {
+		inff_err("set pfn_set enable error:%d\n", ret);
+		return ret;
+	}
+
+	inff_pfn_length = (cfg->pfn_data.count) * sizeof(struct inff_pfn);
+
+	pfn_list_buffer = kzalloc(inff_pfn_length, GFP_KERNEL);
+
+	if (!pfn_list_buffer)
+		return -ENOMEM;
+
+	pssidnet = pfn_list_buffer;
+	network_blob_data = cfg->pfn_data.network_blob_data;
+
+	for (i = 0; i < cfg->pfn_data.count; i++) {
+		/* Default setting, open, no WPA, no WEP and bss */
+		pssidnet->auth = WLAN_AUTH_OPEN;
+		pssidnet->wpa_auth = WPA_AUTH_DISABLED;
+		pssidnet->wsec = CRYPTO_ALGO_OFF;
+		pssidnet->infra = PFN_SSID_INFRA;
+		pssidnet->flags = 0;
+		memcpy((char *)pssidnet->ssid.SSID, network_blob_data->ssid,
+		       network_blob_data->ssid_len);
+		pssidnet->ssid.SSID_len = cpu_to_le32(network_blob_data->ssid_len);
+		pssidnet->flags = cpu_to_le32(pssidnet->flags);
+
+		if (strlen(network_blob_data->psk)) {
+			memcpy((char *)pssidnet->psk.key,
+			       network_blob_data->psk, WSEC_MAX_PASSWORD_LEN);
+			pssidnet->psk.key_len = strlen(network_blob_data->psk);
+		}
+
+		if (network_blob_data->proto == WPA_PROTO_WPA &&
+		    network_blob_data->key_mgmt == INFF_KEY_MGMT_ID_WPA) {
+			pssidnet->wpa_auth = WPA_AUTH_PSK;
+
+		} else if (network_blob_data->proto == WPA_PROTO_RSN &&
+			   network_blob_data->key_mgmt == INFF_KEY_MGMT_ID_WPA2) {
+			pssidnet->wpa_auth = WPA2_AUTH_PSK;
+
+		} else if (network_blob_data->proto == WPA_PROTO_RSN &&
+			   network_blob_data->key_mgmt == INFF_KEY_MGMT_ID_SAE) {
+			pssidnet->wpa_auth = WPA3_AUTH_SAE_PSK;
+			pssidnet->auth = WLAN_AUTH_SAE;
+
+		} else if (network_blob_data->proto == WPA_PROTO_RSN &&
+			   network_blob_data->key_mgmt == INFF_KEY_MGMT_ID_OWE) {
+			pssidnet->wpa_auth = WPA3_AUTH_OWE;
+		}
+
+		if (network_blob_data->pairwise_cipher == BIT(CRYPTO_ALGO_AES_CCM))
+			pssidnet->wsec = AES_ENABLED;
+
+		else if (network_blob_data->pairwise_cipher == BIT(CRYPTO_ALGO_TKIP))
+			pssidnet->wsec = TKIP_ENABLED;
+
+		inff_dbg(TRACE, "ssid %s key_mgmt %d proto %d wsec %d wpa_auth %d auth %d\n",
+			 network_blob_data->ssid, network_blob_data->key_mgmt,
+			 network_blob_data->proto, pssidnet->wsec,
+			 pssidnet->wpa_auth, pssidnet->auth);
+		pssidnet++;
+		network_blob_data++;
+	}
+
+	/* There is a limit in len of data that we can send to fw using an iovar at a time.
+	 * Here max value of cfg->pfn_data.count could be 16 which is exceeding the limit,
+	 * so sending it two times.
+	 */
+	if (cfg->pfn_data.count > (INFF_PNO_MAX_PFN_COUNT / 2)) {
+		offset = sizeof(struct inff_pfn) * (INFF_PNO_MAX_PFN_COUNT / 2);
+		ret = inff_fil_iovar_data_set(ifp, "pfn_add", (void *)pfn_list_buffer,
+					      offset);
+		if (ret) {
+			inff_err("set pfnadd enable error:%d\n", ret);
+			return ret;
+		}
+
+		ret = inff_fil_iovar_data_set(ifp, "pfn_add", (void *)pfn_list_buffer + offset,
+					      inff_pfn_length - offset);
+		if (ret) {
+			inff_err("set pfnadd enable error:%d\n", ret);
+			return ret;
+		}
+
+	} else {
+		ret = inff_fil_iovar_data_set(ifp, "pfn_add", (void *)pfn_list_buffer,
+					      inff_pfn_length);
+	}
+
+	if (ret) {
+		inff_err("set pfnadd enable error:%d\n", ret);
+		return ret;
+	}
+	ret =  inff_fil_iovar_int_set(ifp, "pfn", PFN_SET);
+	if (ret) {
+		inff_err("set pfn error:%d\n", ret);
+		return ret;
+	}
+	kfree(pfn_list_buffer);
+	inff_dbg(TRACE, "Exit\n");
+	return 0;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/pno.h b/drivers/net/wireless/infineon/inffmac/pno.h
new file mode 100644
index 000000000000..9037107a648c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pno.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2016 Broadcom
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_PNO_H
+#define INFF_PNO_H
+
+#define INFF_PNO_SCAN_COMPLETE			1
+#define INFF_PNO_MAX_PFN_COUNT			16
+#define INFF_PNO_SCHED_SCAN_MIN_PERIOD	10
+#define INFF_PNO_SCHED_SCAN_MAX_PERIOD	508
+#define AUTO_CONNECT_MASK		0x0010
+#define AUTO_NET_SWITCH_MASK		0x0002
+#define INFF_PNO_WPA_AUTH_ANY		0xFFFFFFFF
+#define MAXNUM_SSID_PER_ADD		16
+#define WSEC_MIN_PASSWORD_LEN		8
+#define WSEC_MAX_PASSWORD_LEN		64
+#define PFN_VERSION			2
+#define PFN_LIST_ORDER			0
+#define PFN_RSSI			1
+#define SORT_CRITERIA_BIT		0
+#define ENABLE				1
+#define IMMEDIATE_SCAN_BIT		3
+#define DEFAULT_BESTN			2
+#define DEFAULT_MSCAN			0
+#define DEFAULT_REPEAT			10
+#define DEFAULT_EXP			2
+#define PFN_SET				1
+#define PFN_UNSET			0
+#define PFN_CONFIG_AND_COUNT_SIZE	2
+#define PFN_SSID_INFRA			1
+
+struct inff_pfn_param {
+	s32 version;
+	s32 scan_freq;
+	s32 lost_network_timeout;
+	s16 flags;
+	s16 rssi_margin;
+	u8 bestn;
+	u8 mscan;
+	u8 repeat;
+	u8 exp;
+	s32 slow_freq;
+};
+
+struct inff_pfn {
+	struct inff_ssid_le ssid; /*ssid and its length*/
+	s32 flags; /*bit2: hidden*/
+	s32 infra; /*BSS Vs IBSS*/
+	s32 auth; /*Open Vs Closed*/
+	s32 wpa_auth; /*WPA type*/
+	s32 wsec; /*wsec value*/
+	struct inff_wsec_pmk_le psk; /*Password*/
+};
+
+struct pfn_conn_info {
+	u8 SSID_len;
+	u8 SSID[IEEE80211_MAX_SSID_LEN];
+	u8 BSSID[ETH_ALEN];
+	s16 RSSI;
+	s8 phy_noise;
+	u16 channel;
+	s16 SNR;
+	u8 proto;
+	int key_mgmt;
+};
+
+enum {
+	PFN_CONFIG_AUTOCONNECT,
+	PFN_CONFIG_AUTOSWITCH_LISTORDER,
+	PFN_CONFIG_AUTOSWITCH_RSSI,
+};
+
+/* forward declaration */
+struct inff_pno_info;
+
+/**
+ * inff_pno_start_sched_scan - initiate scheduled scan on device.
+ *
+ * @ifp: interface object used.
+ * @req: configuration parameters for scheduled scan.
+ */
+int inff_pno_start_sched_scan(struct inff_if *ifp,
+			      struct cfg80211_sched_scan_request *req);
+
+/**
+ * inff_pno_stop_sched_scan - terminate scheduled scan on device.
+ *
+ * @ifp: interface object used.
+ * @reqid: unique identifier of scan to be stopped.
+ */
+int inff_pno_stop_sched_scan(struct inff_if *ifp, u64 reqid);
+
+/**
+ * inff_pno_wiphy_params - fill scheduled scan parameters in wiphy instance.
+ *
+ * @wiphy: wiphy instance to be used.
+ * @gscan: indicates whether the device has support for g-scan feature.
+ */
+void inff_pno_wiphy_params(struct wiphy *wiphy, bool gscan);
+
+/**
+ * inff_pno_attach - allocate and attach module information.
+ *
+ * @cfg: cfg80211 context used.
+ */
+int inff_pno_attach(struct inff_cfg80211_info *cfg);
+
+/**
+ * inff_pno_detach - detach and free module information.
+ *
+ * @cfg: cfg80211 context used.
+ */
+void inff_pno_detach(struct inff_cfg80211_info *cfg);
+
+/**
+ * inff_pno_find_reqid_by_bucket - find request id for given bucket index.
+ *
+ * @pi: pno instance used.
+ * @bucket: index of firmware bucket.
+ */
+u64 inff_pno_find_reqid_by_bucket(struct inff_pno_info *pi, u32 bucket);
+
+/**
+ * inff_pno_get_bucket_map - determine bucket map for given netinfo.
+ *
+ * @pi: pno instance used.
+ * @netinfo: netinfo to compare with bucket configuration.
+ */
+u32 inff_pno_get_bucket_map(struct inff_pno_info *pi,
+			    struct inff_pno_net_info_le *netinfo);
+
+int pfn_send_network_blob_fw(struct wiphy *wiphy,
+			     struct wireless_dev *wdev);
+
+#endif /* INFF_PNO_H */
-- 
2.25.1


