Return-Path: <linux-wireless+bounces-30651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7DD0F85C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84AC9305CA25
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124B34BA24;
	Sun, 11 Jan 2026 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebFw4nuH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3434CFD8
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153180; cv=none; b=s/u4DlnGbOf0uHA8E5pvpzuv6S+bMl62tUBB7Loq5rpd9CzkBFdp+YBBxdvWVchfzrT9TF9WILy6bIvK96Aqxfh8nDsGx7B0wf6ME9R0lWIiuTrFe+vY4dA0ZUR2+qu2u/+b4vKsrii+odTj5tR8kUAn2V4ZJ5tx87QgL+IhRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153180; c=relaxed/simple;
	bh=ljjdVk66vpTOXdgjqcinQ0sVo3wPGwJoWHBGO8gtz7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4/abfMaZkfAjpVKH6/DUifSWT1vlVWdOx/A3PCWI53v9uc6uyb24dVntM1LiImFTBWRjdzdQQEpYKKBzlPYdJT7MTDNnKF8VKW74JFf/4DpMg3g5kTJlCe2nkhCyZyyKrdKOEmvfuxBi0xJog42wVoJNetCt2/aaW07X9RlnVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebFw4nuH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153178; x=1799689178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljjdVk66vpTOXdgjqcinQ0sVo3wPGwJoWHBGO8gtz7Y=;
  b=ebFw4nuHEZK7+TU9OzZDhVMH991BpGDSMlY0LIiZjUSe8X8mP8cG+mm2
   +XqrKgmJpLh5dEF5VUet7FqkX00NtiOmNXu3DoAJnXGulTifDHk+wAjMm
   zb6QCSI6MjPiniX3PFs6yN08iPs9L6QT6RP+5utJLibbwjau5DpxhzBZy
   d56V1vPta/CFkxBS4chcIVm5N/nj3agDoR5XJ3PswDK7tkmApFWW9lNBL
   8d1zK+Mwc2cIVTiNk5heUemEyNHcJAmyha9kEViZpVhhKLOKkvLXEF6Z2
   Gfrpy1J38AJb+NSJq0+9Dllpq833hidxrezwzInljG3IV4GewcT8YFPaC
   g==;
X-CSE-ConnectionGUID: NsnZGsqlS0Ktr+VMEsU/0A==
X-CSE-MsgGUID: 9Sbn/1IMQBi3/UlA3BWdrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521083"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521083"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:38 -0800
X-CSE-ConnectionGUID: vQFeZpQFSpu/c7GneBpuaw==
X-CSE-MsgGUID: JZabXe9KQfOmQmBRwBno+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393778"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: cfg: remove iwl_be221_name
Date: Sun, 11 Jan 2026 19:39:13 +0200
Message-Id: <20260111193638.360ca699c9d6.I26ceddc2916e134ff50ea8550e44935f287b063c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is unused, no devices with such a name exist,
so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c  | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
index 408b9850bd10..2c29054ce7b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -13,5 +13,4 @@ const char iwl_killer_bn1850i_name[] =
 
 const char iwl_bn201_name[] = "Intel(R) Wi-Fi 8 BN201";
 const char iwl_bn203_name[] = "Intel(R) Wi-Fi 8 BN203";
-const char iwl_be221_name[] = "Intel(R) Wi-Fi 7 BE221";
 const char iwl_be223_name[] = "Intel(R) Wi-Fi 7 BE223";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 076810ee5d34..45cf2bc68e41 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -687,7 +687,6 @@ extern const char iwl_killer_bn1850w2_name[];
 extern const char iwl_killer_bn1850i_name[];
 extern const char iwl_bn201_name[];
 extern const char iwl_bn203_name[];
-extern const char iwl_be221_name[];
 extern const char iwl_be223_name[];
 extern const char iwl_ax221_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
-- 
2.34.1


