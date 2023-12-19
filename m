Return-Path: <linux-wireless+bounces-1036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD6A819125
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DC8B22006
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E339AEE;
	Tue, 19 Dec 2023 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESYIwvnC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238839AD1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015988; x=1734551988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2f0ryeBFFBym9JnGSdsXdFejcXVWuFo4Dsq+OlljVAo=;
  b=ESYIwvnCTg5M+j/Ae41/zY10B2VVE/7Tfkqzx2K+ikyISuG7rjhr63Qk
   +kE2ISvERrBrBy/CW0mypqmBeGBDgYaaSm7X2uwwzuuLBRuQi6C9TpDCi
   uN6MCj8D11KIq1HyP7Kx02f/UbAWqJTS5p3L1MIjrSAKIUQLj8yPRIoKB
   O1Lr7h36C+d6qaTu7xH4pu5aV1b8drtXTiNgpznfGpZtkt5a1ty2vam15
   YQEouHpzh5nWcxJWxkN/htbHOM3Cbb9RzEfR6c7j4DFV6tiQCRw6x+/Vc
   Po7ANK6UzvF3uKLIjfG8J8TwFxSmgrLAGqfw9SoWZCcNzMAs+uHX/LO0X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694968"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694968"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589127"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589127"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/14] wifi: iwlwifi: Add rf_mapping of new wifi7 devices
Date: Tue, 19 Dec 2023 21:58:58 +0200
Message-Id: <20231219215605.a9c04b1e9d13.Ibf258d5e6370d8840a2560282988a1c26377c410@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add the CSR register details for new wifi7 devices and
correctly set rf_name for devices with FM and WP radios.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h         |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index a4df67ff21ba..4511d7fb2279 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -354,6 +354,8 @@ enum {
 #define CSR_HW_RF_ID_TYPE_GF		(0x0010D000)
 #define CSR_HW_RF_ID_TYPE_GF4		(0x0010E000)
 #define CSR_HW_RF_ID_TYPE_MS		(0x00111000)
+#define CSR_HW_RF_ID_TYPE_FM		(0x00112000)
+#define CSR_HW_RF_ID_TYPE_WP		(0x00113000)
 
 /* HW_RF CHIP STEP  */
 #define CSR_HW_RF_STEP(_val) (((_val) >> 8) & 0xF)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c9e5bda8f0b7..a4a4772330cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -290,6 +290,16 @@ static void iwl_pcie_get_rf_name(struct iwl_trans *trans)
 	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_MS):
 		pos = scnprintf(buf, buflen, "MS");
 		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_FM):
+		pos = scnprintf(buf, buflen, "FM");
+		break;
+	case CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_WP):
+		if (SILICON_Z_STEP ==
+		    CSR_HW_RFID_STEP(trans->hw_rf_id))
+			pos = scnprintf(buf, buflen, "WHTC");
+		else
+			pos = scnprintf(buf, buflen, "WH");
+		break;
 	default:
 		return;
 	}
-- 
2.34.1


