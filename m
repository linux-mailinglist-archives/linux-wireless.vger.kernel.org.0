Return-Path: <linux-wireless+bounces-7538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B18C3676
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60873B21C48
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F025569;
	Sun, 12 May 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNzmepNr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E65224DC
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516720; cv=none; b=VKfhv7qr2moAPcTJT2oA/mKbQ4KpC1Uv5v99y+RulTmsmalwKvW5VPB1fs5Ke053l2TQ26bSSB9nxKvbF1ID3RXafARcrgfiJf7pVTgkCt6Izgm+b/eQDcmMAmprj/7TP2TLgA41BqheBECdaUVoMDsEJZVpS74d6/ikY4pp3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516720; c=relaxed/simple;
	bh=UZxz73z3WzB52G15+Uwu/ndn2o/XysNcrmkTRzhvXjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rC1u3ggkfU1Fz26xVtpcxwIcb5lzhPFOZGKj/OOIyH37Ov9MhR8pdSI+ck32gb+RTAQFsi0SucRW/nQuGd40mXEntsvh0EdXo/+8K99M6qgR6A5LIhgHazP0NXDJ2L2k6fvOlWgI3R6O5wMB9ccTH21wiNcpW0dPExCZv+PQ3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNzmepNr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516719; x=1747052719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZxz73z3WzB52G15+Uwu/ndn2o/XysNcrmkTRzhvXjs=;
  b=KNzmepNrcznUGLvrSrhfoDm9mGYNlR5GjKq5NLRNjHLfUc4xtkDBBr51
   StNVhEdc21x/5oCHp6cGQAvOgX15LnhTNE3siLu8MJdV4yuOTC1n0vAnc
   2XD4yigh5JgjnucXChxZxDrtdcsV9Kr5yQEaGYVoMCEdzL5KxGsnYrejt
   5bVsUkSkPV8sKvbVw2Oou+9oqLJpsb890rLYV2bZbQjeS0/+CsT0yDkbF
   sjP+dICKbJ1lJ2GoRf1WPZKC8PeXfoFnKVw/ARRPBQO8wPDlXKKqztyep
   pOW6rT6jZLH3GpCUz+3Ihwgbs7tOaON+JYgsh4efDioNstuUQBAs74TH/
   w==;
X-CSE-ConnectionGUID: +vSZWtWFRd+5rUorJjgSaA==
X-CSE-MsgGUID: d5/6nWmGTCKlb5/cq1+QWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397188"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:19 -0700
X-CSE-ConnectionGUID: 1Ea5epbBSWyDWLgn32WpNQ==
X-CSE-MsgGUID: UCcYCtWdSAiVbnt/nwyJyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761301"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/14] wifi: iwlwifi: tracing: fix condition to allocate buf1
Date: Sun, 12 May 2024 15:24:56 +0300
Message-Id: <20240512152312.a11e6490d053.Ie090beea70d2f271bb22c9b0e287dbd342fb2a96@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to allocate buf1 if we're not going to
write anything to it, and the condition for writing is
(correctly) "hdr_len > 0 && !iwl_trace_data()". Also
allocate the event space only under the same condition.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
index e656bf6bc003..b9aa04cf1d83 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h
@@ -4,7 +4,7 @@
  * Copyright(c) 2009 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018, 2023  Intel Corporation
+ * Copyright(c) 2018, 2023-2024  Intel Corporation
  *****************************************************************************/
 
 #if !defined(__IWLWIFI_DEVICE_TRACE_IWLWIFI) || defined(TRACE_HEADER_MULTI_READ)
@@ -88,8 +88,8 @@ TRACE_EVENT(iwlwifi_dev_tx,
 		 * for the possible padding).
 		 */
 		__dynamic_array(u8, buf0, buf0_len)
-		__dynamic_array(u8, buf1, hdr_len > 0 && iwl_trace_data(skb) ?
-						0 : skb->len - hdr_len)
+		__dynamic_array(u8, buf1, hdr_len > 0 && !iwl_trace_data(skb) ?
+						skb->len - hdr_len : 0)
 	),
 	TP_fast_assign(
 		DEV_ASSIGN;
-- 
2.34.1


