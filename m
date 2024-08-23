Return-Path: <linux-wireless+bounces-11830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A306A95C881
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237E7B271C0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AE41494CD;
	Fri, 23 Aug 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L3trTSgf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839EA149000
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403359; cv=none; b=pz5E1uuKM+eEXDXoXOBG6WADKgT0zDr31V53QyGaliwHOks1XLTlJbPibfni1J5yP+Jc27BN0OXItFppv8gVfN+bV+XRx8BSGsXAKM/5CyEYrASz+NGJ/xQb95rk10dvkcTXsF4B75mcb2cpI/077PWmAlLRFHd9SpTAecLj4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403359; c=relaxed/simple;
	bh=1kzA+PZNDbrxpRiAAMiffJb0qBq2bTmsJBuZEi3jXZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOGRJ1gK9AwZgUadVn9CoIpclCLbJXF9BbzFsiz1imy7fxbfpj92Hy0UTXJAfGOBzSnKjUx4auIBpL7TI6ruGXKvpCVK9orBQ2gliAYafBA9wWcU+fGu8kvEzRLUgsfkmGE7uloc7amHcZeCdh24HaPt/nWsRKMRLgwzOzAJmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L3trTSgf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Xg55v2uSATBeTmWPdA/Oe1TA9nJCwqMqqvyZ53LGcgY=; t=1724403357; x=1725612957; 
	b=L3trTSgfl0zAtSpnKxj9kFx3yCu6WFgk+52f+9fPujDyQeEK4JRmxF5NvRXCVI4VC6sOKoQiS8u
	H16XxP7iQLYLgg4T+Iyaf1bIillBBqR4AemmFl/PWiyUvrXTYUNXTAp72U1hDfHQtKHFFvTG3TMr/
	vdWPe2IKfwa3wYvpwXvlaiHhdB1+ArFw3k1x+FP7QZlm4t68OleTeLulen99GsLulbT2oCoGbUK/w
	l4H5QVtjefp+GLx1QsF9c2oS7UoIxXwG4c754Zjfv2J5phKf0DQof42vnL/P47+wT61QpltIXLTkz
	QQ2sVD31TIitDStRTYq2eWIJJdBBFWd4ud0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shQ5F-0000000FKiS-24V0;
	Fri, 23 Aug 2024 10:55:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: fix beacon SSID mismatch handling
Date: Fri, 23 Aug 2024 10:55:46 +0200
Message-ID: <20240823105546.7ab29ae287a6.I7f98e57e1ab6597614703fdd138cc88ad253d986@changeid>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

Return false when memcmp with zero_ssid returns 0 to correctly
handle hidden SSIDs case.

Fixes: 9cc88678db5b ("wifi: mac80211: check SSID in beacon")
Reviewed-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4779a18ab75d..f9526bbc3633 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6664,7 +6664,7 @@ static bool ieee80211_mgd_ssid_mismatch(struct ieee80211_sub_if_data *sdata,
 		return true;
 
 	/* hidden SSID: zeroed out */
-	if (memcmp(elems->ssid, zero_ssid, elems->ssid_len))
+	if (!memcmp(elems->ssid, zero_ssid, elems->ssid_len))
 		return false;
 
 	return memcmp(elems->ssid, cfg->ssid, cfg->ssid_len);
-- 
2.46.0


