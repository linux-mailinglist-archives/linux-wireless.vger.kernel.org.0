Return-Path: <linux-wireless+bounces-10630-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4393FC52
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6EF1C2114D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D154185E7A;
	Mon, 29 Jul 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjsMcBpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B395028C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273648; cv=none; b=pyRxdQo5uruvEvZzdqfIh8CcCqMw0WAxrkd7P1itCsr59itup4OC05VXnXxNqcZ+ZYfi9WvQ/wIdk1zS+aIW1suB3McFGMplhOqStQiL2HgPZLuLlEm6ogFjII5hOmc7M9+t1gxKLl2d1EpPVURVoF0DdhVGijSDUzd40YlEicM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273648; c=relaxed/simple;
	bh=tRJ2QEiFwFy4lpojhsTnsEoSjcXaahR9ocAQlZ0xs+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0Phcw5BKVjUyrIs8hNoad3xwdWWFNstGE5ALZxN+yk4ZHRb30qv8POGSFltYAnluJcL+2Qu8lh5tN8v2Iw+zIynbZR0+A5Q1ns/9cQCSW97R/9Z0H6OzZM3/wRZu/CBF6c7uIcZLDci8KtHm98TXCdhrf75rPHYNtGbTy/KPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjsMcBpG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273647; x=1753809647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRJ2QEiFwFy4lpojhsTnsEoSjcXaahR9ocAQlZ0xs+g=;
  b=hjsMcBpG80ce/Gh9FaTr5lfHZa0XqudJhvabFCTloiBraHIHzXfpMZHn
   +B1P2lIL24/Pi40f/OjpioSUMxJAZMyX90jks7MxaRVmegZk8jVeUCkKm
   IuKWqn843tlLv/sV7wjX4h5as8aZw64fXtzTR3b9PabhJNJw+bm2hn0J1
   3Y5BMtaCZIDFCGBrnO4hSYJSZ2lP5XrHOpDqnydTHS71RGm2jYqTi79Ai
   oQGw4OFp9GPB/Wudb7OwOrYUcr7sA7uqCE+oMvB8YGaerAZgGOqRei4I7
   BHNd1+AZGok98jVzOn53tN6vlccF+b2YDKaMNbtVuB1E2eYblaHIGmpK6
   w==;
X-CSE-ConnectionGUID: CNb2jJ75TyO4q/64wH+MNg==
X-CSE-MsgGUID: ijB3yAqkQWWHjMz1APDPFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445593"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445593"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:47 -0700
X-CSE-ConnectionGUID: prB+FWysS3G46iOp/d1YGw==
X-CSE-MsgGUID: j2kVJcANQi6cCy7Dd0H8XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288325"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 10/17] wifi: iwlwifi: mvm: set the cipher for secured NDP ranging
Date: Mon, 29 Jul 2024 20:20:11 +0300
Message-Id: <20240729201718.24e83369f136.I80501ddcb82920561f450d00020d860e7a3f90c6@changeid>
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

The cipher pointer is not set, but is derefereced trying to set its
content, which leads to a NULL pointer dereference.
Fix it by pointing to the cipher parameter before dereferencing.

Fixes: 626be4bf99f6 ("wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index afd90a52d4ec..55245f913286 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -772,6 +772,7 @@ iwl_mvm_ftm_set_secured_ranging(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct iwl_mvm_ftm_iter_data target;
 
 			target.bssid = bssid;
+			target.cipher = cipher;
 			ieee80211_iter_keys(mvm->hw, vif, iter, &target);
 		} else {
 			memcpy(tk, entry->tk, sizeof(entry->tk));
-- 
2.34.1


