Return-Path: <linux-wireless+bounces-10631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57B093FC54
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270B0B234BB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96F5028C;
	Mon, 29 Jul 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmzWPcPF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D2183098
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273649; cv=none; b=I7mi3YPndT84I8Vj4XUSWgAa+gcucxxW7QGoXzx43/59kWPxEWZlCV6s+5fZ6JslbIsQ8960mUgmmTK3TCmHC9hWCXM/QQgwJEG6C2x0BRfVxRFmt3IsrKS5whMA/Cren469mxRyTGbEGvlVsTW6bp8cWK5/9gEegzCJZhHzTKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273649; c=relaxed/simple;
	bh=zZ8FeXZ8n2W5NhGapi4k7cMbVovDibf4JesC994JFrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9gNd8xk3Fjj8ys0RjtAJxGGotpfhO/dnhcSysDIvuD9XyT0dDgDsgaaYof3rjfU05D7C1gILe3ZUGQqGNOF9i8LRz5743GqyCwbaHyF/Yk0jH0xNl9gpUZeSRJLGMmFR4CTfzDOsJLlQA5pGxaZ6LempxBBd4loTtg8VUofQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmzWPcPF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273649; x=1753809649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZ8FeXZ8n2W5NhGapi4k7cMbVovDibf4JesC994JFrI=;
  b=MmzWPcPFCGmws3kO3b5LbjdliK9XaYxUaI1fOP1IKWewMBdri10puQUh
   SRY6hHbxUvU1kcmifiD3RMDC5YcDiA60jB30qxS1UFFteuJw1fr68tjl6
   WvyNaa/NkghvHQPqwkD8MGnrGerJ95njq6VRW1kDrPkC+SWEsrZpn+sYO
   y9s6ibVAVTmGfaxfK/5eqQkLTMaDhR1OI+3WlPnDyMPV2TGvV88kobXlm
   jz3E9BA4AdHrxU/sjyRSASwrND7YoUv5BSPD429EvYr5J489qdgY8FuC4
   axSWM0hdT5T0nCdZ0Xo6OqOz1TYtCHjMqZg/6HQJXdKh4GVHMGHTr8Imp
   A==;
X-CSE-ConnectionGUID: fFINJRL9Qbmm8QfPzzkAUA==
X-CSE-MsgGUID: S5b7XvYHR/C+m4X9VJ97Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445601"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:49 -0700
X-CSE-ConnectionGUID: opcG9i2tTL2/qjKIUSYmyg==
X-CSE-MsgGUID: 2TS3W8sHSKuH9wWG06hrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288330"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 11/17] wifi: iwlwifi: mvm: increase the time between ranging measurements
Date: Mon, 29 Jul 2024 20:20:12 +0300
Message-Id: <20240729201718.d3f3c26e00d9.I09e951290e8a3d73f147b88166fd9a678d1d69ed@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

The algo running in fw may take a little longer than 5 milliseconds,
(e.g. measurement on 80MHz while associated). Increase the minimum
time between measurements to 7 milliseconds.

Fixes: 830aa3e7d1ca ("iwlwifi: mvm: add support for range request command version 13")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index c4c1e67b9ac7..8f63cbe9e50d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -109,7 +109,7 @@
 #define IWL_MVM_FTM_INITIATOR_SECURE_LTF	false
 #define IWL_MVM_FTM_RESP_NDP_SUPPORT		true
 #define IWL_MVM_FTM_RESP_LMR_FEEDBACK_SUPPORT	true
-#define IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	5
+#define IWL_MVM_FTM_NON_TB_MIN_TIME_BETWEEN_MSR	7
 #define IWL_MVM_FTM_NON_TB_MAX_TIME_BETWEEN_MSR	1000
 #define IWL_MVM_D3_DEBUG			false
 #define IWL_MVM_USE_TWT				true
-- 
2.34.1


