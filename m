Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEFCF72A5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKLAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 06:00:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28226 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfKKLAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 06:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573470045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vc+FqQYjuwvDH6DKqBFfHO4ftgXOeS6iGxsbJt+uLsU=;
        b=ikK2IRrXqJKpjlMKgqNDMvO1mZnxrcFn5xW+W5vhyF8+SXmw3KWF/U6UOKr5ExS/Jd79cc
        MsFPxh7haGZzBT/ou0J04JmwHk+L7FdGpJZeBcNQBREPcZYFksNVhfGOoTtyD1EBM1Cqnc
        /6PWhgBNpc7ypigmfeG0Pn7h212N+/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-NDXv4P5JNNyB16xMVdYmfg-1; Mon, 11 Nov 2019 06:00:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC4C801E7D;
        Mon, 11 Nov 2019 11:00:42 +0000 (UTC)
Received: from localhost (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 569A9101F6C1;
        Mon, 11 Nov 2019 11:00:40 +0000 (UTC)
Date:   Mon, 11 Nov 2019 12:00:39 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191111110038.GB25919@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org>
 <20191103144749.GA8889@redhat.com>
 <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
 <20191104084823.GA2306@redhat.com>
 <20191104090058.GA1258@makrotopia.org>
 <20191104091525.GB2306@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191104091525.GB2306@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NDXv4P5JNNyB16xMVdYmfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 04, 2019 at 10:15:25AM +0100, Stanislaw Gruszka wrote:
> > > > For your reference: rt2x00: reduce tx power to nominal level on RT6=
352
> > > >=20
> > > > iPA/eLNA - fixes too high power output
> > > > ePA/eLNA - doesn't have any effect
> > > > iPA/iLNA - not tested
> > >=20
> > > Does someone have iPA/iLNA device so this can be tested?
> > > Or it is not used combination on available devices?=20
> >=20
> > iPA/iLNA the most commonly found combination in cheap devices.
> > iPA/eLNA is more rare, but found in some higher-quality devices.
> > ePA/eLNA is available mostly in markets which allow higher TX power.
> > ePA/iLNA haven't seen it yet, but theoretically possible.
> >=20
> > Looking at the internal photos of Nexx WT3020, I'm very certain this
> > is an iPA/iLNA device -- apart from regulators, magnetics, MT7620N
> > itself and flash memory, another magnetics and RAM on the backside,
> > there are no other parts on the board. Also afaik MT7620N only supports
> > iLNA/iPA (due to the limited number of pins of the DRQFN package).
>=20
> With the change on WT3020 I observed better RX throughput and more
> or less the same TX throughput. Not sure why, since the settings
> is about TX? I'll do more test, but so far Tom's change looks like
> good improvment for me.

So, first of all I confused RX and TX testing in iperf. I observed
better TX throughput before (now I'm using netperf, which allow to
initialize performance tests in both directions from station, so=20
I'm no longer confusing).

However better TX throughput come from TX{0,1}_{RF/BB}_GAIN_ATTEN
and TX_ALC_CFG_1 settings, because TX_ALC_VGA is initialized as 0
by hardware, so we have this settings before, when not switched
to the different codepath.

I also checked setting TX_ALC_VGA to 0x06060606 and it vastly degrade
performance for me in both directions on Nexx WT3020 and ASUS RT-AC51U.

Stanislaw

