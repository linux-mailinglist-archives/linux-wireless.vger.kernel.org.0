Return-Path: <linux-wireless+bounces-12215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A4964C25
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 18:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62D3B22BAD
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 16:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237E1B14F6;
	Thu, 29 Aug 2024 16:54:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB41AC8A9
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950444; cv=none; b=BfkuMhfc2J81SNXb5q79LSICI0pbnOZcETbbsS9h4MdbW6kjLeqlArwRYxiu/4pgBeMgU78MvCp2pBDv59vd+IQ/rUr9Cjc+eH8N1Q3sQJsEDoWqgrfQ96bm/IzZdGbWyLchU9wvdpeAxhSKpbgxVzAgRsP0jdKLjPmY4oXP478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950444; c=relaxed/simple;
	bh=UoLoOB2Y8L0wIdsTjatE6Mokw5WON2Nes+vsOhNrNI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cGC17jl8sJV5bMaen+ZZr18CtMA3Uaj+o4e5ngydsE4+qCEG9N5FRKy/s7cjcnqFV7ruGKW5fBjk2TuH1M6o1k10oI/+4lZHgTRJOd+wjOMxePhdHxajcv/zO1ipLGwd/bc+vEnajrsSno1rljmLcxyo0Icu9IpLgvvF8tEm1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-61-FBG4t32LNkyHw8q_JE8r3A-1; Thu, 29 Aug 2024 17:47:25 +0100
X-MC-Unique: FBG4t32LNkyHw8q_JE8r3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Aug
 2024 17:46:40 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Aug 2024 17:46:40 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>, Hongbo Li <lihongbo22@huawei.com>
CC: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "allison.henderson@oracle.com"
	<allison.henderson@oracle.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"pshelar@ovn.org" <pshelar@ovn.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>, "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
	"dev@openvswitch.org" <dev@openvswitch.org>, "linux-afs@lists.infradead.org"
	<linux-afs@lists.infradead.org>
Subject: RE: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
Thread-Topic: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
Thread-Index: AQHa+SLFq2P4KoingEmrGUtsMJSbQLI+cc1Q
Date: Thu, 29 Aug 2024 16:46:40 +0000
Message-ID: <bc839f1e4e3241bf8c0f3eb81f6c5b3f@AcuMS.aculab.com>
References: <1b1ee6e6-ff2e-45d6-bfe2-1f8efaba7b38@huawei.com>
 <20240824074033.2134514-8-lihongbo22@huawei.com>
 <20240824074033.2134514-1-lihongbo22@huawei.com>
 <563923.1724501215@warthog.procyon.org.uk>
 <948381.1724833077@warthog.procyon.org.uk>
In-Reply-To: <948381.1724833077@warthog.procyon.org.uk>
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

From: David Howells <dhowells@redhat.com>
> Sent: 28 August 2024 09:18
>=20
> Hongbo Li <lihongbo22@huawei.com> wrote:
>=20
> > I see reason is u8, so may I use min_t(u8, sp->ack.reason,
> > RXRPC_ACK__INVALID)?
>=20
> No, please don't use min_t(<unsigned type>, ...) if umin() will do.  IIRC=
,
> some arches can't do byte-level arithmetic.

Not to mention all the places where the wrong type has been used and
significant bits masked off before the comparison.

Is there even a problem with min() here?
It should be fine unless sp->ack.reason is a signed type.
In which case things are probably horribly wrong if it is negative.

Looking at the code I'm not even sure that min() is right.
It really ought to be used for counters/sizes.
This is a bit like the (broken) suggestion of replacing:
=09return rval < 0 ? rval : 0;
with
=09return min(rval, 0);

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


