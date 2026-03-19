Return-Path: <linux-wireless+bounces-33478-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ONkKhC+u2n1ngIAu9opvQ
	(envelope-from <linux-wireless+bounces-33478-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:12:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D712C86BE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90D40300CA26
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721CA3B4EBB;
	Thu, 19 Mar 2026 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fzygPUqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A173B0AF9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911404; cv=none; b=SvhFwJQMwE3V7Aoyth8PQ+li6ZSQe11OpJ08Gm+1j4tH7ofeFgX03OiN3oaLrjaghEJaysdo9QruEaBxTJGoWOBblkE/AVbrk/hwIQxbjt0EcwmQv7VwXI1C0MBLEeSWsvs2+YYnPPYtlsUskIP6Qx9WYm0FMm4/Q3hruMPdVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911404; c=relaxed/simple;
	bh=Vmb2edzJObxirpxCbJUAHJo5AU1vQnTUiP7C5meLdyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMVlNo5xj4turNug0bT+r9YglGm+LfgGiPWgktF8kLHSJ+aBWONNONqSPDAUHzSNjH0URquvtALRXB7nyAs6o8crU6fnaHotxh/Nh91quu42i2pBz1fEOWNTnNS9DoUCb3bxpncHwBt5D2hB2dikqT/n1/I9Kf1Od3KuCtMns7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fzygPUqK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911401; x=1805447401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vmb2edzJObxirpxCbJUAHJo5AU1vQnTUiP7C5meLdyQ=;
  b=fzygPUqKkLnp2Q9YDVx8gJgMhXaFnJJOn4ArofA5mgLi7FVNKxPWuQ76
   RYarxHzNMc9QQPmhOr5FzAGMgKxmnD/QzCdjTMSEZhMh3RF46xQkkN74Y
   R6kDChW8xpNn4WAmQhorbhDHdL9XEGqpriDQ/gpUHD5HtCcMhEWLJ9orJ
   FggFDjWCLxe3E+xd+1NvOF6qcqLM9bKhtUf05qCsq+eyuFZG2OBxeCvVh
   mEqJa68FN8YIrKWSUVZBDmZdULblHUtQz8qDH9ADg6uCz+Z9daSn8uy/+
   gI6IwSahv4yQfmMJgmSWD893eq7vVidxXqPneDOhlUOmFcLZCxeRCweBy
   g==;
X-CSE-ConnectionGUID: fnT/lEfzS1mKi+fz3iKjUw==
X-CSE-MsgGUID: UAJEsPPTSDGi6AYOU0aXkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="73992750"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="73992750"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:59 -0700
X-CSE-ConnectionGUID: CGFHVCYsQOSFY1VYyoDytw==
X-CSE-MsgGUID: 7/OeSq/6QcKDM6Kd4quEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="218387167"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:09:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 15/15] wifi: iwlwifi: acpi: add support for PPAG rev5
Date: Thu, 19 Mar 2026 11:09:27 +0200
Message-Id: <20260319110722.a5e7f805d0f2.I0e3ee3258b77b339234692ceccf0d25d1e6dd67e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
References: <20260319090927.1090112-1-miriam.rachel.korenblit@intel.com>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33478-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 54D712C86BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This adds support for UNII9 which requires to add a subband.
Just increase the number of subbands that we need to read.

Replace the usage of the IWL_NUM_SUB_BANDS_VX macros in acpi.h since
those macros are defined in the firmware API and ACPI declarations have
nothing to do the firmware API.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 16 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h | 16 +++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index de30799519cd..4d0a93832336 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -916,6 +916,22 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* try to read ppag table rev 5 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_PPAG_WIFI_DATA_SIZE_V3, &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev == 5) {
+			num_sub_bands = IWL_NUM_SUB_BANDS_V3;
+			IWL_DEBUG_RADIO(fwrt,
+					"Reading PPAG table (tbl_rev=%d)\n",
+					tbl_rev);
+			goto read_table;
+		} else {
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	/* try to read ppag table rev 1 to 4 (all have the same data size) */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
 				ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index c34dc17ff608..138fdb9a5273 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -8,11 +8,6 @@
 
 #include <linux/acpi.h>
 #include "fw/regulatory.h"
-#include "fw/api/commands.h"
-#include "fw/api/power.h"
-#include "fw/api/phy.h"
-#include "fw/api/nvm-reg.h"
-#include "fw/api/config.h"
 #include "fw/img.h"
 #include "iwl-trans.h"
 
@@ -97,10 +92,17 @@
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + IWL_WTAS_BLACK_LIST_MAX)
 
 #define ACPI_PPAG_NUM_CHAINS		2
+#define ACPI_PPAG_NUM_BANDS_V1		5
+#define ACPI_PPAG_NUM_BANDS_V2		11
+#define ACPI_PPAG_NUM_BANDS_V3		12
 #define ACPI_PPAG_WIFI_DATA_SIZE_V1	((ACPI_PPAG_NUM_CHAINS * \
-					  IWL_NUM_SUB_BANDS_V1) + 2)
+					  ACPI_PPAG_NUM_BANDS_V1) + 2)
 #define ACPI_PPAG_WIFI_DATA_SIZE_V2	((ACPI_PPAG_NUM_CHAINS * \
-					  IWL_NUM_SUB_BANDS_V2) + 2)
+					  ACPI_PPAG_NUM_BANDS_V2) + 2)
+
+/* used for ACPI PPAG table rev 5 */
+#define ACPI_PPAG_WIFI_DATA_SIZE_V3	((ACPI_PPAG_NUM_CHAINS * \
+					  ACPI_PPAG_NUM_BANDS_V3) + 2)
 
 #define IWL_SAR_ENABLE_MSK		BIT(0)
 #define IWL_REDUCE_POWER_FLAGS_POS	1
-- 
2.34.1


