Return-Path: <linux-wireless+bounces-35014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJK5GfXa5WnNogEAu9opvQ
	(envelope-from <linux-wireless+bounces-35014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:51:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10247427E69
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A966B3004F78
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A28382383;
	Mon, 20 Apr 2026 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="I18c0eqs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA1128DC4;
	Mon, 20 Apr 2026 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671470; cv=none; b=pxThMrYqUNIKnquIqcJVVaXeUzKvVnY7xGxDSsAyPbhuFZOOTnCjTPHvCvS/Xw/qXmNEcGad315bV3qPy1BfloBvY6n7ttBpNw/sZvL0asqwxn48NCIJ1L9Sx8Q5gZ8Okzm7yHNixfM6YZ9f5d20sSiZ/94dwaxaSd92l0baW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671470; c=relaxed/simple;
	bh=CbEsitcqb/HUj/EQh8wD8dgv+0oz4+eeSGoADGzxeUw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eie18wemJxvXUf2XFX7JKzEj/uVybNK51ZaxnkaydMYqkIdmPNSPDtpUjWgDP1oyRV6JS/tDffn8cRrBMu46X5oPBj+VRCNDuf9nh/OKCHJr/6E5m0HtHkNKgLf/IcKgFZgnQ4tPMDw5J5G/vkovTK8WseVgcaAlhAmBpmzAVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=I18c0eqs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K7nKesD784553, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776671361; bh=iTrcvdEfWfEz2XhL4B7ye1ces+LHHZwvPoft0o6/g4I=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=I18c0eqsRDPmrDEz5xKizQdO5hhNZpedoAMWN2IfOQtEIyQQJmnZN3EDLYNp6ownA
	 u7IMbQ2dS3H/4ftwOjK/6MyJjYW99mVUWdxYjjUgpAAOBVaauC/NMP5Flvj29PgG92
	 GEy8a+4xWXkPvVDpMEDBDwRnLkrNPBYxoBJ669HVMmN8qFMUekY5B22xMY4Z6iBUEQ
	 yzEpVI+D32y2x/h1Wf9J7Dkv3FRXuOrWswep5SJar17z2fDCiU5DwkALkXva8A+pr1
	 XOOGhRZkcp2Jh678zQZjmlZJzeP1m+AQU6r+sB6/MbirMNPX5jEKnZCNnqj1tBASLc
	 z6Fa/EDZXRnoA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K7nKesD784553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 15:49:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 15:49:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Mon, 20 Apr 2026 15:49:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
        "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Hans de Goede
	<hansg@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Salah Triki <salah.triki@gmail.com>,
        "Achim
 Gratz" <Achim.Gratz@Stromeko.DE>,
        Ben Collins <bcollins@watter.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: [PATCH 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Topic: [PATCH 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Thread-Index: AQHczpDF3glizZDnPk2GjSkm0YYWlrXnljqQ
Date: Mon, 20 Apr 2026 07:49:19 +0000
Message-ID: <5fea4ea146404b55919037594ab85f1a@realtek.com>
References: <20260417173621.368914-1-ynorov@nvidia.com>
 <20260417173621.368914-8-ynorov@nvidia.com>
In-Reply-To: <20260417173621.368914-8-ynorov@nvidia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35014-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,infradead.org,baylibre.com,analog.com,gmail.com,lunn.ch,davemloft.net,google.com,bootlin.com,rasmusvillemoes.dk,Stromeko.DE,watter.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 10247427E69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yury Norov <ynorov@nvidia.com> wrote:
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
> @@ -206,9 +206,9 @@ static void rtw8852bx_efuse_parsing_tssi(struct rtw89=
_dev *rtwdev,
>  static bool _decode_efuse_gain(u8 data, s8 *high, s8 *low)
>  {
>         if (high)
> -               *high =3D sign_extend32(FIELD_GET(GENMASK(7,  4), data), =
3);
> +               *high =3D FIELD_GET_SIGNED(GENMASK(7,  4), data);
>         if (low)
> -               *low =3D sign_extend32(FIELD_GET(GENMASK(3,  0), data), 3=
);
> +               *low =3D FIELD_GET(GENMASK(3,  0), data);

FIELD_GET_SIGNED()?

>=20
>         return data !=3D 0xff;
>  }




