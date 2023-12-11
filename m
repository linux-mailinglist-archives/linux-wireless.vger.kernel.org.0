Return-Path: <linux-wireless+bounces-640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5C080C4E4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5C3281663
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06021373;
	Mon, 11 Dec 2023 09:40:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559E12C
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 01:40:21 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-ceEQz8YcNQinqR1vFYLgmA-1; Mon, 11 Dec 2023 09:40:18 +0000
X-MC-Unique: ceEQz8YcNQinqR1vFYLgmA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Dec
 2023 09:39:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Dec 2023 09:39:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
CC: kernel test robot <lkp@intel.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
	<quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>, Max Schulze
	<max.schulze@online.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v3] netlink: Return unsigned value for nla_len()
Thread-Topic: [PATCH v3] netlink: Return unsigned value for nla_len()
Thread-Index: AQHaKIcLTIYg1qNNHkOXUp+SE3zDFLCj2bDQ
Date: Mon, 11 Dec 2023 09:39:57 +0000
Message-ID: <72800762d59a4a61ad1999dd5b816e00@AcuMS.aculab.com>
References: <20231206205904.make.018-kees@kernel.org>
In-Reply-To: <20231206205904.make.018-kees@kernel.org>
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

From: Kees Cook
> Sent: 06 December 2023 20:59
>=20
> The return value from nla_len() is never expected to be negative, and can
> never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> on the function. This will let GCC's value range optimization passes
> know that the return can never be negative, and can never be larger than
> u16. As recently discussed[1], this silences the following warning in
> GCC 12+:
>=20
...
> -static inline int nla_len(const struct nlattr *nla)
> +static inline u16 nla_len(const struct nlattr *nla)
>  {
>  =09return nla->nla_len - NLA_HDRLEN;
>  }

It also adds an explicit mask with 0xffff.
I suspect that returning 'unsigned int' will silence the warning
from gcc (since the error message has a huge max size).

If the value is too small copying ~64k or ~4G will both overflow the
buffer.
The former might (just) be exploitable, the latter will crash
(so is probably better!)

=09David
=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


