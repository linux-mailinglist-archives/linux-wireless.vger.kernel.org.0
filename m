Return-Path: <linux-wireless+bounces-16952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4429FF2D3
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2417F161AA7
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9C16415;
	Wed,  1 Jan 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iAXDC/NC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D911187
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707958; cv=none; b=SSGz7zI6nEWuLG99JebxAPiShdivW1vSXaib4lEOAztP55Z7bP10DIQ3JrNY5za7iK4dJI/4EW6S6jlBKRIwmvHkljvFmUl021NAXdxQtyaQmtE8qm8ZI49irZ8jvKZX3LZN2ZeyN8FWfC7FGoCJoUuduYaMfKySBvLbDqzcfX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707958; c=relaxed/simple;
	bh=gDSbOwLR7Dn1rkujTb+WDkLn//6WrtzruJDAiXHv2C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJ9mdpqOWmaagfpkDa1DSgwWhuzvMjSOHo6e7WwTUx9xHO8O3HABcWE/aqW0/l/2QdAhe4YLSa3Pys/CdgVQXOYVYlkF2y1veXvJBKJwAf/9MiLVXrVnVwa0kGp5FPqcNiD2C8V5YJk9R52bAdojiT4PkJwtMHCmW5a3RzSS1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iAXDC/NC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707956; x=1767243956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gDSbOwLR7Dn1rkujTb+WDkLn//6WrtzruJDAiXHv2C4=;
  b=iAXDC/NCVte8jloNy9tcDzMU/8Eo/EmFlEhJJ4AIaYLD1M/zAeoutDzo
   jg4KaIB5HlbMgIKXTSOHJHKi0ca82JgDeba/oqDVXhvH3GpNA49Pc4NmV
   whr3ZxhR6EwEndS3flCpGRWGrUPmnVyDesy6pMzdxtbJ+/oW6txmw+ng2
   WqCKBE1bN2ojcGNKydv3/fmWmROz12uQAgbTxGv6qD4cvsDpouUPz/4uu
   wLFCRIZN0cxEcv7qdu0vmo/ohSC351opeSQL00uCd0kuUl4b/DpJkjfb1
   hmw14xEE8HM4pODZ9R9NwQyqHscUDGGnaOMNl8QcJhsKW9zi8/EGuVJcY
   g==;
X-CSE-ConnectionGUID: aSFpxzFkSACYRnieStygvA==
X-CSE-MsgGUID: IWHK/bTURH+imyBaH5AqwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194399"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:56 -0800
X-CSE-ConnectionGUID: SQPK3DwLRveMPK5CnZNAMw==
X-CSE-MsgGUID: O6iX/nMXTRq4z40Pj37x6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/19] wifi: mac80211: remove an unneeded check in Rx
Date: Wed,  1 Jan 2025 07:05:22 +0200
Message-Id: <20250101070249.033096029d0a.I0923387246a6152f589d278f27f27bce52daee79@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


