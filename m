Return-Path: <linux-wireless+bounces-8117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A98D07F1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2401C22481
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF5155CB0;
	Mon, 27 May 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQyyYzR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129115A878
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825991; cv=none; b=jPuHW/Z1i6J7rk2YS4yrB1N6ASkYxHiMS/DU89WO/777S076On+4m0Of3fSfgkdQ1Li189SX053STapDnWkpDsCmzZlTZ1EYm3sRY/l8ezobkr+mJSEL/R4MKJ27/lByuw1qZsjhb1R7B6Mra43boqU6z1Xj4rSgEbSOPwwgsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825991; c=relaxed/simple;
	bh=qRWX54XhMdkVAtp/3yAqaKPnnYCSfsB09HLipgk7kTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRR2SWn99754FOMMBFckWzpl0LIhEXK74apv3BotV/0QmLNgrfcn+NCgKEAadRRfFpo8Ibk0HXYJthGO2a4wcewJaxLZYMhF+s5AwHSgO69tBvyde68YMibTDI1uRzbta6OK3T0Lbo1HZ11TVsCKbKDznu2A1+S5AnIQcixw5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQyyYzR5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825990; x=1748361990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRWX54XhMdkVAtp/3yAqaKPnnYCSfsB09HLipgk7kTE=;
  b=cQyyYzR5pPaT+L0QEEjCh6LsVJJtvl7K7AWoq8Gt5Ss/RRZn3ozy+Wx7
   RDgLCC7k8ngedQH5dkhz6dLTC9KtWliEZFmviuGrvKnoWGMyuoBwPRTxP
   yWK8mEDS9GDaiSvqAe8hlUgebOBo9Kj2NO4jg975F7RJFOH3LNQqa4xGQ
   t62uSMlCSoOGUdA1fAdKomkZE8MBHqY40ey3N4Ykgh2gpzigbRDryT/rM
   YKMrRuGzsXExsFaYxMfYHtGzruz+Kmwp5AsaAyjDgVQOzVAjYrWIx1+Gi
   nyRglQpi7RIGln7jWhw68KDT+k6sONxzgLWwVIlzXQUMaQRhf+J7C02bT
   A==;
X-CSE-ConnectionGUID: Falo3/2XTsSXv2u9NhJw/Q==
X-CSE-MsgGUID: U8XrU6BfQFSTH9cr5Ao6QQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002073"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:29 -0700
X-CSE-ConnectionGUID: dvmyVwfvQcKAR8V6cKkJww==
X-CSE-MsgGUID: Q6Ot/b+oQP+AJMrGumkMmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407076"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avri Altman <avri.altman@intel.com>, Grumbach@web.codeaurora.org,
	Emmanuel <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/20] wifi: iwlwifi: mvm: Enable p2p low latency
Date: Mon, 27 May 2024 19:05:58 +0300
Message-Id: <20240527190228.21b431bdfc26.I018e330d1e6a76e967b25e9542c2260f0f6ed2a8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avri Altman <avri.altman@intel.com>

Enable p2p low latency by default.

Signed-off-by: Avri Altman <avri.altman@intel.com>
Reviewed-by: Grumbach, Emmanuel <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 3cbeaddf4358..eda6634b4fb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -23,7 +23,7 @@
 #define IWL_MVM_WOWLAN_PS_RX_DATA_TIMEOUT	(10 * USEC_PER_MSEC)
 #define IWL_MVM_SHORT_PS_TX_DATA_TIMEOUT	(2 * 1024) /* defined in TU */
 #define IWL_MVM_SHORT_PS_RX_DATA_TIMEOUT	(40 * 1024) /* defined in TU */
-#define IWL_MVM_P2P_LOWLATENCY_PS_ENABLE	0
+#define IWL_MVM_P2P_LOWLATENCY_PS_ENABLE	1
 #define IWL_MVM_UAPSD_RX_DATA_TIMEOUT		(50 * USEC_PER_MSEC)
 #define IWL_MVM_UAPSD_TX_DATA_TIMEOUT		(50 * USEC_PER_MSEC)
 #define IWL_MVM_UAPSD_QUEUES		(IEEE80211_WMM_IE_STA_QOSINFO_AC_VO |\
-- 
2.34.1


