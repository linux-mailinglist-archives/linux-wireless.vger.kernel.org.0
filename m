Return-Path: <linux-wireless+bounces-23877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD6AD25AE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE543B1881
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942921D3DF;
	Mon,  9 Jun 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1BQVD8e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2234C218EA7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494148; cv=none; b=FjliLDB1R7dziZ49/xJRsN10LaygYfDlYdAkXdmquNhajkZDATGwybZRaN6WJKRQAmbMuT81AyccpG5LY/NCChMltrblpumPcPvq/Sq+eKJF6j/WStvKCqeRiIRIiqnmM08FP0i+vK2JCED07TF3LV7LWL+LYPIBWuIhS6GRw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494148; c=relaxed/simple;
	bh=BVbKGWCQzkMBHmIUjRqfQqmKZg3m508KuozMaURCByw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur6TbNdoTVtz7r+DaHm0TeSpK/sDe2PBqebovc8hKykuTLC2+R+yxjXkj4+ebr5oaHwyOV0eJ378CZZGBnH98al49TKwT5qauj7nyxbOmT+9b3cPkBFIJFoeJVun9c/nfrKMGkcgejU053K7RmzAXk94ATBhhVBrh1qRynb/cwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1BQVD8e; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494147; x=1781030147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVbKGWCQzkMBHmIUjRqfQqmKZg3m508KuozMaURCByw=;
  b=F1BQVD8ewJAI0Q9t/8kf1kdJBDnuO2zvxDsA1b+sR5CLg00lDx10F0fV
   XPRAwsnqu+6Hc+7Wqog1nMHRDlDmXPDOpjCJJGKQNPbmDY9WfpwL+S+eT
   z1lVzEjtPWMJo/IePRD2CI5ETL//sXYgHgpaG0HzMhxFXqoPX0CVYm4OP
   ElPdvesh6wByBFj2OnMTqg7vjuXSPZR1FEq1F5+JwBsp6tAAB09GaGiTp
   an3Y06zQ1T34q/KERJZrde+x41ROrTHGS+n+zvV4k7pyG9/nUYRSNatJf
   3MBfqEHqtWjN7YY5m9lM6oaLtFZ5+OZnKvx3hl1kU7yI4ZNeeGnZKOKls
   g==;
X-CSE-ConnectionGUID: hHDguDHWQX+AJU+XjEAgEg==
X-CSE-MsgGUID: 2Y0y9Z1fQGibz8Ml7NNmTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249750"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249750"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:46 -0700
X-CSE-ConnectionGUID: 9ugbW7mVRhqh21S3igmB+g==
X-CSE-MsgGUID: i8VxZLQpTIOzKfhq6StbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732450"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:45 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 02/15] wifi: mac80211: Fix uninitialized variable with __free() in ieee80211_ml_epcs()
Date: Mon,  9 Jun 2025 21:35:14 +0300
Message-Id: <20250609213231.eeacd3738a7b.I0f876fa1359daeec47ab3aef098255a9c23efd70@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

The cleanup attribute runs kfree() when the variable goes out of scope.
There is a possibility that the link_elems variable is uninitialized
if the loop ends before an assignment is made to this variable.
This leads to uninitialized variable bug.

Fix this by assigning link_elems to NULL.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b84150dbfe8c..d8953a855ab4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10701,8 +10701,8 @@ static void ieee80211_ml_epcs(struct ieee80211_sub_if_data *sdata,
 	 */
 	for_each_mle_subelement(sub, (const u8 *)elems->ml_epcs,
 				elems->ml_epcs_len) {
+		struct ieee802_11_elems *link_elems __free(kfree) = NULL;
 		struct ieee80211_link_data *link;
-		struct ieee802_11_elems *link_elems __free(kfree);
 		u8 *pos = (void *)sub->data;
 		u16 control;
 		ssize_t len;
-- 
2.34.1


