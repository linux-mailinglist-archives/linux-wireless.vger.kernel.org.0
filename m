Return-Path: <linux-wireless+bounces-12033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8B96049A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74241F228C8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524714A90;
	Tue, 27 Aug 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UiPs0DQr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21957198A19
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747966; cv=none; b=fFvv09Sm2nSao5lGow4nHlyPtJXEwcvwsqbVmCZs+gBwUQwFl8ADQdHiJQpkBH57io6MJdox2Gv+X4EZAiBJQ+YZxYB6zOQrpl8a7kjYOBNzzmMyegsWPJ6fA8TRsiDj5D1pUVYUg3bhhsGUaUC1UYgnGI4qilA9ROs8IIzsFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747966; c=relaxed/simple;
	bh=jvBFOA7svIHWNnG2J6l9vOT+YDs6gsbgCtXVqnKKxko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8RzWaA/5DFcLSUVaCKBJRaFLSUQ7w4UDKYr75EfW0C8o0aDKARBIhKJ+BVI8pt9yaHwaFrCfuSzFOfvMXizpRM1ln/lnX8wv8Xs+LyEZsUbyuT9ixcVQvJXbUR6W6O9DxY/Pf8inh+/UDF4YsiFxqYLMoxoTr/JEusbY6VYvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UiPs0DQr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Yd0gnVMrgPl67ce5JTrx22G52qvSpb24l5CVhj5j77I=; t=1724747965; x=1725957565; 
	b=UiPs0DQrOvnj+4kebQqm5fo+2TtcLvAdqwUC0HOxiw7YABGCsSiCdjjF5TNYRDY83GPjno5HowC
	KrHMforUSxm4W5+UDUU2tP20kVAG43Vj/tScXfrh5PMz3dY5t2KLgx6JlncuWFIPH/Q6d3r+P6x8B
	apHECHU3WgymGAKUpA/yfHy4I55U1yh36CoPQ1CD9NYydg1s1CV6kflJ1Lo6tHGOBCIxiTkPh+3fr
	mYx+7IBm8z72NaiFJGt3TG7r0ReF7GyxvUNbX/l+G55/nKC2GBOrVzx3qwjMhczsUiPUe2D+FDa8E
	KZy2PeUiLuu+4UWeMEDyID0dPDfHs1JKDieQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sirjW-00000004U9B-0qnN;
	Tue, 27 Aug 2024 10:39:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: Check for missing VHT elements only for 5 GHz
Date: Tue, 27 Aug 2024 10:39:20 +0200
Message-ID: <20240827103920.dd711282d543.Iaba245cebc52209b0499d5bab7d8a8ef1df9dd65@changeid>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Check for missing VHT Capabilities and VHT Operation elements in
association response frame only for 5 GHz links.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0285924269cf..60e3a3a6e440 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4715,7 +4715,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	    ((assoc_data->wmm && !elems->wmm_param) ||
 	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
+	     (is_5ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT &&
 	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems *bss_elems;
@@ -4763,19 +4763,22 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
-		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
-			elems->vht_cap_elem = bss_elems->vht_cap_elem;
-			sdata_info(sdata,
-				   "AP bug: VHT capa missing from AssocResp\n");
-		}
-		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
-			elems->vht_operation = bss_elems->vht_operation;
-			sdata_info(sdata,
-				   "AP bug: VHT operation missing from AssocResp\n");
-		}
 
+		if (is_5ghz) {
+			if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
+			    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
+				elems->vht_cap_elem = bss_elems->vht_cap_elem;
+				sdata_info(sdata,
+					   "AP bug: VHT capa missing from AssocResp\n");
+			}
+
+			if (!elems->vht_operation && bss_elems->vht_operation &&
+			    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_VHT) {
+				elems->vht_operation = bss_elems->vht_operation;
+				sdata_info(sdata,
+					   "AP bug: VHT operation missing from AssocResp\n");
+			}
+		}
 		kfree(bss_elems);
 	}
 
-- 
2.46.0


