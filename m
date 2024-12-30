Return-Path: <linux-wireless+bounces-16885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCE9FE27B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1A71882190
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5AE16BE17;
	Mon, 30 Dec 2024 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJtO9sw/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F135513D52E
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534573; cv=none; b=YWC8CmmsEplweON+E9Ky17DUjLFqvR4iJmVV61I70ZSQ7aNLWwjLkOboUwzNOecubmPtnPMiS9Bz1BXUA6VPnVqdabmRI2XY+W39CfME9oaZ6PW2KsAIWHpo+w61frkIWlsQzi3IP2y2NJeaTcV34MVrviW6UhMhW2N95G9j2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534573; c=relaxed/simple;
	bh=gDSbOwLR7Dn1rkujTb+WDkLn//6WrtzruJDAiXHv2C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XHYHBWayOT6GsJAQpVWTRWqBnr8/xQivoqkDjMpaMdtDoTo7bmTpQ41aWf7jKJykoNqF0g5spZVCpHgsu4MvIiWWZ1Cq8gO7f87DIxRyusruPQzriOPyQlCJhjP86HcLkj53R1MSplzDRuvWZbngre/aWQ7oyUJzR+/+JyDgwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJtO9sw/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534572; x=1767070572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gDSbOwLR7Dn1rkujTb+WDkLn//6WrtzruJDAiXHv2C4=;
  b=FJtO9sw/Xa/pz3WEEm/epT/R6RGTFYzahwa18JlRTGLzRl7/NKpxRxYT
   AHZ3g8R14r9p2MKCppE42JWyGGiAsDog8PfRDLbTcK8BO5/GJQZd2nZJv
   YI0jz65bxg81BGt4o145FIGrSAmTeMdoUzDXIBEMwUqDlP7iMXCEZTgqs
   B23uThLXDpD/JUoO+E7MgtEjw3Whsu5+l19lXLEEJjS8GzavrGFeyi4RC
   Yn3ZPM4EEFwDrsMj1pOKlnxhx5ArNXiGu9SBKurg0TxYpG7N7laGaqX75
   V9OFaWDgM7j7t6xqNj93jNfBzgVn+LUmMDDEA252cTlx3x7IzAnTwLQCX
   A==;
X-CSE-ConnectionGUID: Inrm0JplT1Ol/HG0EJ9EWg==
X-CSE-MsgGUID: RXs7oaieQku24pamMRtJ/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405002"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405002"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:12 -0800
X-CSE-ConnectionGUID: Dac+mZDkRquJuh/ORHXqNg==
X-CSE-MsgGUID: MjpRRLfCQlucAjT6F7RuYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758869"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/15] wifi: mac80211: remove an unneeded check in Rx
Date: Mon, 30 Dec 2024 06:55:41 +0200
Message-Id: <20241230065327.033096029d0a.I0923387246a6152f589d278f27f27bce52daee79@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Coverity pointed out that __ieee80211_rx_h_amsdu() checks if rx->sta is
NULL before dereferencing it but not always.

Since rx->sta can't be NULL at this point, just remove the check to
avoid confusion

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 58c1b9a4e8b5..3c0cc3cf5ec8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3034,8 +3034,7 @@ __ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx, u8 data_offset)
 			check_da = NULL;
 			break;
 		case NL80211_IFTYPE_STATION:
-			if (!rx->sta ||
-			    !test_sta_flag(rx->sta, WLAN_STA_TDLS_PEER))
+			if (!test_sta_flag(rx->sta, WLAN_STA_TDLS_PEER))
 				check_sa = NULL;
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
-- 
2.34.1


