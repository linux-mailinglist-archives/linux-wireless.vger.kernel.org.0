Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C444329A3ED
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Oct 2020 06:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505781AbgJ0FSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Oct 2020 01:18:03 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:11788 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505777AbgJ0FSD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Oct 2020 01:18:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603775882; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=g64XdioYWzF68Lt5U5nrTtR7/oWlvIneDTTlwIVAqXc=; b=e+8+i9D6Fg92B8eBkmSAtiqJ4ujSthF5Wbym6TXtTrr6XcE9tluPVgrYpIjuPIwVuJ9lL1Se
 v983N8S6Q1FRBHtmaPoUV6FYSv1wqrQdfLPShXkruOuofgq67HH/H7NdecIcb8FDMQOfTrWV
 y9D7d8LYpr8dEn769yRdhbRivNQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f97ad895c97867acefbaa04 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 05:18:01
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B4440C433CB; Tue, 27 Oct 2020 05:18:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23AE3C433C9;
        Tue, 27 Oct 2020 05:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23AE3C433C9
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
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid> <CAD=FV=Xv7Usev=S_ViWPPsa0xL42KDymjEkqJF7S4CzDiuxP3g@mail.gmail.com> <CACTWRwtqcMxZKhDR-Q+3CyOw0Ju=iR+ZMg2pVrHEuzbOUebjOg@mail.gmail.com> <001a01d6aa24$6ceaf390$46c0dab0$@codeaurora.org> <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com>
In-Reply-To: <CAD=FV=X5cVdMq9H+cABHmscZvJpswqGZONjqv7FL8kqRNvuHnQ@mail.gmail.com>
Subject: RE: [PATCH] ath10k: add option for chip-id based BDF selection
Date:   Tue, 27 Oct 2020 10:47:54 +0530
Message-ID: <002801d6ac20$89ac4df0$9d04e9d0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFjEyTiGf73PRIYZgnn2adypkFjcAJI1HsxAfRirrsAqQquEAGWWD6uql40+ZA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Tuesday, October 27, 2020 4:21 AM
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
> On Sat, Oct 24, 2020 at 9:40 AM Rakesh Pillai <pillair@codeaurora.org> =
wrote:
> >
> > >         if (bd_ie_type =3D=3D ATH10K_BD_IE_BOARD) {
> > > +               /* With variant and chip id */
> > >                 ret =3D ath10k_core_create_board_name(ar, =
boardname,
> > > -                                                   =
sizeof(boardname), true);
> > > +                                               sizeof(boardname), =
true, true);
> >
> > Instead of adding a lot of code to generate a second fallback name, =
its
> better to just modify the condition inside the function
> =E2=80=9Cath10k_core_create_board_name=E2=80=9D to allow the =
generation of BDF tag using
> chip id, even =E2=80=9Cif ar->id.bdf_ext[0] =3D=3D '\0 =E2=80=9C.
> >
> > This will make sure that the variant string is NULL, and just =
board-id and
> chip-id is used. This will help avoid most of the code changes.
> > The code would look as shown below
> >
> > @@ -1493,7 +1493,7 @@ static int =
ath10k_core_create_board_name(struct
> ath10k *ar, char *name,
> >         }
> >
> >         if (ar->id.qmi_ids_valid) {
> > -               if (with_variant && ar->id.bdf_ext[0] !=3D '\0')
> > +               if (with_variant)
>=20
> Wouldn't the above just be "if (with_chip_id)" instead?  ...but yeah,
> that would be a cleaner way to do this.  Abhishek: do you want to post
> a v2?


The parameter name passed to this function is "with_variant", since =
other non-qmi targets (eg QCA6174) use this as a flag to just add the =
variant field.
This can be renamed to something meaningful for both qmi and non-qmi =
targets.

>=20
> -Doug

