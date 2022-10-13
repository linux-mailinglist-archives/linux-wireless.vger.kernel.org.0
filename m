Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8543E5FDE39
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 18:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJMQ0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMQ0C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 12:26:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1886D4A3B
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 09:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B14EB81E35
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C18C433C1;
        Thu, 13 Oct 2022 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665678358;
        bh=0ZprB8JJOEWP6AIX59mAnfcvCDhO84Hoakg5vDW+wH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDBhHIlywcm0Sj5MTFIEnPCiTB+Xr1BVPbpE37MzVoV2EG+QsFrYKsLUPz9QZLbNF
         fWZORxKHM98pJ9/qB91fTNMKE1TDk5YyvFVRaREVcOa6HQzNgMpsbzoTId9rEr1jgi
         2+zZ9PCP+OzXmQk2dv5W4OVPv403110N1WAjRI5zs+XGgEMX8tRCsO5shOYYSgR2su
         NDC1pp6IIRr8TRPJ3gS7ItZHXcyZIXkWlJSalwLKnVMTYdrQlw8QgJRVADBNgdx6+1
         L3zipe3cmT4SGFSphbhQ0r5/NKkoQruzY1syNNHvjEwVotDIDopIr0MTTb5pXFoN1y
         iUsO3sMS1UYnA==
Date:   Thu, 13 Oct 2022 18:25:54 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
Message-ID: <Y0g8Ev4hE7m/kP3H@lore-desk>
References: <20211008130007.GA23161@kili>
 <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
 <20211008142734.GI2083@kadam>
 <Y0gM2jeo/X5Vq+lq@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DOS5cU2t4woqfPoR"
Content-Disposition: inline
In-Reply-To: <Y0gM2jeo/X5Vq+lq@kadam>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--DOS5cU2t4woqfPoR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I would like to revisit this question.  Last time I complained about
> this Johannes responded but he misread what mt76_mcu_send_and_get_msg()
> does.  I have looked at it as well and I also cannot explain what is
> going on in that function.
>=20
> I have looked at the callers and my first instinct is that maybe this
> is dead stub code?  But then when I look at mt76x02u_mcu_send_msg() I
> think "No, this is not stub code.  This should be returning the newly
> allocated skb to the caller."
>=20
> But then I think, surely at some point someone tested this code???  It
> must be stub code.
>=20
> Could we get some clarity on this?

for mt76x2 and mt76x0 we do not care of ret_skb (in fact we do not run
mt76_mcu_send_and_get_msg() directly but we rely on mt76_mcu_send_msg()).
For mt7921 we set mcu_skb_send_msg function pointer and not mcu_send_msg.
Moreover mt7921_mcu_get_eeprom() has been remove a while back.
Am I missing something?

Regards,
Lorenzo

>=20
> regards,
> dan carpenter
>=20
> On Fri, Oct 08, 2021 at 05:27:35PM +0300, Dan Carpenter wrote:
> > On Fri, Oct 08, 2021 at 04:03:10PM +0200, Johannes Berg wrote:
> > > On Fri, 2021-10-08 at 16:00 +0300, Dan Carpenter wrote:
> > > >=20
> > > > =A0=A0=A0=A01146         ret =3D mt76_mcu_send_and_get_msg(&dev->mt=
76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
> > > > =A0=A0=A0=A01147                                         sizeof(req=
), true, &skb);
> > > >=20
> > > > If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg=
()
> > > > then "skb" is not initialized.
> > > >=20
> > > > =A0=A0=A0=A01148         if (ret)
> > > > =A0=A0=A0=A01149                 return ret;
> > > > =A0=A0=A0=A01150=20
> > > > --> 1151         res =3D (struct mt7921_mcu_eeprom_info *)skb->data;
> > >=20
> > > Looks like possibly 'skb' is always initialized if
> > > mt76_mcu_send_and_get_msg() returns 0 (success)?
> > >=20
> >=20
> > This build is with cross function analysis enabled so Smatch looks for
> > that.
> >=20
> > The problem is that the caller has to know if dev->mcu_ops->mcu_send_msg
> > is NULL or not because if it's non-NULL "skb" is not set.  Perhaps that
> > means it should be separated into two functions and we pick which one
> > to call depending on whether the pointer is set.
> >=20
> > drivers/net/wireless/mediatek/mt76/mcu.c
> >     54  int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, co=
nst void *data,
> >     55                                int len, bool wait_resp, struct s=
k_buff **ret_skb)
> >                                                                        =
         ^^^^^^^
> > This is the parameter.
> >=20
> >     56  {
> >     57          struct sk_buff *skb;
> >     58 =20
> >     59          if (dev->mcu_ops->mcu_send_msg)
> >     60                  return dev->mcu_ops->mcu_send_msg(dev, cmd, dat=
a, len, wait_resp);
> >=20
> > The function pointer doesn't set *ret_skb at all.
> >=20
> >     61 =20
> >     62          skb =3D mt76_mcu_msg_alloc(dev, data, len);
> >     63          if (!skb)
> >     64                  return -ENOMEM;
> >     65 =20
> >     66          return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wai=
t_resp, ret_skb);
> >=20
> > But this does.
> >=20
> >     67  }
> >=20
> > regards,
> > dan carpenter

--DOS5cU2t4woqfPoR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY0g8EgAKCRA6cBh0uS2t
rCVPAP4rEv8YfBHfUwLvkIVSKOH+whFxPKd0hF+QEAQNYifD8QD6AtDBpfK5YWO+
7d88bOrTJFkglOlVFYDqN1eO+DqSMgE=
=dXar
-----END PGP SIGNATURE-----

--DOS5cU2t4woqfPoR--
