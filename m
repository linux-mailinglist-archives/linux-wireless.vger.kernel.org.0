Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173C329DD52
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbgJ2Aha (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 20:37:30 -0400
Received: from z5.mailgun.us ([104.130.96.5]:25060 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730689AbgJ2Agx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 20:36:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603931812; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=3TAscz14oWrbc634rB6juc5q//Mynt4kR9cWgTjp0rw=; b=A8sjR+whuDF5E8fl3+IzpDZo57K+EX4b0+XSC4+C5TgVksKYIbAgHnIGto52YXB9JiKNheAK
 +4Q4wTvHOxvCesnUkewVzl2DC/KVGCCeZ0ri7aADU1GPIDU2yxXqbF+lCFBFAD9phmtZ+3xr
 M8xu/UOteSy8bGlUZ5rx6fsKfrQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f999f4ec524f1103641ca43 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 16:41:50
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80CF2C433FF; Wed, 28 Oct 2020 16:41:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 435C8C433CB;
        Wed, 28 Oct 2020 16:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 435C8C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Doug Anderson'" <dianders@chromium.org>
Cc:     "'ath10k'" <ath10k@lists.infradead.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Abhishek Kumar'" <kuabhs@chromium.org>,
        "'Brian Norris'" <briannorris@chromium.org>
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org> <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com> <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org> <CAD=FV=U_Dwb=YRMKcKME9vdxbSgSn-08dznoVXY6VzCaHL8OnQ@mail.gmail.com>
In-Reply-To: <CAD=FV=U_Dwb=YRMKcKME9vdxbSgSn-08dznoVXY6VzCaHL8OnQ@mail.gmail.com>
Subject: RE: [PATCH] ath10k: Fix the parsing error in service available event
Date:   Wed, 28 Oct 2020 22:11:43 +0530
Message-ID: <003a01d6ad49$3a93f040$afbbd0c0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJiqwpvoy2iSO2kR0YP6ePedJFSmQFbRrV/AemjQRUBizF6+6huuv3w
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Wednesday, October 28, 2020 9:33 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k <ath10k@lists.infradead.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; =
Abhishek
> Kumar <kuabhs@chromium.org>; Brian Norris <briannorris@chromium.org>
> Subject: Re: [PATCH] ath10k: Fix the parsing error in service =
available event
>=20
> Hi,
>=20
> On Wed, Oct 28, 2020 at 8:47 AM Rakesh Pillai <pillair@codeaurora.org>
> wrote:
> >
> > > -----Original Message-----
> > > From: Doug Anderson <dianders@chromium.org>
> > > Sent: Wednesday, October 28, 2020 8:07 PM
> > > To: Rakesh Pillai <pillair@codeaurora.org>
> > > Cc: ath10k <ath10k@lists.infradead.org>; linux-wireless <linux-
> > > wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>;
> Abhishek
> > > Kumar <kuabhs@chromium.org>; Brian Norris
> <briannorris@chromium.org>
> > > Subject: Re: [PATCH] ath10k: Fix the parsing error in service =
available
> event
> > >
> > > Hi,
> > >
> > > On Tue, Oct 27, 2020 at 8:20 AM Rakesh Pillai =
<pillair@codeaurora.org>
> > > wrote:
> > > >
> > > > The wmi service available event has been
> > > > extended to contain extra 128 bit for new services
> > > > to be indicated by firmware.
> > > >
> > > > Currently the presence of any optional TLVs in
> > > > the wmi service available event leads to a parsing
> > > > error with the below error message:
> > > > ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
> > > >
> > > > The wmi service available event parsing should
> > > > not return error for the newly added optional TLV.
> > > > Fix this parsing for service available event message.
> > > >
> > > > Tested-on: WCN3990 hw1.0 SNOC
> > > >
> > > > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > > > ---
> > > >  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > > index 932266d..3b49e29 100644
> > > > --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > > +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > > > @@ -1404,9 +1404,12 @@ static int
> ath10k_wmi_tlv_svc_avail_parse(struct
> > > ath10k *ar, u16 tag, u16 len,
> > > >                 arg->service_map_ext_len =3D *(__le32 *)ptr;
> > > >                 arg->service_map_ext =3D ptr + sizeof(__le32);
> > > >                 return 0;
> > > > +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> > > > +               return 0;
> > >
> > > This is at least slightly worrying to me.  If I were calling this
> > > function, I'd expect that if I didn't get back an error that at =
least
> > > "arg->service_map_ext_len" was filled in.  Seems like you should =
do:
> > >
> > > case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> > >   arg->service_map_ext_len =3D 0;
> > >   arg->service_map_ext =3D NULL;
> > >   return 0;
> > >
> > > ...and maybe add a comment about why you're doing that?
> > >
> > > At the moment things are working OK because
> > > ath10k_wmi_event_service_available() happens to init the structure =
to
> > > 0 before calling with:
> > >
> > >   struct wmi_svc_avail_ev_arg arg =3D {};
> > >
> > > ....but it doesn't seem like a great idea to rely on that.
> > >
> > > That all being said, I'm just a drive-by reviewer and if everyone =
else
> > > likes it the way it is, feel free to ignore my comments.
> >
> >
> > Hi Doug,
> >
> > The TLV TAG " WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT" is
> the first and a mandatory TLV in the service available event.
> > The subsequent TLVs are optional ones and may or may not be present
> (based on FW versions).
> > This patch just fixes the bug, where the presence of any other TLVs =
are
> leading to a failure in parsing the service available msg.
> > If, in future, we plan to use any other services from firmware, =
which is
> exposed in the extended TLVs, we will need to add a new variable (and =
not
> service_map_ext) to set the service.
>=20
> I'm not sure I totally understood your response, but look at it from
> the perspective of the function ath10k_wmi_event_service_available().
>=20
> That function calls:
>=20
>   ret =3D ath10k_wmi_pull_svc_avail(ar, skb, &arg);
>=20
> ...if it gets back a non-zero error code, it assumes that the
> "arg.service_map_ext" and "arg.service_map_ext_len" values are now
> valid and it can use them.
>=20
> Before your patch, ath10k_wmi_pull_svc_avail() was returning an error
> code.  That let ath10k_wmi_event_service_available() know that it
> shouldn't look at "arg.service_map_ext" and "arg.service_map_ext_len".
> After your patch, you're not returning an error code but those fields
> aren't being filled in.
>=20
> Said another way, if you remove the initialization of "arg" in
> ath10k_wmi_event_service_available() then everything is broken.  While
> things work because you _do_ have an initialization of "arg" in
> ath10k_wmi_event_service_available(), it feels fragile to me to rely
> on that.

Hi Doug,
Got it. I will send a v2 which will address this concern.

>=20
>=20
> -Doug

