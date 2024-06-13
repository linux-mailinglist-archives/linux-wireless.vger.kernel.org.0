Return-Path: <linux-wireless+bounces-8967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C29067E7
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 10:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448AAB25364
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891813D285;
	Thu, 13 Jun 2024 08:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jie9CYPU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D7139D0B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268952; cv=none; b=NTr4q6thHxYF+vtzGewQLgT6P8/y76G/y06m520zuLC2MhPxZXvs4SCtNqMJ/QkEHoSOwe2i/4fXvkgjd7CCfwfVuJFxFhut8nZ6Xd0kdh54Rr1xCEyUIfXuzFo/kyK2IWpJDUM5TdXa88sFR6pGoxUJqz3Wn9cq49uIIHbAOKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268952; c=relaxed/simple;
	bh=g00td5Wc4rEEGdV4R/wXJAgrprdwOdfZb12x3iXtkWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2khQ2O9VH7GrOstFArL35uimh46fdnibtBM14XWEk+rtz4jAjcVR2+3M84n6Mpta7u1bdVQ9NCSaJol0EyVXEu6fZyLWC2EGFta7OeGpz6njVzrmf6PNRS+fqr0LNK5PL4/7O6l+jgSrpeqA1Dsqlr7rgUtlTHYsxFA1t03oTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jie9CYPU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718268950; x=1749804950;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g00td5Wc4rEEGdV4R/wXJAgrprdwOdfZb12x3iXtkWE=;
  b=Jie9CYPUsfeaH13aR8JVG+77rpKtPJcMw5vOi1UBqXSOWAwJFwmSYbLy
   knJKbdrkx4Md2FW/EbBuAV/CYN5fb3TVLj+0FwfL3lB04ycAUXXYMQ/TO
   YWwJ2Tn0ue24nK20zX5htX/LQi7B4iysbdcj4P5FqsNY47CVfQWF/mzb9
   sLhq4iljLlFcDKz59EWWfe4i/Lw18TEKBfmv2oajc5nQNZ1sSBhMgTXbI
   n5/nXAE1VFtcBKWN3y0qR0wiehubWwMXnShaF1fkf2npCDj8pL12J1Rgw
   lmXAGlHiJcdVz/ICrkL7QPmxmbAhuRd840IMEPuYUz5QzZ+BCmWvNI8V4
   A==;
X-CSE-ConnectionGUID: qftlwVySSZyp7IEVL52q9w==
X-CSE-MsgGUID: rK0jcr7KSC+fUDA7ECP3Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18001111"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18001111"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:55:50 -0700
X-CSE-ConnectionGUID: r3OZHGZ4Sda7kmJ2egzexg==
X-CSE-MsgGUID: a/o9ZafcQvGMjz+D7aOJMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44454215"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:55:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Golan Ben Ami <golan.ben.ami@intel.com>
Subject: [PATCH] wifi: iwlwifi: remove AX101, AX201 and AX203 support from  LNL
Date: Thu, 13 Jun 2024 11:55:33 +0300
Message-Id: <20240613115533.93cfbd8b325b.I989a2d3f1513211bc49ac8143ee4e9e341e1ee67@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Golan Ben Ami <golan.ben.ami@intel.com>

These devices will not be supported on LNL platfroms

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index d6da25e24818..9ad43464b702 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -503,7 +503,37 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2727, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272D, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x272b, PCI_ANY_ID, iwl_bz_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA840, PCI_ANY_ID, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0000, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0090, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0094, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0098, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x009C, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00C4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00E8, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x00EC, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0100, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0110, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0114, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0118, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x011C, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0310, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0314, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0510, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x0A10, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1671, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1672, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1771, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1772, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1791, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x1792, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4090, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40C4, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x40E0, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4110, iwl_bz_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA840, 0x4314, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x7740, PCI_ANY_ID, iwl_bz_trans_cfg)},
 	{IWL_PCI_DEVICE(0x4D40, PCI_ANY_ID, iwl_bz_trans_cfg)},
 
-- 
2.34.1


