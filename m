Return-Path: <linux-wireless+bounces-30441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DAECFDADC
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2D25306590F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61773322C7B;
	Wed,  7 Jan 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4QwLrvz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129B322B93
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788587; cv=none; b=UsaQ/gVGod+ol8RZM+wQfZ+YpavwXJADJDBOEtCFZKTV2er4wfX5mQ7sqaThsmgKRtK/KoW8n/FWsioT+fN0vKePmuwP2uEsZiiywdGkJKg0S+Lx1A8UOCQgVP8AbSDi8FgU6MP10g1OMTLBmyIKxW8nqHVAAfNZkpyyN7P5MGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788587; c=relaxed/simple;
	bh=jPmeEmbCPQPwCe4KqLHw8Nth816RbrkyRLAXvSCo7Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nD9hbjRxNcuicGVjmIjIMzrvbvAjLYa+wrH2zbBAD5Pcwh56lzwlM9zTF70dNbBQNCx6jCJz+9Xy+7JDfTMPpFeV0bCp3uMZ9aJvNsM6x6JD5/Ciig+NSLkE5V8zCuThE8ZSsZvHsFBV9ZdSrOelbGQ57dVhIRAeeNdvUq/F/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4QwLrvz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767788585; x=1799324585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jPmeEmbCPQPwCe4KqLHw8Nth816RbrkyRLAXvSCo7Xc=;
  b=k4QwLrvzsswEkW6yjZUSGgpZ8kqNePptRkOhNZWSwPaYZK1cVPh1k7Ug
   6hgKs9F9R/ChlfqMtIMgHLLz6/kWR+NkNaUG3RvqbxlebasG3nDG6MxHL
   EF/IIJP1oMUUbMBJuHsdA0RtijCG8ZKnLwBK3aK3cckWn28Ngc0Xvbh6a
   t/nPJJVI3IQGjsWnj8mXCu3Y5aK0F+R3DIxZ0NSf12ZERRKpx3yEV/R3/
   XjIw4Jx7/tJpyRc6k3t7UMZADMB0MtpfF08b2p1O48Nri/Uj+ql1YEpdu
   V8g+zjTnfn7S1bp9yQ5wY2/Fb6gjawcveJ7H/Z9vWLEM2Ey5d/D/L+nYr
   A==;
X-CSE-ConnectionGUID: Fc76kMU1SXmpev8sTS03RA==
X-CSE-MsgGUID: UO5HDDDOQSKjr8DIO/agtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69055642"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69055642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:23:04 -0800
X-CSE-ConnectionGUID: 1/n3ghnvQCCDmAPB/Z8n/w==
X-CSE-MsgGUID: o/m1M47mR4Wb/2QQj7IiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203363366"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:23:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: cfg80211: cleanup cluster_id when stopping NAN
Date: Wed,  7 Jan 2026 14:22:53 +0200
Message-Id: <20260107142229.9ccb700797ec.I890ac852be6ca0093995655d987ca5c28a26ce3d@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When NAN is stopped, cluster_id should be set to 0 to indicate that we
are not part of any cluster.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9a420d627d3c..4b18c10ce8b8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -265,6 +265,8 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev_stop_nan(rdev, wdev);
 	wdev->is_running = false;
 
+	eth_zero_addr(wdev->u.nan.cluster_id);
+
 	rdev->opencount--;
 }
 
-- 
2.34.1


