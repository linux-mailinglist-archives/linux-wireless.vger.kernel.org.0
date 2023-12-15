Return-Path: <linux-wireless+bounces-833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131081486D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AE7B22CF2
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 12:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767AA2DB6B;
	Fri, 15 Dec 2023 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Iv2g1ItQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50352DB76
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward204b.mail.yandex.net (Yandex) with ESMTP id DF49067A70
	for <linux-wireless@vger.kernel.org>; Fri, 15 Dec 2023 15:43:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:47a7:0:640:b27a:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTP id 67E93608C6;
	Fri, 15 Dec 2023 15:43:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ehk5Ww9j9W20-eTXliTtL;
	Fri, 15 Dec 2023 15:43:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1702644223; bh=aVa3Zke5sCHKuOMYsq1zPhiC6v4cpT8L+yCTADRCLIo=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Iv2g1ItQCX5yIwDooOvc3/9zYiXqHpfoS3qviMuiR60/dh5zwycmChKyHbJ/Be6fL
	 hAOtRRe5IBi+2QzDGLAmQ+BVtCYlAy4RwNYc45EBZ2XpVmhXh+yxAhbNpTGqEQtvrB
	 Iq2+hLXxR2wmiwHNwBcklmutb3rQiGxL5oT0R3C0=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 3/3] wifi: rtw88: use cfg80211_ssid_eq() instead of rtw_ssid_equal()
Date: Fri, 15 Dec 2023 15:38:53 +0300
Message-ID: <20231215123859.196350-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215123859.196350-1-dmantipov@yandex.ru>
References: <20231215123859.196350-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer generic 'cfg80211_ssid_eq()' over dropped 'rtw_ssid_equal()'.
Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/realtek/rtw88/fw.c   |  4 ++--
 drivers/net/wireless/realtek/rtw88/main.h | 12 ------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index acd78311c8c4..3f037ddcecf1 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -998,7 +998,7 @@ static u8 rtw_get_rsvd_page_probe_req_location(struct rtw_dev *rtwdev,
 		if (rsvd_pkt->type != RSVD_PROBE_REQ)
 			continue;
 		if ((!ssid && !rsvd_pkt->ssid) ||
-		    rtw_ssid_equal(rsvd_pkt->ssid, ssid))
+		    cfg80211_ssid_eq(rsvd_pkt->ssid, ssid))
 			location = rsvd_pkt->page;
 	}
 
@@ -1015,7 +1015,7 @@ static u16 rtw_get_rsvd_page_probe_req_size(struct rtw_dev *rtwdev,
 		if (rsvd_pkt->type != RSVD_PROBE_REQ)
 			continue;
 		if ((!ssid && !rsvd_pkt->ssid) ||
-		    rtw_ssid_equal(rsvd_pkt->ssid, ssid))
+		    cfg80211_ssid_eq(rsvd_pkt->ssid, ssid))
 			size = rsvd_pkt->probe_req_size;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index b6bfd4c02e2d..e14d1da43940 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2090,18 +2090,6 @@ static inline struct ieee80211_vif *rtwvif_to_vif(struct rtw_vif *rtwvif)
 	return container_of(p, struct ieee80211_vif, drv_priv);
 }
 
-static inline bool rtw_ssid_equal(struct cfg80211_ssid *a,
-				  struct cfg80211_ssid *b)
-{
-	if (!a || !b || a->ssid_len != b->ssid_len)
-		return false;
-
-	if (memcmp(a->ssid, b->ssid, a->ssid_len))
-		return false;
-
-	return true;
-}
-
 static inline void rtw_chip_efuse_grant_on(struct rtw_dev *rtwdev)
 {
 	if (rtwdev->chip->ops->efuse_grant)
-- 
2.43.0


