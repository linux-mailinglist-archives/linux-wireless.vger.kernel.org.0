Return-Path: <linux-wireless+bounces-27350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CEB7DFBC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306AA7A7269
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C53528725B;
	Tue, 16 Sep 2025 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="B1n6p2tf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D82288AD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061156; cv=none; b=Pbq6oMph13nSQML7FiCD457Xedm/Of+msT7fO1wejO9hSoAYdJnJVMS4I7Nox2IaWPeMX0G0GiAFCFgKPxF1M6F91bW4P7DFSQbk79eUOS6S6OQvBedjsvXT5wt2WIO1sR7lhL/8WHbdudY3YMgAqWV2I/CgTQWH3rPwpHb+bQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061156; c=relaxed/simple;
	bh=8GRkcb1roKXek/AGEtejk/tcfZ6jgRRZ1rEw55ZZnOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwanCOHGK8bE2qKmbNHxL+2mWZEh4H5CLmwLcR0e4OzZ70P1Fcq546ccxMhSsMHQRVPWsQ90/bEMk6ra5VRyMMSeLwzLcYFX/7sr2a5csguXEBRXXN4H/FsQ8V28prhG2o9vR+OB4Ma9DTSJ1B0BagVqhNk0uBb5NxGBbJcxeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=B1n6p2tf; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061155; x=1789597155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8GRkcb1roKXek/AGEtejk/tcfZ6jgRRZ1rEw55ZZnOI=;
  b=B1n6p2tfM13WJ5+aqAmeNOtE/lrTWywZLETK1SIl3XJIX2W+JgJbknXx
   iVIdKBwHUOXP8SHlp8UInvzEqwPvByar22zT8fGGLE6SI2ap3bn1SIftX
   5dkV2Nfirpx/1OvMMOIKJ1+UhMr+xpVMgzt8WujN6fOiY2gCmpaD89dri
   w=;
X-CSE-ConnectionGUID: ZArhbnfYTtSn+KLNlTdssA==
X-CSE-MsgGUID: 5DeF3jklQ2uuM/NFzY1jGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783242"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783242"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:19:13 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:19:12 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:19:09 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 03/57] wifi: ieee80211: add Radio Measurement (RM) Enabled Capabilities definition
Date: Wed, 17 Sep 2025 03:47:18 +0530
Message-ID: <20250916221821.4387-4-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
 MUCSE827.infineon.com (172.23.29.20)

Add the MACRO definitions for Radio Measurement (RM) Enabled Capabilities
defined in IEEE Std 802.11-2024, 9.4.2.43, Table 9-218.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 include/linux/ieee80211.h | 42 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a3a2ac682fd4..2ab5ab2bee2b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4028,6 +4028,48 @@ enum ieee80211_s1g_actioncode {
 	WLAN_S1G_TWT_INFORMATION = 11,
 };
 
+/* RM Enabled Capabilities (IEEE Std 802.11-2024, 9.4.2.43, Table 9-218) */
+#define IEEE80211_RM_ENAB_CAP0_LINK_MSR				BIT(0)
+#define IEEE80211_RM_ENAB_CAP0_NEIGHBOR_REPORT			BIT(1)
+#define IEEE80211_RM_ENAB_CAP0_PARALLEL_MSR			BIT(2)
+#define IEEE80211_RM_ENAB_CAP0_REPEATED_MSR			BIT(3)
+#define IEEE80211_RM_ENAB_CAP0_BCN_PASSIVE_MSR			BIT(4)
+#define IEEE80211_RM_ENAB_CAP0_BCN_ACTIVE_MSR			BIT(5)
+#define IEEE80211_RM_ENAB_CAP0_BCN_TABLE_MSR			BIT(6)
+#define IEEE80211_RM_ENAB_CAP0_BCN_MSR_REPORTING_COND		BIT(7)
+
+#define IEEE80211_RM_ENAB_CAP1_FRAME_MSR			BIT(0)
+#define IEEE80211_RM_ENAB_CAP1_CHANNEL_LOAD_MSR			BIT(1)
+#define IEEE80211_RM_ENAB_CAP1_NOISE_HISTOGRAM_MSR		BIT(2)
+#define IEEE80211_RM_ENAB_CAP1_STATISTICS_MSR			BIT(3)
+#define IEEE80211_RM_ENAB_CAP1_LCI_MSR				BIT(4)
+#define IEEE80211_RM_ENAB_CAP1_LCI_AZIMUTH			BIT(5)
+#define IEEE80211_RM_ENAB_CAP1_TRANSMIT_STREAM_MSR		BIT(6)
+#define IEEE80211_RM_ENAB_CAP1_TRIGGERED_TRANSMIT_STREAM_MSR	BIT(7)
+
+#define IEEE80211_RM_ENAB_CAP2_AP_CHANNEL_REPORT		BIT(0)
+#define IEEE80211_RM_ENAB_CAP2_RM_MIB				BIT(1)
+#define IEEE80211_RM_ENAB_CAP2_OP_CH_MAX_MSR_DUR_SHIFT		2
+#define IEEE80211_RM_ENAB_CAP2_OP_CH_MAX_MSR_DUR_MASK		\
+		(7 << IEEE80211_RM_ENAB_CAP_OP_CH_MAX_MSR_DUR_SHIFT)
+#define IEEE80211_RM_ENAB_CAP2_NONOP_CH_MAX_MSR_DUR_SHIFT	5
+#define IEEE80211_RM_ENAB_CAP2_NONOP_CH_MAX_MSR_DUR_MASK	\
+		(7 << IEEE80211_RM_ENAB_CAP_NONOP_CH_MAX_MSR_DUR_SHIFT)
+
+#define IEEE80211_RM_ENAB_CAP3_MSR_PILOT_SHIFT			0
+#define IEEE80211_RM_ENAB_CAP3_MSR_PILOR_MASK			\
+		(7 << IEEE80211_RM_ENAB_CAP_MSR_PILOT_SHIFT)
+#define IEEE80211_RM_ENAB_CAP3_MSR_PILOT_TRANSMISSION_INFO	BIT(3)
+#define IEEE80211_RM_ENAB_CAP3_NEIGHBOR_REPORT_TSF_OFFSET	BIT(4)
+#define IEEE80211_RM_ENAB_CAP3_RCPI_MSR				BIT(5)
+#define IEEE80211_RM_ENAB_CAP3_RSNI_MSR				BIT(6)
+#define IEEE80211_RM_ENAB_CAP3_BSS_AVERAGE_ACCESS_DELAY		BIT(7)
+
+#define IEEE80211_RM_ENAB_CAP4_BSS_AVAIL_ADMIISSION_CAPACITY	BIT(0)
+#define IEEE80211_RM_ENAB_CAP4_ANTENNA				BIT(1)
+#define IEEE80211_RM_ENAB_CAP4_FTM_RANGE_REPORT			BIT(2)
+#define IEEE80211_RM_ENAB_CAP4_CIVIC_LOCATION_MSR		BIT(3)
+
 /* Radio measurement action codes as defined in IEEE 802.11-2024 - Table 9-470 */
 enum ieee80211_radio_measurement_actioncode {
 	WLAN_RM_ACTION_RADIO_MEASUREMENT_REQUEST = 0,
-- 
2.25.1


