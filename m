Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D43529DB0B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgJ1Xmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 19:42:55 -0400
Received: from z5.mailgun.us ([104.130.96.5]:30558 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgJ1Xmy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 19:42:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603928573; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=TLNILGHQAl2E5V/J/ptFn/qNwBV4itMmQCkPbQrryS4=; b=T1y+MlOANUyoFCBlPNuXt3MjFhd2V53tXMcPYBlMcheE6wkmz45si607g4yHQEwUoJfdrjGy
 oOK2xytI+5BfrP8muVSFKVX1JTMtMAP20BkADndTlGxdR4BAeIdHH9sMPTtc2UZKqqdcLwbz
 F4Fg50yPRmugAnLizXoF/ah+07o=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f99928e38c6e40045981846 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 15:47:26
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 296D3C433FE; Wed, 28 Oct 2020 15:47:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DAD4C433CB;
        Wed, 28 Oct 2020 15:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DAD4C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Doug Anderson'" <dianders@chromium.org>
Cc:     "'ath10k'" <ath10k@lists.infradead.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Abhishek Kumar'" <kuabhs@chromium.org>,
        "'Brian Norris'" <briannorris@chromium.org>
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org> <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
Subject: RE: [PATCH] ath10k: Fix the parsing error in service available event
Date:   Wed, 28 Oct 2020 21:17:19 +0530
Message-ID: <003801d6ad41$a1bb8970$e5329c50$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJiqwpvoy2iSO2kR0YP6ePedJFSmQFbRrV/qIpSBRA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Wednesday, October 28, 2020 8:07 PM
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
> On Tue, Oct 27, 2020 at 8:20 AM Rakesh Pillai <pillair@codeaurora.org>
> wrote:
> >
> > The wmi service available event has been
> > extended to contain extra 128 bit for new services
> > to be indicated by firmware.
> >
> > Currently the presence of any optional TLVs in
> > the wmi service available event leads to a parsing
> > error with the below error message:
> > ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
> >
> > The wmi service available event parsing should
> > not return error for the newly added optional TLV.
> > Fix this parsing for service available event message.
> >
> > Tested-on: WCN3990 hw1.0 SNOC
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > index 932266d..3b49e29 100644
> > --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > @@ -1404,9 +1404,12 @@ static int =
ath10k_wmi_tlv_svc_avail_parse(struct
> ath10k *ar, u16 tag, u16 len,
> >                 arg->service_map_ext_len =3D *(__le32 *)ptr;
> >                 arg->service_map_ext =3D ptr + sizeof(__le32);
> >                 return 0;
> > +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> > +               return 0;
>=20
> This is at least slightly worrying to me.  If I were calling this
> function, I'd expect that if I didn't get back an error that at least
> "arg->service_map_ext_len" was filled in.  Seems like you should do:
>=20
> case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
>   arg->service_map_ext_len =3D 0;
>   arg->service_map_ext =3D NULL;
>   return 0;
>=20
> ...and maybe add a comment about why you're doing that?
>=20
> At the moment things are working OK because
> ath10k_wmi_event_service_available() happens to init the structure to
> 0 before calling with:
>=20
>   struct wmi_svc_avail_ev_arg arg =3D {};
>=20
> ....but it doesn't seem like a great idea to rely on that.
>=20
> That all being said, I'm just a drive-by reviewer and if everyone else
> likes it the way it is, feel free to ignore my comments.


Hi Doug,

The TLV TAG " WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT" is the first =
and a mandatory TLV in the service available event.
The subsequent TLVs are optional ones and may or may not be present =
(based on FW versions).
This patch just fixes the bug, where the presence of any other TLVs are =
leading to a failure in parsing the service available msg.
If, in future, we plan to use any other services from firmware, which is =
exposed in the extended TLVs, we will need to add a new variable (and =
not service_map_ext) to set the service.


>=20
> -Doug

