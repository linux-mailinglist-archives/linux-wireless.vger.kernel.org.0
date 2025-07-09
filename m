Return-Path: <linux-wireless+bounces-25044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA1AFDEF8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD75F3BFC7A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1622D4DD;
	Wed,  9 Jul 2025 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHl4YiG6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AA26A1D9
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037351; cv=none; b=m4DJnRI2JGj1NE2BoUKdhEUPIcMcj/QYAfm2woclRArPylHLtQyps9bpDT5h4xp3PUJgvasB2auplMzw3sb/OrTrIZWnHkqTuleggzOISYgjVcLTOqKoZ/H75EmwfNtsJjIjOHcTeRgDN3pgvJySbpFY9zhD9v1WVM5Rru6KDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037351; c=relaxed/simple;
	bh=yHRifJcOlgI6nEW9mARx9NzmtKzBruzOtG+DumL5QxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6loH1aV+zHZ8pmgRWt6FjgoZPvDOnbIiISthYc3jAXtTfwcpN8DPCVhnfsKQ0gvSiGtJJPyl1ZMCZ5EN0mSI6SKd1vxLr0HftzpomqEHyyDdgAeKHtJiWXPrgFzi4a6M32eGzlizh5wJaWl3MrKhP9UpBvNXilBTZLIMh0JJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHl4YiG6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037349; x=1783573349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHRifJcOlgI6nEW9mARx9NzmtKzBruzOtG+DumL5QxA=;
  b=AHl4YiG6Dwzmj6xIMJ8a5PjFTgbgZIQRi7RgB23xZ5WDSku7a7RrKEcy
   5bB2BZsAC5vP3HwfRjtI0QEBvrU/9cfLGwqplU8q65kRXq4lVF41OX/US
   M6Z4mqOAubpVFJHHiednF2MvLQdLKQp/j1LPwj/vTHFVh5VGbrWo/VbgS
   fEDF/eV6XaeRiUus9zKyots/gePzjoh0sa/e6InTOtSSXwtM0Gy9TrEDR
   I7B82Io+uCmZ1Pe379m1kujBF8qretjJFsuQBIFo/jtbZ0QXUZfIseGPt
   ASQSGfjUUc1BFY9yIili4g0DQs2EPYwRYqRlYzx0VdyKzCEa+VueHEANJ
   g==;
X-CSE-ConnectionGUID: zZFV/c/mSJmBwuR85uOqGw==
X-CSE-MsgGUID: cUsZ1w6ZTpyaERU3I4UIWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501462"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501462"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:29 -0700
X-CSE-ConnectionGUID: +kK8QnptT7OtftR4jra2TA==
X-CSE-MsgGUID: 31hDzvTiQi+47IzVyTFI/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859238"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
Date: Wed,  9 Jul 2025 08:01:50 +0300
Message-Id: <20250709075928.4deaa1e2634e.I53c1527cc5097f05df352b6f2f99282b00a5d7ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
References: <20250709050159.854432-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

FWs with this version are no longer supported on any device.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  3 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 38 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 13 -------
 3 files changed, 1 insertion(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 1c86a858aaab..3f8f9e3fcba8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -574,8 +574,7 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @WOWLAN_GET_STATUSES: response in &struct iwl_wowlan_status_v6,
-	 *	&struct iwl_wowlan_status_v7, &struct iwl_wowlan_status_v9 or
-	 *	&struct iwl_wowlan_status_v12
+	 *	&struct iwl_wowlan_status_v7, &struct iwl_wowlan_status_v9
 	 */
 	WOWLAN_GET_STATUSES = 0xe5,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 3fd1a1b64b07..a73b1f63da1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -757,44 +757,6 @@ struct iwl_wowlan_status_v9 {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_9 */
 
-/**
- * struct iwl_wowlan_status_v12 - WoWLAN status
- * @gtk: GTK data
- * @igtk: IGTK data
- * @replay_ctr: GTK rekey replay counter
- * @pattern_number: number of the matched pattern
- * @non_qos_seq_ctr: non-QoS sequence counter to use next.
- *                   Reserved if the struct has version >= 10.
- * @qos_seq_ctr: QoS sequence counters to use next
- * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
- * @num_of_gtk_rekeys: number of GTK rekeys
- * @transmitted_ndps: number of transmitted neighbor discovery packets
- * @received_beacons: number of received beacons
- * @wake_packet_length: wakeup packet length
- * @wake_packet_bufsize: wakeup packet buffer size
- * @tid_tear_down: bit mask of tids whose BA sessions were closed
- *		   in suspend state
- * @reserved: unused
- * @wake_packet: wakeup packet
- */
-struct iwl_wowlan_status_v12 {
-	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
-	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
-	__le64 replay_ctr;
-	__le16 pattern_number;
-	__le16 non_qos_seq_ctr;
-	__le16 qos_seq_ctr[8];
-	__le32 wakeup_reasons;
-	__le32 num_of_gtk_rekeys;
-	__le32 transmitted_ndps;
-	__le32 received_beacons;
-	__le32 wake_packet_length;
-	__le32 wake_packet_bufsize;
-	u8 tid_tear_down;
-	u8 reserved[3];
-	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
-} __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
-
 /**
  * struct iwl_wowlan_info_notif_v1 - WoWLAN information notification
  * @gtk: GTK data
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index bc5f70f04d2c..36890e9c7a2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2467,7 +2467,6 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 iwl_mvm_parse_wowlan_status_common(v6)
 iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
-iwl_mvm_parse_wowlan_status_common(v12)
 
 static struct iwl_wowlan_status_data *
 iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
@@ -2559,18 +2558,6 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 		iwl_mvm_convert_igtk(status, &v9->igtk[0]);
 
 		status->tid_tear_down = v9->tid_tear_down;
-	} else if (notif_ver == 12) {
-		struct iwl_wowlan_status_v12 *v12 = (void *)cmd.resp_pkt->data;
-
-		status = iwl_mvm_parse_wowlan_status_common_v12(mvm, v12, len);
-		if (!status)
-			goto out_free_resp;
-
-		iwl_mvm_convert_key_counters_v5(status, &v12->gtk[0].sc);
-		iwl_mvm_convert_gtk_v3(status, v12->gtk);
-		iwl_mvm_convert_igtk(status, &v12->igtk[0]);
-
-		status->tid_tear_down = v12->tid_tear_down;
 	} else {
 		IWL_ERR(mvm,
 			"Firmware advertises unknown WoWLAN status response %d!\n",
-- 
2.34.1


