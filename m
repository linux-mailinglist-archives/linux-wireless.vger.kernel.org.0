Return-Path: <linux-wireless+bounces-25048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D9AFDEFC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7283B1C26A36
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74711CAA85;
	Wed,  9 Jul 2025 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM7Zrxlg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E3D269AF3
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037356; cv=none; b=FkXWfu/ZLa3ivZwFlD5Zt4L+14pTDtI197HRCFBtkPoqFBAVEifdZbKSAA76rRGSBJqcbXdxvtSRekIpktCewb1lKlL3qoHsyctPftk1N4TQIzAvYiouDcQjKT7CLNzXCd0yRJVc4QRqV/K2rkxRbK8kUwG1LdcTzA1HyGBkRdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037356; c=relaxed/simple;
	bh=UlHi/ivh6rO6X6wFs3YLYAl/j8RDYdaEuIfGQUCb4Qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nn4bJ7mgbirs+/conlduEFmZG+cPQfAgeSstSk5ZoCG1L6zw0yNfJwnXQCL41XJzmBbmVtQVOWNKGpxYc4Vytl+mJ55msxT4VNKYi4qHIFsYy+4kdZxYIfjEV/lTbpBta6rtlSb56MGYuIyADM7fDft5NcWQ73LIOLap74wjUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM7Zrxlg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752037355; x=1783573355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlHi/ivh6rO6X6wFs3YLYAl/j8RDYdaEuIfGQUCb4Qk=;
  b=VM7ZrxlgPpUkxNGRN4n56ZAA214RSq9mwcOnHmPicLrjdrUeBhp97m7/
   put7UzpkkiUcYGs3ct5vySa5Du2HH7IcAMY2iTMwu5lXRRMuc15YFYxU1
   A2jQGA8d03pgsJHhVa/7TggERWhZGhudQmlnOslfQ0f7SaKgGSqh63NSE
   X6+1hD5Tc+WJJ7bPWn7MbNgsIwfrw/6lAzZvhzzekZPiGI656g2Rh6eKN
   NJQE58cKJuDM0qkkBLJ8k+NJB/jCOEuEdCBGCs/ZQr1FRQV7J63ZAaKgm
   fDzv38F9z9ieCIoWHzmylGU8epP2nxNfSdGBNDopb7vuWs0KLlW7BeYtz
   Q==;
X-CSE-ConnectionGUID: o3UaRBzxS9Kb4Ud6+a1KGA==
X-CSE-MsgGUID: oEQC5RF8SvmhZHsdNttmFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53501472"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53501472"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:35 -0700
X-CSE-ConnectionGUID: cUPpcKcxTsC0OUKURPqU2Q==
X-CSE-MsgGUID: QS3xT921Qou3bFYznsdquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192859263"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:02:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: pcie: accept new devices for MVM-only configs
Date: Wed,  9 Jul 2025 08:01:54 +0300
Message-Id: <20250709075928.a1e004f239b4.Ic05530048fc0b67b1cd8772882a595d56b204e65@changeid>
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


