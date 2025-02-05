Return-Path: <linux-wireless+bounces-18509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90447A286D4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B52E1663CA
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89122A7F0;
	Wed,  5 Feb 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9E7FTXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCAC22A807
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748417; cv=none; b=jIHTIlnRCOFb9P7Fxxjx7zecKSPjzUgHFEI4Tx5B/80yHIfn0H4j+tTuWwBfwnH8bTK/SuIgDBf/sKrLXG2Vf82EzfemJ96TxWkEGjMEfUHknkXVN/JrpzNxEW67SqmisCYsYVh9aPDvbb+pyOlafAosuCQMVhunqS8jYmXgssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748417; c=relaxed/simple;
	bh=oVXHJXw+TE6cGHXsWXIugX0oU137gA5zO2dMMeELoCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rSsEk+4yfNZPVqjDShVt9M1hxQ6m4HXFhsTo6OBaPgvjlv4vy4ruXRtcWKSooyBN/rOq1tLQiwqv6nVWbFrLGcCSNHwaQzqVt6K1Lg6IoIxMloZaSvf+bGI+ZCN0mr6xomWQGrm4oK7zz3SRm4GG6LwvOAiJfBrG5nVYUfqJvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9E7FTXJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748416; x=1770284416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oVXHJXw+TE6cGHXsWXIugX0oU137gA5zO2dMMeELoCY=;
  b=c9E7FTXJ+Su718SvkBvhJprTJ0BFzoXOzkyXEmKZv+ZCzVxUE0PL+SGA
   M63Iy2pSgsO0KvfVki4g53WMr2fVJt17ROM0ekOQzbKDnY7H7dpje55w5
   VDvXrrR5MBxwPvnvEZGuNdVGCyubb5u0stngvc9TsS+K3PduVPZ+mOcPG
   D5g3ekmAO4wTFB/rZgW2Jd/3nRUOVA6owP3TRv7Ipf7dd/MP6y9/NqoXx
   Ir08uFFLREcLC45TEJWWi5iQzcDq7Mxa/CJSICM2FcaNJxPnkyfakUUHC
   qLTSJTljLyiDaADYXunnCjcvZPGsVX3E8wRfKMat4D13hGdFywA424aH9
   g==;
X-CSE-ConnectionGUID: VkZlwnpjSfSlTbTWpo/DMA==
X-CSE-MsgGUID: aK44KGZCS+uUEpMgwUDFaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225263"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225263"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:10 -0800
X-CSE-ConnectionGUID: RTWaNYRkRG+Puj4oN5u7Ww==
X-CSE-MsgGUID: LqDwH7tiTXOyny27qosvYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845341"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:07 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 15/17] wifi: mac80211: enable removing assoc link
Date: Wed,  5 Feb 2025 11:39:25 +0200
Message-Id: <20250205110958.05bc2175cea2.I8f62609a682fdf3f703872d0fce63ab6a4780a7e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the previous patch to no longer access deflink for aggregation
it seems we no longer access the deflink for MLO stations (MLDs) so
we can allow removing the assoc link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1d118c30948d..3fb7e624834f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10391,9 +10391,6 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!sta))
 		return -ENOLINK;
 
-	if (rem_links & BIT(sta->sta.deflink.link_id))
-		return -EINVAL;
-
 	/* Adding links to the set of valid link is done only after a successful
 	 * ML reconfiguration frame exchange. Here prepare the data for the ML
 	 * reconfiguration frame construction and allocate the required
-- 
2.34.1


