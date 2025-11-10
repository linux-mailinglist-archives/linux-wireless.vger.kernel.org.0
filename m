Return-Path: <linux-wireless+bounces-28779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E706C46C0E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 14:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8D3BC1AF
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542C5311964;
	Mon, 10 Nov 2025 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXLH408V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A611E9905
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779772; cv=none; b=gksRUCDa2NLQ2Y7X25fogqV5UiNte3JtdAQ4swUqkIdlSYTNyzQAkS1+cg7qv4ATXnEkyQwvoR9TW7RtkPbf+IhmbAXkjdZu99/ARSlh+uWXBzwIjWak8fKjKdEvJtOtL/VMTtgU4ikGVRK+3Uf6fKMZWhRzSeaA/A090cmzI4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779772; c=relaxed/simple;
	bh=X5sgSyFa/s3Ek24CLzOECmXT21EjGPFUgMH8z43cSOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTxsSQb3+O36wTDWbuVOk9SFCpknPp5o52JzefnRprbcJk4NdXwYXeY5TRLW8p8SATcc+xQA9E2YbSvJIjy4TB/wfBmtRNKXzbiv6/Z0nvNjiuC1lMGAoqzZNZTI/Pd2ETukLfHs1e410HOB3V1snzipPN5ZitT9cbW1mVVKTEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXLH408V; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779771; x=1794315771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X5sgSyFa/s3Ek24CLzOECmXT21EjGPFUgMH8z43cSOU=;
  b=aXLH408VliyfzoZZqxJIlYa0H2jWAvvkcdOA57pZ91GXqFCQsDQNmDOh
   zQUspvVuaMyqFizoSuLtFvCclHBAZT6S8z9JP7h/gKPWCRDgfD4a7IktQ
   pq48cSeYLGcRqGtyCRGY0Gfdum4Kvz95WUoSVXLO4DtqG2z/qJUne4ubS
   K0IT8BG9E0BIT+hbYz1BVbHAW/sPAaP5TDAeMJQr6s4I9yDZ5EXvDAjAa
   0M75o9AVY3ZJj79zphaVeBDtMLWvNvqEMz83iLn9YpHJz2Xow4PJUQOyG
   TqqSRRKle4ccI0iJNWV8a886gfh+0YBtKo3CmXL6gUgUVeS3DI4YHsnDv
   w==;
X-CSE-ConnectionGUID: qpqlUh3pTt6icrz20iEi2A==
X-CSE-MsgGUID: r530RFXtRGO24QRAQXymSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82454891"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82454891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:48 -0800
X-CSE-ConnectionGUID: x3J+B5mlQ1CWHVfg2TPFow==
X-CSE-MsgGUID: QoLzBuQuRvO25VW9Q8UH2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192928557"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:02:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: add UHR TLC mode
Date: Mon, 10 Nov 2025 15:02:22 +0200
Message-Id: <20251110150012.aba5036fcee0.Ifba8e366a3ad794a384ced1ebe39fccfc0ec5198@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
References: <20251110130226.223364-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is part of the new TLC API for UHR, was just missed
in the earlier update.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 8a998747dd95..e073e1963742 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -73,6 +73,7 @@ enum iwl_tlc_mng_cfg_chains {
  * @IWL_TLC_MNG_MODE_VHT: enable VHT
  * @IWL_TLC_MNG_MODE_HE: enable HE
  * @IWL_TLC_MNG_MODE_EHT: enable EHT
+ * @IWL_TLC_MNG_MODE_UHR: enable UHR
  */
 enum iwl_tlc_mng_cfg_mode {
 	IWL_TLC_MNG_MODE_CCK = 0,
@@ -82,6 +83,7 @@ enum iwl_tlc_mng_cfg_mode {
 	IWL_TLC_MNG_MODE_VHT,
 	IWL_TLC_MNG_MODE_HE,
 	IWL_TLC_MNG_MODE_EHT,
+	IWL_TLC_MNG_MODE_UHR,
 };
 
 /**
-- 
2.34.1


