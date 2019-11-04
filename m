Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5DAEDB5E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfKDJPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 04:15:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41228 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDJPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 04:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572858935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9DB5gp+ro/GtJFv0UTXR5fBfRs7JWr9kfJxMjyEATaw=;
        b=K6Ihqe4TM1ug4FYyRVmgjEZmP1jJfE9iZ0xY5r5qLRL07rGOTEKC/wEsY97E2ZGMdHrEYz
        7Cnm82q8UY0S8/fJw3LAipatI3k1/6qTBlFY3BzOmJYdlC+7nXT7MOj/FW0or048GvYTMH
        ifUMNyLd7crnvgQHORKARgtulCPwLH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Yiiu9OZ3NCOtE7E8ABokzQ-1; Mon, 04 Nov 2019 04:15:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7F4A8017DD;
        Mon,  4 Nov 2019 09:15:29 +0000 (UTC)
Received: from localhost (unknown [10.43.2.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68BF25C28D;
        Mon,  4 Nov 2019 09:15:28 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:15:26 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191104091525.GB2306@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org>
 <20191103144749.GA8889@redhat.com>
 <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
 <20191104084823.GA2306@redhat.com>
 <20191104090058.GA1258@makrotopia.org>
MIME-Version: 1.0
In-Reply-To: <20191104090058.GA1258@makrotopia.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Yiiu9OZ3NCOtE7E8ABokzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 04, 2019 at 10:00:58AM +0100, Daniel Golle wrote:
> On Mon, Nov 04, 2019 at 09:48:23AM +0100, Stanislaw Gruszka wrote:
> > On Sun, Nov 03, 2019 at 04:41:11PM +0100, Tom Psyborg wrote:
> > > On 03/11/2019, Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> > > > On Sat, Nov 02, 2019 at 06:42:27PM +0100, Daniel Golle wrote:
> > > >> > This was changed by:
> > > >> >
> > > >> > commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
> > > >> > Author: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
> > > >> > Date:   Thu Dec 27 15:05:25 2018 +0100
> > > >> >
> > > >> >     rt2x00: reduce tx power to nominal level on RT6352
> > > >> >
> > > >> > and I think it is correct.
> > > >>
> > > >> Ah, ok, that's a bit funny, because it means that this change actu=
ally
> > > >> never made any difference, because the codepath wasn't executed.
> > > >
> > > > Yes, this was used/tested on patched rt2x00 driver that switch to t=
his
> > > > different codepath. Now it will be used by default :-)
> > > >
> > > > Stanislaw
> > > >
> > > >
> > >=20
> > > Hi
> > >=20
> > > For your reference: rt2x00: reduce tx power to nominal level on RT635=
2
> > >=20
> > > iPA/eLNA - fixes too high power output
> > > ePA/eLNA - doesn't have any effect
> > > iPA/iLNA - not tested
> >=20
> > Does someone have iPA/iLNA device so this can be tested?
> > Or it is not used combination on available devices?=20
>=20
> iPA/iLNA the most commonly found combination in cheap devices.
> iPA/eLNA is more rare, but found in some higher-quality devices.
> ePA/eLNA is available mostly in markets which allow higher TX power.
> ePA/iLNA haven't seen it yet, but theoretically possible.
>=20
> Looking at the internal photos of Nexx WT3020, I'm very certain this
> is an iPA/iLNA device -- apart from regulators, magnetics, MT7620N
> itself and flash memory, another magnetics and RAM on the backside,
> there are no other parts on the board. Also afaik MT7620N only supports
> iLNA/iPA (due to the limited number of pins of the DRQFN package).

With the change on WT3020 I observed better RX throughput and more
or less the same TX throughput. Not sure why, since the settings
is about TX? I'll do more test, but so far Tom's change looks like
good improvment for me.

> See:
> https://apps.fcc.gov/eas/GetApplicationAttachment.html?id=3D2241504

I get 'You are not authorized to access this page.' :-/

Stanislaw

