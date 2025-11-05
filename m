Return-Path: <linux-wireless+bounces-28615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4BC362C2
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35260626590
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AC32D7F7;
	Wed,  5 Nov 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LhfmM3dt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AEB32E74B
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353685; cv=none; b=NoFlzuPTJb6ghLsVWJU67n72W4HpZikqybmesrQUqzNCuGrjZWRiDkZXpPCN0pGjt9M6GTCeRuvgT2pdJS1MU9QgSYXKDlFdQHHnHPl38z4q6qmm9JT/AK3cmZJavNPhjUrG6+NUQZDK9+nIQnB61n23njg3crjo3ZFco2yWqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353685; c=relaxed/simple;
	bh=2YUwh1LSD6344QyWXdNYtxQwgnTkbFmH4OtXrYsi1FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fL5aRtEzmZeMCo0p9Jicb26GNdj3X24Nt9dFWke+7pmb/MHjZP6pIkI1OOQOXCQZCM0/jDFMmkSDYui81JJbS0fjdOTdGXEzzZbZLJH0PqDNrt/7SwMfcJMCRNFtOjpV5N4TaFb9LDNAqcFM/lfXXooE9td71uT4GEmP81LKc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LhfmM3dt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wNHZrn4qWWFuKpNP97WEQrTY5vcu62JN0H0g7oA8kF0=; t=1762353684; x=1763563284; 
	b=LhfmM3dtRI70ItSlMaIq7jgE9jnM+tntqGWuPT+pIht6YthyMZL40PqB0YvAeUxpRvz2QffMKTP
	v+xjoHksReawsxCbTb4wRq8DeWKrqEAtp1CNMlOtVjaXHVdlXZa0HB05PxhL13TBUsPKmQQ9/CXWV
	3aJcprzDupZbHzHhGgasmz9LIHWEhrshfNPBTzgY1Bd34hHJkhBGB09CV4fT41ZEGpuyNcNSNPqNg
	WqGFg3jyZ/Eiu1B8aO4MM+Um+OdPWZj+jRZYqjt0rcfXd3aXJw2HLArIKBeBG4sslsrTaeFRfB4vN
	lMbeTdGVr7RKUyPskrkM/I58plI+Xy1I36FA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGehO-0000000FE6k-03GG;
	Wed, 05 Nov 2025 15:41:22 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: mac80211: reject address change while connecting
Date: Wed,  5 Nov 2025 15:41:19 +0100
Message-ID: <20251105154119.f9f6c1df81bb.I9bb3760ede650fb96588be0d09a5a7bdec21b217@changeid>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

While connecting, the MAC address can already no longer be
changed. The change is already rejected if netif_carrier_ok(),
but of course that's not true yet while connecting. Check for
auth_data or assoc_data, so the MAC address cannot be changed.

Also more comprehensively check that there are no stations on
the interface being changed - if any peer station is added it
will know about our address already, so we cannot change it.

Fixes: 3c06e91b40db ("wifi: mac80211: Support POWERED_ADDR_CHANGE feature")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/iface.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a7873832d4fa..0ca55b9655a7 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -223,6 +223,10 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 	if (netif_carrier_ok(sdata->dev))
 		return -EBUSY;
 
+	/* if any stations are set known (so they know this vif too), reject */
+	if (sta_info_get_by_idx(sdata, 0))
+		return -EBUSY;
+
 	/* First check no ROC work is happening on this iface */
 	list_for_each_entry(roc, &local->roc_list, list) {
 		if (roc->sdata != sdata)
@@ -242,12 +246,16 @@ static int ieee80211_can_powered_addr_change(struct ieee80211_sub_if_data *sdata
 			ret = -EBUSY;
 	}
 
+	/*
+	 * More interface types could be added here but changing the
+	 * address while powered makes the most sense in client modes.
+	 */
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		/* More interface types could be added here but changing the
-		 * address while powered makes the most sense in client modes.
-		 */
+		/* refuse while connecting */
+		if (sdata->u.mgd.auth_data || sdata->u.mgd.assoc_data)
+			return -EBUSY;
 		break;
 	default:
 		ret = -EOPNOTSUPP;
-- 
2.51.1


