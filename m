Return-Path: <linux-wireless+bounces-11141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027DD94C5A2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340371C21827
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566C15AADB;
	Thu,  8 Aug 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipCqdcRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BA15665D
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148592; cv=none; b=iz9WY8yra0nPFceC43iTEcrhqQKyOrBRZWzl1hoeIlH1Ao+0SYlKOgMQJT5EAnamcOvTggPNhwl02C5TMd470TA76O7hzEHGxzx53EUh2aScQzQhPu1wzht/k8zt4732gz7R3sAGqNuRvJZln05/cEpbQqJlDu/LxfUGASPjXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148592; c=relaxed/simple;
	bh=NBBjc7lk+ro6kzFamUvUJqvpQbhIXkJwB3vd8ZCylC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HW/FzYF6/4DAm482fOGXzYuWpsyLDIVF69RzW3hKHOwnMX5sf5coT/0m7v/rwGtJDTr3S3M8lCtaR3bsvhLUK4uKh+wBWnNLPnnMWR+lhuqO/0pMlI82LWcav9wkW4ilVh+5L1YAkZq+fnFY8d7uNDw+Ua9+je508tnd66RArqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipCqdcRm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148591; x=1754684591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBBjc7lk+ro6kzFamUvUJqvpQbhIXkJwB3vd8ZCylC8=;
  b=ipCqdcRmLXJOKmbeFQnFEgW6ph2ZCFIuwYC0H9IU2Nxjy32HnVpKzD6c
   1XODb/cYRHvl9GuZKky5Jv+y8bVeCNOO9BkGK4Qr1qdr5v70MkOUbHNVy
   Q0HPIslwAzb3SGNXf46h7sBs7O9JiIXLsMt3xeCyCah8+v/fFpshJgxxF
   if5e3O/nmL05wFmq5y7Qgu2I1+jE9eoedXRFcC/DR1NE1DWp0l/NQ+1dI
   SuK0SscnXbQn6CZktJtNZEtAyKNh6dtrwhO58O6+QuZJg4kSYCWEkFaMD
   LfCqnQp5MdfnWP/5oO9+KXqsHV39TK9GxqKMZ0d+JjdGPYsGZBWnw3bqh
   g==;
X-CSE-ConnectionGUID: QObh33+/SaKnno0rBF/uRA==
X-CSE-MsgGUID: 0nibRcyBQhK/U7hvvzwv3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808845"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808845"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:10 -0700
X-CSE-ConnectionGUID: JW3vb02EQM+VtdUEq2BV1A==
X-CSE-MsgGUID: 5eiC5wFuSNa9tTgDs+MlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305305"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 06/13] wifi: iwlwifi: mvm: add API for EML OMN frame failure
Date: Thu,  8 Aug 2024 23:22:42 +0300
Message-Id: <20240808232017.0c6bc216ef8c.Ida85d2062734a569e1af35f47d14cc5bb4bf893e@changeid>
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

When the firmware fails to send EML OMN frames, it notifies the host and
the host need to take proper action.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 5fc7967df6c5..6a2c5bed357e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -65,6 +65,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @MISSED_BEACONS_NOTIF: &struct iwl_missed_beacons_notif
 	 */
 	MISSED_BEACONS_NOTIF = 0xF6,
+	/**
+	 * @EMLSR_TRANS_FAIL_NOTIF: &struct iwl_esr_trans_fail_notif
+	 */
+	EMLSR_TRANS_FAIL_NOTIF = 0xF7,
 	/**
 	 * @ROC_NOTIF: &struct iwl_roc_notif
 	 */
@@ -690,4 +694,30 @@ struct iwl_missed_beacons_notif {
 	__le32 consec_missed_beacons_other_link;
 } __packed; /* MISSED_BEACON_NTFY_API_S_VER_5 */
 
+/*
+ * enum iwl_esr_trans_fail_code: to be used to parse the notif below
+ *
+ * @ESR_TRANS_FAILED_TX_STATUS_ERROR: failed to TX EML OMN frame
+ * @ESR_TRANSITION_FAILED_TX_TIMEOUT: timeout on the EML OMN frame
+ * @ESR_TRANSITION_FAILED_BEACONS_NOT_HEARD: can't get a beacon on the new link
+ */
+enum iwl_esr_trans_fail_code {
+	ESR_TRANS_FAILED_TX_STATUS_ERROR,
+	ESR_TRANSITION_FAILED_TX_TIMEOUT,
+	ESR_TRANSITION_FAILED_BEACONS_NOT_HEARD,
+};
+
+/**
+ * struct iwl_esr_trans_fail_notif - FW reports a failure in EMLSR transition
+ *
+ * @link_id: the link_id that was activated / de-activated
+ * @activation: true if the link was activated, false otherwise
+ * @err_code: see &enum iwl_esr_trans_fail_code
+ */
+struct iwl_esr_trans_fail_notif {
+	__le32 link_id;
+	__le32 activation;
+	__le32 err_code;
+} __packed; /* ESR_TRANSITION_FAILED_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
-- 
2.34.1


