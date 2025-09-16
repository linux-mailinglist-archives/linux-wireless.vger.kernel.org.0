Return-Path: <linux-wireless+bounces-27354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7AB7D898
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9756A16C697
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF028C869;
	Tue, 16 Sep 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="axwfrq+h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C9288AD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061192; cv=none; b=l27ClNjoduRFQRdyH4gDkZq68WL7jF7qJ20x7HESoIHhFwujEE2nBcUZ77p5hfzxPAGrilXG13L7l5MpGw1s4hdEJXX0xlkv2b/CWU96rGqH7rdLH69DIzrtz1i21xM3oJCLOYeiijfhxftsq0P0/YlTdvaBBSzosz2m12bgQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061192; c=relaxed/simple;
	bh=2kNYDaIr65fqF8XQvWro7dxKE52rpjkSlXXIxEhTR+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8PXUHWmSnGiLMeDcA+HSstnwYlpqv8nH4C5bItoi8fzO2jZ0EZCseO0e/ugf5nhykFhQIMxJfJGen/8nvtUnJtbPSIratrBG7cbvOzhi44xo76q75fh15UEiWVlU/nsT1+xjxanX4/7tMOsRglBDu0kfk3jUgITKu0si76WBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=axwfrq+h; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061190; x=1789597190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kNYDaIr65fqF8XQvWro7dxKE52rpjkSlXXIxEhTR+U=;
  b=axwfrq+h1hzvu+mbP3yEyKHV8/FLUlHs1sFuJhm/P0LW6CS+ymOMJuqT
   /Lh/rM/Hm1gXuEI4QI+mQixy2z0KWQQI1mYL/hYDDVSw3NK8rzCai0Xsu
   oyFlUHLQnbEjoRt4qGF1XGJuVbr4W1O4r9nUCCt347RVeAWv5ZcZ/7JDi
   g=;
X-CSE-ConnectionGUID: EDXM3RfRSkakbyhj54erPQ==
X-CSE-MsgGUID: 7SLFDAq/QCen24vVBWOxag==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093193"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:19:48 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:19:47 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:19:44 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 06/57] wifi: inffmac: add pmsr.c/h
Date: Wed, 17 Sep 2025 03:47:21 +0530
Message-ID: <20250916221821.4387-7-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for Initating Peer Measurement (PMSR) Request and
returning the collected result back to the userspace through cfg80211.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/pmsr.c | 282 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/pmsr.h |  35 +++
 2 files changed, 317 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pmsr.h

diff --git a/drivers/net/wireless/infineon/inffmac/pmsr.c b/drivers/net/wireless/infineon/inffmac/pmsr.c
new file mode 100644
index 000000000000..049b39c984cc
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pmsr.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include "cfg80211.h"
+#include "debug.h"
+#include "pmsr.h"
+
+void inff_wiphy_pmsr_params(struct wiphy *wiphy, struct inff_if *ifp)
+{
+	struct cfg80211_pmsr_capabilities *pmsr_capa;
+
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_FTM) &&
+	    !inff_feat_is_enabled(ifp, INFF_FEAT_WLAN_SENSE))
+		return;
+
+	pmsr_capa = kzalloc(sizeof(*pmsr_capa), GFP_KERNEL);
+	if (!pmsr_capa)
+		return;
+
+	pmsr_capa->max_peers = INFF_PMSR_PEER_MAX;
+	pmsr_capa->report_ap_tsf = 0;
+	pmsr_capa->randomize_mac_addr = 1;
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FTM)) {
+		pmsr_capa->ftm.preambles = BIT(NL80211_PREAMBLE_HT) |
+		   BIT(NL80211_PREAMBLE_VHT);
+		pmsr_capa->ftm.bandwidths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+		   BIT(NL80211_CHAN_WIDTH_20);
+		pmsr_capa->ftm.max_bursts_exponent = -1; /* all supported */
+		pmsr_capa->ftm.max_ftms_per_burst = 0; /* no limits */
+		pmsr_capa->ftm.supported = 1;
+		pmsr_capa->ftm.asap = 1;
+		pmsr_capa->ftm.non_asap = 1;
+		pmsr_capa->ftm.request_lci = 1;
+		pmsr_capa->ftm.request_civicloc = 1;
+		pmsr_capa->ftm.trigger_based = 0;
+		pmsr_capa->ftm.non_trigger_based = 0;
+	}
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WLAN_SENSE)) {
+		pmsr_capa->sensing.supported = 1;
+		pmsr_capa->sensing.associated = 1;
+		pmsr_capa->sensing.unassociated = 1;
+		pmsr_capa->sensing.vendor_mode = 1;
+		pmsr_capa->sensing.bandwidths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+		   BIT(NL80211_CHAN_WIDTH_20);
+		pmsr_capa->sensing.max_tx_ltf_rep = 0;
+		pmsr_capa->sensing.max_rx_ltf_rep = 0;
+		pmsr_capa->sensing.min_interval = 0;
+		pmsr_capa->sensing.max_rx_chains = 0;
+	}
+
+	wiphy->pmsr_capa = pmsr_capa;
+}
+
+int inff_cfg80211_start_pmsr(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     struct cfg80211_pmsr_request *request)
+{
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct cfg80211_pmsr_request_peer *peer = &request->peers[0];
+	struct inff_ftm_info *ftm_info = cfg->pmsr_info->ftm_info;
+	struct inff_wlan_sense_info *wlan_sense_info = cfg->pmsr_info->wlan_sense_info;
+	struct inff_wlan_sense_cfg wlan_sense_cfg = {0};
+	s32 err = 0;
+
+	if (request->n_peers > INFF_PMSR_PEER_MAX) {
+		inff_err("PMSR: n_peers %d exceeds max peers %d!\n",
+			 request->n_peers, INFF_PMSR_PEER_MAX);
+		err = -EINVAL;
+		goto exit;
+	}
+
+	switch (peer->type) {
+	case NL80211_PMSR_TYPE_FTM:
+		if (!ftm_info || !ftm_info->vif) {
+			inff_err("FTM: context not created!\n");
+			err = -EACCES;
+			goto exit;
+		}
+
+		if (wdev != &ftm_info->vif->wdev) {
+			inff_err("FTM: get request from invalid wdev interface!\n");
+			err = -EINVAL;
+			goto exit;
+		}
+
+		if (ftm_info->ftm_req) {
+			inff_err("FTM: task is running!\n");
+			err = -EBUSY;
+			goto exit;
+		}
+
+		inff_dbg(TRACE, "FTM: FTM request\n"
+			"peer_mac          : %pM\n"
+			"center_freq       : %d\n"
+			"bandwidth         : %d\n"
+			"preamble          : %d\n"
+			"burst_period      : %d\n"
+			"requested         : %d\n"
+			"asap              : %d\n"
+			"request_lci       : %d\n"
+			"request_civicloc  : %d\n"
+			"trigger_based     : %d\n"
+			"non_trigger_based : %d\n"
+			"num_bursts_exp    : %d\n"
+			"burst_duration    : %d\n"
+			"ftms_per_burst    : %d\n"
+			"ftmr_retries      : %d\n",
+			peer->addr, peer->chandef.chan->center_freq, peer->chandef.width,
+			peer->ftm.preamble, peer->ftm.burst_period, peer->ftm.requested,
+			peer->ftm.asap, peer->ftm.request_lci, peer->ftm.request_civicloc,
+			peer->ftm.trigger_based, peer->ftm.non_trigger_based,
+			peer->ftm.num_bursts_exp, peer->ftm.burst_duration,
+			peer->ftm.ftms_per_burst, peer->ftm.ftmr_retries);
+
+		/* FTM global/session configure */
+		err = inff_ftm_set_global_config(ftm_info, peer);
+		if (err)
+			goto exit;
+		err = inff_ftm_set_session_config(ftm_info, peer,
+						  INFF_PROXD_SESSION_ID_DEFAULT_FTM);
+		if (err)
+			goto exit;
+
+		ftm_info->ftm_req = request;
+		break;
+	case NL80211_PMSR_TYPE_SENSING:
+		if (!wlan_sense_info || !wlan_sense_info->vif) {
+			inff_err("WLAN SENSE: interface not created!\n");
+			err = -EACCES;
+			goto exit;
+		}
+
+		if (wdev != &wlan_sense_info->vif->wdev) {
+			inff_err("WLAN SENSE: get request from invalid wdev interface!\n");
+			err = -EINVAL;
+			goto exit;
+		}
+
+		if (wlan_sense_info->sense_req) {
+			inff_err("WLAN SENSE: task is running!\n");
+			err = -EBUSY;
+			goto exit;
+		}
+
+		err = inff_wlan_sense_parse_req(peer, &wlan_sense_cfg);
+		if (err)
+			goto exit;
+
+		inff_dbg(TRACE, "WLAN SENSE: SENSING request\n"
+			"interval        : %d\n"
+			"duration        : %d\n"
+			"mode_flags      : %d\n"
+			"bss_scope       : %d\n"
+			"ignore_fcs      : %d\n"
+			"ta[0]           : %pM\n"
+			"ta[1]           : %pM\n"
+			"ta[2]           : %pM\n"
+			"ta[3]           : %pM\n"
+			"frmtyp_subtyp[0]: 0x%x\n"
+			"frmtyp_subtyp[1]: 0x%x\n",
+			wlan_sense_cfg.interval, wlan_sense_cfg.duration,
+			wlan_sense_cfg.mode_flags, wlan_sense_cfg.filter.bss_scope,
+			wlan_sense_cfg.filter.ignore_fcs,
+			wlan_sense_cfg.filter.ta[0].octet, wlan_sense_cfg.filter.ta[1].octet,
+			wlan_sense_cfg.filter.ta[2].octet, wlan_sense_cfg.filter.ta[3].octet,
+			wlan_sense_cfg.filter.frmtyp_subtyp[0],
+			wlan_sense_cfg.filter.frmtyp_subtyp[1]);
+
+		err = inff_wlan_sense_oper_handler(wiphy, wdev,
+						   INFF_WLAN_SENSE_OPER_CONFIGURE,
+						   wlan_sense_cfg);
+		if (err)
+			goto exit;
+		err = inff_wlan_sense_oper_handler(wiphy, wdev,
+						   INFF_WLAN_SENSE_OPER_ENABLE,
+						   wlan_sense_cfg);
+		if (err)
+			goto exit;
+
+		wlan_sense_info->sense_req = request;
+		break;
+	default:
+		inff_err("PMSR: type %d not support!\n", peer->type);
+		err = -EINVAL;
+		break;
+	}
+
+exit:
+	return err;
+}
+
+void inff_cfg80211_abort_pmsr(struct wiphy *wiphy, struct wireless_dev *wdev,
+			      struct cfg80211_pmsr_request *request)
+{
+	s32 err = 0;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_ftm_info *ftm_info = cfg->pmsr_info->ftm_info;
+	struct inff_wlan_sense_info *wlan_sense_info = cfg->pmsr_info->wlan_sense_info;
+	struct inff_wlan_sense_cfg wlan_sense_cfg = {0};
+
+	if (ftm_info && ftm_info->vif &&
+	    &ftm_info->vif->wdev == wdev) {
+		/* FTM case */
+		if (!ftm_info->ftm_req) {
+			inff_err("FTM: task not running!\n");
+			return;
+		}
+
+		inff_err("FTM: not support abort currently!\n");
+		return;
+	} else if (wlan_sense_info && wlan_sense_info->vif &&
+		 &wlan_sense_info->vif->wdev == wdev) {
+		/* WLAN_SENSE case */
+		if (!wlan_sense_info->sense_req || !wlan_sense_info->sensing) {
+			inff_err("WLAN SENSE: task not running!\n");
+			return;
+		}
+
+		err = inff_wlan_sense_oper_handler(wiphy, wdev,
+						   INFF_WLAN_SENSE_OPER_DISABLE,
+						   wlan_sense_cfg);
+		inff_dbg(TRACE, "WLAN SENSE: err %d\n", err);
+	} else {
+		inff_err("PMSR: no matching interface!\n");
+	}
+}
+
+void inff_pmsr_debugfs_create(struct inff_pub *drvr)
+{
+	struct wiphy *wiphy = drvr->wiphy;
+	struct inff_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
+	struct inff_ftm_info *ftm_info = cfg->pmsr_info->ftm_info;
+	struct dentry *dentry = inff_debugfs_get_devdir(drvr);
+
+	debugfs_create_u8("ftm_partial_report", 0644, dentry,
+			  &ftm_info->ftm_partial_report);
+	debugfs_create_u32("ftm_debug_mask", 0644, dentry,
+			   &ftm_info->ftm_debug_mask);
+	inff_debugfs_add_entry(drvr, "wlan_sense_stats",
+			       inff_wlan_sense_stats_read);
+}
+
+s32 inff_pmsr_attach(struct inff_cfg80211_info *cfg)
+{
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_pmsr_info *pmsr_info;
+	s32 err = 0;
+
+	pmsr_info = kzalloc(sizeof(*pmsr_info), GFP_KERNEL);
+	if (!pmsr_info)
+		return -ENOMEM;
+	cfg->pmsr_info = pmsr_info;
+
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_FTM)) {
+		err = inff_ftm_attach(cfg);
+		if (err)
+			return err;
+	}
+	if (inff_feat_is_enabled(ifp, INFF_FEAT_WLAN_SENSE)) {
+		err = inff_wlan_sense_attach(cfg);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void inff_pmsr_detach(struct inff_cfg80211_info *cfg)
+{
+	inff_wlan_sense_detach(cfg);
+	inff_ftm_detach(cfg);
+
+	kfree(cfg->pmsr_info);
+	cfg->pmsr_info = NULL;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/pmsr.h b/drivers/net/wireless/infineon/inffmac/pmsr.h
new file mode 100644
index 000000000000..83d88eb2c229
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pmsr.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_PMSR_H
+#define INFF_PMSR_H
+
+#include "ftm.h"
+#include "wlan_sense.h"
+
+#define INFF_PMSR_PEER_MAX 1
+
+/**
+ * struct inff_pmsr_info - context for each kind of PMSR measurement procedure
+ *
+ * @ftm_info: FTM context
+ * @wlan_sense_info: WLAN Sensing context
+ */
+struct inff_pmsr_info {
+	struct inff_ftm_info *ftm_info;
+	struct inff_wlan_sense_info *wlan_sense_info;
+};
+
+void inff_wiphy_pmsr_params(struct wiphy *wiphy, struct inff_if *ifp);
+int inff_cfg80211_start_pmsr(struct wiphy *wiphy, struct wireless_dev *wdev,
+			     struct cfg80211_pmsr_request *request);
+void inff_cfg80211_abort_pmsr(struct wiphy *wiphy, struct wireless_dev *wdev,
+			      struct cfg80211_pmsr_request *request);
+void inff_pmsr_debugfs_create(struct inff_pub *drvr);
+s32 inff_pmsr_attach(struct inff_cfg80211_info *cfg);
+void inff_pmsr_detach(struct inff_cfg80211_info *cfg);
+
+#endif /* INFF_PMSR_H */
-- 
2.25.1


