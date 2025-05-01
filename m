Return-Path: <linux-wireless+bounces-22296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EB5AA5CD9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42823BA633
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C144323183B;
	Thu,  1 May 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elEqIddC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED122D4E3
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093599; cv=none; b=VpFh/xDG83lVwTBz94NFVhFTzBReklDQJC4TOUo8WRd2bPUc+TL+jM8KIWaF+ZzD91W0uDGPr3umDkMqx+ZydDW8yj6tcBu589kiXzEoD5kf50GV71ynkaTN8+pZUbjBRwzEK18w9pTMJ1lhqB6UUA7mGCozyGkibiYGzuA9WCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093599; c=relaxed/simple;
	bh=kVbWEmFUQdAf9SnCHmHJD4jfiuixmClaHEq3cqAZ71Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nAa0GqKBiaAxpqMugoDfzvHc2aLEDHepV7Z2YuZIHhb3A+lt8aXbGm8P6toSd/m9/6WHl6dxDQXR4jZLoRXQsC0aop6e5TAWOSTNW+QO8Qkxr1lfNMHoeA4TOBHLRW0Of9LCg0VGJ1csmG+fRh5AFbYSy6gkoxmNnBG8rS6lwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elEqIddC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746093598; x=1777629598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVbWEmFUQdAf9SnCHmHJD4jfiuixmClaHEq3cqAZ71Y=;
  b=elEqIddCilSkvAplTcnnQ5reH6UT+RGPVUGV6NTCKGsxGnkv8gaqPRIk
   +o9HOACqhxAPnJoPlhI/BMLazJcCb8gfim7GtUKZ5sUD7y6K5XPZAvRhD
   TwSwx3wYyFh0TXl8lAN8jUIjTYP9Xh+nD6ZQBNMoFLMM8SvXmI/LfoOvE
   3N6Ng1QIWdLXiJTEM/2RBjTvEav1/FnybdXp9s5lfZanLk5SoAbLBQ5WK
   1unaJFKrY/NmwCqIoJVasfl+iS1BpWEJvV5LY0H95rEVjt3k/BscnWiX7
   IIyZuiURwr0zcfcimegtxAvEj5PLj7rC9R9dMFG9ZqvNBMXOZWOqDdxgO
   Q==;
X-CSE-ConnectionGUID: zRQPU8TUR7qCF8d3RBsneg==
X-CSE-MsgGUID: N4az00vWQL6HlUU7tfQysQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="57962822"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="57962822"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:58 -0700
X-CSE-ConnectionGUID: UYIB/+o0SbaFMEa/BFDFCg==
X-CSE-MsgGUID: kGIDjJp+QHCcW0zoaJA4Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="135317945"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 02:59:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: remove duplicated line
Date: Thu,  1 May 2025 12:59:26 +0300
Message-Id: <20250501125731.aebfb48d1fcc.Ie72fadec40e41b8197bfdae16eaa430c64a3e62d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
References: <20250501095937.2097123-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This line was duplicated by mistake, remove one occurrence.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a14488f03f92..daf04ae2f9a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -658,8 +658,6 @@ extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 #if IS_ENABLED(CONFIG_IWLMLD)
 extern const struct iwl_ht_params iwl_bz_ht_params;
 
-extern const struct iwl_ht_params iwl_bz_ht_params;
-
 extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl;
 
-- 
2.34.1


