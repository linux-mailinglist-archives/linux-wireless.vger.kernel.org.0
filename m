Return-Path: <linux-wireless+bounces-4304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C086E679
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 17:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13040B29831
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D03D4432;
	Fri,  1 Mar 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hGJC/MXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7D3A29E
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312107; cv=none; b=BbHhXM24lH1af/ydR02eyC2E5ounDG/QhLpRzZ/FbTtlzskW7EtpxR0hFKJk9fEVf6tt8/IaaADJYOC9k+mbOgq1jk2AAZJG8HQRX+agpCuvakKg3J572Sps1PPia3c13A3AroNj5NhvkOALIYCUsQ+1cchB21M0C7/CxZr9+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312107; c=relaxed/simple;
	bh=KiUY1a/fn282xsMeQLAASiYMBFSc+C52ruIjEYrSeac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=afF6EHYBGx4Uy7cSBiJLTCteBij9JNFHb1iz9U81zsXRjLxqPs8NNXpGQv69oM0QndnHA8OWddsc6UG4ef5orNn/7N4PmmJIlDU4ROAlzDXjgCHQ/cVX18USELbQu96J3rvdYVGZkExhiN7j320eVK5ALyYVkokg2G/nDb+8gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hGJC/MXH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=1ZMMD4x+i1HA45FRh3wRhuCHPNsQ5NH/GIHZXAfiq10=; t=1709312102; x=1710521702; 
	b=hGJC/MXHkpLyOUtXkk3DNZLGIG6GQKh5/iSJNH18vRbCIMFpE9tXJrzUqvAp4lcUidMOugjECny
	rzNIGIOa2ftoIqFFH0Lb7SwDsrQgKNVr+JU+RqoBmP/HB3id/kLc9RcgZb1cIlWLTppRPp0ny9QDe
	RtFP7q37Lvoe00dhfpRhFGG23vlSOT4tH6KtW9YHmtuhVAixoaLWeyxiOLGFKeLL/rKNc/jXmxKCt
	mMhIb6ItP6pFjH/j7bmad1F0KG9VoxzCXjaJlfYSeTd7k5zyjSiiZFlI5RuKCOuh8g7V0H0rFjyhl
	vPc0V4hedX9+C0Gc0ja9o5teK/3lEuOPEjRQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rg69t-0000000F844-0rmo;
	Fri, 01 Mar 2024 17:54:53 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix supported rate masking in scan
Date: Fri,  1 Mar 2024 17:54:51 +0100
Message-ID: <20240301175451.7ad8ab0bd90c.I46b49e4fc27fe60b75d4559c01104e55ed381c37@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We have an nl80211 attribute to mask supported rates from
probe responses in scanning, e.g. for use in P2P, but in
the refactoring I stopped applying this mask. Restore it.

Fixes: 07095d167749 ("wifi: mac80211: start building elements in SKBs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/util.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 627bd5a8bda5..f810b83a390a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1216,8 +1216,8 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 	if (band == NL80211_BAND_S1GHZ)
 		return ieee80211_put_s1g_cap(skb, &sband->s1g_cap);
 
-	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags, 0,
-					WLAN_EID_SUPP_RATES);
+	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags,
+					~rate_mask, WLAN_EID_SUPP_RATES);
 	if (err)
 		return err;
 
@@ -1238,8 +1238,8 @@ static int ieee80211_put_preq_ies_band(struct sk_buff *skb,
 		*offset = noffset;
 	}
 
-	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags, 0,
-					WLAN_EID_EXT_SUPP_RATES);
+	err = ieee80211_put_srates_elem(skb, sband, 0, rate_flags,
+					~rate_mask, WLAN_EID_EXT_SUPP_RATES);
 	if (err)
 		return err;
 
-- 
2.44.0


