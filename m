Return-Path: <linux-wireless+bounces-19888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A2A5483C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63521891724
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571682063C7;
	Thu,  6 Mar 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUpo/Ds4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CA20AF9B
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257839; cv=none; b=FIrFog1o5JlbrpBuj/9e2y3hy+gmy3x/7HtHydQSWYJ+Z6BgBW59O+ZTTzuHBGdP1znFwhd1DbZf6LcOeJnqkDQM7o2p/8scARewF9tUXn2GE/EkMf2MrJ6+naPN2tD4bLmkdDGXzpf0vJjzn+A7zKUExmZJK9aGCi2WBrVO7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257839; c=relaxed/simple;
	bh=zKodz0hKk/Ug/8bZRVtOH5ADH9qO7VyFvVqWi8zrCh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQIYtdeAESt1NJoX1d7LDfg4d1TamIxUjlBZg+U8XqwxR4bcJBp8Wx4EsaBlJ+WNUI0P7BcpsiUd5CHpBrTqov3Re7aYtio/zcK6QrlIn6W7Ii0RftK16X4/iUgAiO1GFALmZc3IUn8t2o0l28SIHyYN8S4eg8VPWXrpGOVeFMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUpo/Ds4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257837; x=1772793837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zKodz0hKk/Ug/8bZRVtOH5ADH9qO7VyFvVqWi8zrCh8=;
  b=cUpo/Ds4dyz4dfSEf2pOVbq9fbXraCIL3uX5dT6aVJ+v4Puv5xIfX/h7
   ykaHWX6e7pRq/pS+nkzixqwbuMkj/srU4ReY0rjXDjk/OvuxkN5PuhJN2
   k6r59dU2i7HSw69/PQdkU0c0HbD+BFVbNLUdOxIERDDN9CrMoEUl/0hvF
   tUMylcXqB0QC9c4PsKRq6b7IhjlHbNtOcDRBLSpOV6GtGQGy690byS9Cv
   vxF3hTSeIR/fIou7maFGYIq+cNxl2aEvothwWx7WDKt53Vu6PRZB6y7cc
   k8b5Yl45k6aclj2Ro6eo5M3jDU8m5wljnkhV5fpUbddreqxRTbvekNtJI
   Q==;
X-CSE-ConnectionGUID: 0jOjyai2Si6Ojn16u6KmXg==
X-CSE-MsgGUID: DwXd523kQWuDSaHLwLs9cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844504"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:56 -0800
X-CSE-ConnectionGUID: dFcas984Qga1/fVb7yXNXQ==
X-CSE-MsgGUID: OX6/7WwrSMOz/Z8ajvop5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797772"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 11/15] wifi: cfg80211: Update the link address when a link is added
Date: Thu,  6 Mar 2025 12:43:22 +0200
Message-Id: <20250306124057.6ae37b21922b.I79b010ea9aab47893e4f22c266362fde30b7f9ac@changeid>
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
index 6f76059c0aa5..558dc88b9f07 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9771,6 +9771,7 @@ struct cfg80211_mlo_reconf_done_data {
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


