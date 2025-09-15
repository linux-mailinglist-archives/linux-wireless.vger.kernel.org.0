Return-Path: <linux-wireless+bounces-27318-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA4B5730C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13395164445
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC7D2F067E;
	Mon, 15 Sep 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZCadZLV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39832D5C7A
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925310; cv=none; b=V2codGEg84TNdgJavfH9j2+5aH2OCgrtXk6mkK5CQei0pdVbw96BjJN/LavMFyabvGGOkYUPv8Kclw/X5dfAMsT0ehOyVEGb1IusJSnHKDERIlLtY80aZ7EmXB9ATT+YnHuCx8Q/vBMdHV04iODGgMTJ5p/n3vqr7KlxPxtFjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925310; c=relaxed/simple;
	bh=7m8ryZLhrbspo3tB8bhQGfqWLN7cxCAMKrFyJsNgSpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyvPvwhu1lwaAIH7BMYpay/88hF43ahB4Xl8bBCXypOidebE+vVAd6Dnrquteul4ilvThZyCC2giRAuEUiJg7C3SNRjNe4F9jWJL9lV7zN4nsBQr6CwFGwYF6AqsQvLnLGwMKm3gWB5KBTBKzOs02EFm1eBaAIbkj5mYDT0tlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZCadZLV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757925309; x=1789461309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7m8ryZLhrbspo3tB8bhQGfqWLN7cxCAMKrFyJsNgSpU=;
  b=JZCadZLVBmyhbi37jQ5fxrndavK7T88MNZ5I6iFRqtgMXBFkaQ3TMrBv
   K04cyM+K6ilQc30pTbjWI3VqRaCeHpd7CAoc2WfUIceszsV55kAl9JzMn
   yKq5/gdmefgmaXhDWwSgApUtUVXphRshzSnbaKjZyMpivWMLBwKATTIzR
   5YuYRSh7FOmDYZ9ryjIKFQe3DCoSbYFDK+veZZd+ndtZdgXR5bqBSIjCW
   j0nFniAJkye9KuQhRttDh4H/sFSlAfbIE7Ribwc4o0MmSBpkkVwgQYE1+
   Oix70bNJiOW03LTRUL+u0Inb8moTHaf4ancDvL4ZWgwJnYG+wYMUw96tJ
   A==;
X-CSE-ConnectionGUID: g/z5CuXYTYq5YO6mS1bTuQ==
X-CSE-MsgGUID: 1LucfSnJSEWJtUUftaPW0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213078"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="59213078"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:09 -0700
X-CSE-ConnectionGUID: ReV/WvolQmiYP3B03WJXbA==
X-CSE-MsgGUID: Y2Zi9S00QRSE6wMT5Wjlog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="178569887"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 01:35:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/11] wifi: iwlwifi: cfg: add new device names
Date: Mon, 15 Sep 2025 11:34:27 +0300
Message-Id: <20250915113137.1cbc0251532f.I6183a6a08a7998e598042a50c7d7a6b82f9fa58e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
References: <20250915083432.1048608-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a couple of device names so that these new devices will
be shown correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c  | 1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
index 97735175cb0e..b8c6b06e7099 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/rf-wh.c
@@ -13,3 +13,4 @@ const char iwl_killer_be1775i_name[] =
 
 const char iwl_be211_name[] = "Intel(R) Wi-Fi 7 BE211 320MHz";
 const char iwl_be213_name[] = "Intel(R) Wi-Fi 7 BE213 160MHz";
+const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a607e7ab914b..cfd1629f0016 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -688,6 +688,7 @@ extern const char iwl_killer_bn1850i_name[];
 extern const char iwl_bn201_name[];
 extern const char iwl_be221_name[];
 extern const char iwl_be223_name[];
+extern const char iwl_ax221_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_rf_cfg iwl5300_agn_cfg;
 extern const struct iwl_rf_cfg iwl5350_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e68dce21df64..af5faf49f4ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1053,11 +1053,14 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* WH RF */
 	IWL_DEV_INFO(iwl_rf_wh, iwl_be211_name, RF_TYPE(WH)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_ax221_name, RF_TYPE(WH), SUBDEV(0x0514)),
+	IWL_DEV_INFO(iwl_rf_wh, iwl_ax221_name, RF_TYPE(WH), SUBDEV(0x4514)),
 	IWL_DEV_INFO(iwl_rf_wh_160mhz, iwl_be213_name, RF_TYPE(WH), BW_LIMITED),
 
 /* PE RF */
 	IWL_DEV_INFO(iwl_rf_pe, iwl_bn201_name, RF_TYPE(PE)),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE), SUBDEV(0x0524)),
+	IWL_DEV_INFO(iwl_rf_pe, iwl_be223_name, RF_TYPE(PE), SUBDEV(0x4524)),
 	IWL_DEV_INFO(iwl_rf_pe, iwl_be221_name, RF_TYPE(PE), SUBDEV(0x0324)),
 
 /* Killer */
-- 
2.34.1


