Return-Path: <linux-wireless+bounces-16877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330F19FDF4E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 15:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E73A1048
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Dec 2024 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092E1925A0;
	Sun, 29 Dec 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EyTQYmwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B704194091
	for <linux-wireless@vger.kernel.org>; Sun, 29 Dec 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483534; cv=none; b=k59mWtVuV7STLhOcijwoitxJVwjuUsW6uYboE/eBBqSD7/oRar73/RRsYnvFrCLadPwfjt7mlYEGJxoadsklCCoVm+qzCpXDGLYQMINtUftjs9O1tSWgDQqOxRrO/pU5KWokc889KXQ0360IdYDHxVcAdc0WCQNpTmvZ6/GqR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483534; c=relaxed/simple;
	bh=iWIOczPmNbj8ZGAP/RLFtTe+BfAiYhVYBuo2zzcTuw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oSXToPtcgBu2gp7iiRT+OsKfphKktJlSCtPjtRwXjepgE2bAwIibLwIFYTTBtBI/HWJFjhASAHsbBb1GAH44oQjGw5iJs+A8Hv3HL7W8D7a/UOjfvG3oAH9M6QG+XBDmx9eLa3zQp564klSUY33E9oaJsZZTV/CQ8dMO4D3gxZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EyTQYmwh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735483531; x=1767019531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iWIOczPmNbj8ZGAP/RLFtTe+BfAiYhVYBuo2zzcTuw0=;
  b=EyTQYmwhKIOnXmp9UxR2ssSZuSa3g1KIOw6r1d04Fbv7SR/sbRrse+tS
   Wzrx+7d5QzfxMcUZhd14i37p9bFaVjoFcozlgWL68g8M2TUUPwSMPYniZ
   ZvR5QBJtgB4/VLAB8eNe7B+8lWfV91n45Q2w2E6IYKhmaKSwPpWJrCiob
   R/LurnoHHXDZhK2CUt+4s17F4SCJDLWrvQNqq/2oXIWu/i8ar1fyA1EWV
   65DxulsT9zjsodGV0LVOyh6LK4LZTNvEq3EZkDJeKzHe80S3q+Ppg1nKi
   3e8MEZtOpazaCBZFMT/Zjhos+S0Xsswjs8mEY4zhqA1ItcOuxLYfpWE9b
   g==;
X-CSE-ConnectionGUID: sI338saST5eydC62hK49Cw==
X-CSE-MsgGUID: BXJeGr+HSPWAZVWamwA7YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="39572467"
X-IronPort-AV: E=Sophos;i="6.12,274,1728975600"; 
   d="scan'208";a="39572467"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:30 -0800
X-CSE-ConnectionGUID: 8mJkzrZaSdGwt88lp63lgw==
X-CSE-MsgGUID: TTXT8PhqTqS6w+19UpfquA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105656995"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 06:45:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Jason Wang <wangborong@cdjrlc.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: mvm: Fix comment typo
Date: Sun, 29 Dec 2024 16:44:50 +0200
Message-Id: <20241229164246.9d8c224e9d4c.Iaacfbd1e9432f31d5d7d037ad925aadbb0d5c4d6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
References: <20241229144452.3151163-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Jason Wang <wangborong@cdjrlc.com>

The double `if' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Link: https://msgid.link/20220811115958.8423-1-wangborong@cdjrlc.com
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ede053507366..c1363b790277 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2915,7 +2915,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		/*
 		 * The division below will be OK if either the cache line size
 		 * can be divided by the entry size (ALIGN will round up) or if
-		 * if the entry size can be divided by the cache line size, in
+		 * the entry size can be divided by the cache line size, in
 		 * which case the ALIGN() will do nothing.
 		 */
 		BUILD_BUG_ON(SMP_CACHE_BYTES % sizeof(baid_data->entries[0]) &&
-- 
2.34.1


