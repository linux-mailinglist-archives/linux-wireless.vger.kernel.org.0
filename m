Return-Path: <linux-wireless+bounces-22753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C652AAF981
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60013BCA0B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559D22A7E2;
	Thu,  8 May 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckZtn2QI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F760225415
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706425; cv=none; b=EM09I/Bdug2L7cyZ9Z7DRySwyS/mV6mRU04zc9wOVUGIGgSc0RkMWIao3kS8DYXNcHMNtdzyy3hzKjwJ3V7ecLMH3rW6mDNfVY7IMHWdxTSwL/UJyO0G99smNNXOSEx9hnbk9grsBYj+9Zn1Qlnmf2HAdt4i728kNW8X9V19SYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706425; c=relaxed/simple;
	bh=TGv90qRhe2xFkVM+xKfpsgm8YgBP3zcdfnDb8M75qEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5XDJ/KpOf6d85MmIFH7Hohe3gvo3njRNZJe+UxrbfeZXXlKJrqHlsFUxnxhuF4b9Zon6pwwTbYpdA6gyt0ckOdetALPMFvw3qB7Qh4VNNIg2lmUsHVKBiCQI8V+jFFZMhxf9c+7tTrLQuMQcCqphg30OmlODcTkx0eHbt3OQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckZtn2QI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706424; x=1778242424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGv90qRhe2xFkVM+xKfpsgm8YgBP3zcdfnDb8M75qEM=;
  b=ckZtn2QIpc3+SteTmrzZRkKd4+xTGob2o4E+NSXuoGvt3kP2uFFAVIgm
   y2P+0OzmyZ03jfHPYomT8EIKinGvED269uH8MqPway1D0+fQR+isa1eKc
   jvrQOKFw9AK5WTw0GtaJoM3I1zk70xub9qYueA3T68zet4K9QFkMI/FTF
   AK+OnwXKVVDQhS6IPtdkInQcqigq7vQ+dt3ZAuRQQ7xU9UaXtr79S3jMt
   aWp/sOu9dzCV4t37lf2VLNJ8P70Ctecwxr1BTaoJbbtFEga09jkR5gVbx
   tS4ZuRTzN6mw7oCZviQKVgbTG9bJ0TPI6wM+2fXhFWA1PM/1LxPoTetnr
   g==;
X-CSE-ConnectionGUID: K9KaymWHR7qnPTxfZzW93w==
X-CSE-MsgGUID: mRcw2mt2Qr2iWNZzffMEcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688059"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:43 -0700
X-CSE-ConnectionGUID: sdz7NEYiSwGzfgvLkuQOqA==
X-CSE-MsgGUID: aDz26KOQQRKQqXUM8XSfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347898"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: remove unused high_temp from iwl_cfg
Date: Thu,  8 May 2025 15:13:06 +0300
Message-Id: <20250508121306.1277801-16-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
References: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This value is never read, so it's not needed. Remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.7ad912c81934.If378122dcee1a3d919340a69207242a65f04081b@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c   | 1 -
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index c2c8e81904f2..4b50a02b1cc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -151,7 +151,6 @@ const struct iwl_cfg iwl7260_high_temp_cfg = {
 		.ht40_bands = BIT(NL80211_BAND_2GHZ) | BIT(NL80211_BAND_5GHZ),
 	},
 	.nvm_ver = IWL7260_NVM_VERSION,
-	.high_temp = true,
 	.host_interrupt_operation_mode = true,
 	.lp_xtal_workaround = true,
 	.dccm_len = IWL7260_DCCM_LEN,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index c99b18b0ef7f..b5cfaad6a037 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -359,7 +359,6 @@ struct iwl_mac_cfg {
  * @rx_with_siso_diversity: 1x1 device with rx antenna diversity
  * @tx_with_siso_diversity: 1x1 device with tx antenna diversity
  * @internal_wimax_coex: internal wifi/wimax combo device
- * @high_temp: Is this NIC is designated to be in high temperature.
  * @host_interrupt_operation_mode: device needs host interrupt operation
  *	mode set
  * @pwr_tx_backoffs: translation table between power limits and backoffs
@@ -400,7 +399,6 @@ struct iwl_cfg {
 	    tx_with_siso_diversity:1,
 	    internal_wimax_coex:1,
 	    host_interrupt_operation_mode:1,
-	    high_temp:1,
 	    lp_xtal_workaround:1,
 	    vht_mu_mimo_supported:1,
 	    uhb_supported:1;
-- 
2.34.1


