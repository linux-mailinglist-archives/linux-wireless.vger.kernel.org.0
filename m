Return-Path: <linux-wireless+bounces-19009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD14A3739C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050677A1DE5
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315B18DB08;
	Sun, 16 Feb 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GowyMdcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8249719ABC2
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699067; cv=none; b=r5jpaciByc9zIMDl9EkrZZq0F5LKf2lQVZsI6YJzIiWc8soATRYHHHMlZQ7DL5V/dhZ8JUutGkT0xGYZ3Lhd4ua0dq2f12n9E9ypjGvYwxfQ94d2PbBohGZKUL+pTRK5sjbeT5QozODqAopGzd5QqFsWjJARwUpOTHyc8eOBch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699067; c=relaxed/simple;
	bh=gBnLZNBslJr6W2iri6Qv8zLy4PqUNR249LYBhRKCSHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttLaCfJV2DXEmW8vK4utE7tqx2bGbwhWcY5ow0rBpZng92wOGjzwESVgxPQNqU63WTlh5xz6PGG4HyTVzAlKGzHgiT8J84FPF0CUVbtCd1c1rK6nDXxXejOPOTqyvVU2fLonCZ4snvDUb9iYs4xXhkPe5mVGlflVWqW4ZZkkWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GowyMdcW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699066; x=1771235066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gBnLZNBslJr6W2iri6Qv8zLy4PqUNR249LYBhRKCSHw=;
  b=GowyMdcWsLk+/gYCHwx8I0a7ocBtOaKu1Vq4lKCAsTtPxLhPJD3sDPPn
   WvWjnxHbrbttGFHP/uIhz9t5dAHAjV5dYvOfznrOLQa1bscuYBTOi3UsU
   BxwTUpHwwAeU+CFTSRCutJKSkjw3AHTy2WmMR//EaFpA99R1k92JM/NnI
   v9r7w0iLnX3uhz1Sp1bjgkpi0ZhDoBVbuF06J13b9YqXVylvXrKDXfM10
   E5bcR3uznSwlYyxEZetUqqYbpHDNDy9LGuzzf3yhvjTxQ/6firkUYOn3f
   4yF2TTznXgfHzqTcnsCmrMmFMKSFtUZ/KcviCBvVQqWarHj/Zekf3a/fI
   w==;
X-CSE-ConnectionGUID: G58m3WziQkCd88mLHaa6lQ==
X-CSE-MsgGUID: dhj2712mTr2jkYExXj25WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323436"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323436"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:25 -0800
X-CSE-ConnectionGUID: wH9rNF8rRYmf0gtxXhzlEg==
X-CSE-MsgGUID: k/5ZWAzcTd+nZeDO6VO0Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785310"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 39/42] wifi: iwlwifi: mld: add KUnit test file rx.c
Date: Sun, 16 Feb 2025 11:43:18 +0200
Message-Id: <20250216111649.7869ddecfeb3.I57d678a06b29be51d6f43d1651346b5ea256e41c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file implemets RX Kunit tests

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/tests/rx.c | 353 ++++++++++++++++++
 1 file changed, 353 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c
new file mode 100644
index 000000000000..20cb4e03ab41
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <kunit/test.h>
+#include "utils.h"
+#include "iwl-trans.h"
+#include "mld.h"
+#include "sta.h"
+
+static const struct is_dup_case {
+	const char *desc;
+	struct {
+		/* ieee80211_hdr fields */
+		__le16 fc;
+		__le16 seq;
+		u8 tid;
+		bool multicast;
+		/* iwl_rx_mpdu_desc fields */
+		bool is_amsdu;
+		u8 sub_frame_idx;
+	} rx_pkt;
+	struct {
+		__le16 last_seq;
+		u8 last_sub_frame_idx;
+		u8 tid;
+	} dup_data_state;
+	struct {
+		bool is_dup;
+		u32 rx_status_flag;
+	} result;
+} is_dup_cases[] = {
+	{
+		.desc = "Control frame",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_CTL),
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = 0,
+		}
+	},
+	{
+		.desc = "Null func frame",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_NULLFUNC),
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = 0,
+		}
+	},
+	{
+		.desc = "Multicast data",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA),
+			.multicast = true,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = 0,
+		}
+	},
+	{
+		.desc = "QoS null func frame",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_NULLFUNC),
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = 0,
+		}
+	},
+	{
+		.desc = "QoS data new sequence",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x101),
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "QoS data same sequence, no retry",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x100),
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "QoS data same sequence, has retry",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA |
+					    IEEE80211_FCTL_RETRY),
+			.seq = __cpu_to_le16(0x100),
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = true,
+			.rx_status_flag = 0,
+		},
+	},
+	{
+		.desc = "QoS data invalid tid",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x100),
+			.tid = IWL_MAX_TID_COUNT + 1,
+		},
+		.result = {
+			.is_dup = true,
+			.rx_status_flag = 0,
+		},
+	},
+	{
+		.desc = "non-QoS data, same sequence, same tid, no retry",
+		.rx_pkt = {
+			/* Driver will use tid = IWL_MAX_TID_COUNT */
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA),
+			.seq = __cpu_to_le16(0x100),
+		},
+		.dup_data_state = {
+			.tid = IWL_MAX_TID_COUNT,
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "non-QoS data, same sequence, same tid, has retry",
+		.rx_pkt = {
+			/* Driver will use tid = IWL_MAX_TID_COUNT */
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_FCTL_RETRY),
+			.seq = __cpu_to_le16(0x100),
+		},
+		.dup_data_state = {
+			.tid = IWL_MAX_TID_COUNT,
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = true,
+			.rx_status_flag = 0,
+		},
+	},
+	{
+		.desc = "non-QoS data, same sequence on different tid's",
+		.rx_pkt = {
+			/* Driver will use tid = IWL_MAX_TID_COUNT */
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA),
+			.seq = __cpu_to_le16(0x100),
+		},
+		.dup_data_state = {
+			.tid = 7,
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "A-MSDU new subframe, allow same PN",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x100),
+			.is_amsdu = true,
+			.sub_frame_idx = 1,
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_ALLOW_SAME_PN |
+					  RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "A-MSDU subframe with smaller idx, disallow same PN",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x100),
+			.is_amsdu = true,
+			.sub_frame_idx = 1,
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 2,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "A-MSDU same subframe, no retry, disallow same PN",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA),
+			.seq = __cpu_to_le16(0x100),
+			.is_amsdu = true,
+			.sub_frame_idx = 0,
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = false,
+			.rx_status_flag = RX_FLAG_DUP_VALIDATED,
+		},
+	},
+	{
+		.desc = "A-MSDU same subframe, has retry",
+		.rx_pkt = {
+			.fc = __cpu_to_le16(IEEE80211_FTYPE_DATA |
+					    IEEE80211_STYPE_QOS_DATA |
+					    IEEE80211_FCTL_RETRY),
+			.seq = __cpu_to_le16(0x100),
+			.is_amsdu = true,
+			.sub_frame_idx = 0,
+		},
+		.dup_data_state = {
+			.last_seq = __cpu_to_le16(0x100),
+			.last_sub_frame_idx = 0,
+		},
+		.result = {
+			.is_dup = true,
+			.rx_status_flag = 0,
+		},
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(test_is_dup, is_dup_cases, desc);
+
+static void
+setup_dup_data_state(struct ieee80211_sta *sta)
+{
+	struct kunit *test = kunit_get_current_test();
+	const struct is_dup_case *param = (const void *)(test->param_value);
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	u8 tid = param->dup_data_state.tid;
+	struct iwl_mld_rxq_dup_data *dup_data;
+
+	/* Allocate dup_data only for 1 queue */
+	KUNIT_ALLOC_AND_ASSERT(test, dup_data);
+
+	/* Initialize dup data, see iwl_mld_alloc_dup_data */
+	memset(dup_data->last_seq, 0xff, sizeof(dup_data->last_seq));
+
+	dup_data->last_seq[tid] = param->dup_data_state.last_seq;
+	dup_data->last_sub_frame_idx[tid] =
+		param->dup_data_state.last_sub_frame_idx;
+
+	mld_sta->dup_data = dup_data;
+}
+
+static void setup_rx_pkt(const struct is_dup_case *param,
+			 struct ieee80211_hdr *hdr,
+			 struct iwl_rx_mpdu_desc *mpdu_desc)
+{
+	u8 tid = param->rx_pkt.tid;
+
+	/* Set "new rx packet" header */
+	hdr->frame_control = param->rx_pkt.fc;
+	hdr->seq_ctrl = param->rx_pkt.seq;
+
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		u8 *qc = ieee80211_get_qos_ctl(hdr);
+
+		qc[0] = tid & IEEE80211_QOS_CTL_TID_MASK;
+	}
+
+	if (param->rx_pkt.multicast)
+		hdr->addr1[0] = 0x1;
+
+	/* Set mpdu_desc */
+	mpdu_desc->amsdu_info = param->rx_pkt.sub_frame_idx &
+				IWL_RX_MPDU_AMSDU_SUBFRAME_IDX_MASK;
+	if (param->rx_pkt.is_amsdu)
+		mpdu_desc->mac_flags2 |= IWL_RX_MPDU_MFLG2_AMSDU;
+}
+
+static void test_is_dup(struct kunit *test)
+{
+	const struct is_dup_case *param = (const void *)(test->param_value);
+	struct iwl_mld *mld = test->priv;
+	struct iwl_rx_mpdu_desc mpdu_desc = { };
+	struct ieee80211_rx_status rx_status = { };
+	struct ieee80211_vif *vif;
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr hdr;
+
+	vif = iwlmld_kunit_add_vif(false, NL80211_IFTYPE_STATION);
+	sta = iwlmld_kunit_setup_sta(vif, IEEE80211_STA_AUTHORIZED, -1);
+
+	/* Prepare test case state */
+	setup_dup_data_state(sta);
+	setup_rx_pkt(param, &hdr, &mpdu_desc);
+
+	KUNIT_EXPECT_EQ(test,
+			iwl_mld_is_dup(mld, sta, &hdr, &mpdu_desc, &rx_status,
+				       0), /* assuming only 1 queue */
+			param->result.is_dup);
+	KUNIT_EXPECT_EQ(test, rx_status.flag, param->result.rx_status_flag);
+}
+
+static struct kunit_case is_dup_test_cases[] = {
+	KUNIT_CASE_PARAM(test_is_dup, test_is_dup_gen_params),
+	{},
+};
+
+static struct kunit_suite is_dup = {
+	.name = "iwlmld-rx-is-dup",
+	.test_cases = is_dup_test_cases,
+	.init = iwlmld_kunit_test_init,
+};
+
+kunit_test_suite(is_dup);
-- 
2.34.1


