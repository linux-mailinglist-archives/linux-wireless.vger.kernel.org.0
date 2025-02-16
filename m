Return-Path: <linux-wireless+bounces-18974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36232A37378
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367C1188D521
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A6118C93C;
	Sun, 16 Feb 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYOSssr5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1518DB20
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699022; cv=none; b=aQ+xWRL2sJX3iOqwXTRYC7W+ryKObKepGAFxupW+YaGnYDCnalKc4TiIMLCPWnv6GZB4/S0cgejzjzyi6ZoUaIVZ3cBpFXfMSB9DP2onBjSJs/A66CeLjYJe8fyVy3u+NwI2zHo/EWj/yDyTIAFeb5HRa1c2M+xUjdRKuDOIJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699022; c=relaxed/simple;
	bh=cSpF8jX5UqAU64NKbnwCfylCz5vBDsXuA7ZIJvbuQxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5Qz+IssQLlExceUw53tWqZirbsTwKLJ9lHka/pH9/7yOrieAkYvHecs50hwaiHuMBSB7A2sGikQ7MyhV9UDvdo1UDEa5E4UUhvw7VGXkMWgPNp/bs0dXhuexm0XM5C1HgS+OCY6xGYtZstnfC66NrVyuSWxLlHYvbzb6xpbSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYOSssr5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699021; x=1771235021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cSpF8jX5UqAU64NKbnwCfylCz5vBDsXuA7ZIJvbuQxU=;
  b=AYOSssr5crlkO/fI6ROQMHdbK8KxaydnpXO6sPsFzWcEJHL4/NH+3UAn
   R6h9zaOdOkz420WOkn6fmPreBBAkz9Zdhi9xv1UAjNnFl8tG/s58IkNnn
   xAGK+Tzn3bwd6OspQdUikOzy+hYnse7d3XpirYAgNBCxgqcrkKb6Q00hl
   Ot40+pMlxfVpEhrAlav2EuXdRDV+RfFcoHvm2P3+fF45MYEEn8JC/31VT
   MhutisWXKzgJP1SAKJz5bVCYBrmBXHVbpGJ/p7r+HnH2SEI5kRSOTFxA+
   Bla7wk8C1SxV4XbidPrYYCDcD4yv7o1/qfedmGM6q9QwAVoiw9lAPMpGu
   g==;
X-CSE-ConnectionGUID: YVbz3uwXSb63alKWxbbirg==
X-CSE-MsgGUID: kkuy5QvrR3Cj0AhRFtowpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323352"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323352"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:41 -0800
X-CSE-ConnectionGUID: OI0s7eRcQ7Cj2NNYJOgNnA==
X-CSE-MsgGUID: qpDwDzTSQbWrtO0SBXV1Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785200"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/42] wifi: iwlwifi: mld: add file constants.h
Date: Sun, 16 Feb 2025 11:42:43 +0200
Message-Id: <20250216111648.8f2a46afed0b.Ieccb3d2753492fef3713e647adfc21d841725e37@changeid>
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

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/constants.h    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/constants.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/constants.h b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
new file mode 100644
index 000000000000..9a24996014b8
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/constants.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#ifndef __iwl_mld_constants_h__
+#define __iwl_mld_constants_h__
+
+#define IWL_MLD_MISSED_BEACONS_SINCE_RX_THOLD			4
+#define IWL_MLD_MISSED_BEACONS_THRESHOLD			8
+#define IWL_MLD_MISSED_BEACONS_THRESHOLD_LONG			19
+#define IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_2_LINKS		5
+#define IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH			15
+#define IWL_MLD_BCN_LOSS_EXIT_ESR_THRESH_BSS_PARAM_CHANGED	11
+#define IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH			-72
+
+#define IWL_MLD_DEFAULT_PS_TX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
+#define IWL_MLD_DEFAULT_PS_RX_DATA_TIMEOUT	(100 * USEC_PER_MSEC)
+#define IWL_MLD_WOWLAN_PS_TX_DATA_TIMEOUT	(10 * USEC_PER_MSEC)
+#define IWL_MLD_WOWLAN_PS_RX_DATA_TIMEOUT	(10 * USEC_PER_MSEC)
+#define IWL_MLD_SHORT_PS_TX_DATA_TIMEOUT	(2 * 1024) /* defined in TU */
+#define IWL_MLD_SHORT_PS_RX_DATA_TIMEOUT	(40 * 1024) /* defined in TU */
+
+#define IWL_MLD_UAPSD_RX_DATA_TIMEOUT		(50 * USEC_PER_MSEC)
+#define IWL_MLD_UAPSD_TX_DATA_TIMEOUT		(50 * USEC_PER_MSEC)
+
+#define IWL_MLD_PS_SNOOZE_INTERVAL		25
+#define IWL_MLD_PS_SNOOZE_INTERVAL		25
+#define IWL_MLD_PS_SNOOZE_WINDOW		50
+
+#define IWL_MLD_PS_SNOOZE_HEAVY_TX_THLD_PACKETS	30
+#define IWL_MLD_PS_SNOOZE_HEAVY_RX_THLD_PACKETS	20
+
+#define IWL_MLD_PS_HEAVY_TX_THLD_PERCENT	50
+#define IWL_MLD_PS_HEAVY_RX_THLD_PERCENT	50
+#define IWL_MLD_PS_HEAVY_TX_THLD_PACKETS	20
+#define IWL_MLD_PS_HEAVY_RX_THLD_PACKETS	8
+
+#define IWL_MLD_TRIGGER_LINK_SEL_TIME_SEC	30
+#define IWL_MLD_SCAN_EXPIRE_TIME_SEC		20
+
+#define IWL_MLD_TPT_COUNT_WINDOW (5 * HZ)
+
+/* OMI reduced BW thresholds (channel load percentage) */
+#define IWL_MLD_OMI_ENTER_CHAN_LOAD		10
+#define IWL_MLD_OMI_EXIT_CHAN_LOAD_160		20
+#define IWL_MLD_OMI_EXIT_CHAN_LOAD_320		30
+/* time (in milliseconds) to let AP "settle" the OMI */
+#define IWL_MLD_OMI_AP_SETTLE_DELAY		27
+/* time (in milliseconds) to not enter OMI reduced BW after leaving */
+#define IWL_MLD_OMI_EXIT_PROTECTION		5000
+
+#define IWL_MLD_DIS_RANDOM_FW_ID                false
+#define IWL_MLD_D3_DEBUG                        false
+#define IWL_MLD_NON_TRANSMITTING_AP	        false
+#define IWL_MLD_6GHZ_PASSIVE_SCAN_TIMEOUT       3000 /* in seconds */
+#define IWL_MLD_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
+#define IWL_MLD_CONN_LISTEN_INTERVAL		10
+#define IWL_MLD_ADAPTIVE_DWELL_NUM_APS_OVERRIDE 0
+#define IWL_MLD_AUTO_EML_ENABLE			true
+
+#define IWL_MLD_HIGH_RSSI_THRESH_20MHZ		-67
+#define IWL_MLD_LOW_RSSI_THRESH_20MHZ		-72
+#define IWL_MLD_HIGH_RSSI_THRESH_40MHZ		-64
+#define IWL_MLD_LOW_RSSI_THRESH_40MHZ		-72
+#define IWL_MLD_HIGH_RSSI_THRESH_80MHZ		-61
+#define IWL_MLD_LOW_RSSI_THRESH_80MHZ		-72
+#define IWL_MLD_HIGH_RSSI_THRESH_160MHZ		-58
+#define IWL_MLD_LOW_RSSI_THRESH_160MHZ		-72
+
+#define IWL_MLD_ENTER_EMLSR_TPT_THRESH		400
+#define IWL_MLD_CHAN_LOAD_THRESH		2 /* in percentage */
+
+#define IWL_MLD_FTM_INITIATOR_ALGO		IWL_TOF_ALGO_TYPE_MAX_LIKE
+#define IWL_MLD_FTM_INITIATOR_DYNACK		true
+#define IWL_MLD_FTM_LMR_FEEDBACK_TERMINATE	false
+#define IWL_MLD_FTM_TEST_INCORRECT_SAC		false
+#define IWL_MLD_FTM_R2I_MAX_REP			7
+#define IWL_MLD_FTM_I2R_MAX_REP			7
+#define IWL_MLD_FTM_R2I_MAX_STS			1
+#define IWL_MLD_FTM_I2R_MAX_STS			1
+#define IWL_MLD_FTM_R2I_MAX_TOTAL_LTF		3
+#define IWL_MLD_FTM_I2R_MAX_TOTAL_LTF		3
+#define IWL_MLD_FTM_RESP_NDP_SUPPORT		true
+#define IWL_MLD_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
+#define IWL_MLD_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	7
+#define IWL_MLD_FTM_NON_TB_MAX_TIME_BETWEEN_MSR	1000
+
+#endif /* __iwl_mld_constants_h__ */
-- 
2.34.1


