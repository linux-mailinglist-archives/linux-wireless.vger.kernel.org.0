Return-Path: <linux-wireless+bounces-18829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33AA32110
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BF63A2397
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40935204F73;
	Wed, 12 Feb 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="R/GGP3VP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1D1D86F2;
	Wed, 12 Feb 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348885; cv=none; b=Sjt+8Cjl+Xhn+cxOn9gki6cYK37bzZqMUtvQRJunBr3luALZTLbWNt3Qz6nf2cIA1nwvxWKhP37eCXzpmEmmVzJ074WozEusph6t+7/URO1Emce9HQoRjRIKAnYM32JpAMRagoJrXZfwrCNFE9WXkwUFO+gn39WP46rLvQCjs3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348885; c=relaxed/simple;
	bh=1yEjyPyPd55xrfzDLQha4JqWN0HhYlvPPLP2kUZIZwM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EUqbXXK154N1ux1tlDO/fQeq0oLAF+HIPczRWt2kjE8WP5pXDOyzbuPUEDNwqd4Z/hLlUaSYzXEq97pDyM565Ay2cHijH17RFJbSeYqd21DLN6BKNXerb47ruLlH6QjLC4yswc+g1IOodH82JP6jFCMdDCqPsT53EAc08hjC344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=R/GGP3VP; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id DC74E10713A7;
	Wed, 12 Feb 2025 11:21:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru DC74E10713A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1739348486; bh=xsDP1LEoMSu7HIkQ5w960VASY/onF6JaEzOXJrcEgEk=;
	h=From:To:CC:Subject:Date:From;
	b=R/GGP3VPFBshVBKCYNDVeuaRJ6ofhSHY3zwm4ngu5NYxJ7L7vv8ju9FGARhg+7WEN
	 f78GERTrCAtF1Z5d2WvSwaPwJv7vp37wwIIBS2UCfhoNRIwQjmhODoqMYnh3ojjM2X
	 afVVSfkkLMwS6RW6mUZelurZiuMFih5o190WIHBg=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id D937F3045BCA;
	Wed, 12 Feb 2025 11:21:25 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v4] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Topic: [PATCH v4] wifi: mac80211: fix integer overflow in
 hwmp_route_info_get()
Thread-Index: AQHbfScbaA7QH0ty/EqZGebnxR+Xlw==
Date: Wed, 12 Feb 2025 08:21:25 +0000
Message-ID: <20250212082124.4078236-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/02/12 06:53:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/02/12 04:08:00 #27176921
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
v4:
- Simplify the is_metric_better() function
- Remove 'inline', add a comment
 net/mac80211/mesh_hwmp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4e9546e998b6..c94a9c7ca960 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -367,6 +367,12 @@ u32 airtime_link_metric_get(struct ieee80211_local *lo=
cal,
 	return (u32)result;
 }
=20
+/* Check that the first metric is at least 10% better than the second one =
*/
+static bool is_metric_better(u32 x, u32 y)
+{
+	return (x < y) && (x < (y - x / 10));
+}
+
 /**
  * hwmp_route_info_get - Update routing info to originator and transmitter
  *
@@ -458,8 +464,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 				    (mpath->sn =3D=3D orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=3D
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
-					      new_metric) >=3D mpath->metric)) {
+					      !is_metric_better(new_metric, mpath->metric) :
+					      new_metric >=3D mpath->metric))) {
 					process =3D false;
 					fresh_info =3D false;
 				}
@@ -533,8 +539,8 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) !=3D sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
-				       last_hop_metric) > mpath->metric)))
+				      !is_metric_better(last_hop_metric, mpath->metric) :
+				       last_hop_metric > mpath->metric))))
 				fresh_info =3D false;
 		} else {
 			mpath =3D mesh_path_add(sdata, ta);
--=20
2.39.5

