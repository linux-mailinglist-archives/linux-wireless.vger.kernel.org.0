Return-Path: <linux-wireless+bounces-25114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D1AFF2AA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858933B60B1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C125A2AB;
	Wed,  9 Jul 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjVC6rLA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653B26136D
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091572; cv=none; b=Iz8x6DrBd0KKgfGuDs1ojxol49hP0iHh/5EOu83c8V/PWUw/Fz8THo+lX85Dz/cB8+v+NLRefb+CwVeEY2Vu7UWx6/XrgA9gpbKHV1sbz3lsMapAvJAgt3aaLj9hqpvB144jwvNTSs8U1wXCHB99S+TBIDMLrn8ECyINCtl+u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091572; c=relaxed/simple;
	bh=yHRifJcOlgI6nEW9mARx9NzmtKzBruzOtG+DumL5QxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EizL+P4U85ifTq7BOQQIin/Hr4egtfzpaSiKH5nffT22XFrzfwxBs+b5/JBdWaR1cXyz4OGfsu7EXDtVYfUFG6fMfQ7m/DAJX3nlc3bb1hAyYlWjH6wAo+ZbbiJQaJG62O5I1DWrBo4mW92DzJlxggA4CQybMsU+tZ0TKy/11ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjVC6rLA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091571; x=1783627571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHRifJcOlgI6nEW9mARx9NzmtKzBruzOtG+DumL5QxA=;
  b=TjVC6rLAJCP9OiTncrA8uKMjDH1/y5GqG+wMQPBf9alcNEUgprFJFETz
   qnIcoWLmOOyiuhiA+gnEoq4/FX6rMFrTyeo3uE+jjndRQewp/OTEHODGX
   dZtZZH4DOnvT79RqbJVaDzGvyxfyvc0w3CGqQPdiNfGsT27g67vJWkGII
   gt44kUy0rZtpY29YaRhbRAOEyo+uTkjHLwkmv6uwTfp4K8UDrjv+kswXy
   qKCf8EEKuGC5re1FL7Gqu0xPQZaoZZokg33gy8VbQu9/EWHmzY/P/iqDz
   6ApAqwRCmHS3M3RdBHdLsE/lo4pjjIKpokLs7IBUHU1I2u8PHy3Pu6khI
   A==;
X-CSE-ConnectionGUID: cJyaE782TNKgQuC7+44oig==
X-CSE-MsgGUID: opnmEZ5wQQeeui+HH8zuDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240305"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240305"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:10 -0700
X-CSE-ConnectionGUID: aoPylSWFSZ2sOZ9M/kpmoQ==
X-CSE-MsgGUID: ypdhyyL2RKqFzyL59fXD3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126037"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
Date: Wed,  9 Jul 2025 23:05:34 +0300
Message-Id: <20250709230308.1b9177bfbe1d.I53c1527cc5097f05df352b6f2f99282b00a5d7ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
References: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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


