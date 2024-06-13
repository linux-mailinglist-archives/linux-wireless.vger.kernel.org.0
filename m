Return-Path: <linux-wireless+bounces-8983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB79074C0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825131C23AE0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E1F1465A4;
	Thu, 13 Jun 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyJHTa73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EA146593
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287895; cv=none; b=dRbDvtOXe0v5iKraLL9W3XnRumCyS0qEZ1UM1IsZHhP2z+8+g3MYa8Td7YPzn5Iz8DyJcw6t19dc8iWhsNbMzKRW7e4N8PKlPZbLnDqh396Tw4yo5tDrjJcR4BgHATFuTpJ2JE8bgcE1r3JlGOZSQoOOK8T8wLHZwClxSA2UeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287895; c=relaxed/simple;
	bh=E6ZzhxVccCcmm9jAHO2CUeAxQNRNPaVsiUbn5N6SvtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4+TgmKoV2aacCXBl47/AcNXqUh5tiashVLMEKSSPhs5gq3CG9bBusRJa5gcw2MtkiR7hrk/m2PoTsIR+CDs6iY4Wxlnl/KliQPG155jifavUvKpESa9z9UxJ6SSez70MfM6wc69EfNsd32nNRzu2uHxJCNDIkoWLZNniEEyqX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyJHTa73; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718287894; x=1749823894;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E6ZzhxVccCcmm9jAHO2CUeAxQNRNPaVsiUbn5N6SvtQ=;
  b=hyJHTa737YZBe0edyG9D0rpZEYaMi/R2zC4sby5H/tGhE96cUUu0lJsa
   /TBZyPV8AexEr1ByVlTcfAK8m1XfUu3RyeRSmX0d42LW9qF7mdo5s4D7E
   4iPZjsozIAI5mmMbKlYmR47F2bhY8gCl5NejxPUSxOXUEvGQ0GAGdpqMf
   JOaArfF3OOITVl8S739OiT9Lpwh8BYDeub1A82+j7BvSWLMknhJqMrKvU
   vV118wistV/rZnBcju4eaX3ZyMjmCk6ZczonXV12i9j4X+FUGKrF8aDej
   MyE1d0aFi2OqIboSUJgfEFKv+F4t7WygeQDAEO7vDiUs1zOJxo5I52CWI
   w==;
X-CSE-ConnectionGUID: vq2GZ0L4RRSVHEYnDpeTeg==
X-CSE-MsgGUID: MEQzgn06QPu+xmTVeQOFKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15265915"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="15265915"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 07:11:33 -0700
X-CSE-ConnectionGUID: hx9YYEV3Qkm+AuolapMgHw==
X-CSE-MsgGUID: ovltZ8GuQ7+dwXgX2955WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="45065180"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 07:11:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Golan Ben Ami <golan.ben.ami@intel.com>
Subject: [PATCH v3] wifi: iwlwifi: remove AX101, AX201 and AX203 support from LNL
Date: Thu, 13 Jun 2024 17:11:23 +0300
Message-Id: <20240613171043.f24a228dfd96.I989a2d3f1513211bc49ac8143ee4e9e341e1ee67@changeid>
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

LNL is the codename for the upcoming Series 2 Core Ultra
processors designed by Intel. AX101, AX201 and AX203 devices are not
shiped on LNL, so don't support them.

Signed-off-by: Golan Ben Ami <golan.ben.ami@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
added commit message
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


