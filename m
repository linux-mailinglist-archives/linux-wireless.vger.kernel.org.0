Return-Path: <linux-wireless+bounces-28622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18603C363A8
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D14E04FC175
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0831329D;
	Wed,  5 Nov 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="q4ZSHrpl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966D41C63
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355144; cv=none; b=ZiCUh8x1sWayDTfLwO3eIwMc7OQUGVcu+41pMX34pmkToq3M9Vz6IvBfeX8UwPiFIL93c3ONobmRM1kjroCROLwqd56EeAiBBQZCB553coy728r8JIX42+vVlkDPYHOhBxH6nv13+ACcATpIx/csN0tnplj8QOKBh0MD4k8JJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355144; c=relaxed/simple;
	bh=CyIg4MN5eC7ChJt62XXsnPjGMMDLbuFVmADvXyS8xAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mF70GGf4rWFDOzQm04q89Ovsozba4FgXxH51AaXqxlZ7obyKrbp/CtdXhUPVFU1N43R95x5lu1u9WMWjdSLru/8Q4wkwHUHwfew+T6v5TZaExdvM+oCs9pIKknbI5VQGI/5V30wNlPT0rmAuEduaOF/ZR3mFnZzZ1zdcfW2ukI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=q4ZSHrpl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=zLSWkLIknT/sexkGK8E6ePDKCq8s5PzbaVBKUMB9+bM=; t=1762355143; x=1763564743; 
	b=q4ZSHrploFymXXrse9Y3CPNp4iDRfmSJwAQe3Ouwvp2Fa2XwzLgIfkIlH1H1xs5AHNDb4yNzr7z
	TW9KeaCoXj1d9i8f9oG7/winwbsLZu1xkYcgM9lTQ3lnMVC7DJf0voeNBk8bmQq5bLw1Yb/e2u2sJ
	Rn2W6iwd45l8zageS7O7XDvey1Yg+R1XVWAj6pHoztTQfpCwrWJKjw7iDBjzHpwAX6K8u3LSfjA6Z
	FvFLdpuMPkEoz1MzjoxNRxdjWxNgj/mFqtlcRJlya++Pdyewd+KlDkrYopzkq63hqzhXjW6nvI3jL
	OfpCQmBkw0EqFUq2R7+HCjzM07aTEZhfTcSw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf4u-0000000FGgg-1ocz;
	Wed, 05 Nov 2025 16:05:40 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: remove "disabling VHT" message
Date: Wed,  5 Nov 2025 16:05:38 +0100
Message-ID: <20251105160538.f8b286cfba08.Ib91b5b09a3fff753341b0f7cb0df7f6913a4abe6@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This message always occurs with any AP that is simply HT/11n,
remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 025210d50405..adfb33508005 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -276,11 +276,8 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			return IEEE80211_CONN_MODE_VHT;
 		}
 	} else if (!vht_oper || !elems->vht_cap_elem) {
-		if (sband->band == NL80211_BAND_5GHZ) {
-			sdata_info(sdata,
-				   "VHT information is missing, disabling VHT\n");
+		if (sband->band == NL80211_BAND_5GHZ)
 			return IEEE80211_CONN_MODE_HT;
-		}
 		no_vht = true;
 	} else if (sband->band == NL80211_BAND_2GHZ) {
 		no_vht = true;
-- 
2.51.1


