Return-Path: <linux-wireless+bounces-23972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90419AD4974
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AA8189C12E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F50213E61;
	Wed, 11 Jun 2025 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qkewf2Uk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14610226188
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612891; cv=none; b=kKvgnFb8ixgZmBMLfdFP8tjqC2cx3fAV0ouowbpymitWf7PZcwNBgQaBjd2ap39DJiQ0iVcRIo0JYotBpupFnsk9vR193z1A+n6FL6WB7pRcrWp7FP6KPnZ7nRXKuO82CWmXH0HIy4CJhLSx2NZAqWTKVDVFpXKnZyTmJeqTkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612891; c=relaxed/simple;
	bh=CHR2/8ZIAOOEAXbxGZThg/nnIh1RBVNVWuJsrNVgYA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHTz/m/y5/d2dYqiVM/2kVyGoAXKO5d8HkIp1IRpNkyq4T4YRPTbLW+/ZqDMpgSmBSel8fnBIyKXI4GAWSqywYLw/ZQetJKLdN2akfOBi15lEww/qQUR28r13s/8b9g1G343WrxV2kTwJse4PnACYwGlDAxIa/tEzZm2oaTh8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qkewf2Uk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612890; x=1781148890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CHR2/8ZIAOOEAXbxGZThg/nnIh1RBVNVWuJsrNVgYA4=;
  b=Qkewf2Ukdg8ShYeKVAM7oljufB92gcFvvza3gGIlTnhb6eCWCdssBLbS
   RXwqavOYA6kkkQtFm3g/vMQULJAAGq++GOck0QqHF4jGCRH324NhuIaZ0
   GR0UrKzPKEDMyO0h8yAZ2PijN/RRgGoG3Qnzn9ix/iMfNBxzyhCTljp5n
   ZOMHA40LJ+L89+RiFgp81mGE6h0L+GR3FSo5E1c43UNrtQljbQ17W2fxM
   gKNXRM5IL/xnyksROBlQX62o46hJldxTAjDx+dwYGXBNCcgbs5arQWYih
   LpWO4vuHaZdZ3hNZdxF66tnrlr4HyMGqwVhpjyN9LwYIxg76wKKtU28sO
   Q==;
X-CSE-ConnectionGUID: JrdV7bftTQmW+hHU2czRfQ==
X-CSE-MsgGUID: U66gskBzRLaM2zvLgxpTQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094899"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094899"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:50 -0700
X-CSE-ConnectionGUID: P3kR97WWT7+WWWNOHdM4xQ==
X-CSE-MsgGUID: B3NEBWfgS2+486gFOfPm0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880986"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: fw: make PNVM version a debug message
Date: Wed, 11 Jun 2025 06:34:15 +0300
Message-Id: <20250611063124.a372d977e58e.I06f2adca38d012a71cde3956e1d2005293f70604@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
References: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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


