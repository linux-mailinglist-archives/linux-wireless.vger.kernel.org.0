Return-Path: <linux-wireless+bounces-4306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD1986E88A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 19:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1522A286F7D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE81E88A;
	Fri,  1 Mar 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Rhpudlth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069CA1E48C
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318215; cv=none; b=d7mf87J54pcLDynnqIPPIfK/ljS4mEfVGM3CSodCjwACkTDI0unZ4fYxgySILgTzRa9WkvQoGr/4WAGVDf8blZDyl1uKzKW3jpXFg+fPFHTJubnFic6IC4Qv0aYVIpXPGkYootIJD5vLcslsZrXlkpZur+k9CUfaWR5Dr21HYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318215; c=relaxed/simple;
	bh=nSw5ihD3dIwp/Z+NJ3O797854Njl/DWC54KAM+SY4uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPpjdPjoJxKjGAgodjzV/kh/Lw5XR/LT2hqqi5qw2G5fA9/7yb/G3JFNJ0+2uSeIWw0bd/ltkkgyeaFrlYsa6nMLmM6T1Xb9U8q1ODhQt7pX2s9i5A8jN4lu2OC3vYypGAwxu59U3spi2Z9VCY+4iv9AwWyOdRx/XzqG8s3h960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Rhpudlth; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ixXvsH69elV7ql2yjm+az9ytGzPGVTvVRlYbB0GPdjs=; t=1709318213; x=1710527813; 
	b=RhpudlthM2KdaBgZy9RN4qImLwu3FAk09qcUGxGb+2uwdugJv2x1uYjLtYUGV2oMt5xHwH2wSUa
	OPQf2UOs/WIllLuG6iDlYFgZDPu6X2PXYK4VBht7kQyxdIJyc0xnDn1bDIKPNpL3HEIqzh6x4/7k/
	urfaHnHrmVo9F/+1pARYalE4nksb0X6lfCKxH5aoQct8kfWxZE1dAVYEgr8/MLOrX7IkvRQKkUG5v
	R76JC+H5nfB6/LIbcg7vT7vH3PAgn4O6d9Rbq0YJWKNq90FloqCm8WPPxOxWWHioIIqQO/qFU+16k
	Uw/sya5aMN1ndvqZJO8o7V3SMdpCMBUL8MNw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rg7kX-0000000FC4Q-2Hr0;
	Fri, 01 Mar 2024 19:36:49 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: always initialize match_auth
Date: Fri,  1 Mar 2024 19:36:32 +0100
Message-ID: <20240301193633.1a3fc370f211.I979dd222b3b5eb5e1437886e5f7c2355eeccb9f7@changeid>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

My previous patch only initialized match_auth when the
ifmgd->auth_data exists, but that was wrong, it should
always be set. Fix that.

Fixes: 310c8387c638 ("wifi: mac80211: clean up connection process")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/3151f5d0-c18f-413d-b34b-b94f095b947c@moroto.mountain
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5f2e9f5e1779..89c4165f2753 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8129,10 +8129,10 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	       sizeof(ifmgd->s1g_capa_mask));
 
 	/* keep some setup (AP STA, channel, ...) if matching */
-	if (ifmgd->auth_data)
-		match_auth = ether_addr_equal(ifmgd->auth_data->ap_addr,
-					      assoc_data->ap_addr) &&
-			     ifmgd->auth_data->link_id == req->link_id;
+	match_auth = ifmgd->auth_data &&
+		     ether_addr_equal(ifmgd->auth_data->ap_addr,
+				      assoc_data->ap_addr) &&
+		     ifmgd->auth_data->link_id == req->link_id;
 
 	if (req->ap_mld_addr) {
 		uapsd_supported = true;
-- 
2.44.0


