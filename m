Return-Path: <linux-wireless+bounces-30465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA3CFE778
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645E330A084A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9016339B58;
	Wed,  7 Jan 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EA6d/qki"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18909328246
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795820; cv=none; b=URFbZ2SGJ3TH7GoIQos+O/o0n70kUwC6p8YWdAGN02oQ8Pz1HA+aEHxMaoBWPr2mK2pueq+K2+tDMap7/J3taf8Sgkb5wSIGd6u4cVUvvz+5i0NCGsJBaSETi0rX/yxwVlm5oJLIXMG3Z1+UWxIbbrqRCVPiFUfdL+2UGHYf+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795820; c=relaxed/simple;
	bh=2XQQrBC1LbU/KpnD2lemQt+xBANAmMuIAD3ZHorM38Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLCKAkypaHQdM7Y70FVRCmhMXYURwzoqIspH26vPZL2/KrM/UmKhMFKMbdkxGMw3GLiuvRpvaRqX4okKt6p0TOoy/HO1y8Bm2QEnp1CmZZptPt+1W9ZGgqXb1WTyW92PunX824VBILiECF56H5L3rl/L+niJLq6k7AhZB/Tl3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EA6d/qki; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3+r+Bhb+rE0vJlarl6zqyEkfVfkcrmhuOvGZZD6HycQ=;
	t=1767795819; x=1769005419; b=EA6d/qki+CyUGSXFgNHFt9yoLvUaZxShK7HXSvf1zUGHse0
	27nIl/h5mqz2K+a/O9QPrk5xI8/QfGEhh2awdQya9IEdmIk3MYIw4FpQafV4UXJRWVYEhccJ3Bhe1
	JNwW2qwZxxo78shp4kAnfcHvkEkrv27FPT0TdNK8509cxlwJoUuChxdOIa9dfD+2OVhrpdwvYk6cl
	XK3pxP3qrUZ4VKjVrYyBTQdJDupjgWZoizvz6Rf0oFz6zVWuVcmwaN7Xn06jypxLbEREfAgsvZAnk
	8/zB2DGcExJ8Rjpw0dBcW8nOmA9nGqUZJ3W2/rvLKO5mKj1wNwSKnyuwIKdJYZaw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURj-00000005agF-352y;
	Wed, 07 Jan 2026 15:23:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 02/46] wifi: mac80211: remove width argument from ieee80211_parse_bitrates
Date: Wed,  7 Jan 2026 15:22:01 +0100
Message-ID: <20260107152324.fffccdc57007.Ie70b24af583e3812883b4004ce227e7af1646855@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The width parameter in ieee80211_parse_bitrates() is unused. Remove it.
While at it, use the already fetched sband pointer as an argument
instead of dereferencing it once again.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 6 ++----
 net/mac80211/ieee80211_i.h | 3 +--
 net/mac80211/mlme.c        | 2 +-
 net/mac80211/parse.c       | 3 +--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 593440a00981..771f8433b3b9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2127,8 +2127,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len &&
-	    !ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-				      sband, params->supported_rates,
+	    !ieee80211_parse_bitrates(sband, params->supported_rates,
 				      params->supported_rates_len,
 				      &link_sta->pub->supp_rates[sband->band]))
 		return -EINVAL;
@@ -2989,8 +2988,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		return -EINVAL;
 
 	if (params->basic_rates) {
-		if (!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-					      wiphy->bands[sband->band],
+		if (!ieee80211_parse_bitrates(sband,
 					      params->basic_rates,
 					      params->basic_rates_len,
 					      &link->conf->basic_rates))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9d9313eee59f..649ea9d2ae9b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2660,8 +2660,7 @@ u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata);
 u8 *ieee80211_ie_build_he_oper(u8 *pos, const struct cfg80211_chan_def *chandef);
 u8 *ieee80211_ie_build_eht_oper(u8 *pos, const struct cfg80211_chan_def *chandef,
 				const struct ieee80211_sta_eht_cap *eht_cap);
-int ieee80211_parse_bitrates(enum nl80211_chan_width width,
-			     const struct ieee80211_supported_band *sband,
+int ieee80211_parse_bitrates(const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
 u8 *ieee80211_add_wmm_info_ie(u8 *buf, u8 qosinfo);
 void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad53dedd929c..ddff090e7dce 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1548,7 +1548,7 @@ static void ieee80211_assoc_add_rates(struct ieee80211_local *local,
 		 * in the association request (e.g. D-Link DAP 1353 in
 		 * b-only mode)...
 		 */
-		ieee80211_parse_bitrates(width, sband,
+		ieee80211_parse_bitrates(sband,
 					 assoc_data->supp_rates,
 					 assoc_data->supp_rates_len,
 					 &rates);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index bfc4ecb7a048..667021bc60c6 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -1115,8 +1115,7 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 }
 EXPORT_SYMBOL_IF_KUNIT(ieee802_11_parse_elems_full);
 
-int ieee80211_parse_bitrates(enum nl80211_chan_width width,
-			     const struct ieee80211_supported_band *sband,
+int ieee80211_parse_bitrates(const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates)
 {
 	struct ieee80211_rate *br;
-- 
2.52.0


