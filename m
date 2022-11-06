Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1B61E285
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 15:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiKFOLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 09:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFOLJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 09:11:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5CB1DA
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 06:11:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CDD760C7E
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 14:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F30C433C1;
        Sun,  6 Nov 2022 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667743868;
        bh=HRzlzaAp1hkkbufMr1HRqyiXo4Ule5hEWmQsQVXN1R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8Ie2mLFGUsMXfXZqCZrXfvVlb9ceqiMB6Cgmtgvc5bNAUuV2ZUpecdZr5QjHCxAO
         OSduLAip6y4vpA8IUnNvaMNpvf+xTK0PBLxlhUSqQkh3FM8ljQF9pACXlRhaSEc59i
         YHlNYPyXPn8Ac1VOjk8+9VeFcVa3kMtWH3dUB3hBwSHMZ+ifK5AKYqCKYMX+91lm6A
         jPxSX0iNP6A1l5u+7dt6zBUU5wVrv7L9NBUtLQFpIjHU0FVydsHX/USqQyqEMuWVcs
         m9GFaESrY1F0OVorBLyfvPdNDQmNxCre78/SE6lOYc78B3Q88MGStWEW11/+zUrrpM
         v9TkJV8Ro4y3w==
Date:   Sun, 6 Nov 2022 15:11:04 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, bjlockie@lockie.ca,
        johannes@sipsolutions.net, nbd@nbd.name
Subject: Re: [PATCH wireless] wifi: mac8021: fix possible oob access in
 ieee80211_get_rate_duration
Message-ID: <Y2fAeJHViQqgoFXP@lore-desk>
References: <08b259df20d9e61c5b852bf8b96db7272dbb1767.1667730476.git.lorenzo@kernel.org>
 <87mt94w94y.fsf@toke.dk>
 <Y2e3hBYhdUtrMKtm@lore-desk>
 <8735aww654.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LWab2AKhTdQ8z6aJ"
Content-Disposition: inline
In-Reply-To: <8735aww654.fsf@toke.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--LWab2AKhTdQ8z6aJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >>=20
> >> > Fix possible out-of-bound access in ieee80211_get_rate_duration rout=
ine
> >> > as reported by the following UBSAN report:
> >> >
> >> > UBSAN: array-index-out-of-bounds in net/mac80211/airtime.c:455:47
> >> > index 15 is out of range for type 'u16 [12]'
> >> > CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 6.1.0-060100rc3-gen=
eric
> >> > Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS R01-A2 07/18/2=
017
> >> > Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
> >> > Call Trace:
> >> >  <TASK>
> >> >  show_stack+0x4e/0x61
> >> >  dump_stack_lvl+0x4a/0x6f
> >> >  dump_stack+0x10/0x18
> >> >  ubsan_epilogue+0x9/0x43
> >> >  __ubsan_handle_out_of_bounds.cold+0x42/0x47
> >> > ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 [mac80211]
> >> >  ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
> >> >  ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
> >> >  ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
> >> >  mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
> >> >  mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
> >> >  mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
> >> >  process_one_work+0x225/0x400
> >> >  worker_thread+0x50/0x3e0
> >> >  ? process_one_work+0x400/0x400
> >> >  kthread+0xe9/0x110
> >> >  ? kthread_complete_and_exit+0x20/0x20
> >> >  ret_from_fork+0x22/0x30
> >> >
> >> > Reported-by: bjlockie@lockie.ca
> >> > Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from=
 mt76")
> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> > ---
> >> >  net/mac80211/airtime.c | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> >> > index 2e66598fac79..4ed05988131d 100644
> >> > --- a/net/mac80211/airtime.c
> >> > +++ b/net/mac80211/airtime.c
> >> > @@ -452,6 +452,9 @@ static u32 ieee80211_get_rate_duration(struct ie=
ee80211_hw *hw,
> >> >  			 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
> >> >  		return 0;
> >> > =20
> >> > +	if (WARN_ON_ONCE(idx >=3D MCS_GROUP_RATES))
> >> > +		return 0;
> >> > +
> >>=20
> >> So presumably this is something that can actually happen in real usage,
> >> so should we really warn? Or was the driver also fixed to not trigger
> >> this?
> >
> > looking at the mt76x02 support, MT_RATE_INDEX_VHT_IDX is GENMASK(3, 0) =
so the
> > hw can report rate_idx up to 15. Do you prefer to drop WARN_ON_ONCE()? =
I would
> > prefer to keep it since it informs us something nasty occurred (and at =
the end
> > it just runs ones), but I can live even w/o it :)
>=20
> Well, what I mean is that the purpose of WARN_ON is, as you say, to
> catch if "something nasty occurred", so we can fix it. But if we already
> know that something nasty does, indeed, occur, shouldn't we just fix the
> cause instead of putting in a warn so that we'll get a spat the next
> time it happens? :)

I think in this case the hw just reports a wrong value, so we can limit the
value there too, anyway I would not assume each driver limits the rate_idx
value (as we already do for stream :))

Regards,
Lorenzo

>=20
> -Toke

--LWab2AKhTdQ8z6aJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2fAeAAKCRA6cBh0uS2t
rEgwAP4z9Amk+1pJKm5rsktL34c5xTdTU6ycc0Badt2m+lAZJgEAozsRqNsvdJAk
vv89GcHlVIlBqD86FWkGxvfZfSjBUQY=
=5SkB
-----END PGP SIGNATURE-----

--LWab2AKhTdQ8z6aJ--
