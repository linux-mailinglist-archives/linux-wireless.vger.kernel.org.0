Return-Path: <linux-wireless+bounces-13778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C92C6996273
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EF64B25C73
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD6618871E;
	Wed,  9 Oct 2024 08:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="oPNb/+A/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61934188587
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462366; cv=none; b=B901O1Zhc2QEOgFYH1XBe69fJqI1fKF584r2spOZlhKAXWJwWFcrJGXfVDqzwogV1akvdsJ6vuUlyIQUXw+bcIUO+JlcWpFrZyukSAp0WN8+s5jB4lKn5jknRsFCzskjQI88kjiTWGJDCK1nRG+u0v0sIhPdxHzNGkKyLLw3VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462366; c=relaxed/simple;
	bh=fbeUdJPfWRKxFCGQEnx6aiukC1xDof+H8mfsDngzo0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+pthJu/aI2Z+1+q2QLwDTbVWUYmiYjj8UrbWcK/TK08exAoxRUzOJ83vXBnyKv22lLd3NWAFGb7b0oKoOMOGaOjVSaIA1+ANveD8Kcjj20PaHnuS2S/vnj+aNtC/idS3UvjZRSt7Oa+eh+NHaqqrx0TuNns3OTyP8nEbxzNEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=oPNb/+A/; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=N9TvnQzM4Kfni6m/dfvbOYeZlvq1j8gL483nUuDmtZw=; b=oPNb/+A/ViASLIpdrUhAyS6maX
	Nl8+OBl+QRodEzEM0pXo2Bu/mb4iu/AdWAHbYdZMfJ+IcIldzI2YppOllKMyaqWAglENwHuOa5pMR
	HZHZgU5GFrkKVxplFhOHjF/YZC6PWwAsc7e+Nz/6dgtKi+wT37Zqglaj4a5TOI07jTZ0=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS13-006e0I-16;
	Wed, 09 Oct 2024 10:25:53 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 02/11] wifi: mac80211: use vif radio mask to limit ibss scan frequencies
Date: Wed,  9 Oct 2024 10:25:43 +0200
Message-ID: <9d5c0b6b00a7ecef6a0ac6de765c0af00c8bb0e1.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
References: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject frequencies not supported by any radio that the vif is allowed to
use.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/scan.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index adb88c06b598..cb7079071885 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1176,14 +1176,14 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				unsigned int n_channels)
 {
 	struct ieee80211_local *local = sdata->local;
-	int ret = -EBUSY, i, n_ch = 0;
+	int i, n_ch = 0;
 	enum nl80211_band band;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* busy scanning */
 	if (local->scan_req)
-		goto unlock;
+		return -EBUSY;
 
 	/* fill internal scan request */
 	if (!channels) {
@@ -1200,7 +1200,9 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 				    &local->hw.wiphy->bands[band]->channels[i];
 
 				if (tmp_ch->flags & (IEEE80211_CHAN_NO_IR |
-						     IEEE80211_CHAN_DISABLED))
+						     IEEE80211_CHAN_DISABLED) ||
+				    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+								   tmp_ch))
 					continue;
 
 				local->int_scan_req->channels[n_ch] = tmp_ch;
@@ -1209,21 +1211,23 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (WARN_ON_ONCE(n_ch == 0))
-			goto unlock;
+			return -EINVAL;
 
 		local->int_scan_req->n_channels = n_ch;
 	} else {
 		for (i = 0; i < n_channels; i++) {
 			if (channels[i]->flags & (IEEE80211_CHAN_NO_IR |
-						  IEEE80211_CHAN_DISABLED))
+						  IEEE80211_CHAN_DISABLED) ||
+			    !cfg80211_wdev_channel_allowed(&sdata->wdev,
+							   channels[i]))
 				continue;
 
 			local->int_scan_req->channels[n_ch] = channels[i];
 			n_ch++;
 		}
 
-		if (WARN_ON_ONCE(n_ch == 0))
-			goto unlock;
+		if (n_ch == 0)
+			return -EINVAL;
 
 		local->int_scan_req->n_channels = n_ch;
 	}
@@ -1233,9 +1237,7 @@ int ieee80211_request_ibss_scan(struct ieee80211_sub_if_data *sdata,
 	memcpy(local->int_scan_req->ssids[0].ssid, ssid, IEEE80211_MAX_SSID_LEN);
 	local->int_scan_req->ssids[0].ssid_len = ssid_len;
 
-	ret = __ieee80211_start_scan(sdata, sdata->local->int_scan_req);
- unlock:
-	return ret;
+	return __ieee80211_start_scan(sdata, sdata->local->int_scan_req);
 }
 
 void ieee80211_scan_cancel(struct ieee80211_local *local)
-- 
git-series 0.9.1

