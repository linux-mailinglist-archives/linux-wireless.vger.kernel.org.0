Return-Path: <linux-wireless+bounces-18459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34521A278E8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE63B3A4949
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C20217736;
	Tue,  4 Feb 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UL+mVqqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B141217715
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691034; cv=none; b=CljEbKR2I2roj0fa2ZiJNMy4JBZG1/E8PuiALrQ33c3e4iQd2yVRcUgJEvBpDMiIMU+ENBJV8jzsQ8mZRIP0rdN8JkmCbDyewTG/tYyWrTL6OO07Ba+4nFb/gR0YXdiw+u/E9PnnDN5WZ7G9/iLA80zdu90ej4zo/VwZjYXGYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691034; c=relaxed/simple;
	bh=erd7G2XY3j3Bv7e6tWorf0W/YkCwIdR9O3U8NYzel6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDblDF1a+PoQgYQV+mqN2xRVK+GnvXnLoxLU2WEg6qxVqjUEgajPj7otuA49u8ofE8OfIAagbS2lyw8edGD9PLWP0XjOVaYGjvDtQIrtccHyeQds1gGXGjuQxMEl5/fuZcbSHuuLtngg61Hhhw0Sag9eNAQyUsBYLldeoCmilHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UL+mVqqg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691032; x=1770227032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erd7G2XY3j3Bv7e6tWorf0W/YkCwIdR9O3U8NYzel6w=;
  b=UL+mVqqg85pyc4u5UeP8baXmlG7aTNc7+0CZoGcPpxF6qpu4VpKfoWQk
   FSA6oqd33FqYP2UgMEOV2GdtFwcFo1gGuXCje3bvOliBjKIGSqW9KxQeA
   T+kfbsiXBdg9IcsHKmVdiVs1fAgBbk58qZ9jNETGSjCsqyGfuuU/9cmjg
   FSlhs+OsEqx4y18jHgyKH2tcd/Fx/W0g5t3mXYgT3HYmeVQUr+6m7bWd+
   qKv6oeAU+/QE/LeExQvfxR7YYZS9RpeQ4yNZWR2uVyCpiDejZr0zURjAD
   vKBdAv8d13dHI0q3aZd21+39fgkc41elQuFbtlsg9jDjONYOJa2SA1hlB
   w==;
X-CSE-ConnectionGUID: D2Igs225QRm9mO7mOQqiBg==
X-CSE-MsgGUID: m1UOfwM7QISzDHKm89VvMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585485"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585485"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:04 -0800
X-CSE-ConnectionGUID: lKxIrw8ySa2HcbY+yesxSw==
X-CSE-MsgGUID: E5CnBKNMTTKI/hkwh5BDaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696852"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:43:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 19/20] wifi: mac80211: ensure sdata->work is canceled before initialized.
Date: Tue,  4 Feb 2025 19:42:16 +0200
Message-Id: <20250204193721.012f3191559b.I84ce27a239059f6009cee197b252549a11426046@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This wiphy work is canceled when the iface is stopped,
and shouldn't be queued for a non-running iface.
If it happens to be queued for a non-running iface (due to a bug)
it can cause a corruption of wiphy_work_list when ieee80211_setup_sdata
is called. Make sure to cancel it in this case and warn on.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f8aaa2db52ce..6bea6342d3b7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -807,6 +807,9 @@ static void ieee80211_set_multicast_list(struct net_device *dev)
  */
 static void ieee80211_teardown_sdata(struct ieee80211_sub_if_data *sdata)
 {
+	if (WARN_ON(!list_empty(&sdata->work.entry)))
+		wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->work);
+
 	/* free extra data */
 	ieee80211_free_keys(sdata, false);
 
-- 
2.34.1


