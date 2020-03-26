Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECA194193
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgCZOcc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 10:32:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55616 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgCZOcc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 10:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585233151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIHJNM3XWK3yBrk0Vbx3fuejrIQajbz5L+7zkTyh0TE=;
        b=NzOzTwzirfkEPnJTA38Zx9SOUXPX25DrE1ZA5DX8v/dRgfbh4raPQlNjdA3Rg1Vo5Ah4WV
        pVqm8ZXzRp1nTy4ENT395clONhV+0UaaevnZ+9fMJLylSJHl9cUDqKvydH5I8Ax4dERp+V
        s7ECrPgTYiUch/JZdzZ+Mv/lZH8qbGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-DRa48ZxDPlqIXAKK-9_b_w-1; Thu, 26 Mar 2020 10:32:29 -0400
X-MC-Unique: DRa48ZxDPlqIXAKK-9_b_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607331084441;
        Thu, 26 Mar 2020 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.10.110.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05C5797AE5;
        Thu, 26 Mar 2020 14:32:24 +0000 (UTC)
Message-ID: <a70556a0cacc376826f38258156a0224d2f54b56.camel@redhat.com>
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
From:   Dan Williams <dcbw@redhat.com>
To:     Geoffroy Letourneur <g.letourneur@samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
Cc:     Gilles Mazars <g.mazars@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>
Date:   Thu, 26 Mar 2020 09:32:23 -0500
In-Reply-To: <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
         <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
         <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
         <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
         <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
         <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-26 at 09:27 +0000, Geoffroy Letourneur wrote:
> Hello Johannes,
>=20
> What you mean by regulatory restrictions?
> Hardware restriction ?
> Software restriction ?
> Law restriction ?

There are legal restrictions on spectrum use, especially in the 5Ghz
range. Which means additional effort must be put into both hardware and
software to satisfy those restrictions. And perhaps that effort was not
considered cost effective for the AX200.

Dan

> Best regards Geo
>=20
> --
> Geoffroy LETOURNEUR
> Embedded Software Engineer,
> SSIC, Paris
> =20
> Email: g.letourneur@samsung.com
> Tel: +33 6 45 14 24 32
> =20
> =20
> =20
>=20
> =EF=BB=BFLe 26/03/2020 09:24, =C2=AB Johannes Berg =C2=BB <johannes@sip=
solutions.net> a
> =C3=A9crit :
>=20
>     On Thu, 2020-03-26 at 08:19 +0000, Geoffroy Letourneur wrote:
>     > Hello Matthias,
>     >=20
>     > The AX200 module seems to support AP mode it works with 2.4GHz
> Wifi
>     > 802.11n mode, I tested it. But maybe it could not support this
> mode in
>     > 802.11ax.=20
>    =20
>     2.4 GHz should be OK - 5 GHz is generally limited on those
> devices due
>     to regulatory restrictions.
>    =20
>     johannes
>    =20
>    =20
>=20

