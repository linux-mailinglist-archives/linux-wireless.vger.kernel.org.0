Return-Path: <linux-wireless+bounces-8000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6D8CD006
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD710281DB5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30C1411C6;
	Thu, 23 May 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B5cvAs9h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84313F44A
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458996; cv=none; b=S8mDT2UHl5DuyHNQM7BDeMvOHiKF0TX0C7wEw6k1RiClJATzriReqClUO331jsO39/JXygMXdHVchdOyokTQskYcmiFmwE2SlqG6In0zPU+NO3Kh8H5Ms7LWQPZGwHKiqB2Zz3OdHMSelH/1WQeXqy2IozAbooVlPovRdyCXLnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458996; c=relaxed/simple;
	bh=rWg1bruOfMOfbU08MIDxT9+qLVtnCTDwtOpk0dTzRSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW3kklhYIuxqX5UAVjIeGHB/G9nqvWLNG5qLnhctbsxltfOSWBg8MLkJ5hwqArH4ZCsOgXU0lhfCZf+69nBrlF7iqnQUlG3V0mipHSZM3ctun/JGdtNvUTCIbpHwSqzNAZPMkLoNRuBbgY7jvwWYLEfk+vlu2fmlqmltW3fn4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B5cvAs9h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rxY4PdS+ENwJ3Eo6/IUmeSZHVASFt9JAJgYawuqX5Jw=;
	t=1716458994; x=1717668594; b=B5cvAs9hB1moSyvi4FD2D6cjxFYMS43MudZj7LYeIJiYhFc
	/il8UtbQbPgxhjOMgKHLERbJQhshmfuI+BDAAE9eCk0cg6ZIRQNN9mFw/ifpA3JRTrsiNYHb+FDGg
	9bgNraeTzvGM+8SYcbTFOTtoTleQKv+zWhb3NwnL58snoJ0kkGCTOOLSLqIvoaBrog0/8TnQEc/84
	gjTYqHtDCdwDQgeuz1xNgEjHNPH+P0iOqSqg+x1RivUieZiXcdCiVzpD9SfEmb7vKateqMx73E1Rn
	BTVFmc/FXslUQ/fgH7oTUidpHe8JMVAFVl6dmTV57ks+4A1e3j2u/vOr5KBRG4zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sA5OR-00000005wvn-3kxl;
	Thu, 23 May 2024 12:09:52 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 5/8] wifi: mac80211: refactor channel checks
Date: Thu, 23 May 2024 12:09:46 +0200
Message-ID: <20240523120945.3da28ded4a50.I90cffc633d0510293d511f60097dc75e719b55f0@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
References: <20240523120945.9a2c19a51e53.I50fa1b1a18b70f63a5095131ac23dc2e71f3d426@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

To later introduce an override for VLP APs being allowed despite
NO-IR flags, which is somewhat similar in construction to being
allowed to monitor on disabled channels, refactor the code that
checks channel flags to have not a 'monitor' argument but a set
of 'permitting' flags that permit the operation without checking
for 'prohibited' flags.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c    | 19 +++++++++++--------
 net/wireless/core.h    |  3 ++-
 net/wireless/nl80211.c |  2 +-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 3414b2c3abcc..360480604515 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1145,7 +1145,8 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
 static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 					u32 center_freq, u32 bandwidth,
-					u32 prohibited_flags, bool monitor)
+					u32 prohibited_flags,
+					u32 permitting_flags)
 {
 	struct ieee80211_channel *c;
 	u32 freq, start_freq, end_freq;
@@ -1157,7 +1158,7 @@ static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return false;
-		if (monitor && c->flags & IEEE80211_CHAN_CAN_MONITOR)
+		if (c->flags & permitting_flags)
 			continue;
 		if (c->flags & prohibited_flags)
 			return false;
@@ -1221,7 +1222,8 @@ static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
 
 bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 			      const struct cfg80211_chan_def *chandef,
-			      u32 prohibited_flags, bool monitor)
+			      u32 prohibited_flags,
+			      u32 permitting_flags)
 {
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
@@ -1383,22 +1385,23 @@ bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 
 	if (!cfg80211_secondary_chans_ok(wiphy,
 					 ieee80211_chandef_to_khz(chandef),
-					 width, prohibited_flags, monitor))
+					 width, prohibited_flags,
+					 permitting_flags))
 		return false;
 
 	if (!chandef->center_freq2)
 		return true;
 	return cfg80211_secondary_chans_ok(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq2),
-					   width, prohibited_flags, monitor);
+					   width, prohibited_flags,
+					   permitting_flags);
 }
 
 bool cfg80211_chandef_usable(struct wiphy *wiphy,
 			     const struct cfg80211_chan_def *chandef,
 			     u32 prohibited_flags)
 {
-	return _cfg80211_chandef_usable(wiphy, chandef, prohibited_flags,
-					false);
+	return _cfg80211_chandef_usable(wiphy, chandef, prohibited_flags, 0);
 }
 EXPORT_SYMBOL(cfg80211_chandef_usable);
 
@@ -1541,7 +1544,7 @@ static bool _cfg80211_reg_can_beacon(struct wiphy *wiphy,
 		prohibited_flags = IEEE80211_CHAN_DISABLED;
 	}
 
-	res = cfg80211_chandef_usable(wiphy, chandef, prohibited_flags);
+	res = _cfg80211_chandef_usable(wiphy, chandef, prohibited_flags, 0);
 
 	trace_cfg80211_return_bool(res);
 	return res;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 118f2f619828..470a18dc4cbf 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -494,7 +494,8 @@ bool cfg80211_wdev_on_sub_chan(struct wireless_dev *wdev,
 			       bool primary_only);
 bool _cfg80211_chandef_usable(struct wiphy *wiphy,
 			      const struct cfg80211_chan_def *chandef,
-			      u32 prohibited_flags, bool monitor);
+			      u32 prohibited_flags,
+			      u32 permitting_flags);
 
 static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b10799710fe0..00f7d36c66a5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3347,7 +3347,7 @@ static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 
 	if (!_cfg80211_chandef_usable(&rdev->wiphy, chandef,
 				      IEEE80211_CHAN_DISABLED,
-				      monitor)) {
+				      monitor ? IEEE80211_CHAN_CAN_MONITOR : 0)) {
 		NL_SET_ERR_MSG(extack, "(extension) channel is disabled");
 		return -EINVAL;
 	}
-- 
2.45.1


