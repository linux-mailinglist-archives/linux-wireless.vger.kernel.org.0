Return-Path: <linux-wireless+bounces-11138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09094C59E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501FA1C209AD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CE91591F3;
	Thu,  8 Aug 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTvkxM3M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4D158DA0
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148588; cv=none; b=k+9FRk+FlhlFvmfYTWRqWNS6sZlctJTucRcoQTOwtBmZSyzi8k5Suqmf8aJWHHSywKHQv0AyB4Ol+58zaZD+x0FaJuF2GAkoISnEy4tSpOrkrDdD4KmY6NKYCSoTCFSoe2ePb5vW3NspPf6Mazv1qPx7sz/cJ81jVk7hvBkoPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148588; c=relaxed/simple;
	bh=kWLKIOFTnqErhnq/7X3ep8qEyoWgLJNIM6KpB3wyL80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7ygAP+zTepzAuzWD/iomaDMJ847RP7NiAE5y6CSiWGutKdqnP4Bx2HP/y/0fD+yq7xNfMN/8sCF3n9/b9MjNFd76pR/nnHu4PSsrFL1dJXb4+FT+pJLx0DIM7sZh4RJz5ZmnIBPZxNdWER7A7qfRbTEVluG7psaJH3g3JYrchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTvkxM3M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148586; x=1754684586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWLKIOFTnqErhnq/7X3ep8qEyoWgLJNIM6KpB3wyL80=;
  b=RTvkxM3Mb3L/ulYxkxG1G+rFwnX+oIPFMo2VRJGPWuNukrGaN0KTjCOl
   cuVDN3Hx+lEiTcjuwU+EPcN8GMMOitX1JlGRu9JMN+77vHIY84rcaNawd
   FDcRfF45MXfAEUtMidSItVCqFiBxbEqAqHTvaANnZRcqZ0gTcgrFejLDA
   /E+Ykc0lxQWledPwgun2kLHmIWvTBlnC5A1zw0Bq6HSpmebyoH9BdFE1e
   Yu8fF+zVTy/sS/t/Cox6xxsS6I7j7VbQA9OYOaurxHFJ6S04joJlDeTpN
   9MjIWUwfA7falZIiVEuI/c7aQmX+5ztc82jlpHoQcdANExicc9rw7oVUw
   w==;
X-CSE-ConnectionGUID: wsH+bBjBTZ+VIqJjcNg+uQ==
X-CSE-MsgGUID: rZ+3rBLpRxaQA/IxdBolnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808836"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:06 -0700
X-CSE-ConnectionGUID: MC6q+FYaSrmgG/naFnJmhA==
X-CSE-MsgGUID: 5wd8X/83RW+omdlwtFgAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305287"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/13] wifi: iwlwifi: mvm: add the new API for the missed beacons notification
Date: Thu,  8 Aug 2024 23:22:39 +0300
Message-Id: <20240808232017.4ea52360b32e.Ibc25dcabd8aeadda906549482a6c77bc42fb55bb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Note that the new API does not have the same notification ID as the
previous notification: the new notification belongs to the group 0x3.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 56b880e68870..5fc7967df6c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -61,6 +61,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @ROC_CMD: &struct iwl_roc_req
 	 */
 	ROC_CMD = 0xE,
+	/**
+	 * @MISSED_BEACONS_NOTIF: &struct iwl_missed_beacons_notif
+	 */
+	MISSED_BEACONS_NOTIF = 0xF6,
 	/**
 	 * @ROC_NOTIF: &struct iwl_roc_notif
 	 */
@@ -665,4 +669,25 @@ struct iwl_mvm_esr_mode_notif {
 	__le32 action;
 } __packed; /* ESR_MODE_RECOMMENDATION_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_missed_beacons_notif - sent when by the firmware upon beacon loss
+ *  ( MISSED_BEACONS_NOTIF = 0xF6 )
+ * @link_id: fw link ID
+ * @consec_missed_beacons_since_last_rx: number of consecutive missed
+ *	beacons since last RX.
+ * @consec_missed_beacons: number of consecutive missed beacons
+ * @other_link_id: used in EMLSR only. The fw link ID for
+ *	&consec_missed_beacons_other_link. IWL_MVM_FW_LINK_ID_INVALID (0xff) if
+ *	invalid.
+ * @consec_missed_beacons_other_link: number of consecutive missed beacons on
+ *	&other_link_id.
+ */
+struct iwl_missed_beacons_notif {
+	__le32 link_id;
+	__le32 consec_missed_beacons_since_last_rx;
+	__le32 consec_missed_beacons;
+	__le32 other_link_id;
+	__le32 consec_missed_beacons_other_link;
+} __packed; /* MISSED_BEACON_NTFY_API_S_VER_5 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
-- 
2.34.1


