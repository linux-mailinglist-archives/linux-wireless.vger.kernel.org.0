Return-Path: <linux-wireless+bounces-20583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D0A69D35
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 01:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BB9003BD
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED872744D;
	Thu, 20 Mar 2025 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="V84Z31WT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0979F2
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 00:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430310; cv=none; b=hyQexhBXVWCP4+mMu/fJerO+xeJFd760p5C25sszI02HPasRtDvGdzqb/PKto3eVy4YKC/120m3Banf2L7wion9MBTpmyTEoiuO4tF7Mh435gkSanhfnqFzOpMQkxq1gITpOdXDN6NML/vLtJtCYawtcvsl7uomjblIwB6pZ0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430310; c=relaxed/simple;
	bh=jqF5joFouSt7kbfZCCT2gvTGMMcgED0A6GfZOSZTVuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3bvqZb9A/jYIOWsZk1UQaKfVzpCig6LbsI5xPC+h6Ln8bgJYhRiytBL0JLbOjJ49hCieNEASVEpwoRAbnBFN1dvMI/ZaNUc2b52S+AT8aW4lMTUhmeJHaJvgvNRm9sQBY2PQNeJsobMsu3c0C2QiJ2IZ9U+UkXBTokV76WEc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=V84Z31WT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K0OctZ61484847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742430278; bh=jqF5joFouSt7kbfZCCT2gvTGMMcgED0A6GfZOSZTVuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=V84Z31WTRaZXT5U9CaIDtc90THInU6Y0Ts7i4MHc9nHMMTZ5O1N2vHtYoxN9g5UTa
	 BhDXM76HTJC12xpb6yIgQ8ybgtJIVXnbgyMk+d2A7Uyb2uIuCZRIyAYhAsu9kLZ/mg
	 JM9JM++kvJSAl8TnUcwXMhXK8eEze/7HeAvjJZkyjcn8OAxbGckz4tbY7xTrj+BDgG
	 hnEvmXzg+KweRhF5rAc0cOQsPaHxn+qlu/v5g5AN2AvmlB8FJLiZINtuqyzjCkH4Jg
	 x7ffCY5BIXzt1to9hLuPzAtOpf/9nfFGe0lUb+xl53yviTBYDvcDao/bNWVvzKJR4R
	 J9ZHPmc8oCdQQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K0OctZ61484847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:24:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 08:24:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Mar 2025 08:24:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 20 Mar 2025 08:24:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pradeep
 Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: RE: [PATCH ath-next v2] wifi: ath12k: Fix incorrect rates sent to firmware
Thread-Topic: [PATCH ath-next v2] wifi: ath12k: Fix incorrect rates sent to
 firmware
Thread-Index: AQHbmOUFZrOJ4Em7mE6Hda2k7cKDX7N7Ke9A
Date: Thu, 20 Mar 2025 00:24:37 +0000
Message-ID: <524e12be0cb6421883d353114089fb6e@realtek.com>
References: <20250319153547.771843-1-quic_rdevanat@quicinc.com>
In-Reply-To: <20250319153547.771843-1-quic_rdevanat@quicinc.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index 9fda97667d4e..661167acaa69 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -3450,7 +3450,9 @@ static void ath12k_recalculate_mgmt_rate(struct ath=
12k *ar,
>         }
>=20
>         sband =3D hw->wiphy->bands[def->chan->band];
> -       basic_rate_idx =3D ffs(bss_conf->basic_rates) - 1;
> +       basic_rate_idx =3D __ffs(bss_conf->basic_rates);
> +       if (basic_rate_idx)
> +               basic_rate_idx -=3D 1;

It looks like you misunderstood what I meant.=20

The difference of ffs() and __ffs():
ffs(0x0) =3D 0, ffs(0x1) =3D 1
__ffs(0x0) =3D undefined, __ffs(0x1) =3D 0

So you need to ensure argument isn't zero before calling __ffs(), and no
need to minus 1 after the call.

>         bitrate =3D sband->bitrates[basic_rate_idx].bitrate;
>=20
>         hw_rate_code =3D ath12k_mac_get_rate_hw_value(bitrate);
> @@ -3983,10 +3985,13 @@ static void ath12k_mac_bss_info_changed(struct at=
h12k *ar,
>                 band =3D def.chan->band;
>                 mcast_rate =3D info->mcast_rate[band];
>=20
> -               if (mcast_rate > 0)
> +               if (mcast_rate > 0) {
>                         rateidx =3D mcast_rate - 1;
> -               else
> -                       rateidx =3D ffs(info->basic_rates) - 1;
> +               } else {
> +                       rateidx =3D __ffs(info->basic_rates);
> +                       if (rateidx)
> +                               rateidx -=3D 1;

Here should be:

if (info->basic_rates)
    rateidx =3D __ffs(info->basic_rates);
else
    rateidx =3D 0;

> +               }
>=20
>                 if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
>                         rateidx +=3D ATH12K_MAC_FIRST_OFDM_RATE_IDX;
>=20
> base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4
> --
> 2.34.1
>=20


