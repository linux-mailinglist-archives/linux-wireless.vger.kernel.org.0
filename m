Return-Path: <linux-wireless+bounces-6510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F28A9562
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 10:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB9C1C20D04
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849415AAB2;
	Thu, 18 Apr 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PcfSItAh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724E2E403
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430357; cv=none; b=OxBNtySZ+KuthaexOeRN+YeVyQi3CAhHUqh2j9VIu0hyrPe/5Sqlt97T+3u2aDPiy2SgldKmfqgGdOrwqDcO/LRBAZBNAZEKQ5x+vLldg9OVEsCHzVn4tlhemx3hXJHSsbmTmFy/Flq9BGJw8oD4aFSDN4RUnCbkByHyTOLZtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430357; c=relaxed/simple;
	bh=wFrEyj32PeQLJfETjCmMhKJdKWgKLh8yFrZj3/AOOJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFb6Uo3sSWMhTY9BFaozfRc3dA138QmSPlDjjv1flBF9U9Q+ajwqbSCdXTEluILZJR4RXAP16MNcD/VghGQkjvAhIL70IMUyfsOIybbyIMnfucW98+jqvMnF6vTdIZ8GT+ojpI0r7YzI9L8IFJ3H/7TPntAT/MTRDoaY4xIt02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PcfSItAh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sjl/TBaQ2FsUM8rXOQOzPCWw1Ve6RluJx/APc2DYfFk=;
	t=1713430355; x=1714639955; b=PcfSItAhnORtqqpiPT0/9BUBq9HjW7JSbtDR12FUo1zCjp8
	4R+NoI6NjYloEnkiyUdHOEVh6hZg/uxTcFLWRjAcajr5GNn3EUCqPWcSimF+WHGX2aErVdlDuTTw6
	e0unw9cpcKmCTBZb6olwxXttv2PvXy53vbxk+K2PoK3zztVSjRt2jrfA3CTvOHhHavPg0LTczpzBL
	tK61KdgF5zruD1s8ibVeVZ4Z/KDpAXA9oy6RH1iYZ3mYE0DTsMqkfv7PFv1xA+fIkzdZouj0YToHF
	8HEnu6bo2PsJ6ADLgurqdV182B3UN0FXBub7abt3tOfcHOGHArFygfstDvXgQGvw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rxNVK-0000000CIvO-16JB;
	Thu, 18 Apr 2024 10:52:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless 4/8] wifi: mac80211: mlme: re-parse if AP mode is less than client
Date: Thu, 18 Apr 2024 10:52:22 +0200
Message-ID: <20240418105220.d1f25d92cfe7.Ia21eff6cdcae2f5aca13cf8e742a986af5e70f89@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
References: <20240418105220.90df97557702.I05d2228ce85c203b9f2d6da8538cc16dce46752a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the AP mode ends up being determined less than the client mode,
there may be different reasons for this, e.g. AP misconfiguration.
If this happens in a way that causes e.g. EHT to be rejected, the
elements need to be re-parsed since we'll connect as HE, but not
reparsing means that we'll still think it's OK to use multi-link,
so we can connect in a non-sensical configuration of advertising
only HE on a secondary link. This normally won't happen for the
assoc link because that reuses the mode from authentication, and
if that's not EHT, multi-link association is rejected.

Fix this inconsistency by parsing the elements again if the mode
was different from the first parsing attempt. Print the message a
bit later to avoid printing "determined AP ... to be HE" twice in
cases where ieee80211_determine_ap_chan() returned a lesser mode,
rather than the regulatory downgrades below changing it.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6fa3752b740e..502c34d52fbe 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -632,15 +632,21 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, bss->vht_cap_info,
 					      elems, false, conn, &ap_chandef);
 
-	mlme_link_id_dbg(sdata, link_id, "determined AP %pM to be %s\n",
-			 cbss->bssid, ieee80211_conn_mode_str(ap_mode));
-
 	/* this should be impossible since parsing depends on our mode */
 	if (WARN_ON(ap_mode > conn->mode)) {
 		ret = -EINVAL;
 		goto free;
 	}
 
+	if (conn->mode != ap_mode) {
+		conn->mode = ap_mode;
+		kfree(elems);
+		goto again;
+	}
+
+	mlme_link_id_dbg(sdata, link_id, "determined AP %pM to be %s\n",
+			 cbss->bssid, ieee80211_conn_mode_str(ap_mode));
+
 	sband = sdata->local->hw.wiphy->bands[channel->band];
 
 	switch (channel->band) {
@@ -691,7 +697,6 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	conn->mode = ap_mode;
 	chanreq->oper = ap_chandef;
 
 	/* wider-bandwidth OFDMA is only done in EHT */
-- 
2.44.0


