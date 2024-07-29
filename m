Return-Path: <linux-wireless+bounces-10645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A00940174
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 01:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84A72833A3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E923145A17;
	Mon, 29 Jul 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="y78HSi2K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAF3D9E;
	Mon, 29 Jul 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294033; cv=none; b=jy+ISc85lcGQkkMNBJOi/3XLDrukGXiIXOsLFgIp2UDPPVtprBh+UCynbYrVGFE+qMfrSP6PfJwKpTE07aSLONUrXi0AczjhNJShSqAyKRPH9DzC5vs6Mgd08hNtgPwCqF6LIW8batQ5pUjar5yGd7zwirNidP/bNWZYgE0hEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294033; c=relaxed/simple;
	bh=IJ32f4RDF+bSXG89PDbdJXjbImPvbIqX3J9iMHeSy8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4KZ9rDLBfkVAj2uMe0A5xJFqG9vXE1tkdFTaXyc/pktWWhjE+pgzIt7IMqVLJqi44KgRlQBlAF4Jwf9zzrPg3IgwXHsYnTxDImyhRKemKqLEhZKgoJNMmJw0rY0cg9Yf/Cvk5DqE/XbmB/Y65ta/vjOUugMuwtfBR7rWH1UcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=y78HSi2K; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WXv2q5MLGz9stJ;
	Tue, 30 Jul 2024 01:00:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1722294019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TrZ69C1VDsI6BMBp98nfHz+kqum2W0EP7VaS0Ia+OTI=;
	b=y78HSi2KriCXdDu+f97R1yBhrU1eKudGiPN7lnY69tRh+LibVq3vq7OIrDWXFklvNek2V2
	7HkQtqEbXPy/1wTl8UGfzorZfyjW0yaN7n2kFk7gwDaVXRbF3CUXmlPIWzrrqni0qwMppb
	lgdLg3m8f2+DpTe9ZBm+GrenpwInCNecpKxrQIuHFLdCk38KMcAPm/NsoLub6GhGDbqhGu
	h4p3r+Po6IVPQB0l/ynGCa0iYcf2VXxyVNrxbxJWK8BsaHuus5OrH966m/mH6+dG7GMTFv
	NnFLWpi8lWibZYVJil4KkzfUURibQ1r0qKgBTjrQDkCtHK3D5FdRODKvpkwdSw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: stable@vger.kernel.org
Cc: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	quic_ramess@quicinc.com,
	Johannes Berg <johannes.berg@intel.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 6.1 1/2] wifi: mac80211: Allow NSS change only up to capability
Date: Tue, 30 Jul 2024 00:59:55 +0200
Message-ID: <20240729225956.1352362-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

[ Upstream commit 57b341e9ab13e5688491bfd54f8b5502416c8905 ]

Stations can update bandwidth/NSS change in
VHT action frame with action type Operating Mode Notification.
(IEEE Std 802.11-2020 - 9.4.1.53 Operating Mode field)

For Operating Mode Notification, an RX NSS change to a value
greater than AP's maximum NSS should not be allowed.
During fuzz testing, by forcefully sending VHT Op. mode notif.
frames from STA with random rx_nss values, it is found that AP
accepts rx_nss values greater that APs maximum NSS instead of
discarding such NSS change.

Hence allow NSS change only up to maximum NSS that is negotiated
and capped to AP's capability during association.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Link: https://lore.kernel.org/r/20230207114146.10567-1-quic_ramess@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 net/mac80211/vht.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index f7526be8a1c7..b3a5c3e96a72 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -637,7 +637,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
 	u32 changed = 0;
-	u8 nss;
+	u8 nss, cur_nss;
 
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
@@ -648,10 +648,25 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss += 1;
 
 	if (link_sta->pub->rx_nss != nss) {
-		link_sta->pub->rx_nss = nss;
-		sta_opmode.rx_nss = nss;
-		changed |= IEEE80211_RC_NSS_CHANGED;
-		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+		cur_nss = link_sta->pub->rx_nss;
+		/* Reset rx_nss and call ieee80211_sta_set_rx_nss() which
+		 * will set the same to max nss value calculated based on capability.
+		 */
+		link_sta->pub->rx_nss = 0;
+		ieee80211_sta_set_rx_nss(link_sta);
+		/* Do not allow an nss change to rx_nss greater than max_nss
+		 * negotiated and capped to APs capability during association.
+		 */
+		if (nss <= link_sta->pub->rx_nss) {
+			link_sta->pub->rx_nss = nss;
+			sta_opmode.rx_nss = nss;
+			changed |= IEEE80211_RC_NSS_CHANGED;
+			sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
+		} else {
+			link_sta->pub->rx_nss = cur_nss;
+			pr_warn_ratelimited("Ignoring NSS change in VHT Operating Mode Notification from %pM with invalid nss %d",
+					    link_sta->pub->addr, nss);
+		}
 	}
 
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
-- 
2.45.2


