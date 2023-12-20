Return-Path: <linux-wireless+bounces-967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE34B818389
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F141F2501E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6B213AC8;
	Tue, 19 Dec 2023 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbNNMVs4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765B134A6
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975065; x=1734511065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iW8j2ie8u5EskGVLJU1YHAezWaQ2Se0yEOA6XkvwYMQ=;
  b=AbNNMVs4ejKsuTalrTQSKyuK2BVL+6kZuw5V1VpzPJ4QRn+E/nh4ccyF
   5BOeOXdPtZHqqk5rwNN26H4+W7D8pCCEG95/lapsZDjqvnvci3BuUGW1o
   hLSEFylIaxEQNrggbdkMQUMYX4DlqbSkPEv3q5nI7/wA+kZci74T3ZUo4
   gz8s72AXSo4Fccga8lrEn96a25xUwGzfBjZ7AMJUMaOljJ9yGMF2jU2nR
   lXQ3Uhur9Rn26lQ8ucIhsIhWaBvhO3Cjp5t08k3ZraCSBR4zOahiL8r6Q
   hcDIDY0QfBC63dsFlTyTj42GcmIkP1MCN/mY3znBEgn4lC0hvQHEBDowa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969191"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969191"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266247"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266247"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: mac80211: Schedule regulatory channels check on bandwith change
Date: Wed, 20 Dec 2023 04:37:51 +0200
Message-Id: <20231220043149.2ec1e6a5dfed.If8915d13e203ebd380579f55fd9148e9b3f43306@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Some devices may support concurrent DFS operation which relies on the
BSS channel width for its relaxations. Notify cfg80211 about BW change
so it can schedule regulatory checks.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 40a4fbfff530..fe0be3e5731b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -598,6 +598,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return ret;
 	}
 
+	cfg80211_schedule_channels_check(&sdata->wdev);
 	return 0;
 }
 
-- 
2.34.1


