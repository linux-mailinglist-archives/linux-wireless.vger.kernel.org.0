Return-Path: <linux-wireless+bounces-2714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467784132E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D36B22274
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA26F083;
	Mon, 29 Jan 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uESMDsC8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEB4C61F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556051; cv=none; b=n0Nfu/NxjaArgYbTmub07/txqen0c1YEY+m2AaxPZeJ/lzhPxrgd9010sg2eUM7c8h8o48dAMKVkvUL2/zEOz5s8x3VRNAnN9omakAsHpWnqOjCjP4yvV16KVyFAW2P7zYAoy6ijyqPj79gjq09GaSU4PilMJoycj4iJjhgKXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556051; c=relaxed/simple;
	bh=7cH1Xs3N2WB3ZUB/PLFYrVv5Xo0sCKRMvsMkWpJ0GfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q24igRXmzxOsptZgeqVLt7ijYDO2DCX/H0rS9MSs3nHadz0q2YaLszUqeZyYdPy4P/fWPNSs4laBGOB8FU0BeneHUppCA61SvjAro/ebT36rORz1IriFvzVVsJs+czvLDjTISqNwfkQymWp2i+nZ4dvu6RwTc4WIEt+H9sbBGcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uESMDsC8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9KofAjDcQJz2AJW2Ua/HIt5xhhRm0vUDGALwkMnwvpo=;
	t=1706556050; x=1707765650; b=uESMDsC8kqIEr7uqarUuCcIeD4/twjUbiCEXOD7JNi46h7o
	ot6rzaD2FrTRzXV+t2u/vCX4u7mumu332L+HSfD7AlBL2u6SCOHycS0D6n5W06LP7b4N80qPZ4ImI
	50OU2A9znHPb0kqWFPFJVez71Ld1SlVm3PQi2C27TXoHE26LBUIGxBkHhv7v0+Y5UQPHCmi6wEdZb
	36T26U0J27NqWO4QuNm/7HrGvkAxxPOPBnZrT85pezh8mv0snXhhvwJDSR6Na31F1n06pT1gRXtiE
	D1gqQMGyIikracKAOFRXjgkN3S7nu1CW1ykUwbHkwFHgs89N88x/RoI6aJFShDDA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBX-000000050Z6-2u1b;
	Mon, 29 Jan 2024 20:20:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/10] wifi: mac80211: tdls: use ieee80211_put_he_6ghz_cap()
Date: Mon, 29 Jan 2024 20:19:31 +0100
Message-ID: <20240129202041.6454ac78ff8c.I7152e3c27645105478c68d40ca493feb27cac6bf@changeid>
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

We don't need to use the write function here since we already
have an SKB, so use ieee80211_put_he_6ghz_cap() with the SMPS
mode taken from the link we're using.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  1 -
 net/mac80211/tdls.c        | 11 ++---------
 net/mac80211/util.c        |  2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2b5d49399500..f7b2381878a9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2457,7 +2457,6 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 				    const u8 *da, const u8 *bssid,
 				    u16 stype, u16 reason,
 				    bool send_frame, u8 *frame_buf);
-u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end);
 
 enum {
 	IEEE80211_PROBE_FLAG_DIRECTED		= BIT(0),
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 57673f27daf4..e6808b7660ff 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -552,7 +552,6 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 	    (action_code == WLAN_TDLS_SETUP_REQUEST ||
 	     action_code == WLAN_TDLS_SETUP_RESPONSE ||
 	     action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES)) {
-		__le16 he_6ghz_capa;
 		u8 cap_size;
 
 		cap_size =
@@ -564,14 +563,8 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_link_data *link,
 		pos = ieee80211_ie_build_he_cap(NULL, he_cap, pos, pos + cap_size);
 
 		/* Build HE 6Ghz capa IE from sband */
-		if (sband->band == NL80211_BAND_6GHZ) {
-			cap_size = 2 + 1 + sizeof(struct ieee80211_he_6ghz_capa);
-			pos = skb_put(skb, cap_size);
-			he_6ghz_capa =
-				ieee80211_get_he_6ghz_capa_vif(sband, &sdata->vif);
-			pos = ieee80211_write_he_6ghz_cap(pos, he_6ghz_capa,
-							  pos + cap_size);
-		}
+		if (sband->band == NL80211_BAND_6GHZ)
+			ieee80211_put_he_6ghz_cap(skb, sdata, link->smps_mode);
 	}
 
 	/* add any custom IEs that go before EHT capabilities */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e8de82bafeef..c90f338b229c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2035,7 +2035,7 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
+static u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
 {
 	if ((end - pos) < 5)
 		return pos;
-- 
2.43.0


