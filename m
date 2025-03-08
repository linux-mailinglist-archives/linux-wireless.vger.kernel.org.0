Return-Path: <linux-wireless+bounces-20054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFD7A57E81
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF5416DFA7
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E920458B;
	Sat,  8 Mar 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEr31ka5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B391F9F5C
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468793; cv=none; b=EeVeylbed3rKl4XNIBLMVcpYrZIX9UnON27D8TSyVf8RistI/maK2r8xr0Wph4aecHIyq3xuw6r9dLVV6ZhWeCWcEB1I67KSSdMWd77gSEdsfmShvDqmsevCeyoivht69BM/9RxJryXVxG1xm6iVmcUF4lX1SYU8+yncyaQrlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468793; c=relaxed/simple;
	bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HE+qHL5hJ1BR+hWag/2KYnz3BMQG0+2hfOWYKAifKZdaj6d62J18LO306QsYguiYZJzHvZgxPj4cY3x+PQqKH84A4hAq+2IhzegsETV2unWTPdWsUis8VWRGVyAZC92usLZGRj/3FbU1ZuDWs46x3afx0arr9dJR+nwUmwYsxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEr31ka5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468792; x=1773004792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lvi7BfNv2bRCFi4MHBrGC8IskUYwUo2kII2i6+tJ10A=;
  b=DEr31ka5NYZWqWylp5h41l3FJb8lOztIQIqfOMKSDgQLDjnxspKxNdoS
   oqHwl0atRQTaxv51+NtfVHf/7KaUx6bDMOrSXNmdOL5l1HYs0neWvBhsm
   AxHkOOabYSrY/WkCDB0x4PhNswCQxZytGsGU/OuJ/0nPL5W3Ke8knpR4y
   +9mm9PIOB9KKqadnLkccsbq56f3QPuDy86x70Z7gsrwIFhtd7IiG8sA1K
   b6OlvpXH1vzJgzrGbcOkexbVtfyqG7vfydIDv7ABJ1QnKWsNJWXFb4wX8
   2/hi5wN3Y+abb6chnDyMOXoJr84v3CY0URuBSr8kqTslQponx3EwjuRHN
   A==;
X-CSE-ConnectionGUID: pQHCnfEtSWGqTGhtHpfwlQ==
X-CSE-MsgGUID: 451tH+BiTv66wu8RWmE/ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052381"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:52 -0800
X-CSE-ConnectionGUID: ft9kaWORSFKDZ8Q7m4hmXQ==
X-CSE-MsgGUID: SZhEWfKgQru2+H3zNKijyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859941"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH v3 wireless-next 09/14] wifi: iwlwifi: mvm: Fix bit size calculation in iwl_dbgfs_tas_get_status_read
Date: Sat,  8 Mar 2025 23:19:20 +0200
Message-Id: <20250308231427.65d373e4a10e.If2cea63035333b07849e5a2c2a4f5dc5c5239595@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Corrected the bit size calculation in the for_each_set_bit macro in
the iwl_dbgfs_tas_get_status_read(). The previous implementation used
sizeof(dyn_status), which only accounts for the number of bytes.
This has been updated to TAS_DYNA_STATUS_MAX to ensure the loop iterates
over the correct number of valid bits in dyn_status.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 6ffc04a23c6c..1289ff3ab162 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -698,11 +698,9 @@ static ssize_t iwl_dbgfs_tas_get_status_read(struct file *file,
 
 		pos += scnprintf(pos, endpos - pos, "Dynamic status:\n");
 		dyn_status = (rsp->tas_status_mac[i].dynamic_status);
-		for_each_set_bit(tmp, &dyn_status, sizeof(dyn_status)) {
-			if (tmp >= 0 && tmp < TAS_DYNA_STATUS_MAX)
-				pos += scnprintf(pos, endpos - pos,
-						 "\t%s (%d)\n",
-						 tas_current_status[tmp], tmp);
+		for_each_set_bit(tmp, &dyn_status, TAS_DYNA_STATUS_MAX) {
+			pos += scnprintf(pos, endpos - pos, "\t%s (%d)\n",
+					 tas_current_status[tmp], tmp);
 		}
 
 		pos += scnprintf(pos, endpos - pos,
-- 
2.34.1


