Return-Path: <linux-wireless+bounces-14899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34789BBE8D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 21:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93731282779
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA31D356E;
	Mon,  4 Nov 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="T0TuLFSv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69151CBA1E;
	Mon,  4 Nov 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750774; cv=none; b=dRSjmfabXkBQWpRP4v6EdcPUYUZyWa0l/kB0eeFo/Zt7AuS1whKLcl/dFwahF6PxQVYQIcq15VUN3RffY6z1oZHQKU6FVTHxX1hluW9CeWAKkJG1WZdINctdNEdgyR+UKkiE/LYwHkCbHvOGy/xMcctNoascNucV+kKGRKQoXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750774; c=relaxed/simple;
	bh=FKFWGi5po/mx3uK8oCShRp6WwiaDqV99UF5bP5pHJNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQmRUB1zI0rNjBDVyRoBwbkCBBawl6rjDPzahurKzW3gxE7zbh/RrCobpBTA+Uhz4Oq7Urnp1CuQp0LdYw7FpqenbyFqFrtxGekBXi2zHgpH64K5CtpeDrcSiHbo08XRlTss0GjJSnA7Hd9xvB/+00LRvPPCX7/3GZ5KKOgN7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=T0TuLFSv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730750762; x=1731355562; i=wahrenst@gmx.net;
	bh=FKFWGi5po/mx3uK8oCShRp6WwiaDqV99UF5bP5pHJNc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=T0TuLFSv+FKPahPisFOQSNfppvWHno9zpAXTeltY6/DiSESG2XY92oDYfJ2jIEG2
	 8N4+bL8tVBBDC2fUf3HzKyg7ECHj8666duELDKNpibZ/n6Ygem9OnAVCQ8B0fkTLl
	 OdAZiOIFwHzVnYmqXIROKupx8Dqw/uhI//KSKjycWQkA3q/nVzf1kJc42BV8Rwrcv
	 XMBl0TeVNvzmh5jNcuPUUbWWEge3722ihBQ8yOou87Ebul+MT0vB4tqcn1BSLe+zK
	 OTE9PuVgCc8vdN3SiXFN8ak1FlEcY9xJ8gOKzfmig6ozxZE5W7172Hsn4kIGaC4nY
	 8M662DnYvOAd3QSvPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1u0iFw2Kla-00xzfv; Mon, 04
 Nov 2024 21:06:02 +0100
Message-ID: <a122ad79-086b-42a9-894e-d589092bac80@gmx.net>
Date: Mon, 4 Nov 2024 21:06:01 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: error messages while entering suspend
To: Johannes Berg <johannes@sipsolutions.net>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, Kalle Valo <kvalo@kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>
References: <a825587c-e6f6-45f8-8ac0-a1a5642a5333@gmx.net>
 <16169285-d838-46f3-8be1-3639f573062e@broadcom.com>
 <86ef2465-3b5c-47c8-9e81-ad5b545bcfe4@gmx.net>
 <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <89888eab44b7b431ac7fedcd573db325e07b935d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VRc1NSBpucuM0Cx95dMoCWJfKwSLvhQQpbor7Bo1SQv2WCBHBKv
 LdEhTjaUfKVbvh+Lftxe77Rg0DMnHXUFn6/pcg3FDiakXcUblKti04fRc2/Fr0quJeudWJL
 zx/fg4wi2peI0ZR0LKzo16NA4nkLaglA5WblBuLInLlSbzC1Z7HUzVHJyYH1MRPdKhMWKsQ
 fp3Xve/CYm1ZRt8mqIGvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iqKjcf2qvjM=;V991R9Fa8EWLuo37ZVmw0KJ9HVO
 1k8cfmVGnOCpDk6rTQNBx4kf0wC/taGGHOmBaz0oH07NEDYKuOtYhPIQj2viajT+N0Fn084Pl
 /LKDz9wG+TNGPmCa/Z3RbLLEYHHASVHWNAYL2P6OF9vqVWCCZiuiL81lhw4gcIEp50jztRXeq
 c7vTfeQj/nq9Ydgt1W5WhDXiS4Kpvt1TNAbLHia7jJUOeGbR6eGlM4exawABvxTZMrD9Gf1CE
 ng9UgyMGH4gb3f06sLe5PvaoYP3RQ4He4yF3ckPUHv6xHv3EBoqtpN/5qvXqciecZ2dl43MAc
 Cp0Pvtb9972SdF9Nig7f1R0KGJWd4nLzRxh9Ew4gxiuIv2naw4tobKC+ImqD+NaCzCTBny6fK
 1RRi7bEbASmU9hQGrJO2rFUgYWFdAF9IZUjEk9zZBv8FJpCQVPcz9hQkP2Y7p4z59+XFNjjq8
 wb4xl9vlfFXzr4krk42KFDt/YryVUZ1MhJPuRpkfHglr7cfM8FWE2ntYtrsdu81UeBT07whi0
 nfK8E6qCsumsdtz3dQlEElWPXkaSSKs+UKWCJTMtIKRIzDBZRmLTBJFlw6Zkso3lfdPXtLuXs
 v1Z5gBejJNamwDFoJqVwrIPoMiZzRWSS5oU/5XCG7mtXJt/LHEgTYih1nIhB8OBjAZVYh6t8D
 7Fruz5idq8K10M8tJPgGKxLaegnO9GH3Fibsh3WjgHVd44y4euPs0ItSUIGeoq2ZTCueVtzSL
 eIQoP350I/vvIp2EmKB4nNCs9zQ34ESVEoLlb8bvmxJBrKZaYs0HQg3keZ//q/93g0K7QL7HF
 Pju+4Lg04NgXBZP2ysWwYh0w==

Hi,

Am 04.11.24 um 13:18 schrieb Johannes Berg:
> On Mon, 2024-11-04 at 12:59 +0100, Stefan Wahren wrote:
>>>> [=C2=A0 384.292071] ieee80211 phy0: brcmf_fil_cmd_data: bus is down. =
we have
>>>> nothing to do.
>>>> [=C2=A0 384.292079] ieee80211 phy0: brcmf_cfg80211_get_tx_power: erro=
r (-5)
>>>>
>>>> These errors are not new and I assume they have always been there. I'=
m
>>>> not an expert here, so I want to know is the problem here that the SD=
IO
>>>> interface is shutdown before brcmfmac is suspended or lies the issue
>>>> within brcmfmac suspend itself?
>>> Upon suspend we execute the remove path and cleaning the interfaces.
>>> We notify cfg80211 about the removal, which in turn will notify
>>> userspace, but is tries to obtain the tx power from brcmfmac.
> I guess "it tries to obtain" is some sort of event path that wants to
> include the TX power in an event. That doesn't seem to make all that
> much sense on removal events though, so perhaps we could remove the
> get_channel and get_tx_power calls for NL80211_CMD_DEL_INTERFACE.
>
Not sure if I get it right, but the follow patch make the errors go away:

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1ac8a196f376..52120cce2f7e 100644
=2D-- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4006,23 +4006,25 @@ static int nl80211_send_iface(struct sk_buff
*msg, u32 portid, u32 seq, int flag
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 nla_put_u32(msg, NL80211_ATTR=
_VIF_RADIO_MASK, wdev->radio_mask))
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto nla_put_failure;

-=C2=A0=C2=A0=C2=A0 if (rdev->ops->get_channel && !wdev->valid_links) {
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct cfg80211_chan_def chandef =
=3D {};
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int ret;
+=C2=A0=C2=A0=C2=A0 if (cmd !=3D NL80211_CMD_DEL_INTERFACE) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (rdev->ops->get_channel && !wdev=
->valid_links) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct cfg80211_=
chan_def chandef =3D {};
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int ret;

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D rdev_get_channel(rdev, wdev=
, 0, &chandef);
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0 && nl80211_send_ch=
andef(msg, &chandef))
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto nla_put_fai=
lure;
-=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D rdev_get=
_channel(rdev, wdev, 0, &chandef);
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0=
 && nl80211_send_chandef(msg, &chandef))
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 goto nla_put_failure;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }

-=C2=A0=C2=A0=C2=A0 if (rdev->ops->get_tx_power) {
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int dbm, ret;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (rdev->ops->get_tx_power) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int dbm, ret;

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D rdev_get_tx_power(rdev, wde=
v, &dbm);
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0 &&
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 nla_put_u32(msg,=
 NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 DBM_TO_MBM(dbm)))
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto nla_put_fai=
lure;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D rdev_get=
_tx_power(rdev, wdev, &dbm);
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0=
 &&
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 nla_put_u32(msg, NL80211_ATTR_WIPHY_TX_POWER_LEVEL,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 DBM_TO_MBM(dbm)))
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 goto nla_put_failure;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0 }

 =C2=A0=C2=A0=C2=A0=C2=A0 switch (wdev->iftype) {

But this change doesn't consider get_txq_stats and the further calls
rdev_get_channel for the valid_links.

Do we actually need nl80211_send_iface() for NL80211_CMD_DEL_INTERFACE?

Regards

