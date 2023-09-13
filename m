Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDAF79DE14
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbjIMCDF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjIMCDE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 22:03:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A21706
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 19:03:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A3C433C7;
        Wed, 13 Sep 2023 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694570580;
        bh=a0r8FafZCRykI67NjApO3w2QCbRNSVhDa1MttsUYh5g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=koMeJ5h62VBOqKarkBjz3LHaBuH5CDDfVwRU8glJWdkDKm7Zs6v4DrHN0ovSlbuRW
         OqmzxBiljNEtHmqWgO5EjHHrhcPB2iYEitvuy1YzB2iibyb1t9uY8np8o6NGqFY/bD
         cTyDiOIf+K+gN7ao+PIU8swxWUWnBC+50PJfLwr3+EARplIdJ6qaPSk5cpWSexPMDo
         aHSpNREvJGQu28vMMz63pHJqJi63UV3ypTKqgEEZnFL087XCRm1o8MtHGzAs98aqiw
         TiodsViIavHroLX+hrTgSJmmecaDeSvhEMiXfWS9oR8Z9qFzFVd762tkzvMNI5X982
         415Wf1rnvsz8w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next] wifi: ti/wlcore: Convert to platform remove
 callback returning void
References: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de>
        <87sf7jcnll.fsf@kernel.org>
        <20230912200117.5ygpaucixihppg65@pengutronix.de>
Date:   Wed, 13 Sep 2023 05:02:57 +0300
In-Reply-To: <20230912200117.5ygpaucixihppg65@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 12 Sep 2023 22:01:17
 +0200")
Message-ID: <87o7i6de3y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Hello,
>
> On Tue, Sep 12, 2023 at 08:23:18PM +0300, Kalle Valo wrote:
>> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>>=20
>> > The .remove() callback for a platform driver returns an int which makes
>> > many driver authors wrongly assume it's possible to do error handling =
by
>> > returning an error code.  However the value returned is (mostly) ignor=
ed
>> > and this typically results in resource leaks. To improve here there is=
 a
>> > quest to make the remove callback return void. In the first step of th=
is
>> > quest all drivers are converted to .remove_new() which already returns
>> > void.
>> >
>> > wlcore_remove() returned zero unconditionally. With that converted to
>> > return void instead, the wl12xx and wl18xx driver can be converted to
>> > .remove_new trivially.
>> >
>> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> > ---
>> >  drivers/net/wireless/ti/wl12xx/main.c   | 6 +++---
>> >  drivers/net/wireless/ti/wl18xx/main.c   | 2 +-
>> >  drivers/net/wireless/ti/wlcore/main.c   | 6 ++----
>> >  drivers/net/wireless/ti/wlcore/wlcore.h | 2 +-
>> >  4 files changed, 7 insertions(+), 9 deletions(-)
>>=20
>> wireless patches go to wireless-next, not net-next. But no need to
>> resend because of this.
>
> So for the next patch to drivers/net/wireless: I should write "[PATCH
> wireless-next]" in the Subject?

That's not a requirement from our side but feel free to add that if you
want. Usually we do so that if the patch has "[PATCH wireless]" or
"[PATCH v6.6]" we queue the patch to wireless tree, otherwise it's
queued for wireless-next.

> Do the other special rules for net-next apply to wireless-next, too?
> (E.g. that I must not send patches for -next during the merge window
> and the rules about comments.)

Yeah, we do work a bit different compared to net-next. For example,
wireless-next remains open during merge windows so you can submit
patches anytime. We have tried to document our practises in the wiki
link below in my signature.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
