Return-Path: <linux-wireless+bounces-17587-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA700A13581
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DB718867C4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE301ADC81;
	Thu, 16 Jan 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="KTxDg9+N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355BA197A8B;
	Thu, 16 Jan 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016642; cv=none; b=cn4CCYmhTy6QF0AjkgYiUbBSDC+AsQyRhKymm2vrR+lLpJXMrzwRPIR7slopJJ6CE5STNutNT1QJEdZ42+wT6gPdzDIZK+trSEqj2UMs9W9k/F/WZyCb+C2QyeZ7wbq9NRt3gc/gtfi2MrLluPFj7/efhOCAQchGw3xVV6Dk8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016642; c=relaxed/simple;
	bh=u97bZSAzNPdN2wy4YPbkJbKCCPI3tneN0r7EHqmk074=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hRJ0Y3cOQE+1F22kuhlIARW5emfbECelHEexNsr1g7VG12sHzvlasyny/l6CesPl61Jt615EQ5yQOUBVaaNk5iw8zsG+3mKNHH5Lxp+TV6C25cbA2CTSIYDPfdFZoKBz7Tt26eAN5GUpdQAAbEywzRzP1RYmQJ+SgJ6xuHHNIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=KTxDg9+N; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id EEC3B104E004;
	Thu, 16 Jan 2025 11:31:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru EEC3B104E004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1737016291; bh=r7SMpMaUy70vtJ0RMkNydBK1HZgkL2YTYqhJ3MxRekE=;
	h=From:To:CC:Subject:Date:From;
	b=KTxDg9+Nxth9UAT9w3CjedxdIwT8siUJWV4wGLHeaaQ2S1nGHXlokTNZ2XjSoS3Vn
	 buS0c87Ps1EDleikTY6APGVJAfKosnQPLCj67uzXGumno+PO0nLsFly9ndaAIJtBzD
	 nXpqAyZVnvS6BPEoavNEyH4wrKxxeIbhGNdp+ztM=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id E8C943066066;
	Thu, 16 Jan 2025 11:31:30 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Topic: [PATCH v2] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Index: AQHbZ/EKB/18T1vQNESPvuAAOLFY3A==
Date: Thu, 16 Jan 2025 08:31:30 +0000
Message-ID: <20250116083128.3901602-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/01/16 07:12:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/01/15 23:13:00 #27037711
X-KLMS-AntiVirus-Status: Clean, skipped

Since the new_metric and last_hop_metric variables can reach
the MAX_METRIC(0xffffffff) value, an integer overflow may occur
when multiplying them by 10/9. It can lead to incorrect behavior.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: a8d418d9ac25 ("mac80211: mesh: only switch path when new metric is a=
t least 10% better")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
v2:
- Remove 64-bit arithmetic according to https://lore.kernel.org/all/a6bd38c=
58f2f7685eac53844f2336432503c328e.camel@sipsolutions.net/
- Replace multiplication by 10/9 with a function that compares metrics by a=
dding 10% without integer overflow
 net/mac80211/mesh_hwmp.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4e9546e998b6..4a7446e4c226 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -367,6 +367,26 @@ u32 airtime_link_metric_get(struct ieee80211_local *lo=
cal,
 	return (u32)result;
 }
=20
+static inline bool is_metric_better(u32 x, u32 y, u32 persent)
+{
+	u32 a, e;
+
+	if (x >=3D y)
+		return false;
+
+	a =3D mult_frac(x, persent, 100);
+
+	if (check_add_overflow(x, a, &e)) {
+		if (x > y - a)
+			return false;
+	} else {
+		if (e > y)
+			return false;
+	}
+
+	return true;
+}
+
 /**
  * hwmp_route_info_get - Update routing info to originator and transmitter
  *
@@ -458,8 +478,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 				    (mpath->sn =3D=3D orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=3D
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
-					      new_metric) >=3D mpath->metric)) {
+					      !is_metric_better(new_metric, mpath->metric, 10) :
+					      new_metric >=3D mpath->metric))) {
 					process =3D false;
 					fresh_info =3D false;
 				}
@@ -533,8 +553,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) !=3D sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
-				       last_hop_metric) > mpath->metric)))
+				      !is_metric_better(last_hop_metric, mpath->metric, 10) :
+				       last_hop_metric > mpath->metric))))
 				fresh_info =3D false;
 		} else {
 			mpath =3D mesh_path_add(sdata, ta);
--=20
2.39.5

