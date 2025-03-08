Return-Path: <linux-wireless+bounces-20051-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD78A57E7E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9833B13C4
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A621FE45D;
	Sat,  8 Mar 2025 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSli9fKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3020F083
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468788; cv=none; b=ctg9Wwmn6abtW5YKTYCPT0Z5oUmQiKgDHpIeBvElkrtbUmkPLcCUF3oxhoGMq5N8xM8MtoAcVDXOD7kTzTgbOT8ZVTnesb3BNVIpNP9vzw2/qLqSo7xqLsXMEb/mSwP8iMAD2gWaWkUjvyiK6p0t5/ick2D0GzCcSGP1XuY9Xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468788; c=relaxed/simple;
	bh=v8eDgCLCD7qr1N7shvQbjm54WkW42fw+d5O30jsCbKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asJoNLFKdCuuXpYZIZ/mLch3hXMLgnBuLoqZNCQwrKIHLIbbmWuk3+xNcKDdFc/7BYskqvne15uLl2vBMlPcDrzQuQhmL80BeI9X1HThqnm2KbZ1Vu9Y7j6nk5r0H0EgzcVNssTYz/RPLNBr5JOySdEybzh5mk8PUOLkRDR9RKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSli9fKA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468787; x=1773004787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8eDgCLCD7qr1N7shvQbjm54WkW42fw+d5O30jsCbKQ=;
  b=cSli9fKAqJ5/0RaYa0z5UXaBpsvjTqH3MrpzVkrn50IeH2U6NtvNeyNu
   63lwOVecx8ggT+Hg/ynlHlB5gvKbXPZdPPH3JxTqJIbfwq0lyyyGolFVn
   JNd+3P3TVQ1kNtT883mNaTxEh1VSoD14YXqXt8rRmGpCZNoeq7ReRpczH
   xOt++fDv+bWhVDJAJ8RNgMfl8BVLE4fzh5iUVCDZPPv4Andl/vJMbTEqM
   Kcs3huXRdvPZQEHfwJak7DxjC22GeDMjG2dVcqDhadD/Kb/reJMvsRxFx
   5wmOfjuo93R53SNmImF9fRoG23cVo9zIfOYXhfSCgDBXWZ0ATk3ziUvpr
   g==;
X-CSE-ConnectionGUID: wE1BJ2yZSeCo5MrgRpqP8A==
X-CSE-MsgGUID: OejWjCasT/2LdqdR4LGrTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052373"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:47 -0800
X-CSE-ConnectionGUID: RWIqvk8oSwiQscq8Z9vy4w==
X-CSE-MsgGUID: CT0Ry5S+QFWRYU6u1VHhwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859919"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 06/14] wifi: iwlwifi: mark Br device not integrated
Date: Sat,  8 Mar 2025 23:19:17 +0200
Message-Id: <20250308231427.9bb69393fcc9.I197129383e5441c8139cbb0e810ae0b71198a37c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
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
index 69176b59b4de..48b487f6e366 100644
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


