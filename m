Return-Path: <linux-wireless+bounces-11118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D922794B96A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE581F21D4D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D054188CC8;
	Thu,  8 Aug 2024 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KM47AUyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AE146019
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107570; cv=none; b=GSJArPk+EswLrvE4tWFx//njuI2Z+AFHc+95RLAXYRg+oZMrUH+1bAkYvR0wI3t/07DXgFqY7zNqbYSXxdtS9IgIZRHd9WLawr+s2NwflS0y+yilexiurievcWjh6XCUPxyPsdWtzDR3fGD8m6z0GaRCpxa80JKtA5eHRA4pyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107570; c=relaxed/simple;
	bh=F3xVsznyETlRg5wYtweRekzYR8vyv4wtIqm9zF8RKv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCNeyMc1CBYBWOO4DRwcZnQFQzqzjqca7FPTMbPwhij05h7JB4493xDps5wtAjvBMiHZnw/XPnmgZPWamDlxkVK3672eJO5mAxd976gw/MgorSOYQZzLJmt/RlEnVFaWM0QL/DQUFOlGlvEWuf75zkpTr86S9C9LrCYq/wNgw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KM47AUyU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107569; x=1754643569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F3xVsznyETlRg5wYtweRekzYR8vyv4wtIqm9zF8RKv4=;
  b=KM47AUyUZfIavoCme/2yQeQXArzetSAUlHARbK7x4IK5UH6aiDGiALHu
   Ch5LcNBsDA1AyL3uKgmSAqppXrw9ezMHMmQJoXdjia7HlUELR7atmhlu5
   zO5XE7qxkewN9XobDENi3n06AwTmTpSDyvb28ljVfY1G3Z76b4OTrLvOW
   Du2qhGFdZhKvUSn6qcxPSU3rzoepFVlcrn0Z0N+NamS2V2j92JAU42c7R
   nKsdSwT+EUJdmplCTVM86vnXPBQMZBcykxZFy6VhWXt+UOEGAXGOiDr5l
   dukcncJacgH6ovDjBFkc5W2vtsDvMPhiKv6s3kCY9PXiGn5luWLJH97gH
   g==;
X-CSE-ConnectionGUID: 3lLAcJ+jT9CigdX4uPsMnw==
X-CSE-MsgGUID: lCFqz0YCTW2dxroC1+WqUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21078860"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21078860"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:59:28 -0700
X-CSE-ConnectionGUID: k/N7ZO0ITXeaeTlqh6RtfQ==
X-CSE-MsgGUID: kozUkj+MRdyVUxqwx/FuBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="88059392"
Received: from egrumbac-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.245.251.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:59:25 -0700
From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To: johannes@sipsolutions.net
Cc: j@w1.fi,
	linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] wifi: mac80211: fix the comeback long retry times
Date: Thu,  8 Aug 2024 11:59:16 +0300
Message-ID: <20240808085916.23519-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we had a comeback, we will never use the default timeout values
again because comeback is never cleared.
Clear comeback if we send another association request which will allow
to start a default timer after Tx status.

The problem was seen with iwlwifi where the tx_status on the association
request is handled before the association response frame (which is the
usual case).

1) Tx assoc request 1/3
2) Rx assoc response (comeback, timeout = 1 second)
3) wait 1 second
4) Tx assoc request 2/3
5) Set timer to IEEE80211_ASSOC_TIMEOUT_LONG = 500ms (1 second after
   round_up)
6) tx_status on frame sent in 4) is ignored because comeback is still
   true
7) AP does not reply with assoc response
8) wait 1s <= This is where the bug is felt
9) Tx assoc request 3/3

With this fix, in step 6 we will reset the timer to
IEEE80211_ASSOC_TIMEOUT_SHORT = 100ms and we will wait only 100ms in
step 8.

Fixes: b133fdf07db8 ("wifi: mac80211: Skip association timeout update after comeback rejection")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4779a18ab75d..0285924269cf 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7660,6 +7660,7 @@ static int ieee80211_do_assoc(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	assoc_data->tries++;
+	assoc_data->comeback = false;
 	if (assoc_data->tries > IEEE80211_ASSOC_MAX_TRIES) {
 		sdata_info(sdata, "association with %pM timed out\n",
 			   assoc_data->ap_addr);
-- 
2.45.2


