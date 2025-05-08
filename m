Return-Path: <linux-wireless+bounces-22741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C678BAAF975
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490104A7436
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD13214A76;
	Thu,  8 May 2025 12:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlVDvGxx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAB35966
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706407; cv=none; b=fbTM9EGjB+7jDp1wPR47VlMpqZNevmLoEQdEjfc4Hbn/ACLjRufjHuNz7vZBHVWgFKixdvoeFxo6mLl1J2dlZvAQNknFKMTeJWLLEuDDW+Oq5LPSYGpPdt3Ie/p7MnGiSyvEvwt71OewbZU5aHtPqi5a1UGi1G9pjSgxAZ09pEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706407; c=relaxed/simple;
	bh=+Zr+56lDozNQtAzYOcP89mxEPOvA2j96GjWuqvsUzVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVncl+aEjQ/d0ZzORnyrJYrl1Vq4WCjdUVJDXzQxiUEOyqTlVaBqENt+KVnHCwSLhcFEzvggiImGZOZZpJOcqc99bG7BQrRRCCfliKfnHt/aEcBEkK/Zh0ERt2kq7GnEzhkHKxI/UdD1Mhx22TkrN6FCTRiqc+HMP82Yh7k3+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlVDvGxx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706406; x=1778242406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Zr+56lDozNQtAzYOcP89mxEPOvA2j96GjWuqvsUzVQ=;
  b=BlVDvGxxaRT/keBiRw3XJc6OajMvTQJUgt8R2daQRY+Gn77SY3q0ZGLX
   iDaocMksIVuGnwmTGD0N9tj9OmKGe4uqDK3/kmIbzaJQH6jZuy0B/qrNx
   GMtSDdE84Xj88aep8ti4auzGSrssE8M0pckyfCPec5z+rICI6ipS5O8VS
   Sk0AByImxSlTbz2bNV+zMX+xuFQeANWr5YaNSnC6ePMHcIPR7O+O84RX5
   Wix6YVFyMqEgZ5XKUEmn2tfCVSfGFQb63RGd8/QWUqJhIOSOnpYWYiWP1
   s+7xbxzEz+FR8VrsU+5hu1u65uMgfsWwfuoXovL3yo5vpNeDRwFFA3u3w
   Q==;
X-CSE-ConnectionGUID: KdWsD1GtRt+jTq1NiBOHhQ==
X-CSE-MsgGUID: Ikz3XYSKSyWiBLDT8LFIpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688035"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688035"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:26 -0700
X-CSE-ConnectionGUID: gjGTXLIGTLW2UDEgKb35gQ==
X-CSE-MsgGUID: lQwZSji1SiaUpKw52zscoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347790"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: cfg: remove 'cdb' value
Date: Thu,  8 May 2025 15:12:54 +0300
Message-Id: <20250508121306.1277801-4-miriam.rachel.korenblit@intel.com>
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

This is never used, so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250508151045.72a8053079d9.Ied2a3b9be71f8a21e158d255e6d8ea810a57e307@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 93bba87a234a..f978449af106 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -340,7 +340,6 @@ struct iwl_fw_mon_regs {
  * @smem_offset: offset from which the SMEM begins
  * @smem_len: the length of SMEM
  * @vht_mu_mimo_supported: VHT MU-MIMO support
- * @cdb: CDB support
  * @nvm_type: see &enum iwl_nvm_type
  * @d3_debug_data_base_addr: base address where D3 debug data is stored
  * @d3_debug_data_length: length of the D3 debug data
@@ -386,7 +385,6 @@ struct iwl_cfg {
 	    lp_xtal_workaround:1,
 	    apmg_not_supported:1,
 	    vht_mu_mimo_supported:1,
-	    cdb:1,
 	    dbgc_supported:1,
 	    uhb_supported:1;
 	u8 valid_tx_ant;
-- 
2.34.1


