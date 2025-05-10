Return-Path: <linux-wireless+bounces-22817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A857EAB2507
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FDA015A3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A8248F7E;
	Sat, 10 May 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ1+S7D5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E52836B1
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902929; cv=none; b=sqFI6RZ1yo8JLIm3cXkfZ1+jMGhI8ovd8RUl+dxuzCtkdEpLOsFA+FWjx8OrMJzMKMTZm53pWaa1hBAAaY1OiKzUrqwC1UljUZFKTQ2fkMRmGlsAKTIyJC5qoGKSnuHz9+T62GQMMB5cieaBxUFNlvDOk7NE1KkCLSIRrIYP7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902929; c=relaxed/simple;
	bh=VOP2B2jyaZCzX1MlNU6X9Qgepvc2BORkdoZKCaIlaf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJlfPY9yOWrWHJdAlFvLNb5oquqpChnZRnIMFwSebyXgVGOAgEGqjtSRkZCNJz8e3XNM3/Lhg0/IBNlDMgk8nxnBG7ytye537QANgVkvE2yZGvd+h7EyxxQTRtWACJp6iGThuwoIRW9NjCEHky+aT+uxDTlsf5NelwgItoBPA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ1+S7D5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902927; x=1778438927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VOP2B2jyaZCzX1MlNU6X9Qgepvc2BORkdoZKCaIlaf4=;
  b=oJ1+S7D5kDYte/AbK7IeMbIO+NSMsL6TSp4VZ86o6Lji2JPEc1lNl+Sa
   BH4V3ETYHs8v4X98crjWoqOfkh2V5IMn20oREKQx7nbwObfXr3lgCZXT4
   H5dgSiYeJD1nYW51N/Vaw8JCwRDtM7PUQrwUic13SHTXkrkHTExGT8CWq
   L1otJAoGRdnkLOce5axuxrzbwZN5vgRDGxon+i6Bdlm5rPBvbkZYvt0eQ
   cu9UxBT92j8fHQGN6bKClq7E7m3TvG/PlPz/T5LzbFgjybHcPeYuTSPQ/
   xiETeWXH6nJO0TpPMSxuBB4WSF80/ugJTDIvZPMgH1i2q5di32gCn59YV
   Q==;
X-CSE-ConnectionGUID: Kxyn0eWDSruJc9LFZHZ+6Q==
X-CSE-MsgGUID: 8QrXGKAhQRGzbTx9ssgt5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880879"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:47 -0700
X-CSE-ConnectionGUID: XF5hp6SITmWJpOShhK1u+g==
X-CSE-MsgGUID: YmH+RdBSTES8ARm5HifXGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033421"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: cfg: fix some device names
Date: Sat, 10 May 2025 21:48:16 +0300
Message-Id: <20250510214621.4f7bbd57680f.Ida19b5e696723db5839c13341d6ca7085e8c2568@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
References: <20250510184827.3800322-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Officially, the device names have dashes ("Wireless-N"),
so add them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index 74b8ca55fba2..f987ad3192c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -121,11 +121,11 @@ const char iwl7260_n_name[] = "Intel(R) Wireless N 7260";
 const char iwl3160_2ac_name[] = "Intel(R) Dual Band Wireless AC 3160";
 const char iwl3160_2n_name[] = "Intel(R) Dual Band Wireless N 3160";
 const char iwl3160_n_name[] = "Intel(R) Wireless N 3160";
-const char iwl3165_2ac_name[] = "Intel(R) Dual Band Wireless AC 3165";
-const char iwl3168_2ac_name[] = "Intel(R) Dual Band Wireless AC 3168";
-const char iwl7265_2ac_name[] = "Intel(R) Dual Band Wireless AC 7265";
-const char iwl7265_2n_name[] = "Intel(R) Dual Band Wireless N 7265";
-const char iwl7265_n_name[] = "Intel(R) Wireless N 7265";
+const char iwl3165_2ac_name[] = "Intel(R) Dual Band Wireless-AC 3165";
+const char iwl3168_2ac_name[] = "Intel(R) Dual Band Wireless-AC 3168";
+const char iwl7265_2ac_name[] = "Intel(R) Dual Band Wireless-AC 7265";
+const char iwl7265_2n_name[] = "Intel(R) Dual Band Wireless-N 7265";
+const char iwl7265_n_name[] = "Intel(R) Wireless-N 7265";
 
 const struct iwl_rf_cfg iwl7260_cfg = {
 	.fw_name_pre = IWL7260_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 7e2be10ff3ae..6bfc8e38296b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -99,11 +99,11 @@ const struct iwl_mac_cfg iwl8000_mac_cfg = {
 	.ucode_api_max = IWL8265_UCODE_API_MAX,				\
 	.ucode_api_min = IWL8265_UCODE_API_MIN				\
 
-const char iwl8260_2n_name[] = "Intel(R) Dual Band Wireless N 8260";
-const char iwl8260_2ac_name[] = "Intel(R) Dual Band Wireless AC 8260";
-const char iwl8265_2ac_name[] = "Intel(R) Dual Band Wireless AC 8265";
-const char iwl8275_2ac_name[] = "Intel(R) Dual Band Wireless AC 8275";
-const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless AC 4165";
+const char iwl8260_2n_name[] = "Intel(R) Dual Band Wireless-N 8260";
+const char iwl8260_2ac_name[] = "Intel(R) Dual Band Wireless-AC 8260";
+const char iwl8265_2ac_name[] = "Intel(R) Dual Band Wireless-AC 8265";
+const char iwl8275_2ac_name[] = "Intel(R) Dual Band Wireless-AC 8275";
+const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless-AC 4165";
 
 const struct iwl_rf_cfg iwl8260_cfg = {
 	.fw_name_pre = IWL8000_FW_PRE,
-- 
2.34.1


