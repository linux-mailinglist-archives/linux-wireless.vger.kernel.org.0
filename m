Return-Path: <linux-wireless+bounces-4845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0949687EE0B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389681C20CA0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AF654BCB;
	Mon, 18 Mar 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPTaVT6N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241754BF1
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780829; cv=none; b=BP1jUlWCK5e013rJRBkFKIWFiN60DCwrY/bWo8eD/YF5n8yCcQn2yClaJ96Ed76NrPy0rI7jrP42rsnRFOx5fROq+SBWirgs8Ts0l4uNOxI0ppHn6U2/ipi/tyeyiUwPZ0a04R9SZ4s2k349KvxzRkwy3kLNXacfOHCKa4eHsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780829; c=relaxed/simple;
	bh=3onFUZnNbcOkZTNuoeKtcvPha8NsDXZipwSyWwvwFT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGcFyqHLeSDiLz+/+AhInPYAkVTcRWszsv6yOqpq+rCfV1+B1Pz4vy5PAtZOwi7TlL+iFDTbWaLeRB6YyZaKk0zkbRh4WbL7qKCgEv7mckdtFKKob4iRrDqF6IcQ4m2WwGnuhGWGTYnErTUTrQLrlQZ0nw9YVDF4z6/prww473U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPTaVT6N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780827; x=1742316827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3onFUZnNbcOkZTNuoeKtcvPha8NsDXZipwSyWwvwFT8=;
  b=JPTaVT6NkB/ExBaqJZ4Qj9ho64sIxC6jMI+sMqHjm756ImFfmAY+hMr5
   uQHKgEshg8JJ7vWgO1mCM9kHeYETJCbDgyj9y9iRFm8TokRKRbRJllfRu
   3TId2+E6XeI56zYUpjT10QyLS6dyUHpiIZnbnv1g2FI4yn3yeidLFV9SM
   YywYLf5oaJ4Wnr6jVXBuhJiL4k1B3YiCfmX9nePXWtuRrFRn5V3nSk1AV
   mthpqYih72PKAW9In5f/iay7sxd0qCb5h0kAH/UMktz9SSR+mxL1Rehk1
   Z+dHcCy2hA3NX7y1jdqwqnql6/eYkZgi5dacegv14xCKVfHzsmgpZSgoP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819372"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819372"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909746"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:53:46 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 02/15] wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
Date: Mon, 18 Mar 2024 18:53:18 +0200
Message-Id: <20240318184907.00bb0b20ed60.I8c41dd6fc14c4b187ab901dea15ade73c79fb98c@changeid>
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

If there was a possibility of an MLE basic STA profile without
subelements, we might reject it because we account for the one
octet for sta_info_len twice (it's part of itself, and in the
fixed portion). Like in ieee80211_mle_reconf_sta_prof_size_ok,
subtract 1 to adjust that.

When reading the elements we did take this into account, and
since there are always elements, this never really mattered.

Fixes: 7b6f08771bf6 ("wifi: ieee80211: Support validating ML station profile length")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index a99f048404b8..4fd9735bb75e 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -5302,7 +5302,7 @@ static inline bool ieee80211_mle_basic_sta_prof_size_ok(const u8 *data,
 		info_len += 1;
 
 	return prof->sta_info_len >= info_len &&
-	       fixed + prof->sta_info_len <= len;
+	       fixed + prof->sta_info_len - 1 <= len;
 }
 
 /**
-- 
2.34.1


