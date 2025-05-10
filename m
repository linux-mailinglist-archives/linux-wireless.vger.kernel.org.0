Return-Path: <linux-wireless+bounces-22827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C839AB2511
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 20:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B53A01584
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065E1283FC3;
	Sat, 10 May 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbRwGARy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B5283C89
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902941; cv=none; b=FK3kEUlDv8x+3p+o0YfWnb1Jqp3Pi2w48M/Ns6AwniFB3blpyxANyODzRP4j8H4ihMfGNmX4IoFmy63fgNm/YY6R11uAZzomfRLTym8aBc2ARgXz0606zssuoORSfYJ1bCRWnEPQxzZ81DXd323MkE7LzPgNr62J2nHIxMEvyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902941; c=relaxed/simple;
	bh=VIKCIIjiSF5Paa75EVq312uKqkAtTxQFzTepWpWh0KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDbNSlvKqFTNZjHfAT10Pmu1KtZEMVX05Fs75LD93UA4Rov/eKw9Lil1/Ti7imIZZkOLWjgVR/M2E7+nYwGquOVBEkcWiPT66nCPF0VYUXapW6qRHksb89kP7jMWzZrmMHWzRMDlE02qS5qAVedDgJQTj2cj4xLwE1UapjiKXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TbRwGARy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746902941; x=1778438941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VIKCIIjiSF5Paa75EVq312uKqkAtTxQFzTepWpWh0KM=;
  b=TbRwGARy+dkVpFLDXCPwrUZysGL1aNlGqRgb2WgDeZiGkJRKDomo7JGl
   Gqw7DJg+BBPfkA1JKA6YyPCM6EaYVF3UjnenGlJyNVd8+nXjwYD1474pu
   djRtsbFT5xsBqSLINXXi0+l0jyfhpedEgZ3cCnF6NImNdyQMjFBfkLg1I
   o2j/vvBlz55l6xDMN+dt+7dCgnbkZ7QhV9t2g/b+sbJU7j9jU5BAPfV/T
   3f40wziJk2jLMwgX1LQLsbeEJ+rUP3K7+rNE87pR8ox+hj+ywGy39ZaRR
   yTw3UIA2xQz6rWw58NMj5ObhPbHEWahFqXvLQCmiHqJnORw68blyqc3d9
   g==;
X-CSE-ConnectionGUID: JL/7jRbZR96SQczFCpYVQg==
X-CSE-MsgGUID: 7aKWHZ7dTVGE6O+Anmh+yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11429"; a="48880894"
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="48880894"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:49:00 -0700
X-CSE-ConnectionGUID: ++NECIuYSRWbOYRA43Mmzw==
X-CSE-MsgGUID: pGQCOXVMStqm3dzZecLmQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,278,1739865600"; 
   d="scan'208";a="142033459"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 11:48:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: cfg: add a couple of older devices
Date: Sat, 10 May 2025 21:48:26 +0300
Message-Id: <20250510214621.ca03a90c294e.I04d64964c664d49ab16760d754968f09c607f36a@changeid>
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

There are some devices that are misidentified, such as 7265-N
and Killer 1435 variants. Add their names, and for some of them
also add the PCI IDs to match at all.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  5 +++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 36 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 6bfc8e38296b..b56574006ee0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -105,6 +105,11 @@ const char iwl8265_2ac_name[] = "Intel(R) Dual Band Wireless-AC 8265";
 const char iwl8275_2ac_name[] = "Intel(R) Dual Band Wireless-AC 8275";
 const char iwl4165_2ac_name[] = "Intel(R) Dual Band Wireless-AC 4165";
 
+const char iwl_killer_1435i_name[] =
+	"Killer(R) Wireless-AC 1435i Wireless Network Adapter (8265D2W)";
+const char iwl_killer_1434_kix_name[] =
+	"Killer(R) Wireless-AC 1435-KIX Wireless Network Adapter (8265NGW)";
+
 const struct iwl_rf_cfg iwl8260_cfg = {
 	.fw_name_pre = IWL8000_FW_PRE,
 	IWL_DEVICE_8260,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 5b3229304616..b1caa7205850 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -598,6 +598,8 @@ extern const char iwl8260_2ac_name[];
 extern const char iwl8265_2ac_name[];
 extern const char iwl8275_2ac_name[];
 extern const char iwl4165_2ac_name[];
+extern const char iwl_killer_1435i_name[];
+extern const char iwl_killer_1434_kix_name[];
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e2f9b1dea58f..39d46b83b5da 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -434,6 +434,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24F3, 0x0930, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24F3, 0x0000, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24F3, 0x4010, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xC030, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24F3, 0xD030, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24FD, 0x0010, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24FD, 0x0110, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24FD, 0x1110, iwl8000_mac_cfg)},
@@ -461,6 +463,8 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24FD, 0x0012, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24FD, 0x0014, iwl8000_mac_cfg)},
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1431, iwl8000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x24FD, 0x1432, iwl8000_mac_cfg)},
 
 /* 9000 Series */
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_mac_cfg)},
@@ -920,21 +924,49 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x095A), SUBDEV(0x5020)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x502A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5090)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5190)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5100)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5400)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095A), SUBDEV(0x5420)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5490)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5C10)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x5590)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x9000)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x900A)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095A), SUBDEV(0x9400)),
 
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2ac_name,
 		     DEVICE(0x095B)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095B), SUBDEV(0x520A)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
 		     DEVICE(0x095B), SUBDEV(0x5302)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
 		     DEVICE(0x095B), SUBDEV(0x5200)),
 	IWL_DEV_INFO(iwl7265_cfg, iwl7265_n_name,
 		     DEVICE(0x095B), SUBDEV(0x5202)),
+	IWL_DEV_INFO(iwl7265_cfg, iwl7265_2n_name,
+		     DEVICE(0x095B), SUBDEV(0x9200)),
 
 /* 8000 Series */
 	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2ac_name,
 		     DEVICE(0x24F3)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
+		     DEVICE(0x24F3), SUBDEV(0x0004)),
+	IWL_DEV_INFO(iwl8260_cfg, iwl8260_2n_name,
+		     DEVICE(0x24F3), SUBDEV(0x0044)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8265_2ac_name,
 		     DEVICE(0x24FD)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
@@ -945,6 +977,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x24FD), SUBDEV(0x1012)),
 	IWL_DEV_INFO(iwl8265_cfg, iwl8275_2ac_name,
 		     DEVICE(0x24FD), SUBDEV(0x0012)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl_killer_1435i_name,
+		     DEVICE(0x24FD), SUBDEV(0x1431)),
+	IWL_DEV_INFO(iwl8265_cfg, iwl_killer_1434_kix_name,
+		     DEVICE(0x24FD), SUBDEV(0x1432)),
 
 /* JF1 RF */
 	IWL_DEV_INFO(iwl_rf_jf, iwl9461_160_name,
-- 
2.34.1


