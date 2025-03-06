Return-Path: <linux-wireless+bounces-19959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E06A5595D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702411899B59
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B91E5B86;
	Thu,  6 Mar 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULYRcRrT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE327BF7B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298731; cv=none; b=BkNLbUoIkG2degJsZfoJ43N6axv1BXCDg8E8AKwrznSDxxeN209BfuzteriCULfKaFzUfsNISzE2ywPr8jvbshQFC+YFuksBMpE5ukENh5SG68nqTHGg5kpBLokPXb7QkI3Itl52PMtXlZbCQY5LUwjERRh32K5E9icSqLH3lTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298731; c=relaxed/simple;
	bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvJcqpTEBWv8MHqWyNnA86Ft0b/px9W8RDbTxhQfzUzZSKqPqWZrNVxTCHpA3BeJyth6JRRZ1YiZNnuH8zafWL7BhXGDKdnV/LRe8oUOdjCTmqY+5q+bcU20gj3ngZGJ35JUSiGZ2EJ3gbjfDqBWc+xnSxTpNRMxBDbZGBv1p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULYRcRrT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298730; x=1772834730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs0s/aimuoS/iHurGf8VxnMtc9mb6hXdFm4hTzV0Yuw=;
  b=ULYRcRrTNEapPIHQmiOylch1xk3uM3epG0zRdrxdHZ1Zx73GgUsg9bV2
   6pnSJ4QGRoEat4wB50H07Oul45IAxv3f4NcSZkNBtnFJwpnpxifURl6mH
   2oCk3f9s002n+xSOUDMwNpRZclfAatezU007aKGU5PH2ME4PErSddSOSN
   nlflw2Tol4CS0HBnl2/D284yzIEfkG06pY5o1l2tAg8oc+zRu+GmulGqU
   y5yCKViz1Qcij+/7Sc/G06EycLpryqtcPemljS7ZyLaRkIIWPnLizZL2o
   icpoRVzHy9kfQA4WwVClDUecuRJrIhAhmOgiqCyRGUHXuOONti/9oJwo4
   w==;
X-CSE-ConnectionGUID: lAx1fvOAQA+OZpMjTAWePQ==
X-CSE-MsgGUID: 535r702TR1WBZ3Pt/saR8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474295"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474295"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:29 -0800
X-CSE-ConnectionGUID: St921vLcS6+SAv5fX2I2Eg==
X-CSE-MsgGUID: gB0q7u8bTLKzbJNRq+W/fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061945"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:27 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: iwlwifi: mvm: fix setting the TK when associated
Date: Fri,  7 Mar 2025 00:04:54 +0200
Message-Id: <20250307000213.c6947a9984ee.Icd19d797e56483c08dd22c55b96fee481c4d2f3d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

When running secured ranging and the initiator is associated with
the responder, the TK was not set in the range request command.
Fix it.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index dfb25b964f0e..a493ef6bedc3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -672,7 +672,11 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			target.bssid = bssid;
 			target.cipher = cipher;
+			target.tk = NULL;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
+
+			if (!WARN_ON(!target.tk))
+				memcpy(tk, target.tk, TK_11AZ_LEN);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
 		}
-- 
2.34.1


