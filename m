Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEF29B6D2
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368711AbgJ0P1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 11:27:01 -0400
Received: from z5.mailgun.us ([104.130.96.5]:18219 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1798143AbgJ0PZx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 11:25:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603812352; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=0ck87C0iKlJLQba8b3HuObbVfgJ1U94uvaqu8TKWpLs=; b=LRHprV33ONvzrYZN85/2bJEuet3USkFaKrsmcEcf/0v7yt4oKV3iq9ELAYvTMZ4ktm9CuZgl
 mGqz5z9enaKwZimTfMxvZqULaV1DuDEcKkmenIFTdGBKYtvpv/JigEJSGsiUDzUuw0Xsr+tH
 jh40tcaHrmT1URxwv2mn3076MSM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f983892f646073bf956cb99 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 15:11:14
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1D2DC4344B; Tue, 27 Oct 2020 15:11:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4171C43443;
        Tue, 27 Oct 2020 15:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4171C43443
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Doug Anderson'" <dianders@chromium.org>
Cc:     "'Abhishek Kumar'" <kuabhs@chromium.org>,
        "'Kalle Valo'" <kvalo@codeaurora.org>,
        "'ath10k'" <ath10k@lists.infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'Brian Norris'" <briannorris@chromium.org>
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid> <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com> <CACTWRwtqcMxZKhDR-Q+3CyOw0Ju=iR+ZMg2pVrHEuzbOUebjOg@mail.gmail.com> <001a01d6aa24$6ceaf390$46c0dab0$@codeaurora.org> <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com> <002801d6ac20$89ac4df0$9d04e9d0$@codeaurora.org> <CAD=FV=W1FiHRHeX-sATY_9x33n6P2n3KaoxfiGjvn2mwAm_-BA@mail.gmail.com>
In-Reply-To: <CAD=FV=W1FiHRHeX-sATY_9x33n6P2n3KaoxfiGjvn2mwAm_-BA@mail.gmail.com>
Subject: RE: [PATCH] ath10k: add option for chip-id based BDF selection
Date:   Tue, 27 Oct 2020 20:41:05 +0530
Message-ID: <002c01d6ac73$67a966e0$36fc34a0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFjEyTiGf73PRIYZgnn2adypkFjcAJI1HsxAfRirrsAqQquEAGWWD6uAa+Wb7kBxA/hJ6pDPLhw
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Tuesday, October 27, 2020 8:26 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: Abhishek Kumar <kuabhs@chromium.org>; Kalle Valo
> <kvalo@codeaurora.org>; ath10k <ath10k@lists.infradead.org>; LKML
> <linux-kernel@vger.kernel.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; Brian Norris <briannorris@chromium.org>
> Subject: Re: [PATCH] ath10k: add option for chip-id based BDF =
selection
>=20
> Hi,
>=20
> On Mon, Oct 26, 2020 at 10:18 PM Rakesh Pillai =
<pillair@codeaurora.org>
> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Doug Anderson <dianders@chromium.org>
> > > Sent: Tuesday, October 27, 2020 4:21 AM
> > > To: Rakesh Pillai <pillair@codeaurora.org>
> > > Cc: Abhishek Kumar <kuabhs@chromium.org>; Kalle Valo
> > > <kvalo@codeaurora.org>; ath10k <ath10k@lists.infradead.org>; LKML
> > > <linux-kernel@vger.kernel.org>; linux-wireless <linux-
> > > wireless@vger.kernel.org>; Brian Norris <briannorris@chromium.org>
> > > Subject: Re: [PATCH] ath10k: add option for chip-id based BDF =
selection
> > >
> > > Hi,
> > >
> > > On Sat, Oct 24, 2020 at 9:40 AM Rakesh Pillai =
<pillair@codeaurora.org>
> wrote:
> > > >
> > > > >         if (bd_ie_type =3D=3D ATH10K_BD_IE_BOARD) {
> > > > > +               /* With variant and chip id */
> > > > >                 ret =3D ath10k_core_create_board_name(ar, =
boardname,
> > > > > -                                                   =
sizeof(boardname), true);
> > > > > +                                               =
sizeof(boardname), true, true);
> > > >
> > > > Instead of adding a lot of code to generate a second fallback =
name, its
> > > better to just modify the condition inside the function
> > > =E2=80=9Cath10k_core_create_board_name=E2=80=9D to allow the =
generation of BDF tag
> using
> > > chip id, even =E2=80=9Cif ar->id.bdf_ext[0] =3D=3D '\0 =E2=80=9C.
> > > >
> > > > This will make sure that the variant string is NULL, and just =
board-id and
> > > chip-id is used. This will help avoid most of the code changes.
> > > > The code would look as shown below
> > > >
> > > > @@ -1493,7 +1493,7 @@ static int
> ath10k_core_create_board_name(struct
> > > ath10k *ar, char *name,
> > > >         }
> > > >
> > > >         if (ar->id.qmi_ids_valid) {
> > > > -               if (with_variant && ar->id.bdf_ext[0] !=3D '\0')
> > > > +               if (with_variant)
> > >
> > > Wouldn't the above just be "if (with_chip_id)" instead?  ...but =
yeah,
> > > that would be a cleaner way to do this.  Abhishek: do you want to =
post
> > > a v2?
> >
> >
> > The parameter name passed to this function is "with_variant", since =
other
> non-qmi targets (eg QCA6174) use this as a flag to just add the =
variant field.
> > This can be renamed to something meaningful for both qmi and non-qmi
> targets.
>=20
> I think we still need Abhishek's change to have two booleans passed to
> this function, though, right?  Thus, it'll be called 3 times:
>=20
> * with_chip_id =3D false, with_variant =3D false
> * with_chip_id =3D true, with_variant =3D true
> * with_chip_id =3D true, with_variant =3D false
>=20
> The two cases you want to combine are both with "with_chip_id =3D =
true",
> right?  The "with_variant" variable being false will make the variant
> string empty.


I meant that we can use the 4th argument passed to the function " =
ath10k_core_create_board_name" (currently named as with_variant) as an =
indication to use the BDF name with variant.
But even if with_variant=3Dtrue, we allow the variant string to be NULL, =
thereby allowing us to generate a boardname with the format =
"bus=3Dsnoc,qmi-board-id=3D0xab,qmi-chip-id=3D0xcd"

The combinations of args/variant-strings for generating different board =
names will be as follows:
1) with_variant=3Dfalse                                                  =
   :      "bus=3Dsnoc,qmi-board-id=3D0xab"
2) with_variant=3Dtrue, variant_string=3DNULL                :     " =
bus=3Dsnoc,qmi-board-id=3D0xab,qmi-chip-id=3D0xcd"
3) with_variant=3Dtrue, variant_string=3D"variant_xyz"  :     " =
bus=3Dsnoc,qmi-board-id=3D0xab,qmi-chip-id=3D0xcd,variant=3Dvariant_xyz"


This will minimize the code changes.

>=20
> -Doug

