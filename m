Return-Path: <linux-wireless+bounces-24015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C4AD5F13
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234903AA013
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58D2BDC06;
	Wed, 11 Jun 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4qvfLLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB22BD5AE
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670034; cv=none; b=F6dzBnfBsL0goutlhzeuJsE/7dvyQwx/XKeGK+p5XnFczTG57tNNb0fenYAdl359duf1xqVQTY/BmvArNS9BwrUIegxyUPlEn7Lvza+7FlrIPi1SkhbeIW0FYitBwYNEne1OCENdgsrw0dApWCP1fMx6nuDaUoVQFPNyrovIclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670034; c=relaxed/simple;
	bh=CHR2/8ZIAOOEAXbxGZThg/nnIh1RBVNVWuJsrNVgYA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jWByHb4KIDctey9uejACG37p/gnhoNzn+r7lzOBhLASM3fctpXax12wqW9nACXGmd3slz0+t6++BpIOAlBI6SBxzeeFomIihmTyV6SYssiSmZWk/cX3lOJIT36bAmFrXsMOfV3KnmHz01dkeEliBb4UX2v9fQ5Z1EHlTQQGcMPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4qvfLLn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670033; x=1781206033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CHR2/8ZIAOOEAXbxGZThg/nnIh1RBVNVWuJsrNVgYA4=;
  b=k4qvfLLncMF+dQTAWnhIx7oUZhT88GVg6eUW7vAWf1QmXubmpsVx3f4E
   uQH7H9i1vkf9bheqNLE2KxCvRoJjMJyzchuRUwJBuqjBlm9fZayr8pXdL
   QNk2iIsKpHmgPyGI3dAzyRgPoLBy3AaUqyD0MfU0r7G75rGC+P+EoaRHz
   IjSHsg3nQvDhEJUX7LNRwuz2K+TfXfZLjS0t7fTBR5ixupg9O2Yw+/u9v
   /0hvygCsC1byTy2fWRIpM2l0Psoj+NFTsx9X359z/ubXpU2+Ar+SCJO4A
   aezDedSROA8Zi/7NgBzXR3DvGvkGZqglijZKiuJ1iMO91Lp+ehCYeqnD/
   Q==;
X-CSE-ConnectionGUID: rWY5aMepRT69p6RPVgzkJQ==
X-CSE-MsgGUID: AT2L1+SNRLOa+4hIVKBCaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360911"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360911"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:13 -0700
X-CSE-ConnectionGUID: zFXV8Ng5TGSTby9dhWIjZw==
X-CSE-MsgGUID: 4nowsenlSpSa5niFu+j/SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165894"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:27:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 15/15] wifi: iwlwifi: fw: make PNVM version a debug message
Date: Wed, 11 Jun 2025 22:26:34 +0300
Message-Id: <20250611222325.0f77cb90aa20.I06f2adca38d012a71cde3956e1d2005293f70604@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
References: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This means nothing to a normal user and really has no value
for most people, print it as a debug message instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 4f3c2f7f4f5b..3bcd375995cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -332,7 +332,7 @@ iwl_pnvm_load_pnvm_to_trans(struct iwl_trans *trans,
 	ret = iwl_trans_load_pnvm(trans, pnvm_data, capa);
 	if (ret)
 		goto free;
-	IWL_INFO(trans, "loaded PNVM version %08x\n", pnvm_data->version);
+	IWL_DEBUG_INFO(trans, "loaded PNVM version %08x\n", pnvm_data->version);
 
 set:
 	iwl_trans_set_pnvm(trans, capa);
-- 
2.34.1


