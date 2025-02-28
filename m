Return-Path: <linux-wireless+bounces-19574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7AA49728
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D673B8B73
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C64125D543;
	Fri, 28 Feb 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ddtPTh25"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BA25CC7A;
	Fri, 28 Feb 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738242; cv=none; b=ipV+DX0uh7vuMm0130zogHbsEr5F04OlrqZwTJ36SQ9JQXksXFphD1Tq25Yr//pRTZcuYUszwndQT6zAVpdmbs/U3xmnU0HYEOMZpEsU2fIfNcvyVku5HLD0agTQATrET7QC/ohLyhZCVWdbFfkWCqq567YP/SsE4mssiZwEsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738242; c=relaxed/simple;
	bh=BkSaTDuV8aJKGAcY1isKai6ZQgdmPKzjoJ58bSGSBxc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mCzHbB1OrlGfqk1trbcMPgbWlImYW5OYjcM4bfUD44rxGfjw9gFvRUDE4cPq5CfPwEi8km+1u01ssLZM604J8ghaWbU8DOZLesc4VeaU+Iwg2fILZAmUVOKVpAFzcGOBK7VYddrsC1cVwocV3YnPtflqEMUnC8uaP/BF/RZXVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ddtPTh25; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740738230; x=1741343030; i=markus.elfring@web.de;
	bh=ovxM7W/WZIC5scrJGTKL2uStXu/qsFMpBnArw0UcDQ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ddtPTh254seY7zcYg2bKxeLqxZanfoRHPVPW3rmv4irdCf+AOTGDztjZwwE60Np4
	 x6ExurIdZYgyN7L9valb3fi5zxVGRG9gm5bPUsxPSiTynWegolSrfr6V20QDcUnPA
	 x2cCXZVkXYr8/hMYeXnd/UV1/bsrbYaS28Gx0KSGdbpjBD9NTbBgtig4DuHJZQ3SU
	 FxwDMnaw51bf7SoiYNmpsnCIUgCu5lh852VaNDa2Y7xKeBO6Dt57kpoGpWJNys3g9
	 F18MZumBoXlh0nU5+Wre2eyWsSV1CQNYuxajgQ16eI9oIRmYJ/KB4pLJ7WYg1Dv6l
	 8XQamzzYUyCvnD7fhg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.27]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1tP6IN3njK-00ibfZ; Fri, 28
 Feb 2025 11:23:49 +0100
Message-ID: <b8a3ccdf-a059-4550-8a9a-bfe66ce28cb2@web.de>
Date: Fri, 28 Feb 2025 11:23:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Qasim Ijaz <qasdev00@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mac80211: minstrel_ht: Simplify minimum determination in
 minstrel_ht_refill_sample_rates()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XuA7nY+nhwadQfw+MMVyvJ230D1hW3bunm6pGUkc2LipmnUHF4m
 26XI9/fbk1qdykyzOgoE0u43wJk3KbsHaoMs9aabsXMhh4CSMkcxpTJDUYCDXO/759hufB0
 uEbp863mkDIYxTvHQ1s721Bmtvo5tPm6POQEHVVWSCMkhdq4t6+FDFsB1IpmdZlPnSdHNx9
 bWT8ptSSSVPcLgB/+NC6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uk0zUWPff3I=;njChae6bie3Tf72Sprwkwvi9wHM
 Plf3p1plltYSQ7iVJaI+NRos96qIhBV+U/aQXXR2dTDY8fCUtxcnky1Li50Q+VvxabdNUZFZR
 QIDahz0MuB10cAY7W4mh4NJlU/EndHiYLtwPVffulY03h/ZHGRegEztWRzWx3SKe0O9vVUHEn
 EsBxoCzaY/PnXO3gDuldxAR4kXeKwv2fkEnEWz6+H7W+keZH60GJkBNDVDIdslG3mLHWZmPRI
 maMHxcyyFC2EqMdd8Bg4q1bh7HkKhZmhPfAFcRI3GACxYRaaHgnoYU4B3AcGqSSesYHEJVugN
 OgGx593Hb0bHAKTC6OSengYNCLnq4ZHX9TWJOcd++MLHJBtEHzi2W9kbq3Zx9GXNiefpCgUbN
 5MasKkEQHdCxgmcqa0SVO8XhLDHwpRr0kk2oMl/x/uvRqNECizfXKwrr2dFcteMWKPk5msvZw
 eh2xN3UHTU8NI+mgVLIZByWNFVaK9SRssNhOnoyFt39Pq/Qh0boUGlD3Tv0jSp5LalrDTmGiG
 cprFxCmedSRLwvObw9iXnELIzYd/9gqH2S+Ym6Y5B3wIeE/YSe0tan9MwNJarxLlXHrozql1Y
 pWbfC/9uZo4NLLNwmFdrbQO5uSkH4f+33AlZNOhtnIOY3qv9Le2pRjm00QaZQqd9BImu9mNEQ
 72x10RYEnLet/rrEw/gpWUy4WN7UQRKcKS2rV4V1JSjaQ895CHn2JGe99nT0hvtloXlQNKupg
 vqpLMTG5N+f6MYJae6cSYU6b1gx7xjrMl0lC5gAN2tm70b4kJK3i1e+KF31qFweBHASOL951Q
 d3oS3DhQuHmni0XslZD4lIRUfG6A3OQHWYXTvpJ3Sr/DkZ64nuFzip8AQ7dOfbg9QrWRMmTEw
 XLapuAw2B2Ce1yn+itosvgaGsC7RAA0BnhgNdViseu5jtIuVO9GV3cFmISUkRLGxVDbEPmVLx
 lMQ+US6qHyXWPSh5y6f6vrsusUWiGrQ/yRo3YKbGnv4AuYluVhJIZRshXebH/DYI3buA/MGuO
 xgslm7cFLfbCmMf+4ohmSD3J8g0GNkDrE+P3T3ACxMtge17N/UOf/KsBczPIgfUOTpoDKZbqN
 qxzFgEQ6ss/kDJwFx9ucZaYsmoerp8KaeADu4hjXJz69RG/qKb/8uMDykQWw1z5biz50Mafd/
 RmP1J23LV8EJr5CmVlnzk0SEu5odzKeFwWSCy370Ad9TOUXeFv7l5s33NwGk2GSekt9KjRnxb
 17dowOg7/OtTpBqtT4EUFt31iSu9a725liA8JN5BwEF/WklYAoqnWisD8Y3fP1DJtQlOtJman
 U0EvqbPu2y8gWbgKBDP7+0hVZdSPvcARHOVPd5QA9zBjurcMU4hMVPP0okpTB7tpc0Bt84v1s
 jQlrt8e0Kg+M8vcPQdAKKTYuytAYa/phkFL3OwW1xSnqGVhxxWpwP09TlHmuUPH1h36Q6VtyS
 TRnhDWPe6+jG8Tzn5BqqLqORN38A=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 28 Feb 2025 11:13:58 +0100

Replace nested min() calls by single min3() call in this
function implementation.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/mac80211/rc80211_minstrel_ht.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_min=
strel_ht.c
index 706cbc99f718..31a3b6e4c58d 100644
=2D-- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1010,7 +1010,7 @@ minstrel_ht_refill_sample_rates(struct minstrel_ht_s=
ta *mi)
 	u32 prob_dur =3D minstrel_get_duration(mi->max_prob_rate);
 	u32 tp_dur =3D minstrel_get_duration(mi->max_tp_rate[0]);
 	u32 tp2_dur =3D minstrel_get_duration(mi->max_tp_rate[1]);
-	u32 fast_rate_dur =3D min(min(tp_dur, tp2_dur), prob_dur);
+	u32 fast_rate_dur =3D min3(tp_dur, tp2_dur, prob_dur);
 	u32 slow_rate_dur =3D max(max(tp_dur, tp2_dur), prob_dur);
 	u16 *rates;
 	int i, j;
=2D-
2.48.1


