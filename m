Return-Path: <linux-wireless+bounces-14320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2A9AA1F1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD762815E5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3D519D083;
	Tue, 22 Oct 2024 12:14:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C219CC21
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599244; cv=none; b=Zr6kcp+NXNABwfrhfev6IbbLbIcfBW2jbqdoUDyfb+M9ROH5xifOEQS+9ceRuk4n/ehTMo3c4Sftt0qOTcGXe3dKHNdn2sswE30femSW6cer7y7wXQ85aWOEWrxowM/Ant2AW1rpD+2pWK7bbsk4KhejA5+xkw/5yK/bWNTk/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599244; c=relaxed/simple;
	bh=5bju6qBlTxqLZyfbC4o7FNcj1lGw86tFWloZEU58fN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=VA0W11W4iqguFdAOQkIqy1Jn+LN/0HpsYYRSONjvljC05wR/XnB52J5hFD2WsbEHK6HIWjiHi2RKLvNhx4Nkpvpg/Yu2xNG/XQt71yGKWCFZYd1nAhUcRzFsczXUxXuh8udLCQxSNbEnaJ1uJ6J3AGxe4b2gxXxpe+ZKg2XPjhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-165-CJp6vUT7NZWM2ETRfMy7Bw-1; Tue, 22 Oct 2024 13:13:58 +0100
X-MC-Unique: CJp6vUT7NZWM2ETRfMy7Bw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 22 Oct
 2024 13:13:56 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 22 Oct 2024 13:13:56 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'Gustavo A. R. Silva'" <gustavoars@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Johannes Berg <johannes@sipsolutions.net>, "David
 Ahern" <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: RE: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
Thread-Topic: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
Thread-Index: AQHbH2IwMvcQvMRBxU2MfSVMnAk5o7KStdew
Date: Tue, 22 Oct 2024 12:13:56 +0000
Message-ID: <9e6a2efa17b94522ad2274332f608c38@AcuMS.aculab.com>
References: <cover.1729037131.git.gustavoars@kernel.org>
 <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
In-Reply-To: <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Gustavo A. R. Silva
> Sent: 16 October 2024 01:27
>=20
> We are currently working on enabling the -Wflex-array-member-not-at-end
> compiler option. This option has helped us detect several objects of
> the type `struct sockaddr` that appear in the middle of composite
> structures like `struct rtentry`, `struct compat_rtentry`, and others:
>=20
...
>=20
> In order to fix the warnings above, we introduce `struct sockaddr_legacy`=
.
> The intention is to use it to replace the type of several struct members
> in the middle of composite structures, currently of type `struct sockaddr=
`.
>=20
> These middle struct members are currently causing thousands of warnings
> because `struct sockaddr` contains a flexible-array member, introduced
> by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
> struct sockaddr").
>=20
> The new `struct sockaddr_legacy` doesn't include a flexible-array
> member, making it suitable for use as the type of middle members
> in composite structs that don't really require the flexible-array
> member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
> warnings.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/socket.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index d18cc47e89bd..f370ae0e6c82 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -40,6 +40,25 @@ struct sockaddr {
>  =09};
>  };
>=20
> +/*
> + * This is the legacy form of `struct sockaddr`. The original `struct so=
ckaddr`
> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to f=
lexible
> + * array in struct sockaddR") due to the fact that "One of the worst off=
enders
> + * of "fake flexible arrays" is struct sockaddr". This means that the or=
iginal
> + * `char sa_data[14]` behaved as a flexible array at runtime, so a prope=
r
> + * flexible-array member was introduced.
> + *
> + * This caused several flexible-array-in-the-middle issues:
> + * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-a=
rray-member-not-at-end

I'd bet that the code even indexed the array?
So it is all worse that just a compiler warning/

> + *
> + * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances =
where
> + * objects of this type do not appear at the end of composite structures=
.
> + */
> +struct sockaddr_legacy {
> +=09sa_family_t=09sa_family;=09/* address family, AF_xxx=09*/
> +=09char =09=09sa_data[14];=09/* 14 bytes of protocol address=09*/
> +};
> +

I'm not sure that is a very good name.
Reading it you don't know when it is 'legacy' from.
It's size is clearly that of the original IPv4 sockaddr.
(I'm not sure there was ever an earlier one.)

Perhaps 'strict sockaddr_16' would be better?
Or, looking at the actual failures, sockaddr_ipv4?

Alternatively revert b5f0de6df6dce and add a new type that has the char[]
field??

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


