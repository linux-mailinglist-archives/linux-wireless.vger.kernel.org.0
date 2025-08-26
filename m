Return-Path: <linux-wireless+bounces-26657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69302B37151
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 19:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DDF1BA675E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3042E371D;
	Tue, 26 Aug 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrLOQLsS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B81238C0B;
	Tue, 26 Aug 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229192; cv=none; b=SYnTZseTxzjarJpC1ys7TvX3qjdifdnuShWOy7KDlKndxqNxbppoYcmt3MTSP+jIfSUvFgBYXc9S9mNHiFWcmvliYVz0pStHJY2+xlLDhCKkkS9mLWnpLX6KzQQd42BNrv0g6cjwOUVEMGUiUKOl0wT/KoLkMv3CXvS32eM0fLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229192; c=relaxed/simple;
	bh=lbOtxM0j44twxV2tyNB4EQyXXixJAdCX6fiPFWLl1R4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TykUe12YHWlXjxKxpmkKdTGLBod+PSwqg6WoB5LcwC/Ow+FfDU8MlqLVS7P+K95xvPWSWGNBRUZQ44nkRKAYuh9TeDGEK5ZZIEFnA6Z5/oS95R7ktEJtsSZOyLxGGphwRlA8wPFPFYOXxSArqpbX7NNkE6E53v0SzNUQAguCPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VrLOQLsS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756229190; x=1787765190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lbOtxM0j44twxV2tyNB4EQyXXixJAdCX6fiPFWLl1R4=;
  b=VrLOQLsSPnNSSIR0VsCrImeUqXNwTMuuMZPGUJ1bnKf9DQjbh/rA26sJ
   TxvjFe2h5nT+HowdrYHok9mTqCKme9gvAZ8xHZsXRYCWsDwcgbXArSiPx
   qBeyGsZk4NbY5JkEAo2DaJq8fpGIHf7C7eM8BH3FndAUD02beGU2rCRbs
   QIGChpriLYJm8eweOhvxH5A8/AbdZS0S33A0HOCVdbWNHG5m02itd6DHU
   3DgE6Rpff0qm38L/TMox+zdQPb6M1tG6WGVwwhelW+iH71T5AF4MeFlY3
   w4fCu5RFPVuKhrs6z2hDRpg/FhvePf97N2w+Vpd59WeFtti1Gek+L24cD
   g==;
X-CSE-ConnectionGUID: xUGaRR7rRcqlEF9d5a+ehA==
X-CSE-MsgGUID: +Bb6VK16QXyLSxVUEJVD0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57675231"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57675231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:26:28 -0700
X-CSE-ConnectionGUID: C3Z8/anXSBCmJy5gyUM7Bg==
X-CSE-MsgGUID: nnBLE3O/Tl6gR/IMS1XbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="170452017"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 10:26:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: do not permit 40 MHz EHT operation on 5/6 GHz
Date: Tue, 26 Aug 2025 20:26:01 +0300
Message-Id: <20250826202553.a6582f3abf57.Ic670429dc7127f68c818b4290d950ebfb5a0b9e1@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The EHT PHY requirements state that 80 MHz must be supported on the 5
and 6 GHz bands unless the STA is 20 MHz only. So if the channel width
is limited to 40 MHz on a band other than 2.4 GHz, then disable EHT and
downgrade to HE.

The primary case where this can happen is if the hardware disables
puncturing using IEEE80211_HW_DISALLOW_PUNCTURING.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c            |  8 ++++++++
 net/mac80211/tests/chan-mode.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1008eb8e9b13..dd650a127a31 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1189,6 +1189,14 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			     "required MCSes not supported, disabling EHT\n");
 	}
 
+	if (conn->mode >= IEEE80211_CONN_MODE_EHT &&
+	    channel->band != NL80211_BAND_2GHZ &&
+	    conn->bw_limit == IEEE80211_CONN_BW_LIMIT_40) {
+		conn->mode = IEEE80211_CONN_MODE_HE;
+		link_id_info(sdata, link_id,
+			     "required bandwidth not supported, disabling EHT\n");
+	}
+
 	/* the mode can only decrease, so this must terminate */
 	if (ap_mode != conn->mode) {
 		kfree(elems);
diff --git a/net/mac80211/tests/chan-mode.c b/net/mac80211/tests/chan-mode.c
index 96c7b3ab2744..adc069065e73 100644
--- a/net/mac80211/tests/chan-mode.c
+++ b/net/mac80211/tests/chan-mode.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for channel mode functions
  *
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <kunit/test.h>
@@ -28,6 +28,10 @@ static const struct determine_chan_mode_case {
 	u8 vht_basic_mcs_1_4, vht_basic_mcs_5_8;
 	u8 he_basic_mcs_1_4, he_basic_mcs_5_8;
 	u8 eht_mcs7_min_nss;
+	u16 eht_disabled_subchannels;
+	u8 eht_bw;
+	enum ieee80211_conn_bw_limit conn_bw_limit;
+	enum ieee80211_conn_bw_limit expected_bw_limit;
 	int error;
 } determine_chan_mode_cases[] = {
 	{
@@ -128,6 +132,14 @@ static const struct determine_chan_mode_case {
 		.conn_mode = IEEE80211_CONN_MODE_EHT,
 		.eht_mcs7_min_nss = 0x15,
 		.error = EINVAL,
+	}, {
+		.desc = "80 MHz EHT is downgraded to 40 MHz HE due to puncturing",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HE,
+		.conn_bw_limit = IEEE80211_CONN_BW_LIMIT_80,
+		.expected_bw_limit = IEEE80211_CONN_BW_LIMIT_40,
+		.eht_disabled_subchannels = 0x08,
+		.eht_bw = IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ,
 	}
 };
 KUNIT_ARRAY_PARAM_DESC(determine_chan_mode, determine_chan_mode_cases, desc)
@@ -138,7 +150,7 @@ static void test_determine_chan_mode(struct kunit *test)
 	struct t_sdata *t_sdata = T_SDATA(test);
 	struct ieee80211_conn_settings conn = {
 		.mode = params->conn_mode,
-		.bw_limit = IEEE80211_CONN_BW_LIMIT_20,
+		.bw_limit = params->conn_bw_limit,
 	};
 	struct cfg80211_bss cbss = {
 		.channel = &t_sdata->band_5ghz.channels[0],
@@ -191,14 +203,21 @@ static void test_determine_chan_mode(struct kunit *test)
 		0x7f, 0x01, 0x00, 0x88, 0x88, 0x88, 0x00, 0x00,
 		0x00,
 		/* EHT Operation */
-		WLAN_EID_EXTENSION, 0x09, WLAN_EID_EXT_EHT_OPERATION,
-		0x01, params->eht_mcs7_min_nss ? params->eht_mcs7_min_nss : 0x11,
-		0x00, 0x00, 0x00, 0x00, 0x24, 0x00,
+		WLAN_EID_EXTENSION, 0x0b, WLAN_EID_EXT_EHT_OPERATION,
+		0x03, params->eht_mcs7_min_nss ? params->eht_mcs7_min_nss : 0x11,
+		0x00, 0x00, 0x00, params->eht_bw,
+		params->eht_bw == IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ ? 42 : 36,
+		0x00,
+		u16_get_bits(params->eht_disabled_subchannels, 0xff),
+		u16_get_bits(params->eht_disabled_subchannels, 0xff00),
 	};
 	struct ieee80211_chan_req chanreq = {};
 	struct cfg80211_chan_def ap_chandef = {};
 	struct ieee802_11_elems *elems;
 
+	/* To force EHT downgrade to HE on punctured 80 MHz downgraded to 40 MHz */
+	set_bit(IEEE80211_HW_DISALLOW_PUNCTURING, t_sdata->local.hw.flags);
+
 	if (params->strict)
 		set_bit(IEEE80211_HW_STRICT, t_sdata->local.hw.flags);
 	else
@@ -237,6 +256,7 @@ static void test_determine_chan_mode(struct kunit *test)
 	} else {
 		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elems);
 		KUNIT_ASSERT_EQ(test, conn.mode, params->expected_mode);
+		KUNIT_ASSERT_EQ(test, conn.bw_limit, params->expected_bw_limit);
 	}
 }
 
-- 
2.34.1


