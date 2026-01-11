Return-Path: <linux-wireless+bounces-30647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B260CD0F81D
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 448283025315
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C65B33DECD;
	Sun, 11 Jan 2026 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6KlS1mh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC63199EAD
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151982; cv=none; b=LA4JFW0Kws0R/gRCrEHrXQZYCkRZ2QS/L+aCnKBfHVryuw4CqiReN47szYVRSW9OBhN4J8S7yMwa+wqF7F+jKliTlaYsIooiuj8aBj1l++y7iriLH6XR1yxCCXD+jq+FKyprQB0DyXlX1AjGAP2fGgDW2UGyIJSo88SsNTgSkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151982; c=relaxed/simple;
	bh=t08yN5cD+LEz06Mg9htooHpyb98WTGKg1959iO1k+Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKwa6c45iQyHpicyxb0tQGrghcITIjCB0gNyv1Fo1LzonEZ98Rqzz9B5q3+huCOnZBxa/hkzTMSdGOGMwD9vCQ++nRnyeqqOPv3yh43fJMSMniGiYJhu5bc90p78foTev1tI0ki2DyQttja2qXY2CevhTI+ZthmeBVxAU/AyxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6KlS1mh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768151981; x=1799687981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t08yN5cD+LEz06Mg9htooHpyb98WTGKg1959iO1k+Ko=;
  b=S6KlS1mhpmPb7C6r1cFI4RBIuSHkluC3hl2XRcNt4TTmAkIl3lEdBVqF
   aD+e30/uNMyPzmsvn9gp4Dc9jxcm2g4YrErAsXf5cxxovHdQ0g5RLJQEf
   3WDYLvUEsWadICokztEDm59z3dLb1yrx/mSqUU3F+r+D6bjjED7qCknxC
   oz+92yFCEKquP/a2YegWqZUQXSdV1o86VPyiW8RY3zvfS7hr94oiwjg3l
   8Lcyg5KGvI2kt/7i+tqiS32pe/nB3rEOsJsPYs0zppLOMVCef0OrnZ8Xy
   CFAgIrsnoRnDI5HuJ7QTh677Qit37eVFgGHYYlMCUC3y18FZWCp4KfL3B
   A==;
X-CSE-ConnectionGUID: M2I7yjlZSdmLg0OTUoxqOg==
X-CSE-MsgGUID: BfjGboZXR8mAsg6zHlOXwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69343774"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69343774"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:19:40 -0800
X-CSE-ConnectionGUID: Kdj4nDUqSAaDd4LYX5+WVA==
X-CSE-MsgGUID: jGerxj2ETWOcD0CC4/dLdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203707103"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:19:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: correctly check if CSA is active
Date: Sun, 11 Jan 2026 19:19:30 +0200
Message-Id: <20260111191912.7ceff62fc561.Ia38d27f42684d1cfd82d930d232bd5dea6ab9282@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

We are not adding an interface if an existing one is doing CSA.
But the check won't work for MLO station interfaces, since for those,
vif->bss_conf is zeroed out.
Fix this by checking if any link of the vif has an active CSA.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7b0aa24c1f97..515384ca2f8f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -350,6 +350,8 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee80211_sdata_running(nsdata)) {
+			struct ieee80211_link_data *link;
+
 			/*
 			 * Only OCB and monitor mode may coexist
 			 */
@@ -376,8 +378,10 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 			 * will not add another interface while any channel
 			 * switch is active.
 			 */
-			if (nsdata->vif.bss_conf.csa_active)
-				return -EBUSY;
+			for_each_link_data(nsdata, link) {
+				if (link->conf->csa_active)
+					return -EBUSY;
+			}
 
 			/*
 			 * The remaining checks are only performed for interfaces
-- 
2.34.1


