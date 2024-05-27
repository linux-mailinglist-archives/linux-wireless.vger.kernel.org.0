Return-Path: <linux-wireless+bounces-8119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A0C8D07F3
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCF91F219B2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B415A878;
	Mon, 27 May 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsooS6yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCF15A87F
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825992; cv=none; b=E3WTyX+x7JtbxfZx1XtkkPwT/+mon3TNlROio62+8Agz9SuvfN6fF7S2QWyM81xOC/GHz+4+bQJT4xhMlScIwTABRetn8i7K5O2S2sLcjKIPe98JvIXUG8mGwYzLR9IiDTM/6JsutOgM71IJFDPbocMMCYT/62iBdBbYbH57Vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825992; c=relaxed/simple;
	bh=llX8MBU0oPhPPqJcjmNYdou62xPDV6OLXxIgzNerdhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1w6beKD38ALTQbTvMZLD0qVgSVUkv6MlBxr4QZ432MoAJqZY7hTgwnrr3gY+kCq2dmWbYZjshA6yTiIyE35iLWT4U6Rc9dz4e8tFttm3glAJn8yLKU5/1DvE3jfL08V1+QvmVF0K/ehrMtd7jJD+6w9Gt7FsVkAm61x3HKcViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsooS6yx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825992; x=1748361992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=llX8MBU0oPhPPqJcjmNYdou62xPDV6OLXxIgzNerdhE=;
  b=hsooS6yx2btqHF9U/tg94JOtqkW6sboaH8CBf90aiVwdpVyjmSTuAEBI
   1yh8acJgy1ydXRRxmnMAbqxLzxyNg7vbExWYyDBGIsFGZeb1Wg3xPydtM
   gs1k8IN3o3jR3jCWMavNIbRKMg0aSwAHgMjeptP27EU7p9KL48dhFmrWX
   nkXApGorPCssBTWawUwtT4EUj16Vp3Oomfnegx8iicnF1ZGZswrhv8BDv
   H+qTci19Sd7E/JE+euu6vCLA6DgilJQ1GSfWK3MRiNMH/0yReOwB2ypck
   6JFa7BkWZLOBFeVo0x5UoyEqEstfDIq3JidbevuJhH1NoQaQt4rNyKQhM
   g==;
X-CSE-ConnectionGUID: 3srIrrirQ2OaHCwKF5HMTA==
X-CSE-MsgGUID: dJKSzFo0R92K7epG2DJaMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002075"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:31 -0700
X-CSE-ConnectionGUID: Bv2BMTFORoq7vdXgyaRvWA==
X-CSE-MsgGUID: FfrBf+nNRn2CPnQZokZ6Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407078"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/20] wifi: iwlwifi: mvm: remove IWL_MVM_USE_NSSN_SYNC
Date: Mon, 27 May 2024 19:05:59 +0300
Message-Id: <20240527190228.c5edfb967e35.I34a3d54a1dc90d9b2937b0bcbbc508fe3cd41773@changeid>
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

This is not used and not needed anymore.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index eda6634b4fb5..c991eaeade15 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -114,7 +114,6 @@
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	20
-#define IWL_MVM_USE_NSSN_SYNC			0
 #define IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH     false
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA      40
 /*  20016 pSec is 6 meter RTT, meaning 3 meter range */
-- 
2.34.1


