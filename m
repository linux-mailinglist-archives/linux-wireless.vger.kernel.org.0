Return-Path: <linux-wireless+bounces-24378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083EAE5A13
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2A018869CF
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 02:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD9B1E104E;
	Tue, 24 Jun 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sy2KWOAJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6257F50F;
	Tue, 24 Jun 2025 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750732128; cv=none; b=LXq4mVFkSjNi4BpjOihB8keFAq1TR42pltKsUq8F8r4iKEwhibkOqlhibrdMJWMyM/G4pmqFEPPclIB6iegJN/AFK/oEm9EOnHNQK5MPkCMY9X+J4eVD/onqGcXWuB+G2FS4QmigwyYnxF7Mmk6MX2Di3bc5OigPh+yaC7H4G+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750732128; c=relaxed/simple;
	bh=zqZunaHZ8pQiSS5PmcKL6vSLxeXji8wT6D1iH8su6Nc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZU06gk6DLo4KmScbSetZRaj8PFJ56fFB8T8cg1YRxdWU4HK06UnkU2A3sX+S2y9e6G4FCfKTJGVuG1vQFtZ2BiN0sfBbfrLAYlHnEZCvOlwGT/4AK9Ie5w2BYiFP6QK8SuxUYY77p63D0B5AYV5ag9OV1RGOj6w7jlgEXGcbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sy2KWOAJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55O2SYW302855972, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750732114; bh=uBvqEueoCGRKtiHHzprOXSUige7h75N5qAm/5I+YmXw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sy2KWOAJ/fZmscI54IjS6et/sEq8j89IjLP/b6eju0JVxjFo2nxUN/qPcWMt0i5Et
	 hdPoJw5lxHhdQRLyLVow2MEpCToftHeaNLxsIehuvsatz0MkoaA+KxGJXgiZq7IRwP
	 ckqGb2Ot5QfJJ80P2pMt+CCOsqe9oH0JwpCAOQXL8QIDUNM9rmKqWWC5F0Qei2c6R3
	 HFSu86FL9JJnZ5FO8JxKoLJHMAep0lviCwWqIIDvHFyBfCeAMEYQtqTkwRVHsDpdoh
	 lWd0XPweDixd/OzoYeWHjqm9QcJwYYeeGvCIs3QeRet+4ik+AiMbJjZiK4VW2F7yFv
	 1oXJxnGBTqMjQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55O2SYW302855972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 10:28:34 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Jun 2025 10:28:47 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 24 Jun 2025 10:28:47 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Tue, 24 Jun 2025 10:28:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Pei Xiao <xiaopei01@kylinos.cn>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags
Thread-Topic: [PATCH] wifi: rtw88: coex: Use bitwise instead of arithmetic
 operator for flags
Thread-Index: AQHb5Kzf/JZXLElinkWikwA/8Zj8yrQRlYXA
Date: Tue, 24 Jun 2025 02:28:46 +0000
Message-ID: <910133af3684449cab0dba7a9389df04@realtek.com>
References: <530c4d8c788a875690948f0f5029e3091aaab5d4.1750730099.git.xiaopei01@kylinos.cn>
In-Reply-To: <530c4d8c788a875690948f0f5029e3091aaab5d4.1750730099.git.xiaopei01@kylinos.cn>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pei Xiao <xiaopei01@kylinos.cn> wrote:
> This silences the following coccinelle warning:
>   WARNING: sum of probable bitmasks, consider |
>=20
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/net/wireless/realtek/rtw88/coex.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wire=
less/realtek/rtw88/coex.c
> index 64904278ddad..37788aca200b 100644
> --- a/drivers/net/wireless/realtek/rtw88/coex.c
> +++ b/drivers/net/wireless/realtek/rtw88/coex.c
> @@ -1500,23 +1500,23 @@ static u8 rtw_coex_algorithm(struct rtw_dev *rtwd=
ev)
>         case BPM_HFP:
>                 algorithm =3D COEX_ALGO_HFP;
>                 break;
> -       case           BPM_HID:
> -       case BPM_HFP + BPM_HID:
> +       case BPM_HID:
> +       case BPM_HFP | BPM_HID:
>                 algorithm =3D COEX_ALGO_HID;
>                 break;
> -       case BPM_HFP           + BPM_A2DP:
> -       case           BPM_HID + BPM_A2DP:
> -       case BPM_HFP + BPM_HID + BPM_A2DP:
> +       case BPM_HFP | BPM_A2DP:
> +       case BPM_HID | BPM_A2DP:
> +       case BPM_HFP | BPM_HID | BPM_A2DP:
>                 algorithm =3D COEX_ALGO_A2DP_HID;
>                 break;
> -       case BPM_HFP                      + BPM_PAN:
> -       case           BPM_HID            + BPM_PAN:
> -       case BPM_HFP + BPM_HID            + BPM_PAN:
> +       case BPM_HFP | BPM_PAN:
> +       case BPM_HID | BPM_PAN:
> +       case BPM_HFP | BPM_HID | BPM_PAN:

Please just replace '+' by '|'. Keep spaces. People can be easier to see th=
e
combination of BT profiles.

>                 algorithm =3D COEX_ALGO_PAN_HID;
>                 break;
> -       case BPM_HFP           + BPM_A2DP + BPM_PAN:
> -       case           BPM_HID + BPM_A2DP + BPM_PAN:
> -       case BPM_HFP + BPM_HID + BPM_A2DP + BPM_PAN:
> +       case BPM_HFP | BPM_A2DP | BPM_PAN:
> +       case BPM_HID | BPM_A2DP | BPM_PAN:
> +       case BPM_HFP | BPM_HID | BPM_A2DP | BPM_PAN:
>                 algorithm =3D COEX_ALGO_A2DP_PAN_HID;
>                 break;
>         case                                BPM_PAN:
> --
> 2.25.1


