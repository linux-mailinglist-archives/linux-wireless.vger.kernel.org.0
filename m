Return-Path: <linux-wireless+bounces-727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394FF810926
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 05:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC184281732
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Dec 2023 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3AC127;
	Wed, 13 Dec 2023 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z08o2x8S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC911D2;
	Tue, 12 Dec 2023 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=zT7HOgwpai99AM7y8YYhF+kMRdmk5e9tP2Lpfdnuez8=; b=Z08o2x8SVRK3iYffhKKlVy9xpd
	REpvqmvBsK7ha+GOB1f81LN3PRlfQ9YPQVCKRglP8NM+suADMb4Lm3Hco9oDF1yQ4H4cI5oO5dR7Q
	pLsKsZeLzA0ZDhU6qYxUr+Jum42nuWqDeK9/mHaCllhRf6ulU6hq+BUDA0lMaP6dtGTmnPpkN7enH
	h5wneXbK+EmbiLcB9K6Troj4YWgX3Gqs0jfYHjWPfdc1CIb1SQlrhgaK9lMb4/dSUpjZcwUn1d5HK
	TJb5Tx+SXTjx7i9D5xDuEhBzjZ+kXQ/8S6FYd5SB5Y/ocTK7bjx/H0wV8xjZmdXzRuUbXJuek1Y30
	Sh6jQpqg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDGyV-00DaeP-1N;
	Wed, 13 Dec 2023 04:35:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] wifi: cfg80211: fix spelling & punctutation
Date: Tue, 12 Dec 2023 20:35:58 -0800
Message-ID: <20231213043558.10409-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling and run-on sentences.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/net/cfg80211.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -- a/include/net/cfg80211.h b/include/net/cfg80211.h
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -52,7 +52,7 @@
  * such wiphy can have zero, one, or many virtual interfaces associated with
  * it, which need to be identified as such by pointing the network interface's
  * @ieee80211_ptr pointer to a &struct wireless_dev which further describes
- * the wireless part of the interface, normally this struct is embedded in the
+ * the wireless part of the interface. Normally this struct is embedded in the
  * network interface's private data area. Drivers can optionally allow creating
  * or destroying virtual interfaces on the fly, but without at least one or the
  * ability to create some the wireless device isn't useful.
@@ -2560,7 +2560,7 @@ struct cfg80211_scan_info {
  * @short_ssid: short ssid to scan for
  * @bssid: bssid to scan for
  * @channel_idx: idx of the channel in the channel array in the scan request
- *	 which the above info relvant to
+ *	 which the above info is relevant to
  * @unsolicited_probe: the AP transmits unsolicited probe response every 20 TU
  * @short_ssid_valid: @short_ssid is valid and can be used
  * @psc_no_listen: when set, and the channel is a PSC channel, no need to wait
@@ -7431,7 +7431,7 @@ void cfg80211_notify_new_peer_candidate(
  * RFkill integration in cfg80211 is almost invisible to drivers,
  * as cfg80211 automatically registers an rfkill instance for each
  * wireless device it knows about. Soft kill is also translated
- * into disconnecting and turning all interfaces off, drivers are
+ * into disconnecting and turning all interfaces off. Drivers are
  * expected to turn off the device when all interfaces are down.
  *
  * However, devices may have a hard RFkill line, in which case they
@@ -7479,7 +7479,7 @@ static inline void wiphy_rfkill_stop_pol
  * the configuration mechanism.
  *
  * A driver supporting vendor commands must register them as an array
- * in struct wiphy, with handlers for each one, each command has an
+ * in struct wiphy, with handlers for each one. Each command has an
  * OUI and sub command ID to identify it.
  *
  * Note that this feature should not be (ab)used to implement protocol
@@ -7643,7 +7643,7 @@ static inline void cfg80211_vendor_event
  * interact with driver-specific tools to aid, for instance,
  * factory programming.
  *
- * This chapter describes how drivers interact with it, for more
+ * This chapter describes how drivers interact with it. For more
  * information see the nl80211 book's chapter on it.
  */
 

