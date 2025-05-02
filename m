Return-Path: <linux-wireless+bounces-22332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB6AA7198
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB8E17006D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16631254B09;
	Fri,  2 May 2025 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KLXYUFNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AA248F46
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188455; cv=none; b=q2AqSGKfHtSssYUTamdv7nTS60r+QlFIoA0JIwSeQ+HxqdbVgcgbk+FlEp7P1pzi6nh1SCY3GBhsOzuOzPAw5w53+eB4vWrbbJgNrd/6tvaCJp20+V0QTtpe6CyGjZ6C3beNoJiubIwRLGE+/B8liduu23ajTB6cq6S7jHMAc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188455; c=relaxed/simple;
	bh=MeJaNDkyFmwa+r4hySyQHJn+Xq9f7+ZrtFyGiC2+5xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZeJ/tI6w1bWP9VYdKUIZTzdpTjrDKy+renl89YI2HTvJi7UzublvEx5KPDVAhXPlsdurFow4RIq52fjUJu+J0Z1hROcElQMlcyDG4hoTKNHVSP3AP3m/F1tXKvygJZQFKAgKKeSvk5nXHrqdw5614p3CH/lNrA9wylXGD/bvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KLXYUFNS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188453; x=1777724453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MeJaNDkyFmwa+r4hySyQHJn+Xq9f7+ZrtFyGiC2+5xA=;
  b=KLXYUFNSNPf9E002u+CWB09Mr4wbcjvjelduorm7zyDBFtKOF0BFHtEw
   SsWeUMGDlj1msYrNRrKyVz08bxTzdj8jRrzsmt0VEL81Yf+Sb/ztFmIZd
   E+xZsAOR6dwQjRiE3mryS/7VWGq57Jp1YzyGCXc4wK344AShO9iz5Aqwv
   BdSnGRkNv1P8TlCgIlM4oVWGYPgYSKEBR2+FF3w+PGilrRG0pCkiFSYPB
   s2Rs98ZSGVKu5rwIYY5YAYWmWSNhGJufNAAwm15w3+vpqbAxB+kgI1eK1
   icYb5ZrXyyLHQvhgMLXgguGlIkToUi4u6pUWJRYa0lroZPxOBGFnryCP1
   A==;
X-CSE-ConnectionGUID: 0hFrWyO4SG2UnS/nNyuOcg==
X-CSE-MsgGUID: VawmeKIlRGi6Z98mVQlR+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010359"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010359"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:53 -0700
X-CSE-ConnectionGUID: dih59rYoRQ2P0ZojKDTuzA==
X-CSE-MsgGUID: KYfjPmHbQdqNJ/CS/0dNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586118"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: pcie: add entry for Killer AX1650i on AdL-P
Date: Fri,  2 May 2025 15:20:21 +0300
Message-Id: <20250502151751.483214386aa4.Iad4d2041bfe544875fe9f5c051e23a765f862786@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

On AdL-P, we're missing an entry for the Killer(R) Wi-Fi 6
AX1650i 160 MHz adapter. Add an entry to fix that.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219114
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6e06a7b4223c..6852a2214936 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1046,6 +1046,9 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     RF_TYPE(HR1), BW_LIMIT(80), NO_CDB),
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_name, MAC_TYPE(SO),
 		     RF_TYPE(HR2), BW_NO_LIMIT, NO_CDB),
+	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax201_killer_1650i_name,
+		     DEVICE(0x51f0), SUBDEV(0x1652),
+		     MAC_TYPE(SO), RF_TYPE(HR2)),
 
 /* So-F with Hr */
 	IWL_DEV_INFO(iwl_cfg_so_a0_hr_a0, iwl_ax203_name, MAC_TYPE(SOF),
-- 
2.34.1


