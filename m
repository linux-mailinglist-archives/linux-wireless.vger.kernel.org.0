Return-Path: <linux-wireless+bounces-25264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFD0B01975
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068967AA332
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339827EFF4;
	Fri, 11 Jul 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="gdFye/Tx";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="TU4ORzDI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D31F4C8C
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228810; cv=none; b=OFfu9VYGbWpH8RLpoAhqPbHqgOPjE3oeeTMF2HvzAl9EDpoOhncT+YjpYZSify/lKjo98ytZfjmuIEDDgMA1n+iCkLL/NgH0b8b18Zb3X34OhItuSP/R4hVJfCIcmlLiOuqudk8sKbaY09klO3Er9eF6F5gJumLFJU47XGLhNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228810; c=relaxed/simple;
	bh=h8sDtTBFaKQV2BzaMtetG1bYXeS9efVwysgWyiEug68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7TF59NUUQxlZf6vEjhlM2tk7l+wfKJ7HQ6XBnLQ5m5I2/ajbGTshXvz88+vJmrkM5fuhlH62KSSyZ/YnJTsvweCZiwlVJ7H3F8BY44ucOrq+qaycQtaynW6Cz71kRya0CdY3t2+SRKi5GSGlVsiX3NNuxRa6C84zzXA0Jt6b4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=gdFye/Tx reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=TU4ORzDI; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1752229707; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=dzP7r4lWPYTYs3RU7pAFEhDbKI/TMIWoBzzkQ7Rua34=; b=gdFye/Txy0/W/nSgP8S2Jd4vFq
	xOcR4ImzKRb24tdi5KkGXt9iKTQ0/X0o3JEU3TDrE6kf7vDiWaqhyHu4xQNAPmWWu1klWlkGUifzE
	1WIB+s1kx5f/T6k0sZZHX2Kq9wcJIZBLTapQyOciQRocQfyVQpoP6xPMvpn8d8jGUPFKST1Cxw9bS
	rd91HPgNWEg2ofYbaMhd8cZ9BB+VsqEriPv3A3A2Kdr/M3gZf6TtLaXV2rPl9iOgRVQTYe2sTrmhH
	fBXl4vx4oP0hFpKXaPK+YBpFLOeteKjXT6YzFmK7JHjgPeur5KJj8rJsDIBZKQgvOWVWU8VGrXKzT
	YDhDeE1A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1752228807; h=from : subject
 : to : message-id : date;
 bh=dzP7r4lWPYTYs3RU7pAFEhDbKI/TMIWoBzzkQ7Rua34=;
 b=TU4ORzDIfKXmw3ceJT4qbUA0rSvfhQWQS6bHF1VfmuTRf8BZsl7my0FnOVw/uc43elrCS
 o+TQSLmHiFVXOtmIJmTtJiu1N26row2hKfWkZSKZBDwdWO2zyj7earXuf1E8HSe7c0THiFm
 1ogGTrWGYQl4NlQBsLY+/BowSGa3wudLoQBnuRZATSKECdykCmp0HgVm2g1JID1D4HlsrU1
 gAj2VPNRX4ZrXmCzNqip9yv/mEMLst8hNiJaIShF47pVOiegVOak29H4Bffv8IE99ffXTP2
 xZWMgYmoVRaoSJQd7OLllWIDE4NB7sTCSC1/QiZXnuZdP8SZWZ4LIP1U9/Xw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAkv-TRk697-0t; Fri, 11 Jul 2025 10:13:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uaAku-AIkwcC8mMix-JkmE; Fri, 11 Jul 2025 10:13:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PACTH v2 wireless-next 1/3] wifi: mac80211: Get link_id from
 freq for received management frame
Date: Fri, 11 Jul 2025 12:03:18 +0200
Message-Id: <dd0eb517cf088f386b00c138563bda3c778ebe41.1752225123.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1752225123.git.repk@triplefau.lt>
References: <cover.1752225123.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: pMW7Eet3b2yU.b1QcBIV1vRgR.stXdNw3y_zN
Feedback-ID: 510616m:510616apGKSTK:510616s4UM4Uu-B8
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

A non-MLD sta could want to send offchannel management frame (e.g. to
do a offchannel scan). Because ieee80211_rx_for_interface() fills the
link_id information with the link the sta is currently using; hostapd
would send back management frame responses through wrong link causing
the sta to miss them.

To fix that, use link_id that matches the received frame frequency if
any or do not fill link_id indication for management frames, relying
on hostapd instead to infer the proper link from the received frame
frequency.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/rx.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index caa3e6b3f46e..26be0f378b3f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5114,6 +5114,37 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 }
 
+static int ieee80211_rx_get_link_from_freq(struct ieee80211_rx_data *rx,
+					   struct sk_buff *skb,
+					   struct link_sta_info *link_sta)
+{
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_sta *sta = &link_sta->sta->sta;
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+
+	if (!status->freq)
+		return link_sta->link_id;
+
+	for_each_link_data(rx->sdata, link) {
+		bss_conf = link->conf;
+		if (!bss_conf)
+			continue;
+		conf = rcu_dereference(bss_conf->chanctx_conf);
+		if (!conf || !conf->def.chan)
+			continue;
+
+		if (conf->def.chan->center_freq != status->freq)
+			continue;
+
+		if (ieee80211_rx_is_valid_sta_link_id(sta, link->link_id))
+			return link->link_id;
+	}
+
+	return -1;
+}
+
 static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 				       struct sk_buff *skb, bool consume)
 {
@@ -5131,7 +5162,15 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
 	if (link_sta) {
 		sta = link_sta->sta;
-		link_id = link_sta->link_id;
+
+		/* Use freq to get link id information on management frames to
+		 * allow for offchannel scan, roaming, etc.
+		 */
+		if (ieee80211_is_mgmt(hdr->frame_control))
+			link_id = ieee80211_rx_get_link_from_freq(rx, skb,
+								  link_sta);
+		else
+			link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-- 
2.40.0


