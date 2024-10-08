Return-Path: <linux-wireless+bounces-13676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38033993DFC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 06:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A56F1C242DC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 04:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEEB13CF9C;
	Tue,  8 Oct 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSgFGKg8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45A13C9CB
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361561; cv=none; b=pWVzxjOfezNoVHSlbdYprh8yCCT/JK+/MzG0oUbQ6AU7ieAWVIF8veV172fsS73e/GSDiXEgN8K1RYfZrvHGvt788Jr+vDUMk+jxm5h9A2BS6yR1ZEebJuaoBnjuBemDa7xCJq9hOSG4Gwaip3ODoDkC0O3hLGWQEgVFYHhhMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361561; c=relaxed/simple;
	bh=g7bbZhF1550XdlVZW2yrFEmAqS/Vic3JK8qrTAE4LLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kin8fFwTT3JFQ+U+QcLAbZ07tkCodF+uufWUdsCH132fVaSh9kBv98rSb6Cn44rbN0cZEt/AFXBC2q1Zx6nAepdvV1XwoEDW6PGgPRCXE6XaPwoAzateSNn8bwvySRKJuNu/aSi6MJ6IcFJy0cIxZhc/yWRIzrFs35grTB+lqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSgFGKg8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728361560; x=1759897560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7bbZhF1550XdlVZW2yrFEmAqS/Vic3JK8qrTAE4LLA=;
  b=dSgFGKg84uxKXg4G1or2zEWGbSL18zQJkGv/opdZqJpcjC5rZGlEgpy8
   5qVYjP0IXUcuv42wItW0kFAnj0VjsmsdridOVi7ZV5Dv6bklaW5SqchsC
   7XAz7YjZ5t0qxcxzuHmPjO8IzISNSv8EC3ex2zx1YHQBLbFifrqnaoOLa
   0GLyS7w/htD5M6yc4QWUPnu9Q6hYeer/YRIPybOdhkO/CyBCgLrLrmdr7
   raJBxUleV4BYVvVgoYn24rdj+I0lYSH8O6GOi101pwBRFeibzD6/COyyd
   H6hG+HVPK03c8Iop5TvB45YgwV450i66VtksuUz+1WJV31Ubi3fQDathR
   Q==;
X-CSE-ConnectionGUID: LdtuoedSTh6ks5PD72F2WA==
X-CSE-MsgGUID: M9zvxVYbRlG0QbjuN/u/0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27024307"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27024307"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:26:00 -0700
X-CSE-ConnectionGUID: qBQSvwv2SPidD680GoDmxQ==
X-CSE-MsgGUID: rW0snNVkSbqwAGc9j8psGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80486406"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:25:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/14] wifi: iwlwifi: mvm: remove redundant check
Date: Tue,  8 Oct 2024 07:25:27 +0300
Message-Id: <20241008072037.5d6bab61c75e.I2cfa1669d4534bce9e9cfdace45f797005b71b9b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
References: <20241008042528.2549752-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_sta_from_mac80211 can't return NULL.
Remove the check.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index a0c088efd240..de5ac000272e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -440,12 +440,6 @@ void iwl_mvm_tlc_update_notif(struct iwl_mvm *mvm,
 
 	mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-	if (!mvmsta) {
-		IWL_ERR(mvm, "Invalid sta id (%d) in FW TLC notification\n",
-			notif->sta_id);
-		goto out;
-	}
-
 	flags = le32_to_cpu(notif->flags);
 
 	mvm_link_sta = rcu_dereference(mvmsta->link[link_sta->link_id]);
-- 
2.34.1


