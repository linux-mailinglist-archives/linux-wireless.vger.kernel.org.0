Return-Path: <linux-wireless+bounces-28080-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 875FEBEE167
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 11:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FAE44E3937
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE5126C17;
	Sun, 19 Oct 2025 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhdQQf1B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07929BDB3
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864462; cv=none; b=ZEOb53PICO7EQxflXptix2GH7g5l71PP6n14WfJnin6ShS0H7PR0Cf7+rwhZfy30phkxpQY5DhwL2GSz8kJGB8FvCI+DJ7s35MHKnWiDqVft3eG+pZRNvudXNGdPYPnN35FQR/0mgWx1mrn4Hid1sxtpoFZCPKEsZnsTJQmYkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864462; c=relaxed/simple;
	bh=jt5DpbjzSC1/cmVApE3+zYYvV+MTZw+S6xUEl3ggPKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ozsKcdAYRmfoX4VD1mZvAtKiRHrLgZFRWTMkP6wbjJfntShcS4DgjiEfshROmbZp8zSQCDa2JvePwA24VQOZOgj7hRl0+dqpiqgwwt7rgyCxUSSV0tnr4hWBbZJSOh70ehRJM8BYHczwkD7duCFXeK8IjUi7AVRejxgDcIlkY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhdQQf1B; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760864461; x=1792400461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jt5DpbjzSC1/cmVApE3+zYYvV+MTZw+S6xUEl3ggPKY=;
  b=OhdQQf1BSijoaqLCpMpFY1PLlMud73rQl1pAqk1MZuN5wVtw2YSFIah0
   ZO8HzHzYkZjn33zxEuc2YUEweyHBHEFeVCBxt9k7/GkMZUYMJ9yfxVprH
   rHVVUfIMa360CXZFNSaeH+MLmxbEnDGBoVVcKb61U+POlTPZEjXMXFyWi
   cXBHJoJPeMXvUJttfDl806fypc0Q/ZCGGzli6TlvESHkseeMWMFBvbuYv
   ZhS8EW9moqOTasZC9/lh47aOYT8p00u9Y+HJvY/mr3fWjh87cUD3tsaa+
   tWCSlNflSNO8k7RHJka4QrUbkR5rZJmzAcBsNeI8cpL/00/b6ykR7cKE9
   Q==;
X-CSE-ConnectionGUID: oeIhqa+OTqK0Ph8C/rSeJA==
X-CSE-MsgGUID: A1qkBZ0sQgW4yHeW14v+Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62719980"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="62719980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 02:00:59 -0700
X-CSE-ConnectionGUID: gygK6pKsRCS4EFmiB14owg==
X-CSE-MsgGUID: 27q6JfgGQ3Sd1nfDS/Dupw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="183860398"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 02:00:57 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: nl80211: call kfree without a NULL
Date: Sun, 19 Oct 2025 12:00:51 +0300
Message-Id: <20251019120040.c62e9b9a0eec.Ice40c7be5447410ee74d48a6eeef1711c719c55f@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Coverity is unhappy because we may leak old_radio_rts_threshold. Since
this pointer is only valid in the context of the function and kfree is
NULL pointer safe, don't check and just call kfree.
Note that somehow, we were checking old_rts_threshold to free
old_radio_rts_threshold which is a bit odd.

Fixes: 264637941cf4 ("wifi: cfg80211: Add Support to Set RTS Threshold for each Radio")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 852573423e52..46b29ed0bd2e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4012,8 +4012,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.txq_quantum = old_txq_quantum;
 		}
 
-		if (old_rts_threshold)
-			kfree(old_radio_rts_threshold);
+		kfree(old_radio_rts_threshold);
 		return result;
 	}
 
-- 
2.34.1


