Return-Path: <linux-wireless+bounces-19891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63691A5483E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBFF171BD7
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A972080CF;
	Thu,  6 Mar 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtsNgFwK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C64207DE2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257843; cv=none; b=EBS3PsUPuAPDOgXRmiWxLKGvUZ6j80xgecZp8j17D/QrdvOnwAb/z3gfEHrUh5yx68mLJO8m9kc3C9vOA6xgnuPmQubLioAth3Kf4NP0owwGsfdp8A7BzUQ5qamgiVuwKOFYmpkzlBfzLLWN4PGoVIg+vpgbxDPLfp6yK5LBYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257843; c=relaxed/simple;
	bh=rcmeEKUl0grt5NqQFQ066GwHAD1piFf/75GVuUnDpDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afiw6P1nb6IFVar12YObwLBYsQPpTIWGoR4n4u1K9vcRqIP9kP3EfhjhFFOK0swsovZ46Ybk3e+Yux2V72ApVe+RklCeXbRp5UAEF0MUY4ly4lMxr9uzUDH94igeroig2RiaLZ6tF1QogpJjsQ5hEv8NRxhP3iRp8A6D/sDfy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtsNgFwK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257842; x=1772793842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcmeEKUl0grt5NqQFQ066GwHAD1piFf/75GVuUnDpDI=;
  b=CtsNgFwKUggoPTdaUwq9Hs9lpRY1LmXU13utxDKXEW8rdbJ8/YhBF0br
   H08KX7zjhfwm6oC51i5Bu330SJBn1VJzXoMllnFw9N2vqXD5ZVKQbeiBm
   daOzKgVz11g+nOb5K7u7K82msfizLsb/a9S0ovlA1YAG6I1VqTMjryQaW
   FX9hT5HYTf3Z2J6IFZ8vfn0pot3zEykTWxnoaIPmANi1JypIAx/9XKCVB
   0YqR1fRnkt4c7lVrUIeAwDFsGp+8lLWCYv5QXWdN3WpqCIaurQh+BXivD
   PBkWbHe5MoXk3+Wlj7DBzqsMCnpNTBaC/2G2JgkvbfPmcBK62Fmfm4zR2
   A==;
X-CSE-ConnectionGUID: PuSxc7ATSQSj7bes/Y7qig==
X-CSE-MsgGUID: nqjkTic4RreEFd8P1ottPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844524"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:44:02 -0800
X-CSE-ConnectionGUID: hnrAqSpNTgCuZyi9LrmwRw==
X-CSE-MsgGUID: /0tSTrmhSN2Newe66c511g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797792"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:44:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: mac80211: set WMM in ML reconfiguration
Date: Thu,  6 Mar 2025 12:43:26 +0200
Message-Id: <20250306124057.2b473bffdbcb.I362c3101d3f523a8db37c16cd7b5f573d76a36e6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the per-STA profiles for added links in multi-link reconfiguration
the WMM element should be included. Fix that.
dfjhds
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 94d9d9ca42fe..bfd3653a5b84 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10435,6 +10435,7 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 			return -ENOMEM;
 
 		data->assoc_link_id = -1;
+		data->wmm = true;
 
 		uapsd_supported = true;
 		ieee80211_ml_reconf_selectors(userspace_selectors);
-- 
2.34.1


