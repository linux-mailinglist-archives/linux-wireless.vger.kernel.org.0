Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BE061E25C
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Nov 2022 14:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKFNdL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Nov 2022 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFNdK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Nov 2022 08:33:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E9BDF29
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 05:32:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69E860C52
        for <linux-wireless@vger.kernel.org>; Sun,  6 Nov 2022 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51F6C433C1;
        Sun,  6 Nov 2022 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667741576;
        bh=NdomuvtmFrX/e0TgpHVyjjWJ0cy2eLP+AsJjEZj/Yyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkhwENq2Qqo20KAt29JWR+0rTg6yenxLs//NzB3StUm7tJiEhIeBHqdRiBUijIIbK
         NsVkazIdvQ40uXDgIisszShNTMmQx6jm205cLm02SeELvDwjTobFYJBt/hwZIes279
         Thp6qFJctuRWSPKcdG27R70TE4tW7HYNsTVrOc3/ZrSjVrxHD8RROK1GE4MQeaaLUa
         qVYPOd4DACYKutMUsD236x4wqGIlpD66IOVLE2Txv2mGNyh3WS+G/Mfd5fWBa94pq0
         xhD0SdeBiu+0lkipZcwmYLgqVTPz0iGM/I1xd/7cRDlHjxMIw+Vm47hUoB2G8CVZtR
         c3NFfoYXVoGyw==
Date:   Sun, 6 Nov 2022 14:32:52 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Cc:     linux-wireless@vger.kernel.org, bjlockie@lockie.ca,
        johannes@sipsolutions.net, nbd@nbd.name
Subject: Re: [PATCH wireless] wifi: mac8021: fix possible oob access in
 ieee80211_get_rate_duration
Message-ID: <Y2e3hBYhdUtrMKtm@lore-desk>
References: <08b259df20d9e61c5b852bf8b96db7272dbb1767.1667730476.git.lorenzo@kernel.org>
 <87mt94w94y.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F+21+hpEgfp+lzCb"
Content-Disposition: inline
In-Reply-To: <87mt94w94y.fsf@toke.dk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--F+21+hpEgfp+lzCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Fix possible out-of-bound access in ieee80211_get_rate_duration routine
> > as reported by the following UBSAN report:
> >
> > UBSAN: array-index-out-of-bounds in net/mac80211/airtime.c:455:47
> > index 15 is out of range for type 'u16 [12]'
> > CPU: 2 PID: 217 Comm: kworker/u32:10 Not tainted 6.1.0-060100rc3-generic
> > Hardware name: Acer Aspire TC-281/Aspire TC-281, BIOS R01-A2 07/18/2017
> > Workqueue: mt76 mt76u_tx_status_data [mt76_usb]
> > Call Trace:
> >  <TASK>
> >  show_stack+0x4e/0x61
> >  dump_stack_lvl+0x4a/0x6f
> >  dump_stack+0x10/0x18
> >  ubsan_epilogue+0x9/0x43
> >  __ubsan_handle_out_of_bounds.cold+0x42/0x47
> > ieee80211_get_rate_duration.constprop.0+0x22f/0x2a0 [mac80211]
> >  ? ieee80211_tx_status_ext+0x32e/0x640 [mac80211]
> >  ieee80211_calc_rx_airtime+0xda/0x120 [mac80211]
> >  ieee80211_calc_tx_airtime+0xb4/0x100 [mac80211]
> >  mt76x02_send_tx_status+0x266/0x480 [mt76x02_lib]
> >  mt76x02_tx_status_data+0x52/0x80 [mt76x02_lib]
> >  mt76u_tx_status_data+0x67/0xd0 [mt76_usb]
> >  process_one_work+0x225/0x400
> >  worker_thread+0x50/0x3e0
> >  ? process_one_work+0x400/0x400
> >  kthread+0xe9/0x110
> >  ? kthread_complete_and_exit+0x20/0x20
> >  ret_from_fork+0x22/0x30
> >
> > Reported-by: bjlockie@lockie.ca
> > Fixes: db3e1c40cf2f ("mac80211: Import airtime calculation code from mt=
76")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/mac80211/airtime.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> > index 2e66598fac79..4ed05988131d 100644
> > --- a/net/mac80211/airtime.c
> > +++ b/net/mac80211/airtime.c
> > @@ -452,6 +452,9 @@ static u32 ieee80211_get_rate_duration(struct ieee8=
0211_hw *hw,
> >  			 (status->encoding =3D=3D RX_ENC_HE && streams > 8)))
> >  		return 0;
> > =20
> > +	if (WARN_ON_ONCE(idx >=3D MCS_GROUP_RATES))
> > +		return 0;
> > +
>=20
> So presumably this is something that can actually happen in real usage,
> so should we really warn? Or was the driver also fixed to not trigger
> this?

looking at the mt76x02 support, MT_RATE_INDEX_VHT_IDX is GENMASK(3, 0) so t=
he
hw can report rate_idx up to 15. Do you prefer to drop WARN_ON_ONCE()? I wo=
uld
prefer to keep it since it informs us something nasty occurred (and at the =
end
it just runs ones), but I can live even w/o it :)

Regards,
Lorenzo

>=20
> -Toke

--F+21+hpEgfp+lzCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2e3hAAKCRA6cBh0uS2t
rIi5AP9cdWYPJ5G570oUrKQq80pAE/4q6ZaGNyOdJWR0TlDtDQD4yD7SFLuS3txK
rFByWDUqJMn1OCMq/5GJ2ItArG8pAw==
=Yh9/
-----END PGP SIGNATURE-----

--F+21+hpEgfp+lzCb--
