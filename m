Return-Path: <linux-wireless+bounces-2505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565B483CC09
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 20:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D81F2779F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6377F02;
	Thu, 25 Jan 2024 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="a78bK8AC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB9111AA
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210280; cv=none; b=nR5UOb4V49rc+H89RzuR6ltx+c8u2jnlCbRMCZ6GVXIFWmNCehK7GdK8KFcEA+9DZAHNrRp1SeD2Q8Og9DTNcahS+lmHyUl5uR+45RvdqLNW8G80HoWGvMcsEq4M4P377Fwk6XXSyjHMY3FE+XfPe1rkOat11GBsXN8GcOSdO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210280; c=relaxed/simple;
	bh=0qQU7SCNn84PuZeyF1JFYV5VTEUTu/fcW1rKMS/vV+Y=;
	h=Message-ID:Subject:From:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:To:Cc; b=GTaAaX6NRCTkGqsmKbjPvi/awx/L20duFyG6C/zSTn4DqJ8bcQSLDQQDK2YwH6fB8qO035IJ8jIwt217karl00XsVu4OGiHyOvVv664KJlWKW+Czys6R1tXOKt1tKfaSyydCP3VtAnJntkIDyRMpsQiXAbIgdnxovSuaJHcSJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=a78bK8AC; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:in-reply-to:references:content-type:
	content-transfer-encoding:mime-version:to:cc:cc:content-type:from:subject:to;
	s=sgd; bh=9WfiMZw74T6VMe/uuVNOn/HJ/IhA5yNY6JncsKibAss=;
	b=a78bK8AC3qV/zellcu81C8SUdiU7CUqkp61vVrzxMNCXULyu/P0wnrsdQDj/0wmGiAR5
	+dnJdJ5XmweZPncnDq7A2JLl79w84lfiIDqNHkoqZIrIqETAFAobFw0X0RACGvAND8aYxG
	85wfLv8rgLRnF2Ka14xJoHa/yQ+xrAQeHWdvCL4rePeo+aIj5sfGwSykp6TsrCJthf1mR9
	QBj3mBopuc3Mrk9R5Yz+oGPiyHMCVJx1SGYfgIlxW/S++Ml/ih6xEkzMTnlRQ8XZ+muciM
	HyhCK7vAMtVgqWZU55IHCY6shW4V/iUJaOTSavKkIu95WSaWlsnKdHIBitX+zrGQ==
Received: by filterdrecv-655bd866f5-sjj6q with SMTP id filterdrecv-655bd866f5-sjj6q-1-65B2B3E5-E
        2024-01-25 19:17:57.449558095 +0000 UTC m=+1231261.315529971
Received: from bixby.lan (unknown)
	by geopod-ismtpd-5 (SG) with ESMTP
	id ELQubASlS6Oxe9gyiMOwOA
	Thu, 25 Jan 2024 19:17:57.187 +0000 (UTC)
Message-ID: <df243322ee109149c29a69d7c7a952dcc034ed51.camel@egauge.net>
Subject: Re: [PATCH] wifi: wilc1000: validate chip id during bus probe
From: David Mosberger-Tang <davidm@egauge.net>
Date: Thu, 25 Jan 2024 19:17:57 +0000 (UTC)
In-Reply-To: <6fa6c238-9938-4e14-9b99-95759b659147@bootlin.com>
References: <20240122211315.1444880-2-davidm@egauge.net>
	 <20240122220350.1449413-1-davidm@egauge.net>
	 <751bf8e4-c81c-495b-9166-9f91f9c4b2d5@bootlin.com>
	 <b8e8a3f82fe240506e82322a10be7b4e9f218eca.camel@egauge.net>
	 <0d77d857-35ce-43bc-aaf3-2b46c01a44ec@bootlin.com>
	 <ab077dbe58b1ea5de0a3b2ca21f275a07af967d2.camel@egauge.net>
	 <eb20373c68936f032c322174fbbd3353167d898a.camel@egauge.net>
	 <c5118672-7e67-4601-a570-52c8e212aeda@microchip.com>
	 <6fa6c238-9938-4e14-9b99-95759b659147@bootlin.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvGP2D8Br9KLILkV5m?=
 =?us-ascii?Q?TKcuDdeYQ289hr3B6ILmlRbn3xX60V9de560j=2FN?=
 =?us-ascii?Q?y7QcX8tnG3TJMVrmFU38T=2FZtsyRVexdU5Ni=2FLkh?=
 =?us-ascii?Q?Pf5gB8gmHQ8Vk26Lkb+1xXC2Q5Keesn1XVtW6Hm?=
 =?us-ascii?Q?xPrphVjLdTyNk2R2bPZmGDtfW2SeG1L2RCNoQZa?=
 =?us-ascii?Q?6g=2FABvUssCx+jNhkePK+g=3D=3D?=
To: Alexis =?iso-8859-1?q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Ajay.Kathat@microchip.com
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

On Thu, 2024-01-25 at 12:04 +0100, Alexis Lothor=E9 wrote:
> On 1/25/24 07:23, Ajay.Kathat@microchip.com wrote:
> > On 1/24/24 11:45, David Mosberger-Tang wrote:
> >=20
> > > >=20
> > > > OK, I think I see what's going on: it's the list traversal.  Here i=
s what
> > > > wilc_netdev_cleanup() does:
> > > >=20
> > > >       list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
> > > >               if (vif->ndev)
> > > >                       unregister_netdev(vif->ndev);
> > > >       }
> > > >=20
> > > > The problem is that "vif" is the private part of the netdev, so whe=
n the netdev
> > > > is freed, the vif structure is no longer valid and list_for_each_en=
try_rcu()
> > > > ends up dereferencing a dangling pointer.
>=20
> Your diagnostic sounds relevant :)

Yeah, it's definitely what's going on.  And it's not just the list traversa=
l:
afterwards, wilc_netdev_cleanup() continues to access the vif structure whi=
le
removing them from the vif-list.

I think the original idea of calling unregister_netdev() is probably the ri=
ght
one as, like you said, you want to remove the device from being visible to =
the
user before tearing down anything else.  If I understood the problem correc=
tly,
the use-after-free caused by this line in wilc_netdev_ifc_init():

	ndev->needs_free_netdev =3D true;

This causes unregister_netdev() to implicitly call free_netdev().  Without =
that
code, I think you could call unregister_netdev() early on (as it is right n=
ow)
and when done with using the vifs, call free_netdev() while avoiding any
dangling references.

In any case, this is definitely not my area of expertise.  I don't fully
understand the motivition behind needs_free_netdev, even after reading
https://docs.kernel.org/networking/netdevices.html - I suspect the use of t=
hat
flag has evolved over the years and the docs may not be entirely up-to-date
anymore.  One driver I looked at (wireless/ath/wil6210/netdev.c) sets
needs_free_netdev only for secondary vifs (i.e., all but the first vif).

Hopefully someone else on this list can figure out what the right solution =
is
here.

Thanks,

  --david


