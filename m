Return-Path: <linux-wireless+bounces-8546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E43C8FC9B4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6531F22EDE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D52A192B68;
	Wed,  5 Jun 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kz/AwZLQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53711922EE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585533; cv=none; b=gsmtNWOsShLqknjkrnYqfmHM/+94WVmQ+aVmQ9bklk8q9KRlwWl91v6M0WDzmiI9SoQM3q9t3bcVwiJPCfLyP32+nT1ohE1vm4a7icI57e0KmiPOahNZ4X00wFN54Ot4pfEwNqGogFLcNJSSgd7K0+BBlujCKmYzlv+rd1TS25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585533; c=relaxed/simple;
	bh=PApi67IfZGRPdokooxmEiGZij+8mWj4OiYKBSTvoO7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SpRCYTmdgR9vWrUjMriK/OGMgXlpMCKfh+6l7fSnZwNK0mp2/dwzatAnh/kzeIWC1yCVhH+yO0Re4Cip3NEGeScJhos+lqupsYu1DwN7a812vw9SXvecEzfDH9JBC1cbA3KhC1p7sphyRvUVWDNeZIjeGbu/s+OqK4Vd/lnOeOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kz/AwZLQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585530; x=1749121530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PApi67IfZGRPdokooxmEiGZij+8mWj4OiYKBSTvoO7U=;
  b=Kz/AwZLQVkCoyULmfKZvAYRDtRRCFoYR09xHso2oMw/3FSyfhu7I7St0
   3y1llzlMsY8ATChbGAOoI48BXIIfFr4XP/rMNAXkaz0jRAXgsPIj6QFJ+
   FTtxo2TxZLJ1WOC95UpuMdh0BTI4Q7a0K+uDerFPsvxhKpp3m+tkBxHrW
   wHn7ESWgxAAOv8J6U/CLx5fZi+h9GKn7w89Kuai+WRRYCAJ4g074NNLg7
   FTmH+vhwUfKPKwoipen8fZEAfiFQ2mmbfj1S/XetRWzq3tOeQ/b5reTuz
   pOh+2FY3cOq7+kO1NUsDY0/7jQK9k6um63Emq8XmxAQToevmANFz8D06G
   A==;
X-CSE-ConnectionGUID: CnskPPi7RXCR6m0/b6DoSw==
X-CSE-MsgGUID: w+e849JxQXSsAvNxSmz6kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402200"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:29 -0700
X-CSE-ConnectionGUID: D9LaZINlQTqQpXpjPA3rdg==
X-CSE-MsgGUID: jbuBGkupSN2QqBztsxTw6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997421"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/11] wifi: iwlwifi: mvm: fix re-enabling EMLSR
Date: Wed,  5 Jun 2024 14:05:06 +0300
Message-Id: <20240605140327.58556fc4cfa9.I4c55b3cd9f20b21b37f28258d0fb6842ba413966@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When EMLSR gets unblocked, the current code checks if the last exit was
due to an EXIT reason (as opposed to a BLOCKING one), and if so, it
does nothing, as in this case a MLO scan was scheduled to run in 30
seconds.

But the code doesn't consider the time that passed from the last exit,
so if immediately after the exit a blocker occurred (e.g. non-BSS
interface), and lasts for more than 30 seconds, then the MLO scan and the
following link selection will decide not to enter EMLSR, and when the
unblocking event finally happens, the reason is still set to the EXIT one,
so it will do nothing, and we will not have the chance to re-enable EMLSR.

Fix this by checking also the time that has passed since the last exit,
only if it is less than 30 seconds, we can count on the scheduled MLO
scan.

Note that clearing the reason itself can't be done since it is needed
for the EMLSR prevention mechanism.

Fixes: 2f33561ea8f9 ("wifi: iwlwifi: mvm: trigger link selection after exiting EMLSR")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 02a475a1f1b8..73527781f89a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1086,8 +1086,10 @@ static void iwl_mvm_esr_unblocked(struct iwl_mvm *mvm,
 
 	IWL_DEBUG_INFO(mvm, "EMLSR is unblocked\n");
 
-	/* We exited due to an EXIT reason, so MLO scan was scheduled already */
-	if (mvmvif->last_esr_exit.reason &&
+	/* If we exited due to an EXIT reason, and the exit was in less than
+	 * 30 seconds, then a MLO scan was scheduled already.
+	 */
+	if (!need_new_sel &&
 	    !(mvmvif->last_esr_exit.reason & IWL_MVM_BLOCK_ESR_REASONS)) {
 		IWL_DEBUG_INFO(mvm, "Wait for MLO scan\n");
 		return;
-- 
2.34.1


