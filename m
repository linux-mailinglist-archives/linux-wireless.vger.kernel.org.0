Return-Path: <linux-wireless+bounces-27154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F61B4A801
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57DB1C61497
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F1629B8F8;
	Tue,  9 Sep 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFUVy3sy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F2285C9F;
	Tue,  9 Sep 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409485; cv=none; b=uAlA5W+2hvW9QiMH56rW2D3wbiDOc3aEW0f5P5P+mUm8jLL7/hAQAEIzpnBVAgZ/6UfgOmTFA4z/2MnW4uhPEI1u879FHUuEcBPK5iRkFbGwsK3CFWy0+hvPOz94BgZlnUmKhBH0nBAEePho/bFxRDaXgqIuSckRx5AXne2yxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409485; c=relaxed/simple;
	bh=CU91bXNdN1IkMGBsQW0jgZTzv5C9aSTraFaZ1oVTurw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ODaQqU5XZr0t6+kkz4MeyjJ1GcADdqrLFVq/eYAhHMm3OFGsWd5B774QPr1/Tp0W5cMoH+ripwo4tbfL01I3QBgPMPK6bS/O5nQdYwKCW1KWJOKDfq9nJaeh3eKUOP3Z4Le7Y9+zwGp7ERKUx9C+9uk8v7R4lsnHpyiNvLhXsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFUVy3sy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757409484; x=1788945484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CU91bXNdN1IkMGBsQW0jgZTzv5C9aSTraFaZ1oVTurw=;
  b=nFUVy3syc6J8rwt1QFSaOXsjNOqf/uIN0M8ZWZLuWGnTqoLolc9J/UDK
   apBHYi4bjoiRFCdfm8joM+BD/FBWwlcwHJmzqiYO0CGP2qjyterpJFoi9
   EsKEm0CItT9jL0tpDtkjbDCbxKT5PIv8stih8Z2axxRXEfTXIJHO7foPw
   Bqe2W6YbRSSBa5gnHb+rH7IG/Zfn5VMO7kuP2zVsb+MKVF/d9RU9Xz0Af
   4UnwMY4VdAxvqmR7aZZUgg8M4sXh7R68zout7d4jDy3Lfwr+obF/ZeYe8
   3DeYM4wWWQ5J/4fag+VXIYAzIanHynFQ01PZGaI0A4tVhYzL4/OJeKlEG
   w==;
X-CSE-ConnectionGUID: zsdNWLaZRlmt45WVzRf2Bw==
X-CSE-MsgGUID: ZajDO/wRR9+cxG3JQBj8IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="71104159"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="71104159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:18:03 -0700
X-CSE-ConnectionGUID: ORwDCc2cQDujUSNWKpusxg==
X-CSE-MsgGUID: WJDu20uDQGO2TqRCPRtObQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="173500726"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 02:18:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwlwifi-fixes] wifi: iwlwifi: fix 130/1030 configs
Date: Tue,  9 Sep 2025 12:17:34 +0300
Message-Id: <20250909121728.8e4911f12528.I3aa7194012a4b584fbd5ddaa3a77e483280f1de4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The 130/1030 devices are really derivatives of 6030,
with some small differences not pertaining to the MAC,
so they must use the 6030 MAC config.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220472
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220517
Fixes: 35ac275ebe0c ("wifi: iwlwifi: cfg: finish config split")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f9e2095d6490..7e56e4ff7642 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -124,13 +124,13 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x0082, 0x1304, iwl6005_mac_cfg)},/* low 5GHz active */
 	{IWL_PCI_DEVICE(0x0082, 0x1305, iwl6005_mac_cfg)},/* high 5GHz active */
 
-/* 6x30 Series */
-	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl1000_mac_cfg)},
+/* 1030/6x30 Series */
+	{IWL_PCI_DEVICE(0x008A, 0x5305, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5307, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5325, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008A, 0x5327, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5315, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x008B, 0x5317, iwl6030_mac_cfg)},
 	{IWL_PCI_DEVICE(0x0090, 0x5211, iwl6030_mac_cfg)},
 	{IWL_PCI_DEVICE(0x0090, 0x5215, iwl6030_mac_cfg)},
 	{IWL_PCI_DEVICE(0x0090, 0x5216, iwl6030_mac_cfg)},
@@ -181,12 +181,12 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x08AE, 0x1027, iwl1000_mac_cfg)},
 
 /* 130 Series WiFi */
-	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl1000_mac_cfg)},
-	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl1000_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5005, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5007, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5015, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0897, 0x5017, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5025, iwl6030_mac_cfg)},
+	{IWL_PCI_DEVICE(0x0896, 0x5027, iwl6030_mac_cfg)},
 
 /* 2x00 Series */
 	{IWL_PCI_DEVICE(0x0890, 0x4022, iwl2000_mac_cfg)},
-- 
2.34.1


