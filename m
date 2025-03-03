Return-Path: <linux-wireless+bounces-19706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24519A4C17D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 14:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FE83A9117
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40491FF619;
	Mon,  3 Mar 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pMWhQSZ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575711F19A;
	Mon,  3 Mar 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007905; cv=none; b=UJJWiUWktX4xwiPojMYMvc8iZRAuk/7GoWfha53iwNqWs32mv1Exxwm81VhR4+UdYayJciREXYx96TXh9LEs9LM9FvnVnIjQO3jSgIGpSzUsWpZedgDVub1IM/Oq9t63+3GdSSYEzHrP4y8A2LCMtjzAV4IHupTF8De2cb3PPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007905; c=relaxed/simple;
	bh=jMjxzuU5ybybM0n8xvB9Cmcz8tDPN1BHkYcTdsgjICY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VmXFfhMjxRxTbx9v1w99aU5J5FoElwbkbkqKlMmD4c80H2RpiK/B46vgQre1bSVwul/ef7pIF4IkhcXTnE1jlXYVhy49+whZAEqZ8gNY30fqykIWnqBW9iY5FOAyxXYtqvKM6pYZe3Osg/2NqkQmWqe/EB6D0os17w+9SmZz1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pMWhQSZ7; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741007901; x=1741612701; i=markus.elfring@web.de;
	bh=haP3YnQ1hTaM4n45Pmancys67feBgEgblRKSuXDvr1A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pMWhQSZ7mmW6WnDrAnSZ/723yKkMZsWgqcHn2JYzn1A2XzjyBQm/ik2Ej2mC1NQH
	 GS13QOP1KrUfaS9mzQLNqpYvcAXt+ZrVgZNDc8I985hG21SwlbBCjbbyuHewMB0j2
	 RfUayrlNt2Wq4kVnJ7kkrs/JOnFoliDCRErARsIXSntPWj7AN7XGGIEdC//pfHwBe
	 C65KCMh/qrJaLbD5iw/e5SYFHMqa8zoI5j6/qFfTybG52f5DLtpbv2CDqt02CG0fl
	 5XvG3fzPCoxLs+DE5EQh32/D4va8BUxB+HX1cOrQEgmk5eC+PfTdnHTOkS0zaZd89
	 eX2aliMELA8jm5EZnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9LIO-1tAIuH18K4-00yGaQ; Mon, 03
 Mar 2025 14:18:21 +0100
Message-ID: <22e24ec8-283f-49e9-b7b0-555e8113c250@web.de>
Date: Mon, 3 Mar 2025 14:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] iwlwifi: Adjust input parameter validation in
 iwl_sta_calc_ht_flags()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Kalle Valo <kvalo@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Sriram R <quic_srirrama@quicinc.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
Content-Language: en-GB
In-Reply-To: <9cb634c8-d6e6-32bc-5fd6-79bf6b274f96@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:klaLpxqRowNpOLqo5TgPE5pwLuOQZxsO7wlnEJEJTMtovuceQzK
 9j5rbUI7I/TUnJK5L4CF9gFQ/eXeg/hblRTs/rM+HoQQF+nLiHgvC/yTerLULFGe/c3bjBb
 MarWJxxg7QLtmxPmtF6LdNp6dF/otzHpWAAhCXfm4i7bDtKLPYB1jL9ij0B0MigrfUOTzCo
 MJ5lJiYrKHkil1c2EPwtA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8hjet2llDHg=;XzADO0IesvNkdn8ez1GDiDig+Fz
 zTe+5Ine+8o3lhtscOx2xxi399ryECeYZas5pCUHajSWwa2tGmdwuInMoma4aFSTyAtiZPsT8
 Td3ElBtGnXvSZPt2JqexXGkv2th3KLL4Ksn6WUyuSs60H4HXN0PkhqDUMGBc3RB5t4JF7sQfT
 m1o7WJsk8vTAsrhDgRw1ZvFiCqEML2kYSTkJex2XIqjQ7lCXtgVEdfA14+qsl+FdpQOFHFT/0
 b6el7Rh3ECXRN/hJH96cfwNPbCIUxZNeVXegFDlQXhDnDNlIjz5iMEr8q/CX2O6m+X3x2yYFY
 v2amNEe2oyJROYUyGCzI9IHecp5McECXojybvKBRSdSrXxH1rT2B1GTvCNZGg3aqVC6GY9wQs
 YJjK1j4mQC7OdbxrjNQj05YszK8t98EsRL9YXExRvbylVnGj68YlKDuZmdRITkNUEB6NhOXrt
 9ENDovRTtJiy67JzRlDE3pKxcPiMHfNPJeMuEO5DpxC2Ca0NPuuq6joFmFz6u1tny/f6gGFvF
 CwLnm6PYRtyXliEVUEn3UUSmDQTz8qyhLs1YDiBIlfeHeZxOaCMscP4YmSn09lyxFef31utby
 9e/uuey3/Jb0I+EZMPUlcH+R23S6MB5gWQ3dFKyQa0f4IypJ389rcODASgUmiXOj5yJYd1u6h
 18/XyDfamrCdIDiv8Licz9/xCiJNJ8IcJteTAMtttm7VFfDjpwlNTvnHVsyP+l+s4ArmONhUD
 XczPFTFaUcmcyFNmNE1+Jf4oEaB8JHXup56yNPoPdXUB6O5mvI/uRDflz8PPQDB3cDowMDC2K
 fJI5d8OkAD38Lr2Y7HnRdBtpy4YiG/JvLBoDMiMdwdwjku861gIE4yA9KZ5atkEG8iZsiVQNG
 Fp5RrdyblFAmPqP+tokyt0D02ZaqcVWwaXCJxBtF/bom3uKwkcFeZajNEHvzXJeRimFFxuRSx
 iTVGaRkdxNOJpP/dncIAe+YYdMSVbCcaPK8BtL5BgehI9VSW730Q+I8Geqoovlt5z0r5C3SyP
 Sg3sMcN6rbx4eRDJOjdxC7OxPDQ+wq98GAyjOCXUT5kRlB8+qBGyQ4xtCwdswHicA1amiAULB
 mb7YvyaJRDSVf6JNK115i3QuY5Btciqw5FVf4+X7UmnoDROerESuHj38PUsb1WoBhg9Z4hItd
 egqapByLzxK/qytebvoMt39/lcwCM9K6VqwRXThr3O/FQk5pmyrSkJsa96UD7aS19COdjUN3C
 8vJyHRwOqwn4h0JhsvpgBpMZbA7Xobq7zhjU+IPlCtOJcCB6ycaFsFgxPk6Z/XVY8nh8gT89k
 cYx7F5B3JDlXk6E1236nBVcknM7JRLrPnkZ/LEGDzy9wvDplvGK301Ntv0TxPsf3//NbNRc3M
 q/WBsCJCPfXChuIyUY8QNUwh8NbKe56CRjUR3vHSvZctplmyU9Hat8/WJ2yOkA43RHGhLrvre
 NgFLOXuXjSyn+3kQuRcx4J6xC2XA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 19 Apr 2023 19:19:34 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Ciwl_sta_calc_ht_flags=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Csta_ht_inf=E2=80=9D behind the null pointer chec=
k.

This issue was detected by using the Coccinelle software.

Fixes: 046d2e7c50e3 ("mac80211: prepare sta handling for MLO support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wi=
reless/intel/iwlwifi/dvm/sta.c
index cef43cf80620..74814ce0155e 100644
=2D-- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -147,7 +147,7 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *pri=
v,
 				  struct iwl_rxon_context *ctx,
 				  __le32 *flags, __le32 *mask)
 {
-	struct ieee80211_sta_ht_cap *sta_ht_inf =3D &sta->deflink.ht_cap;
+	struct ieee80211_sta_ht_cap *sta_ht_inf;

 	*mask =3D STA_FLG_RTS_MIMO_PROT_MSK |
 		STA_FLG_MIMO_DIS_MSK |
@@ -156,7 +156,11 @@ static void iwl_sta_calc_ht_flags(struct iwl_priv *pr=
iv,
 		STA_FLG_AGG_MPDU_DENSITY_MSK;
 	*flags =3D 0;

-	if (!sta || !sta_ht_inf->ht_supported)
+	if (!sta)
+		return;
+
+	sta_ht_inf =3D &sta->deflink.ht_cap;
+	if (!sta_ht_inf->ht_supported)
 		return;

 	IWL_DEBUG_INFO(priv, "STA %pM SM PS mode: %s\n",
=2D-
2.40.0


