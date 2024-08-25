Return-Path: <linux-wireless+bounces-11917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739195E44D
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4206B21084
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AA01684A5;
	Sun, 25 Aug 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo3HEi6k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850171714B2
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602662; cv=none; b=l7EYRaWtN+tlEsekG/SWgXCGDwoye41l3xP6zfvYsBmRNehgo6HXzajluaUDHqmIECKfRTJolCJpOGOhY67DlK0K/s7bTEnI5DB7tyluaMzJZrPAxWUYLtHdayQ1ykploEb4g/dOKgOkJqJgXCH+glwn4wEGU5WHebe2xgTAIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602662; c=relaxed/simple;
	bh=dukzQzawHxZkgtSzm9gPMQY9ZXrl7MkzY+TNt63181s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7CfFa8t/lYJwdRj8+QJHlgCnHCqjdnGEhbd5DWIXbMOJwMiQTvBVRWm08sI+1Ukztk8EE9+fteKnpTKrysRhbraVmpJMWwpwmRV8jaVAiC//7FFD7mbdM58j0XLqJMXl7ff1I5VXdCL1OvZ2eSl5z8fbKrx2Ua2DFaqcSRVAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo3HEi6k; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602661; x=1756138661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dukzQzawHxZkgtSzm9gPMQY9ZXrl7MkzY+TNt63181s=;
  b=Xo3HEi6krH6ONf+jWDhKBLRqX+g0hqw5wehBrtWHv1OMv35/+A5Xd4sW
   748g6vqFfKaePlKSPLqgR1PJQNgYGFzILbcbfYgA2eHTwZPt23aKo0Hzy
   hFCGS21ScBFv2C86ElHemf+ZHMo/GXp35HDQI6P+tw+75J1wvcgGQLL+H
   1R/NKfN3HYkJHtmxh/oUytiWSRDkbnFNv+2ueo13EqaRuhlMDv3EXKXmc
   nunKsNQuSZw2zNeAyVYScRPm6NdQQQpB4/T1udUwIKzurBaWIj0EseLh6
   P409zejGXaW8I66bANxNvmrj/RgnPg6Bn6yc50UrT5hOG61XyvMpAD2zx
   Q==;
X-CSE-ConnectionGUID: VllcbxGsS3igOMdnFckBhQ==
X-CSE-MsgGUID: ihVo1UwiT1ifMWLA40xpug==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544143"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544143"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:41 -0700
X-CSE-ConnectionGUID: y2iDyjkWRRyTf99HIflZ2w==
X-CSE-MsgGUID: ZVuGyhhzRqCOys9KtFEVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999772"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 12/13] wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan
Date: Sun, 25 Aug 2024 19:17:12 +0300
Message-Id: <20240825191257.04807f8213b2.Idd09d4366df92a74853649c1a520b7f0f752d1ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

MLO internal scan may include 6 GHz channels. Since the 6 GHz scan
indication is not set, the channel flags are set incorrectly, which
leads to a firmware assert.
Since the MLO scan may include 6 GHz and non 6 GHz channels in one
request, add support for non-PSC 6 GHz channels (PSC channels are
already supported) when the 6 GHz indication is not set.

Fixes: 38b3998dfba3 ("wifi: iwlwifi: mvm: Introduce internal MLO passive scan")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index bae6aec8295c..1cc9c426bb15 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1659,6 +1659,17 @@ iwl_mvm_umac_scan_cfg_channels_v7(struct iwl_mvm *mvm,
 		cfg->v2.channel_num = channels[i]->hw_value;
 		if (cfg80211_channel_is_psc(channels[i]))
 			cfg->flags = 0;
+
+		if (band == NL80211_BAND_6GHZ) {
+			/* 6 GHz channels should only appear in a scan request
+			 * that has scan_6ghz set. The only exception is MLO
+			 * scan, which has to be passive.
+			 */
+			WARN_ON_ONCE(cfg->flags != 0);
+			cfg->flags =
+				cpu_to_le32(IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE);
+		}
+
 		cfg->v2.iter_count = 1;
 		cfg->v2.iter_interval = 0;
 		if (version < 17)
-- 
2.34.1


