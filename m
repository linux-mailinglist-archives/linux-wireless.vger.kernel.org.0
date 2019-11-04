Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09F4EDAC7
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfKDIsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 03:48:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfKDIsf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 03:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572857314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcGnEGbP2nkjgsroFu4oivDfxSL+0B07LjsyFwj30H0=;
        b=c/mhHyKtsR+tizIZLi49nY/ld+ycIGZpxo3aIaEC/9KpO1Q5FM2W8M+MuX3iZCk9godWOd
        myhQ0lfZgS87r9cccsIF2WEdG4/B5cEF0WwIBZ8GGd5e1L3bSR67lAvEnEkuNkkwTXsi46
        gjodZuA9Qf8JMCFWucYNC35aVs/gjWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-Wsu3YPidPQq40bkMNbrDWw-1; Mon, 04 Nov 2019 03:48:31 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C393800686;
        Mon,  4 Nov 2019 08:48:29 +0000 (UTC)
Received: from localhost (unknown [10.43.2.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1A115D6C8;
        Mon,  4 Nov 2019 08:48:25 +0000 (UTC)
Date:   Mon, 4 Nov 2019 09:48:23 +0100
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191104084823.GA2306@redhat.com>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org>
 <20191103144749.GA8889@redhat.com>
 <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Wsu3YPidPQq40bkMNbrDWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Nov 03, 2019 at 04:41:11PM +0100, Tom Psyborg wrote:
> On 03/11/2019, Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> > On Sat, Nov 02, 2019 at 06:42:27PM +0100, Daniel Golle wrote:
> >> > This was changed by:
> >> >
> >> > commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
> >> > Author: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
> >> > Date:   Thu Dec 27 15:05:25 2018 +0100
> >> >
> >> >     rt2x00: reduce tx power to nominal level on RT6352
> >> >
> >> > and I think it is correct.
> >>
> >> Ah, ok, that's a bit funny, because it means that this change actually
> >> never made any difference, because the codepath wasn't executed.
> >
> > Yes, this was used/tested on patched rt2x00 driver that switch to this
> > different codepath. Now it will be used by default :-)
> >
> > Stanislaw
> >
> >
>=20
> Hi
>=20
> For your reference: rt2x00: reduce tx power to nominal level on RT6352
>=20
> iPA/eLNA - fixes too high power output
> ePA/eLNA - doesn't have any effect
> iPA/iLNA - not tested

Does someone have iPA/iLNA device so this can be tested?
Or it is not used combination on available devices?=20

Stanislaw

