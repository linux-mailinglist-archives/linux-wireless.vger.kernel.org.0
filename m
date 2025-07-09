Return-Path: <linux-wireless+bounces-25119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7760AFF2AC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE055A515C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0990A25A342;
	Wed,  9 Jul 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR8C0AQF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2472586EF
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091576; cv=none; b=R5raNcphMpSbj6mPuB4GqpX2wwdySQpzVCjclclU4Q+rKFdr4m7n0658DbG6f9DEQaBPCZ6CKjp6xwwVXqXIIxObBAp6dxu/Qw2rbof9tVIeVo2LhScL3lUWfdcxUmGj/qLoQIuUY6ZBzHlUyjBbReXVuZL8Qu3AVtZtIfiVV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091576; c=relaxed/simple;
	bh=UlHi/ivh6rO6X6wFs3YLYAl/j8RDYdaEuIfGQUCb4Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XQdggJH9qFoCFHS3nqhoPAR5cS3/6/g4tshT5aKhz2AwzIeoHgolC5qndsuOo1Th6tKlXDXifEMoxaWUST84W1wB+nc69ufBALE/BhSNCAyOQdkuptgHTqbcbn1AckJKEY7gzC3TjEguN/Z4N1tePIFA57SBR9OuymjRjQ1KL0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR8C0AQF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091575; x=1783627575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlHi/ivh6rO6X6wFs3YLYAl/j8RDYdaEuIfGQUCb4Qk=;
  b=dR8C0AQFU9DN0XUwdBjlL+VJmxsiihUcwvOswRWpgN/c4z9/MVmKRNvO
   pGYeLBw3ccHlOrEw9ApIvHJwL0wAxeX+6+xIKhFy6ZQhZBlcEhBADGoHD
   BP5gcTD4xoM6Rs4IB8z9+RR/LE7y+XxCm4FXDqwVje4UJyd4uvRUTCTN0
   MQwYWfon5e7a0kKo0t3IuOon9ueNdVFJc4KZkYyj4hTztL3ylcyNBAG6v
   AEFzv4KBxlQsuzbAqdUAQisAg8yXdc1IKzLqhF4cOPIjRlDakN8sCs610
   hofxinUAZ6cgCr89pRr/KZ8l8xj6F46c8eMElwnLebuBRFW3Ffgo/g5qR
   g==;
X-CSE-ConnectionGUID: /M2tNrMATz+bTdPMMEA9hQ==
X-CSE-MsgGUID: 2U/E1Rh5RdKcTl7y5si5Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240314"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240314"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:15 -0700
X-CSE-ConnectionGUID: HtISAGDYT5uErCZXtyRHBQ==
X-CSE-MsgGUID: XTW0yJ/TQHSyO6I9WMCyzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160126067"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: pcie: accept new devices for MVM-only configs
Date: Wed,  9 Jul 2025 23:05:38 +0300
Message-Id: <20250709230308.483c8112f655.Ic05530048fc0b67b1cd8772882a595d56b204e65@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

For newer MACs, the MVM opmode may be used for older firmware images
or when the RF isn't EHT/WiFi7 capable. List such devices in the PCI
device list when MLD isn't built.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/Makefile   | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/Makefile b/drivers/net/wireless/intel/iwlwifi/Makefile
index b82392978b76..941257b811b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/Makefile
@@ -22,6 +22,7 @@ iwlwifi-$(CONFIG_IWLMVM) += cfg/7000.o cfg/8000.o
 # MAC configurations
 iwlwifi-$(CONFIG_IWLMVM) += cfg/9000.o cfg/22000.o
 iwlwifi-$(CONFIG_IWLMVM) += cfg/ax210.o
+iwlwifi-$(CONFIG_IWLMVM) += cfg/bz.o cfg/sc.o
 iwlwifi-$(CONFIG_IWLMLD) += cfg/bz.o cfg/sc.o cfg/dr.o
 # RF configurations
 iwlwifi-$(CONFIG_IWLMVM) += cfg/rf-jf.o cfg/rf-hr.o cfg/rf-gf.o
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 0bd9b44d295b..b7add05f7a85 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -501,7 +501,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2729, PCI_ANY_ID, iwl_ma_mac_cfg)},
 	{IWL_PCI_DEVICE(0x7E40, PCI_ANY_ID, iwl_ma_mac_cfg)},
 #endif /* CONFIG_IWLMVM */
-#if IS_ENABLED(CONFIG_IWLMLD)
+#if IS_ENABLED(CONFIG_IWLMVM) || IS_ENABLED(CONFIG_IWLMLD)
 /* Bz devices */
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_gl_mac_cfg)},
 	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_mac_cfg)},
@@ -546,7 +546,7 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xD340, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0x6E70, PCI_ANY_ID, iwl_sc_mac_cfg)},
 	{IWL_PCI_DEVICE(0xD240, PCI_ANY_ID, iwl_sc_mac_cfg)},
-#endif /* CONFIG_IWLMLD */
+#endif /* CONFIG_IWLMVM || CONFIG_IWLMLD */
 
 	{0}
 };
-- 
2.34.1


