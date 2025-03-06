Return-Path: <linux-wireless+bounces-19901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E4A54A09
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17CB3B0F59
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE120B7F4;
	Thu,  6 Mar 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbyaM/DE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880F1EDA1F
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261762; cv=none; b=LUrb9pka5fecTYIqPFuNUoBEpzlR152FTT5kfcz+7yZsx6rDKiEj7rKzjpbpyhrHXNwW0MBuLewD41/4j62bWHAigQ4C4MNZk27eW9gAV7PDS7QEpxkLdSXvSOZZQOHdPd5NP9iADUuz0GRDJsH0yHfo7FetPdChEV0/RKfJAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261762; c=relaxed/simple;
	bh=bcd4UQWMKvC6bmrmjeZmoG55v00e9DSiCKaXv8YO56g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0AEH4vhw9EmKDx0rWha+0QrGu9MZXn4+pZVr6tuhwWHarH7L4GkgwZZkrv1Mmx/WxPk0QJRg2uxAMX6LzGsDJkGtFmnjVVUVIbTVlkgBALCBCqdx9nCdn8Gy5eFCYoWZcOP66xcaom1N04XDOnMeWRBuF41h0TUQw02ZNiedDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbyaM/DE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261762; x=1772797762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcd4UQWMKvC6bmrmjeZmoG55v00e9DSiCKaXv8YO56g=;
  b=CbyaM/DEyRyDLQx/CtJo6wpewa9KvqaHwo/1yvww8y+vG4SSmXTPNEs9
   sLjvSIgtRq5Wcp9XvjCrN8zdxVMzYGnR8WO5w8bajii18u6yEBfVBllqL
   EQ+e2xuxw6efjY1joGS6lqR+VkNW0DJ2WXAAM1K40d4iJfIg+sgkh1vvt
   QukNGLQMqxuZxURfCZ+FUsI4wREzzpRNgzWnhCk86E1pgvOnQHMUK8G3T
   vjBowZ8iWWyfEee1CaY6yKGUwUcBWVYd7tXR3IXTa0lIdiXvGupkh5ia8
   b7um1VVztZ8AfiT462jOQ19oGi4xlakSoWSiI95p65ufurgupyaLo22xu
   w==;
X-CSE-ConnectionGUID: upO8kwCTQUqM7uimU4xkzg==
X-CSE-MsgGUID: bijYXTipS8+2vBt3Qk0qow==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474530"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474530"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:22 -0800
X-CSE-ConnectionGUID: fbgROyBUSTe3RLQzicVA2g==
X-CSE-MsgGUID: z7/JX8vjST6vJGAPtuEiVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915562"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:19 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/19] wifi: iwlwifi: mark Br device not integrated
Date: Thu,  6 Mar 2025 13:48:44 +0200
Message-Id: <20250306134559.0a9c43f2f74d.I197129383e5441c8139cbb0e810ae0b71198a37c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is a discrete device, don't mark it as integrated.
This also means we cannot set the LTR delay.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index e58fe8210988..09df9037c91d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -148,11 +148,9 @@ const struct iwl_cfg_trans_params iwl_br_trans_cfg = {
 	.mq_rx_supported = true,
 	.rf_id = true,
 	.gen2 = true,
-	.integrated = true,
 	.umac_prph_offset = 0x300000,
 	.xtal_latency = 12000,
 	.low_latency_xtal = true,
-	.ltr_delay = IWL_CFG_TRANS_LTR_DELAY_2500US,
 };
 
 const char iwl_br_name[] = "Intel(R) TBD Br device";
-- 
2.34.1


