Return-Path: <linux-wireless+bounces-1004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C058818E63
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A21C24790
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47633374F3;
	Tue, 19 Dec 2023 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOU+6Kq3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1F3529B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007684; x=1734543684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7cikeZ9HkLQ1x/zPufMhykvGnNokKD5JPSkn/e1ock=;
  b=KOU+6Kq3WKLb2+82Q9T8vpORjFGAnF7y+zf6Vh/3TfGswFdPczas8Xyo
   UpvcvsMKemiQiht7uhDBYSpwu+zjipleuXITCr2XP/3fRNZsbG2A1wX7D
   MGnYOyub/eCfKsZp6r5aZ/i5/AwjeH9KF9VK7DNl8TOxKzltZ/LJWlKL1
   pr4RoPcfUb1fYjaYi/q4+FbcK5RNIgru1sehagOzhvA1+qGwp3iApd2B/
   J9I86z50iVFH968l7QiKALUwYgTxTVzfOHm0tdSFnRQIwmJNTkJRvLXAH
   60rjiAODombTkoDlle6ZCCSHYUut0XMlwQMayXh3G5OGzQ8ifw9TeJ7GS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790396"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370033"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370033"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 03/13] wifi: mac80211: Schedule regulatory channels check on bandwith change
Date: Wed, 20 Dec 2023 13:41:36 +0200
Message-Id: <20231220133549.e08f8e9ebc67.If8915d13e203ebd380579f55fd9148e9b3f43306@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
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
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses
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


