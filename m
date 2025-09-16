Return-Path: <linux-wireless+bounces-27356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4ECB7D8B5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388E3B1C76
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30455305962;
	Tue, 16 Sep 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="KueGU7rN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9632B481
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061206; cv=none; b=XqlZMoP6O7glYLenjH82NL73OPGA8I2InGb32LhQK2EWA4vgLclfsY4x0v6npQOyCIZoLdcZebV9baeDqQ8VLhxeGMA50vYKZxXcHHPoB1jh0gJn+LjTlXmiChzukzIMv0PAIblnlfUrMs0CrlAcQUMZ4rqYBeFs7i7b5X45RHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061206; c=relaxed/simple;
	bh=ynVPpncUz3mWE7dYINBugWVYsZvjZnnX/T9BFbXd50E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM2ESLNrQLglKDjcwrLxqyoHW1GqDxT8kuEABNiNknjuPV1vNhIz9Pyz61jjlr2Fs1YPADCQm9SVFaACtU7R2bpFfXveMR7pM3zcF6qKb7u0dYvw38b/MUyjVrFAwGOctpsnsNSj/afFfRSvEkNpPQGxeVEx78sKAH6nlbvPbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=KueGU7rN; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061203; x=1789597203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynVPpncUz3mWE7dYINBugWVYsZvjZnnX/T9BFbXd50E=;
  b=KueGU7rN3Q92WS2dVWqurV59BLDiaSiAzQoO3JIHx817T/jMO21dFnq8
   vimzQmmfLPYLXYYSfFSH3ea96JmlYUlmXLL47bRSFly+Fos/eHj/ljVyJ
   W8RNB0Lym1l9WjfyR3r9VycFnvfBUGBB6HFwDQtc2zHabsRfciIm8Ugyr
   s=;
X-CSE-ConnectionGUID: RiCgCWnCTjiLGyOEa3t9MA==
X-CSE-MsgGUID: +jlNbJbERDWp9zD6MHw+rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918133"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:20:01 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:20:00 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:19:57 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 07/57] wifi: inffmac: add ftm.c/h
Date: Wed, 17 Sep 2025 03:47:22 +0530
Message-ID: <20250916221821.4387-8-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of Fine timing measurement (FTM) support, which helps
in finding the accurate round-trip time (RTT) between another supported
peer WLAN device using the Peer Measurement Request (PMSR) infrastructure
currently available in nl80211/cfg80211.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/ftm.c | 605 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/ftm.h | 382 ++++++++++++
 2 files changed, 987 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/ftm.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/ftm.h

diff --git a/drivers/net/wireless/infineon/inffmac/ftm.c b/drivers/net/wireless/infineon/inffmac/ftm.c
new file mode 100644
index 000000000000..ec82e3adbb31
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/ftm.c
@@ -0,0 +1,605 @@
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
+#include "fwil.h"
+#include "pmsr.h"
+
+static s64
+intvl_to_picosecond(struct inff_proxd_intvl intvl)
+{
+	switch (intvl.tmu) {
+	case INFF_PROXD_TMU_TU:
+		return (intvl.intvl * 1024 * 1000 * 1000);
+	case INFF_PROXD_TMU_SEC:
+		return (intvl.intvl * 1000 * 1000 * 1000 * 1000);
+	case INFF_PROXD_TMU_MILLI_SEC:
+		return (intvl.intvl * 1000 * 1000 * 1000);
+	case INFF_PROXD_TMU_MICRO_SEC:
+		return (intvl.intvl * 1000 * 1000);
+	case INFF_PROXD_TMU_NANO_SEC:
+		return (intvl.intvl * 1000);
+	case INFF_PROXD_TMU_PICO_SEC:
+		return (intvl.intvl);
+	default:
+		return (-1);
+	}
+}
+
+static void
+inff_print_rtt_info(struct inff_proxd_rtt_result_v2 *rtt_result,
+		    struct inff_proxd_rtt_sample_v2 *rtt_sample)
+{
+	inff_dbg(TRACE, "FTM: RTT result (%d)\n"
+		"version           : 0x%x\n"
+		"length            : %d\n"
+		"sid               : %d\n"
+		"flags             : 0x%x\n"
+		"status            : %d\n"
+		"peer_mac          : %pM\n"
+		"state             : %d\n"
+		"burst_duration    : %d / %d\n"
+		"avg_dist          : %d\n"
+		"sd_rtt            : %d\n"
+		"num_valid_rtt     : %d\n"
+		"num_ftm           : %d\n"
+		"burst_num         : %d\n"
+		"num_rtt           : %d\n"
+		"num_meas          : %d\n",
+		rtt_result->burst_num, // show burst_num in the first line as result index
+		rtt_result->version, rtt_result->length, rtt_result->sid, rtt_result->flags,
+		rtt_result->status, rtt_result->peer, rtt_result->state,
+		rtt_result->u.burst_duration.intvl, rtt_result->u.burst_duration.tmu,
+		rtt_result->avg_dist, rtt_result->sd_rtt, rtt_result->num_valid_rtt,
+		rtt_result->num_ftm, rtt_result->burst_num, rtt_result->num_rtt,
+		rtt_result->num_meas);
+	inff_dbg(TRACE, "FTM: RTT sample\n"
+		"version           : 0x%x\n"
+		"length            : %d\n"
+		"id                : %d\n"
+		"flags             : 0x%x\n"
+		"rssi              : %d\n"
+		"rtt               : %d / %d\n"
+		"ratespec          : 0x%x\n"
+		"snr               : %d\n"
+		"bitflips          : 0x%x\n"
+		"status            : %d\n"
+		"distance          : %d\n"
+		"tof_phy_error     : %d\n"
+		"tof_tgt_phy_error : %d\n"
+		"tof_tgt_snr       : %d\n"
+		"tof_tgt_bitflips  : 0x%x\n"
+		"coreid            : %d\n"
+		"chanspec          : 0x%x\n",
+		rtt_sample->version, rtt_sample->length, rtt_sample->id, rtt_sample->flags,
+		rtt_sample->rssi, rtt_sample->rtt.intvl, rtt_sample->rtt.tmu,
+		rtt_sample->ratespec, rtt_sample->snr, rtt_sample->bitflips, rtt_sample->status,
+		rtt_sample->distance, rtt_sample->tof_phy_error, rtt_sample->tof_tgt_phy_error,
+		rtt_sample->tof_tgt_snr, rtt_sample->tof_tgt_bitflips, rtt_sample->coreid,
+		rtt_sample->chanspec);
+}
+
+/**
+ * inff_ftm_get_pmsr_result_status() - Mapping rtt_result status to pmsr_result status.
+ *
+ * @status: rtt_result status
+ *
+ * return: pmsr_result status
+ */
+static u8
+inff_ftm_get_pmsr_result_status(s32 status)
+{
+	u8 ret = 0;
+
+	switch (status) {
+	case INFF_PROXD_E_OK:
+		ret = NL80211_PMSR_STATUS_SUCCESS;
+		break;
+	case INFF_PROXD_E_TIMEOUT:
+		ret = NL80211_PMSR_STATUS_TIMEOUT;
+		break;
+	case INFF_PROXD_E_ERROR:
+		ret = NL80211_PMSR_STATUS_FAILURE;
+		break;
+	default:
+		ret = NL80211_PMSR_STATUS_REFUSED;
+		break;
+	}
+
+	return ret;
+}
+
+static s32
+inff_ftm_set_op(struct inff_if *ifp, enum inff_proxd_cmd cmd_id,
+		enum inff_proxd_session_id session_id)
+{
+	struct inff_proxd_iov *ftm_buf = NULL;
+	u8 len = 0;
+	s32 err = 0;
+
+	len = sizeof(struct inff_proxd_iov) + sizeof(struct inff_xtlv);
+	ftm_buf = kzalloc(len, GFP_KERNEL);
+	if (!ftm_buf)
+		return -ENOMEM;
+
+	ftm_buf->version = cpu_to_le16(INFF_PROXD_API_VERSION);
+	ftm_buf->len = cpu_to_le16(len);
+	ftm_buf->cmd = cpu_to_le16(cmd_id);
+	ftm_buf->method = cpu_to_le16(INFF_PROXD_METHOD_FTM);
+	ftm_buf->sid = cpu_to_le16(session_id);
+	ftm_buf->tlvs[0].id = cpu_to_le16(INFF_PROXD_TLV_ID_NONE);
+	ftm_buf->tlvs[0].len = 0;
+	err = inff_fil_iovar_data_set(ifp, "proxd", (char *)ftm_buf, len);
+	if (err)
+		inff_err("proxd ftm cmd %d error: %d\n", cmd_id, err);
+
+	kfree(ftm_buf);
+	return err;
+}
+
+static s32
+inff_ftm_get_op(struct inff_if *ifp, enum inff_proxd_cmd cmd_id,
+		enum inff_proxd_session_id session_id,
+		u8 *data, u16 data_len)
+{
+	struct inff_proxd_iov *ftm_buf = (struct inff_proxd_iov *)data;
+	s32 err = 0;
+
+	ftm_buf->version = cpu_to_le16(INFF_PROXD_API_VERSION);
+	ftm_buf->len = cpu_to_le16(sizeof(struct inff_proxd_iov));
+	ftm_buf->cmd = cpu_to_le16(cmd_id);
+	ftm_buf->method = cpu_to_le16(INFF_PROXD_METHOD_FTM);
+	ftm_buf->sid = cpu_to_le16(session_id);
+	ftm_buf->tlvs[0].id = cpu_to_le16(INFF_PROXD_TLV_ID_NONE);
+	ftm_buf->tlvs[0].len = 0;
+	err = inff_fil_iovar_data_get(ifp, "proxd", data, data_len);
+	if (err)
+		inff_err("proxd ftm cmd %d error: %d\n", cmd_id, err);
+
+	return err;
+}
+
+static s32
+inff_ftm_set_config_op(struct inff_if *ifp,
+		       enum inff_proxd_session_id session_id,
+		       u8 *data, u16 data_len)
+{
+	struct inff_proxd_iov *ftm_buf = NULL;
+	u16 ftm_buf_len = 0;
+	s32 err = 0;
+
+	ftm_buf_len = offsetof(struct inff_proxd_iov, tlvs) + data_len;
+	ftm_buf = kzalloc(ftm_buf_len, GFP_KERNEL);
+	if (!ftm_buf)
+		return -ENOMEM;
+
+	ftm_buf->version = cpu_to_le16(INFF_PROXD_API_VERSION);
+	ftm_buf->len = cpu_to_le16(ftm_buf_len);
+	ftm_buf->cmd = cpu_to_le16(INFF_PROXD_CMD_CONFIG);
+	ftm_buf->method = cpu_to_le16(INFF_PROXD_METHOD_FTM);
+	ftm_buf->sid = cpu_to_le16(session_id);
+	memcpy(&ftm_buf->tlvs[0], data, data_len);
+	err = inff_fil_iovar_data_set(ifp, "proxd", ftm_buf, ftm_buf_len);
+	if (err)
+		inff_err("proxd ftm cmd %d error: %d\n", INFF_PROXD_CMD_CONFIG, err);
+
+	kfree(ftm_buf);
+	return err;
+}
+
+static void
+inff_ftm_update_burst_report(struct inff_ftm_info *ftm_info,
+			     struct inff_proxd_event *p_event)
+{
+	struct cfg80211_pmsr_result result = {0};
+	struct inff_xtlv *proxd_tlv = NULL;
+	struct inff_proxd_rtt_result_v2 *rtt_result = NULL;
+	struct inff_proxd_rtt_sample_v2 *rtt_sample = NULL;
+
+	proxd_tlv = (struct inff_xtlv *)((u8 *)p_event + offsetof(struct inff_proxd_iov, tlvs));
+	if (proxd_tlv->id != INFF_PROXD_TLV_ID_RTT_RESULT_V2) {
+		inff_dbg(TRACE, "FTM: wrong len/id in rtt result!\n");
+		goto fail_result;
+	}
+
+	rtt_result = (struct inff_proxd_rtt_result_v2 *)((u8 *)p_event +
+		      offsetof(struct inff_proxd_iov, tlvs) +
+		      offsetof(struct inff_xtlv, data));
+	rtt_sample = rtt_result->rtt;
+	inff_print_rtt_info(rtt_result, rtt_sample);
+
+	/* update result to upper layer
+	 * please refer the unit of cfg80211_pmsr_result from include/uapi/linux/nl80211.h
+	 */
+	result.host_time = ftm_info->host_time;
+	result.status = inff_ftm_get_pmsr_result_status(rtt_result->status);
+	if (rtt_result)
+		memcpy(result.addr, rtt_result->peer, ETH_ALEN);
+	if (rtt_result->burst_num == (1 << ftm_info->ftm_req->peers[0].ftm.num_bursts_exp)) {
+		/* final report */
+		result.final = 1;
+	} else {
+		result.final = 0;
+	}
+	result.ap_tsf_valid = 0;
+	result.type = NL80211_PMSR_TYPE_FTM;
+	result.ftm.burst_index = rtt_result->burst_num;
+	result.ftm.num_bursts_exp = ftm_info->ftm_req->peers[0].ftm.num_bursts_exp;
+	result.ftm.burst_duration = ftm_info->ftm_req->peers[0].ftm.burst_duration;
+	result.ftm.ftms_per_burst = rtt_result->num_ftm;
+	result.ftm.rssi_avg = (2 * rtt_sample->rssi); // unit: 1/2dBm
+	result.ftm.rtt_avg = intvl_to_picosecond(rtt_sample->rtt); // unit: picosecond
+	result.ftm.rtt_variance = (rtt_result->sd_rtt * rtt_result->sd_rtt);
+	result.ftm.dist_avg = ((rtt_result->avg_dist * 1000) / 256); // unit: mm
+	result.ftm.rssi_avg_valid = 1;
+	result.ftm.rtt_avg_valid = 1;
+	result.ftm.rtt_variance_valid = 1;
+	result.ftm.dist_avg_valid = 1;
+	cfg80211_pmsr_report(&ftm_info->vif->wdev, ftm_info->ftm_req, &result, GFP_KERNEL);
+
+	return;
+
+fail_result:
+	result.status = NL80211_PMSR_STATUS_FAILURE;
+	if (rtt_result)
+		memcpy(result.addr, rtt_result->peer, ETH_ALEN);
+	cfg80211_pmsr_report(&ftm_info->vif->wdev, ftm_info->ftm_req, &result, GFP_KERNEL);
+}
+
+static void
+inff_ftm_update_final_report(struct inff_ftm_info *ftm_info,
+			     struct inff_proxd_event *p_event)
+{
+	struct cfg80211_pmsr_result result = {0};
+	s32 err = 0;
+	u8 proxd_buf[512] = {0};
+	struct inff_proxd_iov *proxd_iov = NULL;
+	struct inff_xtlv *proxd_tlv = NULL;
+	struct inff_proxd_rtt_result_v2 *rtt_result = NULL;
+	struct inff_proxd_rtt_sample_v2 *rtt_sample = NULL;
+
+	/* FTM get result */
+	err = inff_ftm_get_op(ftm_info->ifp, INFF_PROXD_CMD_GET_RESULT,
+			      INFF_PROXD_SESSION_ID_DEFAULT_FTM,
+			      (u8 *)proxd_buf, sizeof(proxd_buf));
+	if (err) {
+		inff_dbg(TRACE, "FTM: get rtt result fail!\n");
+		goto fail_result;
+	}
+
+	proxd_iov = (struct inff_proxd_iov *)proxd_buf;
+	proxd_tlv = (struct inff_xtlv *)(proxd_buf + offsetof(struct inff_proxd_iov, tlvs));
+	if ((proxd_iov->len <
+		sizeof(struct inff_proxd_iov) + sizeof(struct inff_xtlv) +
+		sizeof(struct inff_proxd_rtt_result_v2) - 2) ||
+		proxd_tlv->id != INFF_PROXD_TLV_ID_RTT_RESULT_V2) {
+		inff_dbg(TRACE, "FTM: wrong len/id in rtt result!\n");
+		goto fail_result;
+	}
+	rtt_result = (struct inff_proxd_rtt_result_v2 *)(proxd_buf +
+		      offsetof(struct inff_proxd_iov, tlvs) +
+		      offsetof(struct inff_xtlv, data));
+	rtt_sample = rtt_result->rtt;
+	inff_print_rtt_info(rtt_result, rtt_sample);
+
+	/* update result to upper layer
+	 * please refer the unit of cfg80211_pmsr_result from include/uapi/linux/nl80211.h
+	 */
+	result.host_time = ftm_info->host_time;
+	result.status = inff_ftm_get_pmsr_result_status(rtt_result->status);
+	if (rtt_result)
+		memcpy(result.addr, rtt_result->peer, ETH_ALEN);
+	result.final = 1;
+	result.ap_tsf_valid = 0;
+	result.type = NL80211_PMSR_TYPE_FTM;
+	result.ftm.burst_index = -1;
+	result.ftm.num_bursts_exp = ilog2(rtt_result->burst_num);
+	result.ftm.burst_duration = ftm_info->ftm_req->peers[0].ftm.burst_duration;
+	result.ftm.ftms_per_burst = rtt_result->num_ftm;
+	result.ftm.rssi_avg = (2 * rtt_sample->rssi); // unit: 1/2dBm
+	result.ftm.rtt_avg = intvl_to_picosecond(rtt_sample->rtt); // unit: picosecond
+	result.ftm.rtt_variance = (rtt_result->sd_rtt * rtt_result->sd_rtt);
+	result.ftm.dist_avg = ((rtt_result->avg_dist * 1000) / 256); // unit: mm
+	result.ftm.rssi_avg_valid = 1;
+	result.ftm.rtt_avg_valid = 1;
+	result.ftm.rtt_variance_valid = 1;
+	result.ftm.dist_avg_valid = 1;
+	cfg80211_pmsr_report(&ftm_info->vif->wdev, ftm_info->ftm_req, &result, GFP_KERNEL);
+
+	return;
+
+fail_result:
+	result.status = NL80211_PMSR_STATUS_FAILURE;
+	if (rtt_result)
+		memcpy(result.addr, rtt_result->peer, ETH_ALEN);
+	cfg80211_pmsr_report(&ftm_info->vif->wdev, ftm_info->ftm_req, &result, GFP_KERNEL);
+}
+
+s32
+inff_notify_ftm_evt(struct inff_if *ifp,
+		    const struct inff_event_msg *e, void *data)
+{
+	struct inff_cfg80211_info *cfg = ifp->drvr->config;
+	struct inff_ftm_info *ftm_info = cfg->pmsr_info->ftm_info;
+	struct inff_proxd_event *p_event;
+	u16 event_type;
+	struct inff_xtlv *proxd_tlv = NULL;
+	struct inff_proxd_ftm_session_status *proxd_status = NULL;
+	s32 err = 0;
+
+	p_event = (struct inff_proxd_event *)data;
+	event_type = p_event->type;
+	inff_dbg(INFO, "FTM: event %s (%d), status=%d, proxd_type=%d\n",
+		 inff_fweh_event_name(e->event_code), e->event_code,
+		 e->status, event_type);
+
+	/* Currently do not handle event for softap mode */
+	if (cfg->num_softap || !(ftm_info->ftm_req) ||
+	    !inff_feat_is_enabled(ifp, INFF_FEAT_FTM)) {
+		inff_dbg(TRACE, "FTM: condition check fail!");
+		return 0;
+	}
+
+	/* check session status tlv */
+	proxd_tlv = (struct inff_xtlv *)((u8 *)p_event + offsetof(struct inff_proxd_iov, tlvs));
+	if (proxd_tlv->id == INFF_PROXD_TLV_ID_SESSION_STATUS) {
+		proxd_status = (struct inff_proxd_ftm_session_status *)proxd_tlv->data;
+		inff_dbg(TRACE, "FTM: session status tlv\n"
+			"sid               : %d\n"
+			"state             : %d\n"
+			"status            : %d\n"
+			"burst_num         : %d\n",
+			proxd_status->sid, proxd_status->state, proxd_status->status,
+			proxd_status->burst_num);
+	}
+
+	switch (event_type) {
+	case INFF_PROXD_EVENT_SESSION_CREATE:
+		/* FTM session start */
+		err = inff_ftm_set_op(ifp, INFF_PROXD_CMD_START_SESSION,
+				      INFF_PROXD_SESSION_ID_DEFAULT_FTM);
+		if (err) {
+			inff_err("FTM: start session fail!\n");
+			ftm_info->ftm_req = NULL;
+			ftm_info->host_time = 0;
+		}
+		break;
+	case INFF_PROXD_EVENT_SESSION_START:
+		/* update host_time for non partial report mode*/
+		if (!ftm_info->ftm_partial_report)
+			ftm_info->host_time = (u64)ktime_to_ns(ktime_get_boottime());
+		break;
+	case INFF_PROXD_EVENT_BURST_START:
+		/* update host_time for partial report mode*/
+		if (ftm_info->ftm_partial_report)
+			ftm_info->host_time = (u64)ktime_to_ns(ktime_get_boottime());
+		break;
+	case INFF_PROXD_EVENT_BURST_END:
+		if (ftm_info->ftm_partial_report)
+			inff_ftm_update_burst_report(ftm_info, p_event);
+		break;
+	case INFF_PROXD_EVENT_SESSION_END:
+		if (!ftm_info->ftm_partial_report)
+			inff_ftm_update_final_report(ftm_info, p_event);
+
+		/* FTM session delete */
+		err = inff_ftm_set_op(ifp, INFF_PROXD_CMD_DELETE_SESSION,
+				      INFF_PROXD_SESSION_ID_DEFAULT_FTM);
+		if (err)
+			inff_err("FTM: delete session fail!\n");
+
+		break;
+	case INFF_PROXD_EVENT_SESSION_DESTROY:
+		cfg80211_pmsr_complete(&ifp->vif->wdev, ftm_info->ftm_req, GFP_KERNEL);
+		ftm_info->ftm_req = NULL;
+		ftm_info->host_time = 0;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+s32
+inff_ftm_set_global_config(struct inff_ftm_info *ftm_info,
+			   struct cfg80211_pmsr_request_peer *peer)
+{
+	u8 buf[512] = {0}, *bufp = NULL;
+	u16 buf_len = 0, buf_len_start = 0;
+	u32 param32 = 0;
+
+	buf_len_start = sizeof(buf);
+	buf_len = sizeof(buf);
+	bufp = &buf[0];
+
+	/* ex: proxd ftm config options +mburst-followup */
+	param32 = cpu_to_le32(INFF_PROXD_FLAG_MBURST_FOLLOWUP);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_FLAGS_MASK, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+	param32 = cpu_to_le32(peer->ftm.num_bursts_exp > 0 ?
+			      INFF_PROXD_FLAG_MBURST_FOLLOWUP : 0x00);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_FLAGS, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+
+	buf_len = buf_len_start - buf_len;
+	return inff_ftm_set_config_op(ftm_info->ifp, INFF_PROXD_SESSION_ID_GLOBAL, buf, buf_len);
+}
+
+s32
+inff_ftm_set_session_config(struct inff_ftm_info *ftm_info,
+			    struct cfg80211_pmsr_request_peer *peer,
+			    enum inff_proxd_session_id session_id)
+{
+	u8 buf[512] = {0}, *bufp = NULL;
+	u16 buf_len = 0, buf_len_start = 0;
+	u16 param16 = 0;
+	u32 param32 = 0;
+	struct inff_proxd_intvl param_intvl = {0};
+	u8 burst_no_pref = 0;
+
+	buf_len_start = sizeof(buf);
+	buf_len = sizeof(buf);
+	bufp = &buf[0];
+
+	/* ex: proxd ftm $SID config debug-mask 0xffffffde */
+	param32 = cpu_to_le32(ftm_info->ftm_debug_mask);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_DEBUG_MASK, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config burst-duration 128ms */
+	param_intvl.intvl = cpu_to_le32(0);
+	param_intvl.tmu = cpu_to_le16(INFF_PROXD_TMU_TU);
+	switch (peer->ftm.burst_duration) {
+	case 2:
+	case 3:
+		param_intvl.intvl = cpu_to_le32(250 * (peer->ftm.burst_duration - 1));
+		param_intvl.tmu = cpu_to_le16(INFF_PROXD_TMU_MICRO_SEC);
+		break;
+	case 4:
+	case 5:
+	case 6:
+	case 7:
+	case 8:
+	case 9:
+	case 10:
+	case 11:
+		param_intvl.intvl = cpu_to_le32(1 << (peer->ftm.burst_duration - 4));
+		param_intvl.tmu = cpu_to_le16(INFF_PROXD_TMU_MILLI_SEC);
+		break;
+	default:
+		burst_no_pref = 1;
+		break;
+	}
+	if (!burst_no_pref)
+		inff_pack_xtlv(INFF_PROXD_TLV_ID_BURST_DURATION, (u8 *)&param_intvl,
+			       sizeof(param_intvl), (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config options .....
+	 * must set: +initiator -rtt-detail +rx-auto-burst +pre-scan -immediate
+	 * set by user: +asap +tx-lci-req +tx-civic-req
+	 */
+	param32 = cpu_to_le32(INFF_PROXD_SESSION_FLAG_INITIATOR |
+			      INFF_PROXD_SESSION_FLAG_RTT_DETAIL |
+			      INFF_PROXD_SESSION_FLAG_RX_AUTO_BURST |
+			      INFF_PROXD_SESSION_FLAG_ASAP |
+			      INFF_PROXD_SESSION_FLAG_REQ_LCI |
+			      INFF_PROXD_SESSION_FLAG_REQ_CIV |
+			      INFF_PROXD_SESSION_FLAG_PRE_SCAN |
+			      INFF_PROXD_SESSION_FLAG_BDUR_NOPREF |
+			      INFF_PROXD_SESSION_FLAG_MBURST_NODELAY);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_SESSION_FLAGS_MASK, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+	param32 = cpu_to_le32(INFF_PROXD_SESSION_FLAG_INITIATOR |
+			      INFF_PROXD_SESSION_FLAG_RX_AUTO_BURST |
+			      (peer->ftm.asap ? INFF_PROXD_SESSION_FLAG_ASAP : 0x00) |
+			      (peer->ftm.request_lci ? INFF_PROXD_SESSION_FLAG_REQ_LCI : 0x00) |
+			      (peer->ftm.request_civicloc ?
+			      INFF_PROXD_SESSION_FLAG_REQ_CIV : 0x00) |
+			      (burst_no_pref ? INFF_PROXD_SESSION_FLAG_BDUR_NOPREF : 0x00) |
+			      INFF_PROXD_SESSION_FLAG_PRE_SCAN);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_SESSION_FLAGS, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config peer $PEER_MAC */
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_PEER_MAC, &peer->addr[0], ETH_ALEN,
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config chanspec 36/20 */
+	param32 = cpu_to_le32(chandef_to_chanspec(&ftm_info->cfg80211_info->d11inf,
+						  &peer->chandef));
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_CHANSPEC, (u8 *)&param32, sizeof(u32),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config num-burst 1 */
+	param16 = cpu_to_le16(1 << peer->ftm.num_bursts_exp);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_NUM_BURST, (u8 *)&param16, sizeof(u16),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config num-ftm 6 */
+	param16 = cpu_to_le16(peer->ftm.ftms_per_burst);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_BURST_NUM_FTM, (u8 *)&param16, sizeof(u16),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config burst-period 5000ms */
+	param_intvl.intvl = cpu_to_le32(peer->ftm.burst_period * 100);
+	param_intvl.tmu = cpu_to_le16(INFF_PROXD_TMU_MILLI_SEC);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_BURST_PERIOD, (u8 *)&param_intvl, sizeof(param_intvl),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config req-retries 3 */
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_FTM_REQ_RETRIES, (u8 *)&peer->ftm.ftmr_retries, sizeof(u8),
+		       (char **)&bufp, &buf_len);
+
+	/* ex: proxd ftm $SID config ftm-sep 3ms */
+	param_intvl.intvl = cpu_to_le32(INFF_PROXD_TLV_FTM_SEP_VAL);
+	param_intvl.tmu = cpu_to_le16(INFF_PROXD_TMU_MILLI_SEC);
+	inff_pack_xtlv(INFF_PROXD_TLV_ID_BURST_FTM_SEP, (u8 *)&param_intvl, sizeof(param_intvl),
+		       (char **)&bufp, &buf_len);
+
+	buf_len = buf_len_start - buf_len;
+	return inff_ftm_set_config_op(ftm_info->ifp, session_id, buf, buf_len);
+}
+
+s32 inff_ftm_attach(struct inff_cfg80211_info *cfg)
+{
+	struct net_device *ndev = cfg_to_ndev(cfg);
+	struct inff_if *ifp = netdev_priv(ndev);
+	struct inff_ftm_info *ftm_info;
+	s32 err = 0;
+	u8 rrm_cap[RM_ENAB_CAP_SIZE] = { 0 };
+
+	ftm_info = kzalloc(sizeof(*ftm_info), GFP_KERNEL);
+	if (!ftm_info)
+		return -ENOMEM;
+
+	ftm_info->cfg80211_info = cfg;
+	ftm_info->vif = ifp->vif;
+	ftm_info->ifp = ifp;
+	ftm_info->ftm_req = NULL;
+	ftm_info->ftm_debug_mask = 0xFFFFFFDE;
+	ftm_info->ftm_partial_report = 1;
+	ftm_info->host_time = 0;
+	cfg->pmsr_info->ftm_info = ftm_info;
+
+	/* FTM enable */
+	err = inff_ftm_set_op(ifp, INFF_PROXD_CMD_ENABLE, INFF_PROXD_SESSION_ID_GLOBAL);
+	if (err) {
+		inff_err("FTM: enable fail!\n");
+		/* disable feature */
+		ifp->drvr->feat_flags[INFF_FEAT_FTM / 8] &= ~BIT(INFF_FEAT_FTM % 8);
+		return err;
+	}
+
+	/* set rrm capabilities */
+	err = inff_fil_iovar_data_get(ifp, "rrm", rrm_cap, sizeof(rrm_cap));
+	if (err) {
+		inff_err("get rrm error: %d\n", err);
+	} else {
+		rrm_cap[4] |= IEEE80211_RM_ENAB_CAP4_FTM_RANGE_REPORT;
+		rrm_cap[4] |= IEEE80211_RM_ENAB_CAP4_CIVIC_LOCATION_MSR;
+
+		err = inff_fil_iovar_data_set(ifp, "rrm", rrm_cap, sizeof(rrm_cap));
+		if (err)
+			inff_err("set rrm error: %d\n", err);
+	}
+
+	return err;
+}
+
+void inff_ftm_detach(struct inff_cfg80211_info *cfg)
+{
+	struct inff_ftm_info *ftm_info = cfg->pmsr_info->ftm_info;
+
+	if (!ftm_info || !ftm_info->vif)
+		return;
+
+	kfree(ftm_info);
+	cfg->pmsr_info->ftm_info = NULL;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/ftm.h b/drivers/net/wireless/infineon/inffmac/ftm.h
new file mode 100644
index 000000000000..3d7ca9ff401a
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/ftm.h
@@ -0,0 +1,382 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_FTM_H
+#define INFF_FTM_H
+
+#include "xtlv.h"
+
+#define RM_ENAB_CAP_SIZE	5
+
+/** tlv IDs - data length 4 bytes unless overridden by type, alignment 32 bits */
+enum inff_proxd_tlv_id {
+	INFF_PROXD_TLV_ID_NONE              = 0,
+	INFF_PROXD_TLV_ID_METHOD            = 1,
+	INFF_PROXD_TLV_ID_FLAGS             = 2,
+	INFF_PROXD_TLV_ID_CHANSPEC          = 3, /* note: uint32 */
+	INFF_PROXD_TLV_ID_TX_POWER          = 4,
+	INFF_PROXD_TLV_ID_RATESPEC          = 5,
+	INFF_PROXD_TLV_ID_BURST_DURATION    = 6, /* intvl - length of burst */
+	INFF_PROXD_TLV_ID_BURST_PERIOD      = 7, /* intvl - between bursts */
+	INFF_PROXD_TLV_ID_BURST_FTM_SEP     = 8, /* intvl - between FTMs */
+	INFF_PROXD_TLV_ID_BURST_NUM_FTM     = 9, /* uint16 - per burst */
+	INFF_PROXD_TLV_ID_NUM_BURST         = 10, /* uint16 */
+	INFF_PROXD_TLV_ID_FTM_RETRIES       = 11, /* uint16 at FTM level */
+	INFF_PROXD_TLV_ID_BSS_INDEX         = 12, /* uint8 */
+	INFF_PROXD_TLV_ID_BSSID             = 13,
+	INFF_PROXD_TLV_ID_INIT_DELAY        = 14, /* intvl - optional,non-standalone only */
+	INFF_PROXD_TLV_ID_BURST_TIMEOUT     = 15, /* expect response within - intvl */
+	INFF_PROXD_TLV_ID_EVENT_MASK        = 16, /* interested events - in/out */
+	INFF_PROXD_TLV_ID_FLAGS_MASK        = 17, /* interested flags - in only */
+	INFF_PROXD_TLV_ID_PEER_MAC          = 18, /* mac address of peer */
+	INFF_PROXD_TLV_ID_FTM_REQ           = 19, /* dot11_ftm_req */
+	INFF_PROXD_TLV_ID_LCI_REQ           = 20,
+	INFF_PROXD_TLV_ID_LCI               = 21,
+	INFF_PROXD_TLV_ID_CIVIC_REQ         = 22,
+	INFF_PROXD_TLV_ID_CIVIC             = 23,
+	INFF_PROXD_TLV_ID_AVAIL24           = 24, /* ROM compatibility */
+	INFF_PROXD_TLV_ID_SESSION_FLAGS     = 25,
+	INFF_PROXD_TLV_ID_SESSION_FLAGS_MASK = 26, /* in only */
+	INFF_PROXD_TLV_ID_RX_MAX_BURST      = 27, /* uint16 - limit bursts per session */
+	INFF_PROXD_TLV_ID_RANGING_INFO      = 28, /* ranging info */
+	INFF_PROXD_TLV_ID_RANGING_FLAGS     = 29, /* uint16 */
+	INFF_PROXD_TLV_ID_RANGING_FLAGS_MASK = 30, /* uint16, in only */
+	INFF_PROXD_TLV_ID_NAN_MAP_ID        = 31,
+	INFF_PROXD_TLV_ID_DEV_ADDR          = 32,
+	INFF_PROXD_TLV_ID_AVAIL             = 33, /* wl_proxd_avail_t  */
+	INFF_PROXD_TLV_ID_TLV_ID            = 34, /* uint16 tlv-id */
+	INFF_PROXD_TLV_ID_FTM_REQ_RETRIES   = 35, /* uint16 FTM request retries */
+	INFF_PROXD_TLV_ID_TPK               = 36, /* 32byte TPK  */
+	INFF_PROXD_TLV_ID_RI_RR             = 36, /* RI_RR */
+	INFF_PROXD_TLV_ID_TUNE              = 37, /* wl_proxd_pararms_tof_tune_t */
+	INFF_PROXD_TLV_ID_CUR_ETHER_ADDR    = 38, /* Source Address used for Tx */
+
+	/* output - 512 + x */
+	INFF_PROXD_TLV_ID_STATUS            = 512,
+	INFF_PROXD_TLV_ID_COUNTERS          = 513,
+	INFF_PROXD_TLV_ID_INFO              = 514,
+	INFF_PROXD_TLV_ID_RTT_RESULT        = 515,
+	INFF_PROXD_TLV_ID_AOA_RESULT        = 516,
+	INFF_PROXD_TLV_ID_SESSION_INFO      = 517,
+	INFF_PROXD_TLV_ID_SESSION_STATUS    = 518,
+	INFF_PROXD_TLV_ID_SESSION_ID_LIST   = 519,
+	INFF_PROXD_TLV_ID_RTT_RESULT_V2     = 520,
+
+	/* debug tlvs can be added starting 1024 */
+	INFF_PROXD_TLV_ID_DEBUG_MASK        = 1024,
+	INFF_PROXD_TLV_ID_COLLECT           = 1025,	/**< output only */
+	INFF_PROXD_TLV_ID_STRBUF            = 1026,
+
+	INFF_PROXD_TLV_ID_COLLECT_HEADER    = 1025,	/* wl_proxd_collect_header_t */
+	INFF_PROXD_TLV_ID_COLLECT_INFO      = 1028,	/* wl_proxd_collect_info_t */
+	INFF_PROXD_TLV_ID_COLLECT_DATA      = 1029,	/* wl_proxd_collect_data_t */
+	INFF_PROXD_TLV_ID_COLLECT_CHAN_DATA = 1030,	/* wl_proxd_collect_data_t */
+	INFF_PROXD_TLV_ID_MF_STATS_DATA     = 1031,	/* mf_stats_buffer */
+
+	INFF_PROXD_TLV_ID_MAX
+};
+
+/** commands that can apply to proxd, method or a session */
+enum inff_proxd_cmd {
+	INFF_PROXD_CMD_NONE                 = 0,
+	INFF_PROXD_CMD_GET_VERSION          = 1,
+	INFF_PROXD_CMD_ENABLE               = 2,
+	INFF_PROXD_CMD_DISABLE              = 3,
+	INFF_PROXD_CMD_CONFIG               = 4,
+	INFF_PROXD_CMD_START_SESSION        = 5,
+	INFF_PROXD_CMD_BURST_REQUEST        = 6,
+	INFF_PROXD_CMD_STOP_SESSION         = 7,
+	INFF_PROXD_CMD_DELETE_SESSION       = 8,
+	INFF_PROXD_CMD_GET_RESULT           = 9,
+	INFF_PROXD_CMD_GET_INFO             = 10,
+	INFF_PROXD_CMD_GET_STATUS           = 11,
+	INFF_PROXD_CMD_GET_SESSIONS         = 12,
+	INFF_PROXD_CMD_GET_COUNTERS         = 13,
+	INFF_PROXD_CMD_CLEAR_COUNTERS       = 14,
+	INFF_PROXD_CMD_COLLECT              = 15, /* not supported, see 'wl proxd_collect' */
+	INFF_PROXD_CMD_TUNE                 = 16, /* not supported, see 'wl proxd_tune' */
+	INFF_PROXD_CMD_DUMP                 = 17,
+	INFF_PROXD_CMD_START_RANGING        = 18,
+	INFF_PROXD_CMD_STOP_RANGING         = 19,
+	INFF_PROXD_CMD_GET_RANGING_INFO     = 20,
+	INFF_PROXD_CMD_IS_TLV_SUPPORTED     = 21,
+
+	INFF_PROXD_CMD_MAX
+};
+
+/** proximity detection methods */
+enum inff_proxd_method {
+	INFF_PROXD_METHOD_NONE              = 0,
+	INFF_PROXD_METHOD_RSVD1             = 1, /* backward compatibility - RSSI, not supported */
+	INFF_PROXD_METHOD_TOF               = 2,
+	INFF_PROXD_METHOD_RSVD2             = 3, /* 11v only - if needed */
+	INFF_PROXD_METHOD_FTM               = 4, /* IEEE rev mc/2014 */
+	INFF_PROXD_METHOD_MAX
+};
+
+/** global and method configuration flags */
+enum inff_proxd_global_flag {
+	INFF_PROXD_FLAG_NONE                        = 0x00000000,
+	INFF_PROXD_FLAG_RX_ENABLED                  = 0x00000001, /* respond to requests, per bss */
+	INFF_PROXD_FLAG_RX_RANGE_REQ                = 0x00000002, /* 11mc range requests enabled */
+	INFF_PROXD_FLAG_TX_LCI                      = 0x00000004, /* tx lci, if known */
+	INFF_PROXD_FLAG_TX_CIVIC                    = 0x00000008, /* tx civic, if known */
+	INFF_PROXD_FLAG_RX_AUTO_BURST               = 0x00000010, /* auto respond w/o host action */
+	INFF_PROXD_FLAG_TX_AUTO_BURST               = 0x00000020, /* continue tx w/o host action */
+	INFF_PROXD_FLAG_AVAIL_PUBLISH               = 0x00000040, /* publish availability */
+	INFF_PROXD_FLAG_AVAIL_SCHEDULE              = 0x00000080, /* schedule using availability */
+	INFF_PROXD_FLAG_ASAP_CAPABLE                = 0x00000100, /* ASAP capable */
+	INFF_PROXD_FLAG_MBURST_FOLLOWUP             = 0x00000200, /* new multi-burst algorithm */
+	INFF_PROXD_FLAG_SECURE                      = 0x00000400, /* per bsscfg option */
+	INFF_PROXD_FLAG_NO_TSF_SYNC                 = 0x00000800, /* disable tsf sync */
+	INFF_PROXD_FLAG_ALL                         = 0xffffffff
+};
+
+/* session ids:
+ * id 0 is reserved
+ * ids 1..0x7fff - allocated by host/app
+ * 0x8000-0xffff - allocated by firmware, used for auto/rx
+ */
+/* typedef u16 wl_proxd_session_id_t; */
+enum inff_proxd_session_id {
+	INFF_PROXD_SESSION_ID_GLOBAL        = 0,
+	INFF_PROXD_SESSION_ID_DEFAULT_FTM   = 1
+};
+
+/** session flags */
+enum inff_proxd_session_flag {
+	INFF_PROXD_SESSION_FLAG_NONE                = 0x00000000, /* no flags */
+	INFF_PROXD_SESSION_FLAG_INITIATOR           = 0x00000001, /* local device is initiator */
+	INFF_PROXD_SESSION_FLAG_TARGET              = 0x00000002, /* local device is target */
+	INFF_PROXD_SESSION_FLAG_ONE_WAY             = 0x00000004, /* (initiated) 1-way rtt */
+	INFF_PROXD_SESSION_FLAG_AUTO_BURST          = 0x00000008, /* created w/ rx_auto_burst */
+	INFF_PROXD_SESSION_FLAG_PERSIST             = 0x00000010, /* good until cancelled */
+	INFF_PROXD_SESSION_FLAG_RTT_DETAIL          = 0x00000020, /* rtt detail in results */
+	INFF_PROXD_SESSION_FLAG_SECURE              = 0x00000040, /* sessionis secure */
+	INFF_PROXD_SESSION_FLAG_AOA                 = 0x00000080, /* AOA along w/ RTT */
+	INFF_PROXD_SESSION_FLAG_RX_AUTO_BURST       = 0x00000100, /* Same as proxd flags above */
+	INFF_PROXD_SESSION_FLAG_TX_AUTO_BURST       = 0x00000200, /* Same as proxd flags above */
+	INFF_PROXD_SESSION_FLAG_NAN_BSS             = 0x00000400, /* Use NAN BSS, if applicable */
+	INFF_PROXD_SESSION_FLAG_TS1                 = 0x00000800, /* e.g. FTM1 - ASAP-capable */
+	INFF_PROXD_SESSION_FLAG_REPORT_FAILURE      = 0x00002000, /* report failure to target */
+	INFF_PROXD_SESSION_FLAG_INITIATOR_RPT       = 0x00004000, /* report distance to target */
+	INFF_PROXD_SESSION_FLAG_NOCHANSWT           = 0x00008000,
+	INFF_PROXD_SESSION_FLAG_NETRUAL             = 0x00010000, /* netrual mode */
+	INFF_PROXD_SESSION_FLAG_SEQ_EN              = 0x00020000, /* Toast */
+	INFF_PROXD_SESSION_FLAG_NO_PARAM_OVRD       = 0x00040000, /* no param override */
+	INFF_PROXD_SESSION_FLAG_ASAP                = 0x00080000, /* ASAP session */
+	INFF_PROXD_SESSION_FLAG_REQ_LCI             = 0x00100000, /* transmit LCI req */
+	INFF_PROXD_SESSION_FLAG_REQ_CIV             = 0x00200000, /* transmit civic loc req */
+	INFF_PROXD_SESSION_FLAG_PRE_SCAN            = 0x00400000, /* enable pre-scan for asap=1 */
+	INFF_PROXD_SESSION_FLAG_AUTO_VHTACK         = 0x00800000, /* use vhtack based on ie */
+	INFF_PROXD_SESSION_FLAG_VHTACK              = 0x01000000, /* vht ack is in use */
+	INFF_PROXD_SESSION_FLAG_BDUR_NOPREF         = 0x02000000, /* burst-duration: no pref */
+	INFF_PROXD_SESSION_FLAG_NUM_FTM_NOPREF      = 0x04000000, /* num of FTM frames: no pref */
+	INFF_PROXD_SESSION_FLAG_FTM_SEP_NOPREF      = 0x08000000, /* time btw FTM frams: no pref */
+	INFF_PROXD_SESSION_FLAG_NUM_BURST_NOPREF    = 0x10000000, /* num of bursts: no pref */
+	INFF_PROXD_SESSION_FLAG_BURST_PERIOD_NOPREF = 0x20000000, /* burst period: no pref */
+	INFF_PROXD_SESSION_FLAG_MBURST_FOLLOWUP     = 0x40000000, /* new mburst algo  - reserved */
+	INFF_PROXD_SESSION_FLAG_MBURST_NODELAY      = 0x80000000, /* good until cancelled */
+	INFF_PROXD_SESSION_FLAG_ALL                 = 0xffffffff
+};
+
+/** time units - mc supports up to 0.1ns resolution */
+enum inff_proxd_tmu {
+	INFF_PROXD_TMU_TU           = 0,	/* 1024us */
+	INFF_PROXD_TMU_SEC          = 1,
+	INFF_PROXD_TMU_MILLI_SEC    = 2,
+	INFF_PROXD_TMU_MICRO_SEC    = 3,
+	INFF_PROXD_TMU_NANO_SEC     = 4,
+	INFF_PROXD_TMU_PICO_SEC     = 5
+};
+
+/** result flags */
+enum inff_proxd_result {
+	INFF_PRXOD_RESULT_FLAG_NONE     = 0x0000,
+	INFF_PROXD_RESULT_FLAG_NLOS     = 0x0001, /* LOS - if available */
+	INFF_PROXD_RESULT_FLAG_LOS      = 0x0002, /* NLOS - if available */
+	INFF_PROXD_RESULT_FLAG_FATAL    = 0x0004, /* Fatal error during burst */
+	INFF_PROXD_RESULT_FLAG_VHTACK   = 0x0008, /* VHTACK or Legacy ACK used */
+	INFF_PROXD_REQUEST_SENT         = 0x0010, /* FTM request was sent */
+	INFF_PROXD_REQUEST_ACKED        = 0x0020, /* FTM request was acked */
+	INFF_PROXD_LTFSEQ_STARTED       = 0x0040, /* LTF sequence started */
+	INFF_PROXD_RESULT_FLAG_ALL      = 0xffff
+};
+
+/** status */
+enum inff_proxd_status {
+	INFF_PROXD_E_LAST               = -1056,
+	INFF_PROXD_E_NOAVAIL            = -1056,
+	INFF_PROXD_E_EXT_SCHED          = -1055,
+	INFF_PROXD_E_NOT_INF            = -1054,
+	INFF_PROXD_E_FRAME_TYPE         = -1053,
+	INFF_PROXD_E_VERNOSUPPORT       = -1052,
+	INFF_PROXD_E_SEC_NOKEY          = -1051,
+	INFF_PROXD_E_SEC_POLICY         = -1050,
+	INFF_PROXD_E_SCAN_INPROCESS     = -1049,
+	INFF_PROXD_E_BAD_PARTIAL_TSF    = -1048,
+	INFF_PROXD_E_SCANFAIL           = -1047,
+	INFF_PROXD_E_NOTSF              = -1046,
+	INFF_PROXD_E_POLICY             = -1045,
+	INFF_PROXD_E_INCOMPLETE         = -1044,
+	INFF_PROXD_E_OVERRIDDEN         = -1043,
+	INFF_PROXD_E_ASAP_FAILED        = -1042,
+	INFF_PROXD_E_NOTSTARTED         = -1041,
+	INFF_PROXD_E_INVALIDMEAS        = -1040,
+	INFF_PROXD_E_INCAPABLE          = -1039,
+	INFF_PROXD_E_MISMATCH           = -1038,
+	INFF_PROXD_E_DUP_SESSION        = -1037,
+	INFF_PROXD_E_REMOTE_FAIL        = -1036,
+	INFF_PROXD_E_REMOTE_INCAPABLE   = -1035,
+	INFF_PROXD_E_SCHED_FAIL         = -1034,
+	INFF_PROXD_E_PROTO              = -1033,
+	INFF_PROXD_E_EXPIRED            = -1032,
+	INFF_PROXD_E_TIMEOUT            = -1031,
+	INFF_PROXD_E_NOACK              = -1030,
+	INFF_PROXD_E_DEFERRED           = -1029,
+	INFF_PROXD_E_INVALID_SID        = -1028,
+	INFF_PROXD_E_REMOTE_CANCEL      = -1027,
+	INFF_PROXD_E_CANCELED           = -1026, /* local */
+	INFF_PROXD_E_INVALID_SESSION    = -1025,
+	INFF_PROXD_E_BAD_STATE          = -1024,
+	INFF_PROXD_E_START              = -1024,
+	INFF_PROXD_E_ERROR              = -1,
+	INFF_PROXD_E_OK                 = 0
+};
+
+/* typedef u16 wl_proxd_event_type_t; */
+enum inff_proxd_event_type {
+	INFF_PROXD_EVENT_NONE                   = 0, /* not an event, reserved */
+	INFF_PROXD_EVENT_SESSION_CREATE         = 1,
+	INFF_PROXD_EVENT_SESSION_START          = 2,
+	INFF_PROXD_EVENT_FTM_REQ                = 3,
+	INFF_PROXD_EVENT_BURST_START            = 4,
+	INFF_PROXD_EVENT_BURST_END              = 5,
+	INFF_PROXD_EVENT_SESSION_END            = 6,
+	INFF_PROXD_EVENT_SESSION_RESTART        = 7,
+	INFF_PROXD_EVENT_BURST_RESCHED          = 8, /* burst rescheduled-e.g. partial TSF */
+	INFF_PROXD_EVENT_SESSION_DESTROY        = 9,
+	INFF_PROXD_EVENT_RANGE_REQ              = 10,
+	INFF_PROXD_EVENT_FTM_FRAME              = 11,
+	INFF_PROXD_EVENT_DELAY                  = 12,
+	INFF_PROXD_EVENT_VS_INITIATOR_RPT       = 13, /* (target) rx initiator-report */
+	INFF_PROXD_EVENT_RANGING                = 14,
+	INFF_PROXD_EVENT_LCI_MEAS_REP           = 15, /* LCI measurement report */
+	INFF_PROXD_EVENT_CIVIC_MEAS_REP         = 16, /* civic measurement report */
+	INFF_PROXD_EVENT_COLLECT                = 17,
+	INFF_PROXD_EVENT_START_WAIT             = 18, /* waiting to start */
+	INFF_PROXD_EVENT_MF_STATS               = 19, /* mf stats event */
+	INFF_PROXD_EVENT_MAX
+};
+
+#define INFF_PROXD_API_VERSION 0x0300 /* version 3.0 */
+#define INFF_PROXD_RTT_RESULT_VERSION_2 2
+#define INFF_PROXD_RTT_SAMPLE_VERSION_2 2
+#define INFF_PROXD_TLV_FTM_SEP_VAL 3 /* 3ms */
+
+/** proxd iovar - applies to proxd, method or session */
+struct inff_proxd_iov {
+	u16                 version;
+	u16                 len;
+	u16                 cmd;
+	u16                 method;
+	u16                 sid;
+	u8                  PAD[2];
+	struct inff_xtlv    tlvs[]; /* variable */
+};
+
+/** time interval e.g. 10ns */
+struct inff_proxd_intvl {
+	u32                 intvl;
+	u16                 tmu;
+	u8                  pad[2];
+};
+
+struct inff_proxd_rtt_sample_v2 {
+	u16                     version;
+	u16                     length;
+	u8                      id; /*  id for the sample - non-zero */
+	u8                      flags;
+	s16                     rssi;
+	struct inff_proxd_intvl rtt; /* round trip time */
+	u32                     ratespec;
+	u16                     snr;
+	u16                     bitflips;
+	s32                     status;
+	s32                     distance;
+	u32                     tof_phy_error;
+	u32                     tof_tgt_phy_error; /* target phy error bit map */
+	u16                     tof_tgt_snr;
+	u16                     tof_tgt_bitflips;
+	u8                      coreid;
+	u8                      pad[3];
+	u32                     chanspec;
+};
+
+/** rtt measurement result */
+struct inff_proxd_rtt_result_v2 {
+	u16                             version;
+	u16                             length; /* up to rtt[] */
+	u16                             sid;
+	u16                             flags;
+	s32                             status;
+	u8                              peer[ETH_ALEN];
+	s16                             state; /* current state */
+	union {
+		struct inff_proxd_intvl     retry_after; /* hint for errors */
+		struct inff_proxd_intvl     burst_duration; /* burst duration */
+	} u;
+	u32                             avg_dist; /* 1/256m units */
+	u16                             sd_rtt; /* RTT standard deviation */
+	u8                              num_valid_rtt; /* valid rtt cnt */
+	u8                              num_ftm; /* actual num of ftm cnt (Configured) */
+	u16                             burst_num; /* in a session */
+	u16                             num_rtt; /* 0 if no detail */
+	u16                             num_meas; /* number of ftm frames seen OTA */
+	u8                              pad[2];
+	struct inff_proxd_rtt_sample_v2 rtt[1]; /* variable, first element is avg_rtt */
+};
+
+/** proxd event - applies to proxd, method or session */
+struct inff_proxd_event {
+	u16                 version;
+	u16                 len;
+	u16                 type;
+	u16                 method;
+	u16                 sid;
+	u8                  pad[2];
+	struct inff_xtlv    tlvs[1]; /* variable */
+};
+
+struct inff_proxd_ftm_session_status {
+	u16                 sid;
+	s16                 state;
+	s32                 status;
+	u16                 burst_num;
+	u16                 pad;
+};
+
+struct inff_ftm_info {
+	struct inff_cfg80211_info *cfg80211_info;
+	struct inff_cfg80211_vif *vif;
+	struct inff_if *ifp;
+	struct cfg80211_pmsr_request *ftm_req;
+	u32 ftm_debug_mask;
+	u8 ftm_partial_report; /* set to 1 if each burst report is need */
+	u64 host_time;
+};
+
+s32 inff_ftm_set_global_config(struct inff_ftm_info *ftm_info,
+			       struct cfg80211_pmsr_request_peer *peer);
+s32 inff_ftm_set_session_config(struct inff_ftm_info *ftm_info,
+				struct cfg80211_pmsr_request_peer *peer,
+				enum inff_proxd_session_id session_id);
+s32 inff_notify_ftm_evt(struct inff_if *ifp,
+			const struct inff_event_msg *e, void *data);
+s32 inff_ftm_attach(struct inff_cfg80211_info *cfg);
+void inff_ftm_detach(struct inff_cfg80211_info *cfg);
+
+#endif /* INFF_FTM_H */
-- 
2.25.1


