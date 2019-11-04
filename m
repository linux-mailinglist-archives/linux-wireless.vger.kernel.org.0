Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A312EDAF3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 10:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfKDJB1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 04:01:27 -0500
Received: from fudo.makrotopia.org ([185.142.180.71]:58824 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDJB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 04:01:27 -0500
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.92.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1iRYEh-0003JS-J2; Mon, 04 Nov 2019 10:01:21 +0100
Date:   Mon, 4 Nov 2019 10:00:58 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        linux-wireless@vger.kernel.org, Roman Yeryomin <roman@advem.lv>,
        wbob <wbob@jify.de>
Subject: Re: [PATCH] rt2800: remove erroneous duplicate condition
Message-ID: <20191104090058.GA1258@makrotopia.org>
References: <20191028212244.GA2590@makrotopia.org>
 <20191029091857.GB3571@redhat.com>
 <20191029100503.GA1228@makrotopia.org>
 <20191102154639.GA4589@redhat.com>
 <20191102174227.GA1250@makrotopia.org>
 <20191103144749.GA8889@redhat.com>
 <CAKR_QV+LkUU2+G7z8um7RpSbi0ANfRGe_TeoGky+U9ff=8sOZA@mail.gmail.com>
 <20191104084823.GA2306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104084823.GA2306@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 04, 2019 at 09:48:23AM +0100, Stanislaw Gruszka wrote:
> On Sun, Nov 03, 2019 at 04:41:11PM +0100, Tom Psyborg wrote:
> > On 03/11/2019, Stanislaw Gruszka <sgruszka@redhat.com> wrote:
> > > On Sat, Nov 02, 2019 at 06:42:27PM +0100, Daniel Golle wrote:
> > >> > This was changed by:
> > >> >
> > >> > commit c2e28ef7711ffcb083474ee5f154264c6ec1ec07
> > >> > Author: Tomislav Požega <pozega.tomislav@gmail.com>
> > >> > Date:   Thu Dec 27 15:05:25 2018 +0100
> > >> >
> > >> >     rt2x00: reduce tx power to nominal level on RT6352
> > >> >
> > >> > and I think it is correct.
> > >>
> > >> Ah, ok, that's a bit funny, because it means that this change actually
> > >> never made any difference, because the codepath wasn't executed.
> > >
> > > Yes, this was used/tested on patched rt2x00 driver that switch to this
> > > different codepath. Now it will be used by default :-)
> > >
> > > Stanislaw
> > >
> > >
> > 
> > Hi
> > 
> > For your reference: rt2x00: reduce tx power to nominal level on RT6352
> > 
> > iPA/eLNA - fixes too high power output
> > ePA/eLNA - doesn't have any effect
> > iPA/iLNA - not tested
> 
> Does someone have iPA/iLNA device so this can be tested?
> Or it is not used combination on available devices? 

iPA/iLNA the most commonly found combination in cheap devices.
iPA/eLNA is more rare, but found in some higher-quality devices.
ePA/eLNA is available mostly in markets which allow higher TX power.
ePA/iLNA haven't seen it yet, but theoretically possible.

Looking at the internal photos of Nexx WT3020, I'm very certain this
is an iPA/iLNA device -- apart from regulators, magnetics, MT7620N
itself and flash memory, another magnetics and RAM on the backside,
there are no other parts on the board. Also afaik MT7620N only supports
iLNA/iPA (due to the limited number of pins of the DRQFN package).

See:
https://apps.fcc.gov/eas/GetApplicationAttachment.html?id=2241504


Cheers


Daniel


> 
> Stanislaw
> 
