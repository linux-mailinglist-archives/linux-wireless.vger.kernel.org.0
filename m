Return-Path: <linux-wireless+bounces-30570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C6AD03DA4
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36EFE302D2D6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A4396B65;
	Thu,  8 Jan 2026 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CTaYVD1T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204B392C4E
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879185; cv=none; b=Ldha2ua2URi7/dksZaqSZYYkRJ04CH2r1irBN4sg/bzYbBM1oBHhvFizA83l+CVISlngmn90ZnUGM7KTBJmKWvKTlKXheh9gJJk1+TQ2qVThgTOloWMgaRi86v2/9a0YHxCB65X32HhKQMh0Pww19TB7FVAhkBHan4zCiuvldpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879185; c=relaxed/simple;
	bh=rZ/fs1qEBhDxfcCXGZzIRtUme4mGtzv+W25SHFa8px8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyJUPWiS8yV4ciDZHN/5gmyiF4v9+btigdWVxGv7C/4AC1kuXzWKqlnYkaSodbNQWYfGF90kmUbKO1J5yOgv2ca2Fg+zSG4fCUWQt+ziOOMDscWvztbk7I8qifmXpvGahgHcFM2E3jLPNwnRuxXtqH4+XXwYXn0z81tpyvi8Ro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CTaYVD1T; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=YJ25L6VbIkqpzC1VJdrrlaDq8UWqx5M3AWa6fj9vqVo=; t=1767879183; x=1769088783; 
	b=CTaYVD1TFAwkMVAZPPep2mRdzp8GYFznWsXsv1+bs7MkJbZSyjIBPBwvKvQxgbJ7oXweaCLTchp
	3+mMsgyAt4vl9KlUKpdXuVYjhQUA0YfbUthuOBnFYOUrqdnZtI3VrOODgPA7ATF8zr+4Z3kHKCvjR
	Sn8oRFLl5vNykP4VcydhEYq6RpDXe7m9puDTKOPGVaahOt6YypXYs1QcBS8chUR2oGcxvRM2EBBFH
	oSNMd8whHAmTrRFBJZxKSnWDIvEGtusliHmxA3MKQDqqVll4R4zhihuxzP+UJpfWHmtFmZJ4bEuVM
	i6OlRMXNrmwt0UESkKKqQr0DwFUfyOowDMRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdq8J-00000006WUN-1ryX;
	Thu, 08 Jan 2026 14:32:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: remove width argument from ieee80211_parse_bitrates
Date: Thu,  8 Jan 2026 14:32:57 +0100
Message-ID: <20260108143257.d13dbbda93f0.Ie70b24af583e3812883b4004ce227e7af1646855@changeid>
X-Mailer: git-send-email 2.52.0
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
index 27c234948fbe..a46fd24c5149 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2125,8 +2125,7 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len &&
-	    !ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-				      sband, params->supported_rates,
+	    !ieee80211_parse_bitrates(sband, params->supported_rates,
 				      params->supported_rates_len,
 				      &link_sta->pub->supp_rates[sband->band]))
 		return -EINVAL;
@@ -2987,8 +2986,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
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


