Return-Path: <linux-wireless+bounces-33562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHziE24CvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5CE2D7103
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B607531CB9DA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932237106A;
	Fri, 20 Mar 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0N5gdFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7F377572
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994174; cv=none; b=LdRSCDObP54Aw5Fjp8YQdQ8h0ntF61PNuTxmryGt9x8ajwNLjBVjSOTkRDKpMdZ88M3uDadeafCHDQ9TtsZM6OynYa0mKzjCSGLjeMPIT5r3T8AL+h7cBRMRiwfhhCPfrRAJEoEzDAPfmISp5V9829FDeAv9MpuGmdJxss/5t+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994174; c=relaxed/simple;
	bh=7FzvLpjvB/f5LKygcwNJBhRXKLSYEpqPA6EEkv/ENys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFao0Q0y65dmoL1oMUPTADOGHQ0509az2rl/prkrZBxAzYuOou58RJ8Dh71dF2d8BApG2pk6WHAVHzhjqshNrXn761zkhl90iufHm5iqfXDKkzDu97VhTD4emd0W8s3PbEXrLYPKFjhb5SqI8SqTNblnduaK/ZCK7MxZ7y5ORCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0N5gdFt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994174; x=1805530174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FzvLpjvB/f5LKygcwNJBhRXKLSYEpqPA6EEkv/ENys=;
  b=C0N5gdFtWi7aPoTa5/sNyyuM7HWCvCFV+1QRVXejmHtt73CIHv93TCn6
   B2fsRbtmjzvg2svckbDKo1ilrrlHLxn05sR8qx/3kdNRDQI0DVy9S/bOF
   fMrnPGuswayZOpnotneMWcgx+7F0SWgsxGT8zc9n5QVMkiEBAWZx015KA
   YvthgFkY9STvdGHhoQELu/gfWszazzleN4BR7QHaM99k8K5qLS+zNYaUc
   Zu8FtcR2tEGwN+I63gLkqUBzFkoqN7Q6GxWmum+A27SYrBi+sUda92ri1
   XOsUhm4tGZeSPGv16NzbDuAD4B0yFjH5BDrE9EQvBgRWL/0EEV+xOGNKc
   A==;
X-CSE-ConnectionGUID: t1Pf71KwQouHWixYW4J7yw==
X-CSE-MsgGUID: NVieJDvKRgmnDDDHRGULVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154110"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154110"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:34 -0700
X-CSE-ConnectionGUID: dPSigSnDT4eLrWM2sUSStg==
X-CSE-MsgGUID: EAh24IcoSuaWdon8kz4qMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692555"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: mld: set UHR MCS in RX status
Date: Fri, 20 Mar 2026 10:09:05 +0200
Message-Id: <20260320100746.7d235ea6a4f2.Ibc8c7e1af45cae2756e4ddcdf6dc5424b3992f7b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33562-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ED5CE2D7103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Handle UHR MCSes in the RX status when receiving UHR frames.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/rx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index 214dcfde2fb4..ff6e71e3ff6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -1407,6 +1407,7 @@ static void iwl_mld_set_rx_rate(struct iwl_mld *mld,
 	u32 rate_n_flags = phy_data->rate_n_flags;
 	u8 stbc = u32_get_bits(rate_n_flags, RATE_MCS_STBC_MSK);
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
+	u32 he_type = u32_get_bits(rate_n_flags, RATE_MCS_HE_TYPE_MSK);
 	bool is_sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 
 	/* bandwidth may be overridden to RU by PHY ntfy */
@@ -1481,6 +1482,12 @@ static void iwl_mld_set_rx_rate(struct iwl_mld *mld,
 		rx_status->encoding = RX_ENC_EHT;
 		iwl_mld_set_rx_nonlegacy_rate_info(rate_n_flags, rx_status);
 		break;
+	case RATE_MCS_MOD_TYPE_UHR:
+		rx_status->encoding = RX_ENC_UHR;
+		iwl_mld_set_rx_nonlegacy_rate_info(rate_n_flags, rx_status);
+		if (he_type == RATE_MCS_HE_TYPE_UHR_ELR)
+			rx_status->uhr.elr = 1;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
-- 
2.34.1


