Return-Path: <linux-wireless+bounces-36294-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFSFKiW8AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36294-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:35:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127A51A284
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18FCD30C082C
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6CE33BBD9;
	Tue, 12 May 2026 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WK8asBBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F1337BA6
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563406; cv=none; b=CcgtddCcGtWhTYKcs9xIGpmhwm+1y8u3PqMDx3Q5jC0CAoeo9bTTwPCuywfzRf77DvJiA4XdGlyysvHFYG/kQrapc1pafwPOEnhy1ekRRsn7+41L2UGfkx8NbqPYkzVccxpKfNykpWEWXgigNhS5e1L/4hyCtsNZUfL3cgOQXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563406; c=relaxed/simple;
	bh=kGPO/mh76YXE2WsVUJXd221RgjR+Oyo0p04Xf3JbsZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glBL8aoI74NI2S04kUElF04UCgAnMypwZr3RdHsHsUhp7UovDB4Fazw7LR9dFnHvoXYWwH2gh5UjuxMGtYxELBwNQ21cgR+yhe2bvHk/u52Ro3GrNwKpb55zaxa39B+xh4W+Ogda1fZVOX5Q5Tb+prE54YEq0NvCi+brHpfavRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WK8asBBv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563404; x=1810099404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGPO/mh76YXE2WsVUJXd221RgjR+Oyo0p04Xf3JbsZA=;
  b=WK8asBBvIY7mjxUUw9Iakbc3IGXwd/tQm6DqkufkGqTJvkizJamF8PC3
   iNSAKKqJ8xRdVD2E2xKql1t2WU3uW9rS5H2zUfztYhBmbxH/U9RlU+vJ6
   FgCQQYjIidsXawovhZs9t9BjZdSfpynE7AaiE+j+sxPQ0MOOBoKlJa5WE
   eh4erGQX7FJdylUNVWyzluwUHR5u8hN/ANodzMXTh4Q6+WDOkd87UsPXU
   0y/kq2ob+ug4WGjt9t+cI9DOxrS6AnjBElzdJkHov+bK8X5XniGrtbGJ3
   zbaScTFLsn9BbIPwOdofGroZA+0+bjp2yVam7ctfRE8jj/JI1emBMnL12
   Q==;
X-CSE-ConnectionGUID: 0gNy+blkQ1Gjn6uMb+23wg==
X-CSE-MsgGUID: HLqLwJItSaGkYienTeU2WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495089"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495089"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:24 -0700
X-CSE-ConnectionGUID: cHRmKGwsSQ6ZAhBsFnPKYg==
X-CSE-MsgGUID: kIsXel9cTPWEKeLDKp05bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187502"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: introduce iwl_system_statistics_notif_oper version 4
Date: Tue, 12 May 2026 08:22:55 +0300
Message-Id: <20260512082114.705fbeeb28d1.I4804d029fa76cfb8267f8c6bcac1ed237a8b3497@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0127A51A284
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36294-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This new version includes Coex related statistics

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/stats.h | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 8d734512f4d5..8d16782a129c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -585,6 +585,67 @@ struct iwl_stats_ntfy_per_phy_v1 {
 	__le32 last_tx_ch_width_indx;
 } __packed; /* STATISTICS_NTFY_PER_PHY_API_S_VER_1 */
 
+/**
+ * struct iwl_stats_ntfy_coex - coex statistics
+ *
+ * @wifi_kill_cnt: count of wifi frames killed by BT
+ * @wifi_tx_cts_kill_cnt: count of wifi Tx CTS frames killed by BT
+ * @ttc2_ppdu_error_count: Count PPDU errors on TTC2 - BT Tx indication rises
+ *	within wifi Tx packet on non-shared antenna and wifi is NOT killed by
+ *	PTA/TCL.
+ * @trc2_ppdu_error_count: count PPDU errors on TRC2 - BT Rx indication rises
+ *	within wifi Tx packet on non-shared antenna and wifi is  NOT killed by
+ *	PTA/TCL
+ * @rrc1_collision_count: count RRC1 - BT Rx indication rises within wifi Rx
+ *	packet on shared antenna
+ * @rrc2_collision_count: count RRC2 - BT Rx indication rises within wifi Rx
+ *	packet on non-shared antenna
+ * @rtc2_collision_count: count RTC2 - BT Tx indication rises within wifi Rx
+ *	packet on non-shared antenna
+ * @reserved: reserved
+ */
+struct iwl_stats_ntfy_coex {
+	__le16 wifi_kill_cnt;
+	__le16 wifi_tx_cts_kill_cnt;
+	__le16 ttc2_ppdu_error_count;
+	__le16 trc2_ppdu_error_count;
+	__le16 rrc1_collision_count;
+	__le16 rrc2_collision_count;
+	__le16 rtc2_collision_count;
+	__le16 reserved;
+} __packed; /* STATISTICS_FW_NTFY_COEX_TELEMETRY_API_S_VER_1 */
+
+/**
+ * struct iwl_stats_ntfy_per_phy - per PHY statistics
+ * @channel_load: channel load
+ * @channel_load_by_us: device contribution to MCLM
+ * @channel_load_not_by_us: other devices' contribution to MCLM
+ * @clt: CLT HW timer (TIM_CH_LOAD2)
+ * @act: active accumulator SW
+ * @elp: elapsed time accumulator SW
+ * @rx_detected_per_ch_width: number of deferred TX per channel width,
+ *	0 - 20, 1/2/3 - 40/80/160
+ * @success_per_ch_width: number of frames that got ACK/BACK/CTS
+ *	per channel BW. note, BACK counted as 1
+ * @fail_per_ch_width: number of frames that didn't get ACK/BACK/CTS
+ *	per channel BW. note BACK counted as 1
+ * @last_tx_ch_width_indx: last txed frame channel width index
+ * @coex: coex related data
+ */
+struct iwl_stats_ntfy_per_phy {
+	__le32 channel_load;
+	__le32 channel_load_by_us;
+	__le32 channel_load_not_by_us;
+	__le32 clt;
+	__le32 act;
+	__le32 elp;
+	__le32 rx_detected_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 success_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 fail_per_ch_width[IWL_STATS_MAX_BW_INDEX];
+	__le32 last_tx_ch_width_indx;
+	struct iwl_stats_ntfy_coex coex;
+} __packed; /* STATISTICS_NTFY_PER_PHY_API_S_VER_2 */
+
 /* unknown channel load (due to not being active on channel) */
 #define IWL_STATS_UNKNOWN_CHANNEL_LOAD	0xffffffff
 
@@ -614,6 +675,21 @@ struct iwl_system_statistics_notif_oper_v3 {
 	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
 } __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_3 */
 
+/**
+ * struct iwl_system_statistics_notif_oper - statistics notification
+ *
+ * @time_stamp: time when the notification is sent from firmware
+ * @per_link: per link statistics, &struct iwl_stats_ntfy_per_link
+ * @per_phy: per phy statistics, &struct iwl_stats_ntfy_per_phy_v1
+ * @per_sta: per sta statistics, &struct iwl_stats_ntfy_per_sta
+ */
+struct iwl_system_statistics_notif_oper {
+	__le32 time_stamp;
+	struct iwl_stats_ntfy_per_link per_link[IWL_FW_MAX_LINKS];
+	struct iwl_stats_ntfy_per_phy per_phy[IWL_STATS_MAX_PHY_OPERATIONAL];
+	struct iwl_stats_ntfy_per_sta per_sta[IWL_STATION_COUNT_MAX];
+} __packed; /* STATISTICS_FW_NTFY_OPERATIONAL_API_S_VER_4 */
+
 /**
  * struct iwl_system_statistics_part1_notif_oper - part1 stats notification
  *
-- 
2.34.1


