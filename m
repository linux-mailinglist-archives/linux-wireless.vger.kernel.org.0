Return-Path: <linux-wireless+bounces-26724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7626BB39466
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC6683471
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A302C236D;
	Thu, 28 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpsGQPgO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571072C2354
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756364164; cv=none; b=QkrfSWilVpxq6JKlVl8Gzd9TX8BzTQA7IZnWWB6ukOxsE4poIvB3drSpuihsqXbqJpCTe8lYxb8P93sAd2isU6ilVtGb6lA7aZtbQt9xAJ8Z2PmjIP5r86uXYoSqsNIQFcJmifGdbP6UAHTnoo0wr8do53FDtyEWU/0yhYCiRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756364164; c=relaxed/simple;
	bh=h1k0XcPaiBPx5sqc4eyvkVNUt3CmHCrZ+H53GwsB42A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnJj0W53gbuv5W4tFtq+ImpDWsYM2HqBS+ulCdnDhPKqpLhxs8bqbQCPaZrlrM+TJ9dorb4KNKM0LRf0HR04DJqBpQpLeGPznvf9tjnj2vNIWNmgi3jBcLPLdIvbZB2unh++jYAp6bKUdn3pkm1+U72GKbr2P981MXUJM6VT7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpsGQPgO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756364162; x=1787900162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1k0XcPaiBPx5sqc4eyvkVNUt3CmHCrZ+H53GwsB42A=;
  b=lpsGQPgOm43Cf7/yVEDsv/NZI5/vEbA9EFstJV6Am3NgYW2gBL4EVr98
   oDl3BuchKX1AsTMJ7Y5fMXJV14fHSdsyIGmRM6XBrRuteIMAtgNnn1Zha
   tOEZnpAnZDVw8Ndh7v7IypKE/X6kG6YoHIrZABei34N/7eHlQc7hm6hkt
   Osok4S/WEEj2iLoD6cQ2H7/O8pH0IzegyuM0B7I0xAIaX1Sv8NOLz0Tnk
   yMWaFKM/BmtLBYLJukY1SSzxQL/13avrfX4M47YfTRGdyjZcBk/ZvzEQl
   vuNAasexsiWqko7LJhyXtLKKGlfbzVZ/f7gRJr257u6dUke1vqXjTIIts
   Q==;
X-CSE-ConnectionGUID: dJVsmW6nTsCS81rEFlTDIg==
X-CSE-MsgGUID: 5bvIg8f6TGWRDCiH5XA6Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58723687"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58723687"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:02 -0700
X-CSE-ConnectionGUID: 1D4FKt1FRTyhlvTy53UTfA==
X-CSE-MsgGUID: wOK/gLjqSHCIfXSrDLBvJw==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 23:56:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-fixes 4/6] wifi: iwlwifi: cfg: restore some 1000 series configs
Date: Thu, 28 Aug 2025 09:55:29 +0300
Message-Id: <20250828095500.fabb99c2df9e.If0ad87bf9ab360da5f613e879fd416c17c544733@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
References: <20250828095500.0f203e559242.I59eff718cb5fda575db41081a1a389f7af488717@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the fixed commit, I inadvertently removed two configurations
while combining the 0x0083/0x0084 device IDs. Replace the fixed
matches for the BG versions by a masked match and add the BGN
version back with a similar masked match.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220477
Fixes: 1fb053d9876f ("wifi: iwlwifi: cfg: remove unnecessary configs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 46d8c1922292..f5e72c90dd57 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -729,10 +729,10 @@ VISIBLE_IF_IWLWIFI_KUNIT const struct iwl_dev_info iwl_dev_info_table[] = {
 		     DEVICE(0x0083), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
 		     DEVICE(0x0083), SUBDEV_MASKED(0x6, 0xF)),
+	IWL_DEV_INFO(iwl1000_bgn_cfg, iwl1000_bgn_name,
+		     DEVICE(0x0084), SUBDEV_MASKED(0x5, 0xF)),
 	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1216)),
-	IWL_DEV_INFO(iwl1000_bg_cfg, iwl1000_bg_name,
-		     DEVICE(0x0084), SUBDEV(0x1316)),
+		     DEVICE(0x0084), SUBDEV_MASKED(0x6, 0xF)),
 
 /* 100 Series WiFi */
 	IWL_DEV_INFO(iwl100_bgn_cfg, iwl100_bgn_name,
-- 
2.34.1


