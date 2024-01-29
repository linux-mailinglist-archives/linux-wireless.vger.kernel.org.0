Return-Path: <linux-wireless+bounces-2730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB53841346
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3A42897D3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9C335B5;
	Mon, 29 Jan 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3huNYbM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B8C48790
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556163; cv=none; b=olHXGJagJVA+10gfQO08mMrdvVHH3tR3tIhERki3hm7jaCjWYJliJhsGFGlAC3Y6AA5vxH9L+bywAGph9ANhmg3WbjbpEPDNY1wcc0iFcSq0ZJ+7JESGLQ+KQVzAH9SdT97shOvMeNxdtf2Kp4sFrN/sWJNtYh62qPV46l8VCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556163; c=relaxed/simple;
	bh=fD3YJXmtD6uf4ZvGAQmSof+tTpHB9RZag9ydrtlONyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Moj0xPmGOWVjGky+aIMvPedDPAz0AOaRUZCErkZpxd7BVZ//N8RUYBcYWX8/G41Nm0PkzPLM1Ibc6q20iP+iEnUBU1JhfMP0kgf9+JeJiQySKyGtsLm36he+B2kUFB40/wGRtoZkKFb3PfQkr9LvSaxo7oyA90/TlFhyW/1wj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3huNYbM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556163; x=1738092163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fD3YJXmtD6uf4ZvGAQmSof+tTpHB9RZag9ydrtlONyQ=;
  b=J3huNYbM1G6Af7dIjj7I6rynwd1WLYWDFdW0aCPO/gq4OEGdndN+mhpO
   3y79kyTwO6oDZpRXJs7U3EXW3eYXVWIyE9cM61/jiy/Kxp7/R9M5N8Ctl
   S7CY4CZiVvfQWHPNrmR/9dq7YqW4aml5T2+QF/oxD4J/4oh0dWJfvN8jX
   IoYQt9oeFsa/df6yws4m75ThuNygvXy1wmxWQnoZz19mjW4nO5+QPJXwg
   VmB9Wlrq47lPxEAiyiRs9O71b+2hhdgWmpXDSgto5ypqw2yKX9WlCwJRw
   KtIFDUsx7A0Mgx+1f4YRGa/FZIzVZrjMFygnWKAZR/EA9kSegI7y6fzlM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943037"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943037"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459126"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/15] wifi: iwlwifi: remove Gl A-step remnants
Date: Mon, 29 Jan 2024 21:21:57 +0200
Message-Id: <20240129211905.8929a06c3a55.I3c21305e4b7fa3aba938bc860269e848fe262e88@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The IWL_DEVICE_GL_A macro is no longer used, and couldn't
be, so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 20799a0fbc07..b0b003a6a46e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -129,10 +129,6 @@ static const struct iwl_base_params iwl_bz_base_params = {
 	IWL_DEVICE_BZ_COMMON,						\
 	.ht_params = &iwl_22000_ht_params
 
-#define IWL_DEVICE_GL_A							\
-	IWL_DEVICE_BZ_COMMON,						\
-	.ht_params = &iwl_gl_a_ht_params
-
 /*
  * This size was picked according to 8 MSDUs inside 512 A-MSDUs in an
  * A-MPDU, with additional overhead to account for processing time.
-- 
2.34.1


