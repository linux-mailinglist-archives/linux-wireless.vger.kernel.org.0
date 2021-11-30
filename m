Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D3463C48
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244506AbhK3QyW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 11:54:22 -0500
Received: from gimli.kloenk.dev ([195.39.247.182]:59162 "EHLO gimli.kloenk.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243901AbhK3QyV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 11:54:21 -0500
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1638291058; bh=08f4kR1LCst9gOdUEWW0071y4AY9Nc4Nrjd9edVBnSM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=CqnLIeeBbFdzqQsOKWNWcc7UZG3MhtzLYoGz1mfTM+u+BIRksN/Ip2GDiEtUg2oWP
         nqKmIG9vx2GGqRujWcdt9eEpSF8xYMKhh8IoBW1tw7p8RwIrFa0dqYJTqiXra6uM5k
         UQwizN76U89XwTPIIupIfL60IJRaJlgxCHQ0iZM4=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v5] nl80211: reset regdom when reloading regdb
From:   Finn Behrens <me@kloenk.dev>
In-Reply-To: <YaZLEEj2pUU/DhZD@archlinux-ax161>
Date:   Tue, 30 Nov 2021 17:50:58 +0100
Cc:     Finn Lasse Behrens <me@kloenk.dev>, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6BAD2771-7C01-408E-98BE-76A1CAF3A810@kloenk.dev>
References: <20210526112418.cdwkn7ed4twctimc@imap.mailbox.org>
 <YaIIZfxHgqc/UTA7@gimli.kloenk.dev> <YaZLEEj2pUU/DhZD@archlinux-ax161>
To:     Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 30. Nov 2021, at 17:02, Nathan Chancellor <nathan@kernel.org> =
wrote:
>=20
> Hi Finn,
>=20
> On Sat, Nov 27, 2021 at 11:28:53AM +0100, Finn Behrens wrote:
>> this reloads the regdom when the regulatory db is reloaded.
>> Without this patch the user had to change the regulatoy domain to a
>> different, and then reset it to the one the user is in, to have the =
new
>> regulatory db take effect
>>=20
>> Signed-off-by: Finn Behrens <fin@nyantec.com>
>=20
> This patch as commit 1eda919126b4 ("nl80211: reset regdom when =
reloading
> regdb") in -next causes the following clang warning/error:
>=20
> net/wireless/reg.c:1137:23: error: implicit conversion from =
enumeration type 'enum nl80211_user_reg_hint_type' to different =
enumeration type 'enum nl80211_reg_initiator' =
[-Werror,-Wenum-conversion]
>        request->initiator =3D NL80211_USER_REG_HINT_USER;
>                           ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>=20
> Should that be NL80211_REGDOM_SET_BY_CORE (same value, 0) or something
> different?
>=20
> Cheers,
> Nathan

Hi Nathan,

I think It should have been NL80211_REGDOM_SET_BY_USER, as the reload =
flag check is currently implemented in the user hint function. But If I =
see it correctly right now. We could remove the reload flag,
and NL80211_REGDOM_SET_BY_CORE should work as well. As the =
reg_query_database function is called unconditionally there.

I will prepare a patch that reverts the reload flag, and changes to =
NL80211_REGDOM_SET_BY_CORE as this already works. Or should it be =
NL80211_REGDOM_SET_BY_USER, as it=E2=80=99s results from an user
called function?

Cheers,
Finn=
