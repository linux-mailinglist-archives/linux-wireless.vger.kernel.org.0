Return-Path: <linux-wireless+bounces-2713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38484132D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA32C1C23F03
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E760EE8;
	Mon, 29 Jan 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BDsKHagj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7614335B5
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556051; cv=none; b=dj6GFQepmCxBC7AEu8lcw3H9733D46ezgqsiicZUTYFUa91GHPCicV40eYta0mntzQfnfqMN0gVrlKC+4LMUUzCLiQO1PGiK+1Dy60k6OKMR4WaEXGveoZ55aGNNHuOcUwmHCiFjsiw3eKwlCA17A4PHRfUVJv10Y9pOFWp/FI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556051; c=relaxed/simple;
	bh=2U7d67uIqBzny+UYaT4zgYkLYfyyiBpDVDuS+OZVy3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L80ySq6xsf+LeNUBY2LsiHPwIwXPPhf+nXrwuoWtZkQkn0V95c2D13XeTGrXSXojn2vRhdOaMTU+BBPj1LJo6AFE6XyCygCPhGPnkeyAu/xcMdZ5XRk6GNVXM1hRKf4dizIpFDKRerf3BXFZJbOSeEmnFu/0ifJJ8mYPCb/GJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BDsKHagj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fH/EeDECxgVvufWYdsTEeujGTzTtLEAMTr1mO/KlqEc=;
	t=1706556049; x=1707765649; b=BDsKHagjTvmdb3hM4TWjR57hLFnpXkHiGGUGVqnZiliP/kQ
	FBjtgCu3c4g9MIpUmMyvncRPmkappD+jDOh5/X/TFG6IopLx6yfTpzH0RSiACPGCPBDEYgvKdclkx
	pttx6zjqUyWSo+1J01DNsqw9B3S9X6ge7hDfGpuQ3Z0iIT1UJvCylvSVBuREz4q4mrsYgyVjuEyhv
	yitp+l2PPNXHPhn4XUwQjZ7oaHxRfM4jANAjt5JGAKNnDphe7pz1wmKloGN/01kwXys2OWfJJYIMx
	3BZGv0aljR/Jf0GzstvO6l6HlJfP+dJ5mIqsQWVSgZKmj+m/sRRJ8X8bYn6ETfwQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBW-000000050Z6-3bU7;
	Mon, 29 Jan 2024 20:20:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/10] wifi: mac80211: rename ieee80211_ie_build_he_6ghz_cap()
Date: Mon, 29 Jan 2024 20:19:30 +0100
Message-ID: <20240129202041.b8064a4e73b5.I8d2f4526562029107c6414c6cda378b300b1b0b0@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192041.58481-12-johannes@sipsolutions.net>
References: <20240129192041.58481-12-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The term 'IE' isn't really in use in the spec, and I want
to rework all of this to use SKBs as the primary method
for building elements. Rename this one already.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 8 +++++---
 net/mac80211/mesh.c        | 2 +-
 net/mac80211/mlme.c        | 2 +-
 net/mac80211/util.c        | 6 +++---
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 43c55ea6349c..2b5d49399500 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2506,9 +2506,6 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
 u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 			      const struct ieee80211_sta_he_cap *he_cap,
 			      u8 *pos, u8 *end);
-void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
-				    enum ieee80211_smps_mode smps_mode,
-				    struct sk_buff *skb);
 u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
 u8 *ieee80211_ie_build_eht_oper(u8 *pos, struct cfg80211_chan_def *chandef,
 				const struct ieee80211_sta_eht_cap *eht_cap);
@@ -2529,6 +2526,11 @@ void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
 u8 *ieee80211_ie_build_s1g_cap(u8 *pos, struct ieee80211_sta_s1g_cap *s1g_cap);
 
+/* element building in SKBs */
+void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
+			       struct ieee80211_sub_if_data *sdata,
+			       enum ieee80211_smps_mode smps_mode);
+
 /* channel management */
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
 			       struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 000fa9484b4e..10c7d7714ffe 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -640,7 +640,7 @@ int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!iftd)
 		return 0;
 
-	ieee80211_ie_build_he_6ghz_cap(sdata, sdata->deflink.smps_mode, skb);
+	ieee80211_put_he_6ghz_cap(skb, sdata, sdata->deflink.smps_mode);
 	return 0;
 }
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a97483071e90..ff386f8a1bf3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1067,7 +1067,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	/* trim excess if any */
 	skb_trim(skb, skb->len - (pre_he_pos + he_cap_size - pos));
 
-	ieee80211_ie_build_he_6ghz_cap(sdata, smps_mode, skb);
+	ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
 }
 
 static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c2fe9aece00d..e8de82bafeef 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3413,9 +3413,9 @@ u8 *ieee80211_ie_build_he_cap(const struct ieee80211_conn_settings *conn,
 	return pos;
 }
 
-void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
-				    enum ieee80211_smps_mode smps_mode,
-				    struct sk_buff *skb)
+void ieee80211_put_he_6ghz_cap(struct sk_buff *skb,
+			       struct ieee80211_sub_if_data *sdata,
+			       enum ieee80211_smps_mode smps_mode)
 {
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_sband_iftype_data *iftd;
-- 
2.43.0


