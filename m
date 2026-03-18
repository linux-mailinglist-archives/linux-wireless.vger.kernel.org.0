Return-Path: <linux-wireless+bounces-33439-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD1NIKMRu2nGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-33439-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:57:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CF2C2C1C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 21:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D223F31CA740
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928E2DB781;
	Wed, 18 Mar 2026 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+KFZZzq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D22371871
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867304; cv=none; b=RqYOEyWLP2SF1wbiXqp1XjRveFew5VGg0SGrGbYYb8aI6rnhCL7umyfEqEfuBWQEHx3qnvv6OlaKJwpgbR1nPVkmSsLmSfJ04Dc+03DedxT8Npa3A9j8A7eOk5Ii11aSFrrwdKuz63rf4ea5Z4rTgtG7U16ImbjT3hW2bbz0g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867304; c=relaxed/simple;
	bh=Vmb2edzJObxirpxCbJUAHJo5AU1vQnTUiP7C5meLdyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCcB7UKaNNHw3icVAdGJgfcpAokTsUw/j0GfETr9w9BYPE9Pymo3y2trIZhq7BeQMk3mwalPFfYq0roJbmOEPhGbuNlHVrcyNS+w7uESPtDGmpBcQ4ARWF2MnukE9mTNzOpBy+4JDbnqQBX5VDtODps2VvF7zyjzzutSg/vGJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+KFZZzq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773867303; x=1805403303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vmb2edzJObxirpxCbJUAHJo5AU1vQnTUiP7C5meLdyQ=;
  b=R+KFZZzqD7kY27dlYz22DXYru4xPuZHBQARkV9bKt7pT7iUnaPIJPiUb
   CfSXXLDk2X4sdyAea+L9YXv15MtjVqNnhyhAWLzEFdlVI9qlFlk6n7EJI
   DucdYf1WGKKSi4dlQDf25c89w7OD2hu1zfaEi4KB/lI9TTgx1rY6A6GaH
   i1I/cCLYRfLqUfUQ6lsXeG8d0IZu0eIaycpiQkn4cRIqIQ9FltGrzTviK
   4Us/l9EoKcns3JU9o/gw8ZUdhQSoKdLmGlLxWRI2Q8ZhxjHa7KIfGnNb6
   T7mnQM6UJytrqLJ/j5B/SFsXyyPpWnA4VGe1uBcUfME9IeH26bRhedpbm
   g==;
X-CSE-ConnectionGUID: PI2wnCALQaiKfa1Upixydw==
X-CSE-MsgGUID: jPw8DtnPTcSpe8qGhd/17w==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75010038"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75010038"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:55:03 -0700
X-CSE-ConnectionGUID: Sjnf9jPhQV+sJ5oJw2xTcg==
X-CSE-MsgGUID: nQ51xEejSmyHJtiZ7GEKxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222793965"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 13:55:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: acpi: add support for PPAG rev5
Date: Wed, 18 Mar 2026 22:54:30 +0200
Message-Id: <20260318225236.a5e7f805d0f2.I0e3ee3258b77b339234692ceccf0d25d1e6dd67e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
References: <20260318205430.614577-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33439-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 078CF2C2C1C
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


