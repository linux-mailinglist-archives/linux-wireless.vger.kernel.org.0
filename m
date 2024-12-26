Return-Path: <linux-wireless+bounces-16818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2D49FCBAC
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA343161C60
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237E12FF69;
	Thu, 26 Dec 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QCh0sh6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894071459F6
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227932; cv=none; b=a22e9Nz79ka4fTI4UDByh6fwmz/XYpmlj5Cs8MqCgaTPDYQ+E7gLyaMnz/FmZrTAlBk4mdWZsCSTmztAWDDBfR76E3LtNNp+VD8ePLa8W+M6U+bDaSnCbhREsHTSl9IKS1BaFMGrTUU29L7kWkD42BmwJl9moZM3nWKv8/coFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227932; c=relaxed/simple;
	bh=6m9OvXIC+QOct4HYhtzlylE+PVSIpUo2d2WDRQmqSK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MYX+qzWEkyIhFBy3/TMWZdkeDXPWBl2z1cTrXmUqK7nuieI25tizpqk9buqtFUWgws+6Xl/h4lnerCFEvgttE1nk0sbtoa3+yzH25IjoIxKqyMq9vzzVHgo7PM2E/M8zMgyrUKptUckqxK+sM9lkgWUz8pT6UyfYeQY+ND0WSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QCh0sh6M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227930; x=1766763930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6m9OvXIC+QOct4HYhtzlylE+PVSIpUo2d2WDRQmqSK4=;
  b=QCh0sh6MkzMzOLWoiSjx+BpjM+4xGaJEfEX6uGJ40UFJfbfK12D+23ss
   LpjNBg1gSkWVGUP5V6wqLUTrpxdaPzlFNT9JxSJ/0JgnBV7zLtQiNmLF1
   v8+QyJzoebZ4ZNocq2PoqSJukvYQ/cSKc2YA3OHR3EjLs+ZCupvyeRPkq
   4j1Rs+X08tBmyrnTg896fmeI9CjVeai+R07DeiqFXro55A3+jI4MbIKIP
   nunutIYB/D7C1eAg/XmfobAxMYx9fytxa6FIou0rVWVvfYPJBO4QTgZOL
   cd7Bzuii9hJiOeC2o5GKuj6j7vX5W01pTgK9pTUQ6hJiTDBs1YRc7vqH8
   Q==;
X-CSE-ConnectionGUID: tw5GtdF+T/2V9gWfcl6MQw==
X-CSE-MsgGUID: lf6XS5AaRxaYQAfq8faUtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878162"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878162"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:30 -0800
X-CSE-ConnectionGUID: +f8bfzg8S4aoV5AOtUo5jg==
X-CSE-MsgGUID: e+SsLCnuQzOu1AicZhMh3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99778011"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: Use IWL_FW_CHECK() for BAR notif size validation
Date: Thu, 26 Dec 2024 17:44:54 +0200
Message-Id: <20241226174257.913d5d476929.I8cd62f45bacc088c309b0152fc392dc2579e82e0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Use IWL_FW_CHECK() for BAR notification size validation, improving
diagnostics with a clear error message on failure.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e8ea48936c2d..c03cb7cc2f1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2507,9 +2507,12 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_bar_frame_release *release = (void *)pkt->data;
 	struct iwl_mvm_baid_data *baid_data;
+	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	unsigned int baid, nssn, sta_id, tid;
 
-	if (unlikely(iwl_rx_packet_payload_len(pkt) < sizeof(*release)))
+	if (IWL_FW_CHECK(mvm, pkt_len < sizeof(*release),
+			 "Unexpected frame release notif size %d (expected %zu)\n",
+			 pkt_len, sizeof(*release)))
 		return;
 
 	baid = le32_get_bits(release->ba_info,
-- 
2.34.1


