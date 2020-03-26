Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDC19497B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 21:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgCZUrV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 16:47:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20653 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgCZUrU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 16:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585255638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBEHdLAbXLz6FzSdu8JBxHGY7mbTy71DD8uF/npGEWc=;
        b=IIwvZ/GyMSMVl8s5AI4qaL+3nFhlG3a74SqkL3NDTiXqtu9F9glNlPKpAevYwnCGU70N9q
        ilYnjLICz2dDmyXgiVp4yWSmv6SnpIosLS2W4JNtxTb0MdyUOAgvejorkf7cKEYvkyEvZJ
        NUK3fqN7PraRHgqenLWpIer1a8Ca/58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127--zxsdm6nOLmJUfjqhN4ybw-1; Thu, 26 Mar 2020 16:47:12 -0400
X-MC-Unique: -zxsdm6nOLmJUfjqhN4ybw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C5808010E3;
        Thu, 26 Mar 2020 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.10.110.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 463EC92F98;
        Thu, 26 Mar 2020 20:47:05 +0000 (UTC)
Message-ID: <4198a0421b572b9d6d36c3ff1202868df5a5c6d4.camel@redhat.com>
Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on Nvidia
 Nano.
From:   Dan Williams <dcbw@redhat.com>
To:     Duncan McDonald <d.mcdonald@samsung.com>,
        Martin Bourreau <m.bourreau@samsung.com>,
        Geoffroy Letourneur <g.letourneur@samsung.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Matthias May <matthias.may@neratec.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linuxwifi@intel.com" <linuxwifi@intel.com>
Cc:     Gilles Mazars <g.mazars@samsung.com>,
        "Kitty (Xia) Lou" <kitty.lou@samsung.com>,
        Harris Warren <harris.w@samsung.com>,
        Raymond Chan <raymond.chan@samsung.com>,
        "Seshu (Leela Seshu Reddy) Cheedepudi" <seshu.reddy@samsung.com>
Date:   Thu, 26 Mar 2020 15:47:04 -0500
In-Reply-To: <495ebf129e8846e8a6952eee37f650e2@samsung.com>
References: <CGME20200325155438uscas1p19c02d00cfd32dac911df3df7a5390eba@uscas1p1.samsung.com>
         <8096A04E-8692-4DC3-A8D0-8F85FF972799@samsung.com>
         <04b77faf-2862-22a4-c7e1-1163219e76e9@neratec.com>
         <6AA2E7A5-70C5-4A5D-A934-0D0DDCA024FD@samsung.com>
         <1f9123cc49768db30115c364358ea4898bcfff9d.camel@sipsolutions.net>
         <E16BF92C-B26C-4219-B09B-1DEBF96A3911@samsung.com>
         <a70556a0cacc376826f38258156a0224d2f54b56.camel@redhat.com>
         <ECFB8F73-CA97-4100-9B89-029B4701884A@samsung.com>
         <495ebf129e8846e8a6952eee37f650e2@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-03-26 at 17:45 +0000, Duncan McDonald wrote:
> Martin,
>=20
> Interesting. I knew there were issues for 802.11ax in the ISM band
> outside of the ones currently used for wifi, but it seems the issues
> extend to the current 5GHz band as well.

To be clear, I have no idea about this specific device or case. But
802.11h is an example of behavior required for legal/regulatory
reasons.

https://www.prowesswireless.com/post/2016/05/28/dfs-80211h
https://www.cisco.com/c/en/us/support/docs/wireless-mobility/80211/213882=
-radar-detection-in-dynamic-frequency-sel.html

Dan

> Duncan
>=20
> -----Original Message-----
> From: Martin Bourreau=20
> Sent: Thursday, March 26, 2020 10:39 AM
> To: Dan Williams <dcbw@redhat.com>; Geoffroy Letourneur <
> g.letourneur@samsung.com>; Johannes Berg <johannes@sipsolutions.net>;
> Matthias May <matthias.may@neratec.com>;=20
> linux-wireless@vger.kernel.org; linuxwifi@intel.com
> Cc: Gilles Mazars <g.mazars@samsung.com>; Kitty (Xia) Lou <
> kitty.lou@samsung.com>; Harris Warren <harris.w@samsung.com>; Raymond
> Chan <raymond.chan@samsung.com>; Duncan McDonald <
> d.mcdonald@samsung.com>; Seshu (Leela Seshu Reddy) Cheedepudi <
> seshu.reddy@samsung.com>
> Subject: Re: Geoffroy LETOURNEUR: Samsung AX200 system integration on
> Nvidia Nano.
>=20
> Adding people for awareness of the conversation.=20
>=20
> =EF=BB=BFLe 26/03/2020 15:32, =C2=AB Dan Williams =C2=BB <dcbw@redhat.c=
om> a =C3=A9crit :
>=20
>     On Thu, 2020-03-26 at 09:27 +0000, Geoffroy Letourneur wrote:
>     > Hello Johannes,
>     >=20
>     > What you mean by regulatory restrictions?
>     > Hardware restriction ?
>     > Software restriction ?
>     > Law restriction ?
>    =20
>     There are legal restrictions on spectrum use, especially in the
> 5Ghz
>     range. Which means additional effort must be put into both
> hardware and
>     software to satisfy those restrictions. And perhaps that effort
> was not
>     considered cost effective for the AX200.
>    =20
>     Dan
>    =20
>     > Best regards Geo
>     >=20
>     > --
>     > Geoffroy LETOURNEUR
>     > Embedded Software Engineer,
>     > SSIC, Paris
>     > =20
>     > Email: g.letourneur@samsung.com
>     > Tel: +33 6 45 14 24 32
>     > =20
>     > =20
>     > =20
>     >=20
>     > Le 26/03/2020 09:24, =C2=AB Johannes Berg =C2=BB <
> johannes@sipsolutions.net> a
>     > =C3=A9crit :
>     >=20
>     >     On Thu, 2020-03-26 at 08:19 +0000, Geoffroy Letourneur
> wrote:
>     >     > Hello Matthias,
>     >     >=20
>     >     > The AX200 module seems to support AP mode it works with
> 2.4GHz
>     > Wifi
>     >     > 802.11n mode, I tested it. But maybe it could not support
> this
>     > mode in
>     >     > 802.11ax.=20
>     >    =20
>     >     2.4 GHz should be OK - 5 GHz is generally limited on those
>     > devices due
>     >     to regulatory restrictions.
>     >    =20
>     >     johannes
>     >    =20
>     >    =20
>     >=20
>    =20
>    =20
>=20

