Return-Path: <linux-wireless+bounces-30648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA03D0F829
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A81D305B1C4
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589534D38E;
	Sun, 11 Jan 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LA/fYB5Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AB5348884
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152343; cv=none; b=TDub18n0t6tgC1f0oD4UW3BrwxKOlBjnABkagv6jKW2JTnmXbHZzRWeHuUK/O/YfYZMb/03c2LSHvtR3VJmepypf9UNT9tyKDqrCtnHP7GdM2oaFFB3lHZTUUzYz0MN9FvU1mIuaI/PcD7dcyuO1732Kkzqbyl+LSmb2ThU7kmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152343; c=relaxed/simple;
	bh=o4wPKKTjBZIzeKnIH9ALvZfmBQ6RGpCg/3aH1RdNLnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JNxg/ORDtbjaTjRe5DOWZxnmnV0+ov0qyjXkqmeDaRgDJYdH1a/ahLPEvxtTRBwFx77TzAfI1AIR2gQgmEK30kxvKUOuJXMj54GX4mgPSi1VaIMvhsFX9Ou6EqS1aO91BOO6a7FhNMeBXaMVNoARM7jhDWHqgqxtU7nay+ZKhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LA/fYB5Y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768152343; x=1799688343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o4wPKKTjBZIzeKnIH9ALvZfmBQ6RGpCg/3aH1RdNLnU=;
  b=LA/fYB5YgOd8Z7ukUEUVFsFKL3cZm4Y+SAju6ZGELYGdLad/7v2UrNOm
   nGNGWSJkrjTcStKkLF9dM1p+sLawisyNJ5lUBwHaCYosLB37n03EMKJSD
   e+gg9jhtv/teW6r8H6zoAx2kd4TnzdByJXZlsLa8reLL4glRXQmnfabs4
   95YVpGfevyCFFxCCowPYORMB5c+FeGGbOK3nYxL5M6JE1qaIN/mnPYzha
   nfxGD1oty3CsiAOu1sN9xyjyJ6u0+kZZput/YokD+NTijUFGqKqg6KHar
   10y4SthTlmav65FAdipN38nK2g/v9EkWOLewuFiVGhLoijzAu79pnG7ZR
   Q==;
X-CSE-ConnectionGUID: MB2vV6cxQNGJYYr6e06EsA==
X-CSE-MsgGUID: mBpGTXsVRaiYjdgwb6ygTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="73289019"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="73289019"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:25:42 -0800
X-CSE-ConnectionGUID: QKOuI2LDTACgLIAgZqELNg==
X-CSE-MsgGUID: OvOZZgSgQBe45EDRqFqLXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="203117425"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:25:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: don't send an unused argument to ieee80211_check_combinations
Date: Sun, 11 Jan 2026 19:25:32 +0200
Message-Id: <20260111192411.9aa743647b43.I407b3d878d94464ce01e25f16c6e2b687bcd8b5a@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When ieee80211_check_combinations is called with NULL as the chandef,
the chanmode argument is not relevant. Send a don't care (0) instead.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 27c234948fbe..6da32bd4c6c6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4409,7 +4409,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 
 	/* if reservation is invalid then this will fail */
-	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0, -1);
+	err = ieee80211_check_combinations(sdata, NULL, 0, 0, -1);
 	if (err) {
 		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
-- 
2.34.1


