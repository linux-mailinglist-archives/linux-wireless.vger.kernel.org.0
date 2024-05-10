Return-Path: <linux-wireless+bounces-7441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8098C20E2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30515B21150
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6209161936;
	Fri, 10 May 2024 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M6yDSKzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D6161333
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333178; cv=none; b=SdCIg00QvcDXCewesvqvcyYSEy+xjav4CHTh8w/XqctsUsYxlvfxu+aTugVH/RYCyTFZOCtuoVk54ipljWxHMveC0c7LBQk7fO4G19BC2gSY+84uSFh2vnB8mkM4XEF1a28Ho5IgUKNKBzBd4g2KK98DhsBZ7VeAiip/+55jI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333178; c=relaxed/simple;
	bh=FKFeplz9pcwbaA4mrxDrJ7MBe+C9IkVQpWRJ3zsRb4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GglfRo/5gloO69skKoFeYf9F9RFQuHWpJMeKugKaMrPB3Ue/tsP16tUCd06+tUzI5l7XdEk2USRhryfr5PaqAuypGbmc3cuCTv1oTWTWIwe/3JtCbvyVSl+TmSurHlA7ep/O+LweciyJQqFW7MbB7/f77+8IIKpfVE2ZH6OUhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M6yDSKzv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=VZBMJY6mHsaYpertBvAFBXPW8CfKubBhKdNxEWU+olg=; t=1715333173; x=1716542773; 
	b=M6yDSKzvIlG5H9tSAHIwtukdKC5KWGpYbD+g4hL5BAI9KZLbuUh/3Et9Hax7qqqcuPCpGiV5FLl
	0z0n7DxkCnt6x1SXolJ2dpqguudAkZJPqU/SzfDJ51lqZ0rprWRpSllw1355Vm54Qrn1YVLJqm0pz
	xfvVjRg6BSXFrMxh5b8KSpg1knbrcAB6Qr0KF0EB0z1iRHop0LEUFMVf1yofKFpZx9SRoa0Ft5hjL
	rtSaL9udWZFVrNRgg+C8En1U3TxsNtvIXJJBxWapl4tW0VNfUTH7C5j0DZfh83xKlNt4mVe291TPX
	/JNsEKtWiRZpeBIDO7xDtq093Sw3N3/gxtgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s5MVw-0000000EkIy-0VXw;
	Fri, 10 May 2024 11:26:04 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: send DelBA with correct BSSID
Date: Fri, 10 May 2024 11:26:02 +0200
Message-ID: <20240510112601.f4e1effdea29.I98e81f22166b68d4b6211191bcaaf8531b324a77@changeid>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In MLO, the deflink BSSID is clearly invalid. Since we fill
the addresses as MLD addresses and translate later, use the
AP address here instead.

This fixes an issue that happens with HW restart, where the
DelBA frame is transmitted, but not processed correctly due
to the wrong BSSID (or even just discarded entirely).  As a
result, the BA sessions are kept alive; however, as other
state is reset during HW restart, this then fails (reorder,
etc.) and data doesn't go through until new BA sessions are
established.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index d7e8cf8e48b7..79caeb485fd5 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -475,7 +475,7 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
 		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->deflink.u.mgd.bssid, ETH_ALEN);
+		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
 
-- 
2.45.0


