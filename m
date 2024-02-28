Return-Path: <linux-wireless+bounces-4138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D986AA4B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C400285A60
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3F2E62E;
	Wed, 28 Feb 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ktTf0hUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941A2D052
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109737; cv=none; b=RoPZzjz/Fimj/34MZ2sCd/b/pVKVVObK5Ow0Nq//vEsdtZojXAZt9QjrYc4NMzyq1F0CT7GRSV5DyqzcxN6PHZ0nNxQLZN5iCrGBTe22UcdVjLqvZTkafSx7LVjZ3tCVBMkI9osJXLogmSKdqCzHgkqlCBqYF31RgmLHbPPTvZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109737; c=relaxed/simple;
	bh=UKePmUgJH05HarTc1LPIGnmKWcg26cLLRz0nb5GzBEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Toc/oIZcQjbd8FQt4QeGB+58BuT6SHTiOrdsI5ZYodHqOh4gwzrJB2ZB5YTmSQrw+SxeeYx0pR9f5rDy9+xQbBkFeorIx6E+rCB/2cS73tCah5g54pN7+FLCWpjagBtO3eBeSCYfCxIJDody62UUEp1sSLXzmsnfZw+DJ1Oa6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ktTf0hUy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6kCKtxJaSY0/XGNMynEdzrZHbPPrHCM5s06E9TQopE4=;
	t=1709109734; x=1710319334; b=ktTf0hUypkAczE+Q3enft/ztxB8Ev6X+Sn2jPjPq5eyBtfm
	91ercVX6VhB7Y/Bo57DA/wG757i3rf8rM+9zdbkLyy565brYXAckVd8gm9qpBOWsBGdBtZFbgGUcW
	BkiJMKCiQP2e6QcPFArzrokLNfOparPQCTR9jAJIMe0iyfSVaZ5QJwEqikGL3HvSA/h7PJiMyGBbU
	SW4GhRYC9oQFebghCRu0xnOzTUay1arqunQaJA053kr+ZdmgaZl2g0kbglo0OLIzNpFKQwywDx1Vj
	/WuxcbloUSAjZPSegY2x9OxvkLZYeHmgOZ3BaCwuBdjG72OMjczfUIQWB6EVm2jw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFVz-0000000BzmR-0F61;
	Wed, 28 Feb 2024 09:42:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: don't add VHT capa on links without them
Date: Wed, 28 Feb 2024 09:40:51 +0100
Message-ID: <20240228094207.bfe4283bcde7.Ib70a558bc6bdbcec3d9e663079229dfcc2493682@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228084207.18142-4-johannes@sipsolutions.net>
References: <20240228084207.18142-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a link doesn't have VHT capability, before the rework
we'd have set IEEE80211_CONN_DISABLE_VHT, but now with the
linear progression of 'mode', we no longer have that. Add
an explicit check for VHT being supported, so we don't add
a zeroed VHT capabilities element where it shouldn't be.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5f2e9f5e1779..fa0d679b78f4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1319,7 +1319,8 @@ static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
 						offset);
 
 	if (sband->band != NL80211_BAND_6GHZ &&
-	    assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_VHT) {
+	    assoc_data->link[link_id].conn.mode >= IEEE80211_CONN_MODE_VHT &&
+	    sband->vht_cap.vht_supported) {
 		bool mu_mimo_owner =
 			ieee80211_add_vht_ie(sdata, skb, sband,
 					     &assoc_data->link[link_id].ap_vht_cap,
-- 
2.43.2


