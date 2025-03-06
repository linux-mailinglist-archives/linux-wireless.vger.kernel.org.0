Return-Path: <linux-wireless+bounces-19951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CA0A55955
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA63B22C1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADB27C874;
	Thu,  6 Mar 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjuh5ADm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C727C178
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298723; cv=none; b=q0F+2aggJreK+5YJ6H4gxv5b9Jh0xjVqcBCqK1fp5yk7sDm9BpYm8+IeimdJ2C9wX2ZEkwH7K13QFKKiJgjhaVmCvZlRQNaUHYQVnLermRIOloxxGofuaUgiRPPSLWryR/nWIo9L+grHfSsYglMGInpGReQh/VO8rnIfXT5yTDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298723; c=relaxed/simple;
	bh=bcd4UQWMKvC6bmrmjeZmoG55v00e9DSiCKaXv8YO56g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/0Pk2MfMmil3ZrXCahQAoY+s1kUFI89dlsdqGHJoDFg5gyoQuVx2PQ5bil55VaFpFLBIi7DUKhPTmlFGgMpSThcyeD1jVLDLL+jdGT2WjIz1Ha/vU6rdEg0T/0JUpnHvMmJgFEOPNLIefYDrlpEjKFbJPOz5YoaEfNCIohS98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjuh5ADm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298722; x=1772834722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bcd4UQWMKvC6bmrmjeZmoG55v00e9DSiCKaXv8YO56g=;
  b=hjuh5ADmGLyo3NEt7T25qqbbGoLUvfHqQjCP0UPAM3CmcjJ0+TubtD1Z
   c2OWHOZW3opyfHh8W/0UqMuie8CdCcS+pTqFbgoGpu+6d0fyYGxvKhBpX
   TMXt0xOpNmfDYkFbxqbpG7/NYOAshmFExSRdZKoGREkVPUcdJYwGc49GB
   Aaoz4MpK7n3rpDy3Tr6WJxPXP1/gHgugYl4fAYtSXUsw7cj3Gjosde5gD
   wcCQWGwaQ0l55jhvAr7pqZ+nZhv62gMAIzYyXmjbDhQzk4LlgOtOjE1qb
   w19N8WHydRwl927CP3iRIKkLpOhQ+YtBAbTBVzVbVWBFmhqlv8GzeIBHF
   g==;
X-CSE-ConnectionGUID: /Y3RGJKeSWOQragEv2ijuA==
X-CSE-MsgGUID: v+3W+3UlRJKbVpi6V9yE7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474265"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474265"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:19 -0800
X-CSE-ConnectionGUID: jn3srsK+QgKNkTLDEMsilg==
X-CSE-MsgGUID: +h/brc+wRryXM66CaSte1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061896"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 07/15] wifi: iwlwifi: mark Br device not integrated
Date: Fri,  7 Mar 2025 00:04:46 +0200
Message-Id: <20250307000213.22320378ddc2.I197129383e5441c8139cbb0e810ae0b71198a37c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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


