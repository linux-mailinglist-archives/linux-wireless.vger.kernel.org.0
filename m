Return-Path: <linux-wireless+bounces-17590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BEA135D9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 09:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1931889A7A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F981D7E4F;
	Thu, 16 Jan 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="AwmewLz3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9535944;
	Thu, 16 Jan 2025 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017394; cv=none; b=p1wa0ByIaKebW68140vQGkkRns0zfCZ7q3LxTEY0w+kS6vmQyjvLt8BRlWm805aPBpd99ROaW9WxTmabvdr3VuOFoLSufeo7JiDfYr0DrsabpJmeYB0tiqQWMj1d3u+wao7rRq0WqyIIdeZtEo3MO3CuCt0xyTKxWG9yqG/3rMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017394; c=relaxed/simple;
	bh=Ay0ixWvSyXQi4ZXOFtgmghu+2Uv6P88QyD0VBuIy3NA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMhOEo1tT8vxjVkQaHjqBYviqYXTMmF/Pauv/nFxIXe3VMiZhysUj8f+pMq+qPUt1UOcq3nIrpwi5njF1kq7oSqFBXF+ZmmWw4NvoeqfT6UZHIcWJFalTguR3tHbiqsvDF0LrFpZ/V0zYz3JR8XkkzQ4qwIGT0H9N2LzFTGSBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=AwmewLz3; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 4F4CF104EF8A;
	Thu, 16 Jan 2025 11:49:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 4F4CF104EF8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1737017389; bh=QFT97n2tszIVPac1sIYnOooZaURyzmEqOYawWd99dlw=;
	h=From:To:CC:Subject:Date:From;
	b=AwmewLz32MHeMYc0iGxeM33WUQkrZdIpZ57aNy2N1Yw4L148Mmll+1p82y6mlE0Rb
	 urnissziXHZFEhE63pRmauyftwDtcBwk9cp7UMFgG1oyDHDdKshQokK8js5eXFrRP7
	 NIYhd2zT4gWL6dpfG3cep0yI33XzNpesCCNQvwWk=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 4A1A7302E8A0;
	Thu, 16 Jan 2025 11:49:49 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v3] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Topic: [PATCH v3] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Index: AQHbZ/OZISFF+ut0wEeUiomHEH881w==
Date: Thu, 16 Jan 2025 08:49:48 +0000
Message-ID: <20250116084948.3933834-1-Ilia.Gavrilov@infotecs.ru>
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
v3:
- Fix a typo (persent->percent)
 net/mac80211/mesh_hwmp.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4e9546e998b6..79aa29d61e6b 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -367,6 +367,26 @@ u32 airtime_link_metric_get(struct ieee80211_local *lo=
cal,
 	return (u32)result;
 }
=20
+static inline bool is_metric_better(u32 x, u32 y, u32 percent)
+{
+	u32 a, e;
+
+	if (x >=3D y)
+		return false;
+
+	a =3D mult_frac(x, percent, 100);
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

