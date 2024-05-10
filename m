Return-Path: <linux-wireless+bounces-7474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FEB8C2668
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316B81C21E9F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C639C173340;
	Fri, 10 May 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNLXfAL0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48724172BD4
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350038; cv=none; b=Yy3lZGbHc06f9gRzWXz08Ge4qTCw+11Zeq8JdErn1iCYXAoLHy3p9zPMRukhFBs8u+umEvamm7Cc342x5gLHTv7k1UW9ih9idrg/aGEmNl0CHELyw0lujU+bZPsA4tZFdc3336BhirR0ZKdxc/f75QTT2GqFQHz5Hm95u5I/ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350038; c=relaxed/simple;
	bh=fG0hJAliBinyFWwSFooXkKjRJAJIK0JjWHWVVkzI6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLW77Lm/XEOLfxoWj8I9ngDSmg+7WS1LqU/zabp4sMvF1adqo6KLDR5ZNkyuiclrq+NOwfiKo7FGjwkkyLXMV2mOr1Ai1UCLP/gMlVHF0d7GUqrtcHJ/3wMGodIRp5rqftiLVKNkr1MdA+uXiGm21RqwntNrnd5a0smjuSxqU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNLXfAL0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350037; x=1746886037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fG0hJAliBinyFWwSFooXkKjRJAJIK0JjWHWVVkzI6Wc=;
  b=JNLXfAL0yD+2xLvV7xKGGp7DhbjFTKkn9fSTlXZrj+dOtEQNkKb1CbcO
   l+OQP85NHEz/QZLvJ6qUK2sxt07uRswAeTOyVEfXcSqmBZSlxt2N7PIBI
   sxnU3NiukdyNoRH+SxF4WBY3oyeiLkRTOPusv8SgDvz82ApZ1M7r+iAhw
   iHZLWjeBbt/ug0+rdu382KWV8S6XuguhGtSweJFLQEmOoUP62iXB0mdw0
   KAxK5PEyrQFtTMz0wrujTtCzG9j8kFhVN67IK5giooeyBxwE1OJg+OEJT
   NhkVtxl+hPCLtgWEuHVBsE5jiNOfZaAeruOfaFkTYRNBfa+pK+LUKv43A
   A==;
X-CSE-ConnectionGUID: LNkiTGCVQu6Y+BtxJK16Tg==
X-CSE-MsgGUID: Tm+RcXlRT6OHr5S9qfxfAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125657"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125657"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:17 -0700
X-CSE-ConnectionGUID: EqPTLMQJQ9mfatgndfijIw==
X-CSE-MsgGUID: W1C+huF+Q6CVrnFCGqO3Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:07:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Chaya Rachel Ivgi <chaya.rachel.ivgi@intel.com>,
	Coelho@web.codeaurora.org, Luciano <luciano.coelho@intel.com>
Subject: [PATCH 14/14] iwlwifi: remove redundant reading from NVM file
Date: Fri, 10 May 2024 17:06:41 +0300
Message-Id: <20240510170500.c4d1a4571049.I7d7b73dccb793e220f023e0d049b082b043ca95e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Chaya Rachel Ivgi <chaya.rachel.ivgi@intel.com>

The driver reads xtal_calib from NVM file, but actually never uses it.
This is only used in dvm driver.

Signed-off-by: Chaya Rachel Ivgi <chaya.rachel.ivgi@intel.com>
Reviewed-by: Coelho, Luciano <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cf5c9500af8c..5132964661c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -38,16 +38,13 @@ enum nvm_offsets {
 	N_HW_ADDRS = 3,
 	NVM_CHANNELS = 0x1E0 - NVM_SW_SECTION,
 
-	/* NVM calibration section offset (in words) definitions */
-	NVM_CALIB_SECTION = 0x2B8,
-	XTAL_CALIB = 0x316 - NVM_CALIB_SECTION,
-
 	/* NVM REGULATORY -Section offset (in words) definitions */
 	NVM_CHANNELS_SDP = 0,
 };
 
 enum ext_nvm_offsets {
 	/* NVM HW-Section offset (in words) definitions */
+
 	MAC_ADDRESS_OVERRIDE_EXT_NVM = 1,
 
 	/* NVM SW-Section offset (in words) definitions */
@@ -1574,9 +1571,6 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			     &regulatory[NVM_CHANNELS_SDP] :
 			     &nvm_sw[NVM_CHANNELS];
 
-		/* in family 8000 Xtal calibration values moved to OTP */
-		data->xtal_calib[0] = *(nvm_calib + XTAL_CALIB);
-		data->xtal_calib[1] = *(nvm_calib + XTAL_CALIB + 1);
 		lar_enabled = true;
 	} else {
 		u16 lar_offset = data->nvm_version < 0xE39 ?
-- 
2.34.1


