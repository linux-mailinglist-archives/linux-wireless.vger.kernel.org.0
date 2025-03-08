Return-Path: <linux-wireless+bounces-20040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD1A57E60
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E27188DB66
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FB11F5856;
	Sat,  8 Mar 2025 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enEl3vB3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11641A08B1
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468028; cv=none; b=XhkaHVCgfzM70gCRTEXJlHN7/AgJ5VrwHJFa+GHryV/0dvh+7KGXlP+6W9tB/iSKBF/7C/NIbT+E2RPHUWc5C14wEX7bFIkC5BuhUwpW3Yoku/mDDeFpWWFSweNWNGH/YMKiIXYKVvlWtdZTDMIsZY9Oa7IyvSwivWu0JXewvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468028; c=relaxed/simple;
	bh=ArgH9JlAkzQ9woISgtCsFUGUTK0Fj6MEK5ZPoOI4TME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/8SpLs1fQpSydbFTlZyo2SMih3KuMBNsyelq9wv+5NAC4v+Gh4O0D05PAbHyzeJZb0RGmSzelBs+RftZFeTdRSmX8goxUBmKe7dgfpbpv9Q7eETkdzZl2BBbXpo93tTDDAL1E4RIqTADJCAJGiooABY4mdsD8SnqHUB//DMJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enEl3vB3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468027; x=1773004027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArgH9JlAkzQ9woISgtCsFUGUTK0Fj6MEK5ZPoOI4TME=;
  b=enEl3vB3vLBeW47nTJNJdZDAuptROL0gsCm1sebpql3fK+WwukOgOKge
   Flq6ZtbdyKuUVpC6l1Vaby8pMYk68SlZCMJ+QaRhfbDKVEWHAhkRrWE2j
   CWd6oHx5iED7yH5HsR3qJtaMqYE71F2V41ELdI0uVZZpwk+08XEv2+wvf
   hJbefO5oVpgRHwsrGIDGWsP71PDBLv13oiggryUAVXSL5sQStHkG5QU1S
   i0xJjsS3xm4VG4jNH1tIh3icFzRWnth2FEAA2bJBj91xqdsJ0JDQ/kgIl
   2Vb1mln3lJzefCPCnykGbFDAr8e3P//2tGuuTC9vZmC+0dEUJWecwGJcM
   g==;
X-CSE-ConnectionGUID: 1QPaGjP5R5i6vNlJ2kNtGA==
X-CSE-MsgGUID: DNx9v1jtT+mvijsuWrn0DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413106"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:11 -0800
X-CSE-ConnectionGUID: D4q9Iq60RICSZN4vlX7Vqw==
X-CSE-MsgGUID: 1foGsPJ1TLC8LKyBevNcIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644415"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:04:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH RESEND wireless-next 11/15] wifi: cfg80211: Update the link address when a link is added
Date: Sat,  8 Mar 2025 23:03:37 +0200
Message-Id: <20250308225541.d694a9125aba.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When links are added, update the wireless device link addresses based
on the information provided by the driver.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 1 +
 net/wireless/mlme.c    | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c61894c1265a..73f0e75cc814 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9770,6 +9770,7 @@ struct cfg80211_mlo_reconf_done_data {
 	u16 added_links;
 	struct {
 		struct cfg80211_bss *bss;
+		u8 *addr;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 };
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 956d33b219df..05d44a443518 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1360,6 +1360,10 @@ void cfg80211_mlo_reconf_add_done(struct net_device *dev,
 		if (data->added_links & BIT(link_id)) {
 			wdev->links[link_id].client.current_bss =
 				bss_from_pub(bss);
+
+			memcpy(wdev->links[link_id].addr,
+			       data->links[link_id].addr,
+			       ETH_ALEN);
 		} else {
 			cfg80211_unhold_bss(bss_from_pub(bss));
 			cfg80211_put_bss(wiphy, bss);
-- 
2.34.1


