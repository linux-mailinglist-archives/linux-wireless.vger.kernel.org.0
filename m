Return-Path: <linux-wireless+bounces-24258-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0121ADFA62
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 02:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6181C3A51AE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC7139CFA;
	Thu, 19 Jun 2025 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="hguXUUU0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DA2111;
	Thu, 19 Jun 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750294355; cv=none; b=YHh+HRhtIiY9XcBRSbYtlSWKTGL5zO7ebsOxNu/dkSEpPGvK919udRQdMhkbrCctAm6k3g992E4OSHTcK2dAtIZbg5F8iCG/dPQdLU+mG6PuoIo5zzlRdYfUHAUSuO3nALVo6lOL38TWxOS4EAEvrhrUobWSkrfS09in+zoCmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750294355; c=relaxed/simple;
	bh=yFUw3KgRoHvHcsIiihXGGEOsWmdgi7TliGwo0VDLGkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYXOX3GtB4VFKi4KD/+ItKZWWuWPXsB6LCcZ9zeC0QWtR4yG23ghiQMaCzKGF3wNFM4kIAm6GfPHn+kdnZUDtbiUTaLbbf9dwT+UtJyPtR0TVZReJriyjKO7lczTDkP3A3aYkNUjOG+i2nOw4deS/3tJ+SJxPopUFVAikdXkL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=hguXUUU0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Pt4G2dDJbhVFhJw2DLvUSIPBoeG+1k6zZagnLx7JnpQ=; b=hguXUUU0z0/ahDmW
	JoswMsIkD9f06sDt6EZESZ4UnNJvRv1p3YumdIGYqWf6XLMJm5yP9IimIXOyZTsEzkAgNc5iTmtAt
	pH5aa8m3bTW1WnxVMLePEQbOowmcxSzM9tCfch2ZcVWTnX72qrL7MegEI2y/0Yi/nbhXjxsPLR/VB
	43idBwEtj2IH03zdp5KGsN50u+KCw+n0hxPLbpJ7Yy8untpXJkO4puQAPjifV1QPcgc+ljJtd9lFa
	Jna5vW+lb2/w9w4GHpX5waMa7PKQYh0sNeFarf9Hefacknx+mDE4DcPeGX0alwDmu6fOfZhg/lNgW
	3zerTh2Fp353RDm+WQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uS3W1-00AWcI-2o;
	Thu, 19 Jun 2025 00:52:29 +0000
From: linux@treblig.org
To: johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] wifi: mac80211: Remove unused wdev_to_ieee80211_vif
Date: Thu, 19 Jun 2025 01:52:29 +0100
Message-ID: <20250619005229.291961-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

wdev_to_ieee80211_vif() was added in 2013 by
commit ad7e718c9b4f ("nl80211: vendor command support")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/mac80211.h | 13 -------------
 net/mac80211/util.c    | 11 -----------
 2 files changed, 24 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 286c944d90ad..544a28336b93 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2112,19 +2112,6 @@ static inline bool ieee80211_vif_is_mesh(struct ieee80211_vif *vif)
 	return false;
 }
 
-/**
- * wdev_to_ieee80211_vif - return a vif struct from a wdev
- * @wdev: the wdev to get the vif for
- *
- * This can be used by mac80211 drivers with direct cfg80211 APIs
- * (like the vendor commands) that get a wdev.
- *
- * Return: pointer to the wdev, or %NULL if the given wdev isn't
- * associated with a vif that the driver knows about (e.g. monitor
- * or AP_VLAN interfaces.)
- */
-struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
-
 /**
  * ieee80211_vif_to_wdev - return a wdev struct from a vif
  * @vif: the vif to get the wdev for
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 27d414efa3fd..39a25fe20959 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -857,17 +857,6 @@ void ieee80211_iterate_stations_mtx(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_iterate_stations_mtx);
 
-struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
-
-	if (!ieee80211_sdata_running(sdata) ||
-	    !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
-		return NULL;
-	return &sdata->vif;
-}
-EXPORT_SYMBOL_GPL(wdev_to_ieee80211_vif);
-
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif)
 {
 	if (!vif)
-- 
2.49.0


