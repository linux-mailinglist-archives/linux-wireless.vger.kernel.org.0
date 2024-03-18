Return-Path: <linux-wireless+bounces-4847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C287EE0D
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE47B23F88
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1B54F89;
	Mon, 18 Mar 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CquGZVEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57054FA4
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780833; cv=none; b=cHO0UqQWb7khDgR78azW9FJcbE8j6HqOaokqYNaiHQiWFVC2jRBnYpImDb+Pp4ZpGb6c5nPDqFxgUmJxoY2jhBoWUJ/szZVi9N+WIPeIfiq83klIaQ0WgZSeztyvijhv7texh/qOqgEIUhkheLLR4Fwgf9pIYwPFXo0uG1Kh7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780833; c=relaxed/simple;
	bh=2+XOSAA3/2dmu4rimYG5Vy0Jx+I0tooRv+/7+e9me3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fd6Nva86lKafamgvDDM4yfgtM6VBpH4AOfPON79Xa5n3KW5uI6uY3p1qVnGmTx+JZkKiFwPfFhEbrSG19tIYVnFr99Gm89s6sCnMVfNCl3JrhJCoPWxxHhd+9SIsmMDTuDyZfZtYvE3P+ocuaO/dhQLpj6/uCBprfBy5zg7XueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CquGZVEx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780832; x=1742316832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+XOSAA3/2dmu4rimYG5Vy0Jx+I0tooRv+/7+e9me3g=;
  b=CquGZVEx7MZQJulFm9RCsi0hiCBNWF47Sqyw3DyNHNJOTS6ICW/QqPp3
   bgEwDX7713PT+deoXCt2E7wx6+GUNtmtT2roiIzv/C+Ut7O8Bx6p96fSf
   J+vhwXN61L16RlWfsE3ZDLBTWb/SL3LjlW88jL0YcvmYtwH8rt8TVoipZ
   iLOQQ9z2Ff83XuCMnnjg83YtAkEia3Mu+ipdNlDHINopdsIM0QOF9UH3i
   WuIcsyvhUdfgo1uFEojl2M/yrpRq8ao2yHNuJXNJmPY+80pCAZe9fI30E
   diqjvyyhb80t1LD4CywrqPt+82OE+NP5APA3gBKgNG+Ajtud7l/J4W9Na
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819388"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909782"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: mac80211: clarify the dormant/suspended links docs
Date: Mon, 18 Mar 2024 18:53:20 +0200
Message-Id: <20240318184907.a5b24595b1a2.I92dd7d177b25df189b842d3bcddb1f2b13b1de13@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since I keep getting confused about this and asking about it,
update the documentation.

In the future, especially when we add more reasons for a link
to be disabled, we should add a per-link 'disable state' bitmap
instead of maintaining all these bitmaps with subset logic, to
indicate each of the different states separately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..47fa73a62f8a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1921,10 +1921,12 @@ enum ieee80211_neg_ttlm_res {
  * @active_links: The bitmap of active links, or 0 for non-MLO.
  *	The driver shouldn't change this directly, but use the
  *	API calls meant for that purpose.
- * @dormant_links: bitmap of valid but disabled links, or 0 for non-MLO.
- *	Must be a subset of valid_links.
+ * @dormant_links: subset of the valid links that are disabled/suspended
+ *	due to advertised or negotiated TTLM respectively.
+ *	0 for non-MLO.
  * @suspended_links: subset of dormant_links representing links that are
- *	suspended.
+ *	suspended due to negotiated TTLM, and could be activated in the
+ *	future by tearing down the TTLM negotiation.
  *	0 for non-MLO.
  * @neg_ttlm: negotiated TID to link mapping info.
  *	see &struct ieee80211_neg_ttlm.
-- 
2.34.1


