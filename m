Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42B02ED061
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 14:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbhAGNJo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jan 2021 08:09:44 -0500
Received: from mail.toke.dk ([45.145.95.4]:49465 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbhAGNJo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jan 2021 08:09:44 -0500
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1610024910; bh=8yBcqqCmZGf1LeuXCDPXBC4WzK4eLeRC8bvHGxgx/V4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eLt3/bBWv0ZVvbQDuiVkKm5piHVZJ3mAHQ5EB+HNdlUi4QC04I7rVyQhy+4Uz7vHH
         bHhlyHna6jxyUrBgwJtzVKSua3O2G8i9riMF0zXMgB3ouM+a90T9CXwnF/Vcv7q9tp
         qHtuO1+tPOUDeIgz4/20Fif1skolHkEMWfSeakABWjoH6j9FEQZoRTPFi4XlubTWOU
         RsWdyi8P4kmpu3N5s9QyzUthgZ+zApuNwibZJzhSAyuKDBrgeyAUXXQfOSV8+Ltn7+
         AfDwbfPWqd3CrJQ3kFFvufLfCTIrV3MNrh+ZPXU/ZaC3lHBo7452TnSIZkhme5tIZ9
         4uIqBHMlqHFJQ==
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mac80211: check ATF flag in ieee80211_next_txq()
In-Reply-To: <1609985461.9743.2.camel@mtkswgap22>
References: <d9aef825d186a91ff91f6a81045d49d375533b14.1609894402.git.ryder.lee@mediatek.com>
 <87r1my49us.fsf@toke.dk> <68ab89bc-70f4-e822-3d96-21ba3bd6511f@nbd.name>
 <87k0sq3wfl.fsf@toke.dk> <1609985461.9743.2.camel@mtkswgap22>
Date:   Thu, 07 Jan 2021 14:08:29 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87a6tkki7m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> On Wed, 2021-01-06 at 16:41 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>> > On 2021-01-06 11:51, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> Ryder Lee <ryder.lee@mediatek.com> writes:
>> >>=20
>> >>> The selected txq should be scheduled unconditionally if
>> >>> NL80211_EXT_FEATURE_AIRTIME_FAIRNESS is not set by driver.
>> >>>
>> >>> Also put the sta to the end of the active_txqs list if
>> >>> deficit is negative then move on to the next txq.
>> >>=20
>> >> Why is this needed? If the feature is not set, no airtime should ever=
 be
>> >> accounted to the station, and so sta->airtime[txqi->txq.ac].deficit w=
ill
>> >> always be 0 - so you're just adding another check that doesn't actual=
ly
>> >> change the behaviour, aren't you?
>> >
>> > I think it might make sense to keep airtime reporting even when airtime
>> > fairness is disabled at run time, so this patch makes sense to me.
>> > Instead of this patch, the right place to deal with this would probably
>> > be ieee80211_sta_register_airtime.
>>=20
>> When the fairness mechanism is user-disabled I agree it makes sense to
>> still keep the accounting; and in fact that's what
>> ieee80211_sta_register_airtime() already does when the accounting is
>> turned off by way of the airtime_flags field... So don't think anything
>> else is needed there either?
>>=20
>> -Toke
>
> Not sure I get this right. Are you talking about local->airtime_flags =3D
> AIRTIME_USE_TX | AIRTIME_USE_RX ? I think that's different and we still
> need to take NL80211_EXT_FEATURE_AIRTIME_FAIRNESS into account, right?

I just meant that what Felix was asking for (a way *for the user* to
disable airtime fairness while still getting the airtime usage
accounted) is possible by setting those flags. The EXT_FEATURE flag is
meant as a way for the driver to signal to mac80211 that it supports
reporting airtime at all; so ideally it should be a flag that is only
set once.

Going back and reading your initial response it seems like you may be
toggling the flag dynamically in the driver, though? Is this accurate?
And if so, why? Is it not enough for you to fiddle with the
USE_TX/USE_RX flags? :)

-Toke
