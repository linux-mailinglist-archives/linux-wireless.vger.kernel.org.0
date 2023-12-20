Return-Path: <linux-wireless+bounces-975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79138818394
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A394B245C2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8AE13ADF;
	Tue, 19 Dec 2023 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC/5cPFU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFEE13AD5
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975093; x=1734511093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVh2sesQmYUuXYIAlRyZmjhOyWpIhESTOsf4CK1ea48=;
  b=GC/5cPFUvNX3pK/0KbiLODtDk6fO9LRz/fgnvHZOJAu6pOisX8xh05Vy
   46HjiGjFxXTxnq8fdzm9CpPlfN0sYILUtPSBzUR2ObHBweQGy4JyYkIES
   bVxy4HFryLmNamp6+j5QshJ2OqNIox639k36uA7y5GGWTzKj1E6LlzSq+
   d6S0r/qtOu2DCz01eMVHta8XhaM4sT4fdNQVgXNiwI8erHoTMIqPlttzm
   zkTkvvu/uzySfr10p4j5jsfsXUHw0buV3ZCe3H/8qXJv5CXjeVsjnxBr+
   56qKwdytBX96Rr5S3iBcuZAe3t44Vr2Lu2pxr85MFfE4GLPv1wb4Mr5RC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969250"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969250"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266468"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266468"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:38:10 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>, Berg@web.codeaurora.org,
	Johannes <johannes.berg@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: fix advertised TTLM scheduling
Date: Wed, 20 Dec 2023 04:37:59 +0200
Message-Id: <20231220043149.1f0f63cd03a2.I0dd50bcceff5953080cdd7aee5118b72c78c6507@changeid>
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

From: Ayala Beker <ayala.beker@intel.com>

Handle a case of time overflow, where the switch time might
be smaller than the partial TSF in the beacon.
Additionally, apply advertised TTLM earlier in order to be
ready on time on the newly activated links.

Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 49 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fe0be3e5731b..b526ce589d4d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -43,6 +43,9 @@
 #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
 #define IEEE80211_ASSOC_MAX_TRIES	3
 
+#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
+#define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
+
 static int max_nullfunc_tries = 2;
 module_param(max_nullfunc_tries, int, 0644);
 MODULE_PARM_DESC(max_nullfunc_tries,
@@ -5965,6 +5968,13 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 	pos++;
 
 	ttlm_info->switch_time = get_unaligned_le16(pos);
+
+	/* Since ttlm_info->switch_time == 0 means no switch time, bump it
+	 * by 1.
+	 */
+	if (!ttlm_info->switch_time)
+		ttlm_info->switch_time = 1;
+
 	pos += 2;
 
 	if (control & IEEE80211_TTLM_CONTROL_EXPECTED_DUR_PRESENT) {
@@ -6059,25 +6069,46 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (ttlm_info.switch_time) {
-			u32 st_us, delay = 0;
-			u32 ts_l26 = beacon_ts & GENMASK(25, 0);
+			u16 beacon_ts_tu, st_tu, delay;
+			u32 delay_jiffies;
+			u64 mask;
 
 			/* The t2l map switch time is indicated with a partial
-			 * TSF value, convert it to TSF and calc the delay
-			 * to the start time.
+			 * TSF value (bits 10 to 25), get the partial beacon TS
+			 * as well, and calc the delay to the start time.
+			 */
+			mask = GENMASK_ULL(25, 10);
+			beacon_ts_tu = (beacon_ts & mask) >> 10;
+			st_tu = ttlm_info.switch_time;
+			delay = st_tu - beacon_ts_tu;
+
+			/*
+			 * If the switch time is far in the future, then it
+			 * could also be the previous switch still being
+			 * announced.
+			 * We can simply ignore it for now, if it is a future
+			 * switch the AP will continue to announce it anyway.
+			 */
+			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
+				return;
+
+			delay_jiffies = TU_TO_JIFFIES(delay);
+
+			/* Link switching can take time, so schedule it
+			 * 100ms before to be ready on time
 			 */
-			st_us = ieee80211_tu_to_usec(ttlm_info.switch_time);
-			if (st_us > ts_l26)
-				delay = st_us - ts_l26;
+			if (delay_jiffies > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
+				delay_jiffies -=
+					IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS;
 			else
-				continue;
+				delay_jiffies = 0;
 
 			sdata->u.mgd.ttlm_info = ttlm_info;
 			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
 			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
-						 usecs_to_jiffies(delay));
+						 delay_jiffies);
 			return;
 		}
 	}
-- 
2.34.1


