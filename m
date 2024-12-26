Return-Path: <linux-wireless+bounces-16811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE579FCBA5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942AF1883227
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AE13CFB6;
	Thu, 26 Dec 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GxjIW1W8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9551369BB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227922; cv=none; b=aFDT0EOjNc2gVp3IpRwS2hJNFlZcy2HjKzkAa5BWAGOXsz5pIAKq7Z5CxHJrfxgQlIx7CFnoRh+OEI6tEB7YB5KII++Mm9CPBg+KRNFGu6JvDQj0vhWpxDLwcKpPPu4JchEz3j/cFlNVtwj7NO6FEIsZeK2X0V5KxpgEGwwbN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227922; c=relaxed/simple;
	bh=6Oh5mSK/HC7vjz0hmssanSRC8MHqVTHjw9gigPqC3to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDcg34WN0f1Zeju+Dfr2/iZVn82NYAOjsReUg/vHTAcjUiFSKaPDxaBQGG/RSk2oIVpK6bNHwc7l8w1bR7/VnIVoviZKPZH+I9GjNYYAiUnvPJAGE5hTIXGUkIAfDOL1KlV6mQs6BOTmVmJXuuUcvTjVg5PS13S+yf6p+8eBqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GxjIW1W8; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227921; x=1766763921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Oh5mSK/HC7vjz0hmssanSRC8MHqVTHjw9gigPqC3to=;
  b=GxjIW1W8ZEAF8n7ByQkmevew8B/BYF5zRqR8/r1f8Xo1ntvXbEWSx42V
   MWjQ6Kf2mrOgFBVfhnLSsN1pnIw5gGp10WEEFxr7S2B75T2yk4Ys46wx3
   3K1eJNTwUn5G858LV8k5l5aGBxnEm41fgqUxctla48XAbxubchB7m2mXI
   O2dWbR4J1M6bMIa54ANoe3OwlGSe90towGm+MVHvQPkFOXNNLXebJWSl5
   pWivYwIbdQ//KHa2kHH6zanbnuITaMwJWir2h2H4wqzp6CLSmnwGNcpB/
   92nnBbRg7QVJbl5e2RI2xqZh/wb947lqC6XGsQd0U3llBDnsOfwgF2WBt
   A==;
X-CSE-ConnectionGUID: 9Yoyc7AIQeKpnAXDaG+hNg==
X-CSE-MsgGUID: obz63UyITsKz67dXUtPNaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878140"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878140"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:20 -0800
X-CSE-ConnectionGUID: 9aN6e9gJSyGy1ro+4lvctg==
X-CSE-MsgGUID: NxP2frzfTMen0qegCbOC1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777989"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/15] wifi: iwlwifi: bump FW API to 95 for BZ/SC devices
Date: Thu, 26 Dec 2024 17:44:47 +0200
Message-Id: <20241226174257.d5b73c1e9e17.I121e155b0c1fdfb7fbac934bb2f84fe0e1d13ba0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 95 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index cd1fe8490ae5..af6d3c85eb6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	94
+#define IWL_BZ_UCODE_API_MAX	95
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	92
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index fc5e6e44c6aa..4b92cd274765 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	94
+#define IWL_SC_UCODE_API_MAX	95
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	92
-- 
2.34.1


