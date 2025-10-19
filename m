Return-Path: <linux-wireless+bounces-28069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36499BEE110
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E12E4E98B5
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266B2367CF;
	Sun, 19 Oct 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RpGwx+CE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2B11713
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863552; cv=none; b=XmxQaIZSPyChXq3b74kX4jy8K1yQV+5Hh849l8QSM7P8GSrqZRb4Xp/B7pMcTDNBBKuYSHHUq12NZykB/XF2FMs4QHKNL/UQtrt/tvzRfAWIqUXuoZtVhnp9V0aRI+EUEVD8NK6WD7XBqBQiASXBjRbC+D8h7hkLsoIPXEvlY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863552; c=relaxed/simple;
	bh=0LW0MGedfENYNJ8ORp8Qi8UCGZ040FUbnr01IC8zsDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwV10+g8OlRXAq7ESUaJQlq28cA62BHI19dqwfZdUiuVprs5rkVku/iuyocOv9hKVCvYf97PhgDCrOYLyH/H2Gy2MESDKLKXkWWLqi0bez3qe3XqTpjykio3C0q9i1vF8RPv8a7sgX43NcP4hDPdbEGC8sNXB5G0O5VFO6u8mmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RpGwx+CE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863551; x=1792399551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0LW0MGedfENYNJ8ORp8Qi8UCGZ040FUbnr01IC8zsDM=;
  b=RpGwx+CE85Yp0UY6oBI+SlBn0TTzh/IbuGNTCIeQ/vcF/M1x6TFwIuDd
   loDmxIHgIjcCdn2mxl8wXX2i2Pp4D6fUkw3gIkuXp7YgBOh9qWwhO6JN9
   IvSeOnw7Vgu8ai3atCtl9hVmunDE90prq8Z/PXWI8gKsP72DJNdJ7+a8P
   bgLowzIg/GN6X54Z/FDJ1VFIpfe4ixUC21aaM6nP44NsdcdnZTmmJo8xz
   LS47VIb2RoK8pc1cRs/1Kr7zqow8j5pJp9hg9E+YIXaYZpsj4OqxahQqA
   PtiSxJMNn/HQt6zUsHwGeK9lkqQkFnZn+VPgv8syD/wnxZwva6zo+ugby
   Q==;
X-CSE-ConnectionGUID: VaogVj14RF2cSdw2/pUY0g==
X-CSE-MsgGUID: AMNUfBNiRHqLia9d3A3VIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363195"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:50 -0700
X-CSE-ConnectionGUID: MEizpUFYTqi4EBmjkgZqfA==
X-CSE-MsgGUID: nUFV8nDaQFWLu4x7ZozgfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279912"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: cfg: fix a few device names
Date: Sun, 19 Oct 2025 11:45:15 +0300
Message-Id: <20251019114304.2ad0f42ffb57.I2c7864d33f0d7d3dc49381949571c4ce620a9723@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are going to be some devices called BN203 instead of
BN201, adjust the names accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 7 ++++---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
index 483f21659eff..408b9850bd10 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c
@@ -12,5 +12,6 @@ const char iwl_killer_bn1850i_name[] =
 	"Killer(R) Wi-Fi 8 BN1850i 320MHz Wireless Network Adapter (BN201.NGW)";
 
 const char iwl_bn201_name[] = "Intel(R) Wi-Fi 8 BN201";
+const char iwl_bn203_name[] = "Intel(R) Wi-Fi 8 BN203";
 const char iwl_be221_name[] = "Intel(R) Wi-Fi 7 BE221";
 const char iwl_be223_name[] = "Intel(R) Wi-Fi 7 BE223";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0a5a683325ef..076810ee5d34 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -686,6 +686,7 @@ extern const char iwl_be211_name[];
 extern const char iwl_killer_bn1850w2_name[];
 extern const char iwl_killer_bn1850i_name[];
 extern const char iwl_bn201_name[];
+extern const char iwl_bn203_name[];
 extern const char iwl_be221_name[];
 extern const char iwl_be223_name[];
 extern const char iwl_ax221_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ab132eb84096..f81be5420e4e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1061,9 +1061,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* PE RF */
 	IWL_DEV_INFO(iwl_rf_pe, iwl_bn201_name, RF_TYPE(PE)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE), SUBDEV(0x0524)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE), SUBDEV(0x4524)),
-	IWL_DEV_INFO(iwl_rf_pe, iwl_be221_name, RF_TYPE(PE), SUBDEV(0x0324)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE),
+		     SUBDEV_MASKED(0x0524, 0xFFF)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_bn203_name, RF_TYPE(PE),
+		     SUBDEV_MASKED(0x0324, 0xFFF)),
 
 /* Killer */
 	IWL_DEV_INFO(iwl_rf_wh, iwl_killer_be1775s_name, SUBDEV(0x1776)),
-- 
2.34.1


