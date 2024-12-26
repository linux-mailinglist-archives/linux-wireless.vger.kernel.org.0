Return-Path: <linux-wireless+bounces-16804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C59FC987
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 08:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BCD1619A9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE01684B0;
	Thu, 26 Dec 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="f7wKbdvw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCD77F10;
	Thu, 26 Dec 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735199832; cv=none; b=UL9yETIHJAZ9sy4GP29xu4yJ5udTvfDhxTxFZp1B4mfMACbNKw6xvK8bNp8GGl9PnRGVtLSf79wDuArJBZ6OqRXEMNYoqOTq7S00W/EZYoIi8Dz3Jc0UWpsT3Bkqyy41x0A3hCsRi4+a0cC1T/lCw3XtRo0dMlGNGt1aRksgyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735199832; c=relaxed/simple;
	bh=m2Oao6Ilp3Ej1XTcX+f+slevq4kxELufuVtDJMDHN3s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oXSL6FLf5s6dINby5j/W2wYgyE7yQdpz2zzMSiFS0H141Uprel58W+aQcKokIx6jcYJs5v9b6stQXyyVUe50XwvZ3AfSendZGPLX0EMNF+4cxZIzLmv/u6NhdQCBQSiND1pTv8Q491hKuLiss96gzQAfXTop7d8Bo/ZOQyYT+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=f7wKbdvw; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id E9A2010F9812;
	Thu, 26 Dec 2024 10:47:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru E9A2010F9812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1735199259; bh=OlYOAcedIe2WplJcsEEaxseHblRY5yphhqpvTb2giS4=;
	h=From:To:CC:Subject:Date:From;
	b=f7wKbdvw0eichRcumOuQEmWREBEhkRGfpwFpBlQKBZ3/TS8HxU9UQCWrAZZXfh3KY
	 woOSduIr/jKKNcmAWAYsRBNSXOHtjOYNuSdwYFyjARgKxxD9/zqDkVQW0I0bmnD0P5
	 i+VcW91jDIz8cfXTAdVqOOGvWjbEtpg6RFvza/24=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id E69DF321433C;
	Thu, 26 Dec 2024 10:47:38 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: Julan Hsu <julanhsu@google.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] wifi: mac80211: fix interger overflow in
 hwmp_route_info_get()
Thread-Topic: [PATCH] wifi: mac80211: fix interger overflow in
 hwmp_route_info_get()
Thread-Index: AQHbV2pv0eKs7ElagkWE1F00G0BVAQ==
Date: Thu, 26 Dec 2024 07:47:38 +0000
Message-ID: <20241226074737.3737062-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/12/26 06:30:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/12/26 05:01:00 #26918077
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
 net/mac80211/mesh_hwmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 4e9546e998b6..7d367ff1efc2 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -458,7 +458,7 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 				    (mpath->sn =3D=3D orig_sn &&
 				     (rcu_access_pointer(mpath->next_hop) !=3D
 						      sta ?
-					      mult_frac(new_metric, 10, 9) :
+					      mult_frac((u64)new_metric, 10, 9) :
 					      new_metric) >=3D mpath->metric)) {
 					process =3D false;
 					fresh_info =3D false;
@@ -533,7 +533,7 @@ static u32 hwmp_route_info_get(struct ieee80211_sub_if_=
data *sdata,
 			if ((mpath->flags & MESH_PATH_FIXED) ||
 			    ((mpath->flags & MESH_PATH_ACTIVE) &&
 			     ((rcu_access_pointer(mpath->next_hop) !=3D sta ?
-				       mult_frac(last_hop_metric, 10, 9) :
+				       mult_frac((u64)last_hop_metric, 10, 9) :
 				       last_hop_metric) > mpath->metric)))
 				fresh_info =3D false;
 		} else {
--=20
2.39.5

