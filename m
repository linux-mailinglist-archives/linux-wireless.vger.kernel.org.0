Return-Path: <linux-wireless+bounces-607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935780BAD6
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC751C20955
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86011709;
	Sun, 10 Dec 2023 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gCpuDAvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA7106
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213597; x=1733749597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtIV/haCqIx3IMwa8K87ABGlJlO3Ox4zUxlfdavbFyw=;
  b=gCpuDAvg/u+5q3DL4vVAndpAvX+F+yynIXPT386lcA6M/S1ST8j/fk1Y
   NvTOwuCdnu6N3mMS1RwbtGeYEmRx76VfM84eNBcRF51g2RUijuljs/EMj
   djdV0GjIzfjo82u8Nki3Fv91Ymx4hWxfSJFHjx5YINsNsftEKfZAc5cp5
   SP71cm2Va06yQ0ATeH5f44XLnzTTAZky2ExgUOutpqOIIsRmiHZiJ42U3
   fo+626YMplx/tRlOaK1S4Gb4NJc0iS/mKY7rWAHwNu9vEtOeEFwMhC4vf
   EOiiyOqjA+lOKAoQRZYhTqfNcwbMIiLMTyMqHBwVFXzx7I4rtqLqIZd6v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480746177"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480746177"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748926451"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748926451"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:06:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/14] wifi: mac80211: check defragmentation succeeded
Date: Mon, 11 Dec 2023 09:05:30 +0200
Message-Id: <20231211085121.8595a6b67fc0.I1225edd8f98355e007f96502e358e476c7971d8c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We need to check that cfg80211_defragment_element()
didn't return an error, since it can fail due to bad
input, and we didn't catch that before.

Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a693ca2cf8cd..40a4fbfff530 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5800,7 +5800,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 {
 	const struct ieee80211_multi_link_elem *ml;
 	const struct element *sub;
-	size_t ml_len;
+	ssize_t ml_len;
 	unsigned long removed_links = 0;
 	u16 link_removal_timeout[IEEE80211_MLD_MAX_NUM_LINKS] = {};
 	u8 link_id;
@@ -5816,6 +5816,8 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 					     elems->scratch + elems->scratch_len -
 					     elems->scratch_pos,
 					     WLAN_EID_FRAGMENT);
+	if (ml_len < 0)
+		return;
 
 	elems->ml_reconf = (const void *)elems->scratch_pos;
 	elems->ml_reconf_len = ml_len;
-- 
2.34.1


