Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41829E413
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgJ2Hae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Oct 2020 03:30:34 -0400
Received: from z5.mailgun.us ([104.130.96.5]:12367 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbgJ2H2o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Oct 2020 03:28:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603956522; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=E/cbhf4EC5pSPJmXgqlC0DVMTkquNWZJfezuBzLVb5I=; b=vQzFMYdDgwhcsjWL/HWDYAzC0sG+71VpLzgGu6erf40/DwxcqLkLNhFnzekGNcufnm5cgsWD
 ag3+gWKOU4zKJlRIBYxbAAVe91uDm12CkvxovqX0w63A1xDFFHQ33w42yPY8V7Iv3mWSMY3N
 chQsUkwNF/J3qA6sJuV3uR3N7/I=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f9a533444ab0dcc453c39e3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 05:29:24
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 662FBC433FF; Thu, 29 Oct 2020 05:29:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.247.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E26AFC433C9;
        Thu, 29 Oct 2020 05:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E26AFC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Doug Anderson'" <dianders@chromium.org>
Cc:     "'ath10k'" <ath10k@lists.infradead.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Abhishek Kumar'" <kuabhs@chromium.org>,
        "'Brian Norris'" <briannorris@chromium.org>
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org> <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
In-Reply-To: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Subject: RE: [PATCH v2] ath10k: Fix the parsing error in service available event
Date:   Thu, 29 Oct 2020 10:59:17 +0530
Message-ID: <004501d6adb4$754a9930$5fdfcb90$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFSHT7JIDNVEOf9hYE4s856hE6ZMQI5NlbiqqVieRA=
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Thursday, October 29, 2020 12:15 AM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k <ath10k@lists.infradead.org>; linux-wireless <linux-
> wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; =
Abhishek
> Kumar <kuabhs@chromium.org>; Brian Norris <briannorris@chromium.org>
> Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service =
available
> event
>=20
> Hi,
>=20
> On Wed, Oct 28, 2020 at 10:01 AM Rakesh Pillai =
<pillair@codeaurora.org>
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
> > Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT
> support")
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> > Changes from v1:
> > - Access service_map_ext only if this TLV was sent in service
> >   available event.
> > ---
> >  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
> >  drivers/net/wireless/ath/ath10k/wmi.c     | 5 +++--
> >  drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > index 932266d..7b58341 100644
> > --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> > @@ -1401,13 +1401,15 @@ static int
> ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
> >
> >         switch (tag) {
> >         case WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT:
> > +               arg->service_map_ext_valid =3D true;
> >                 arg->service_map_ext_len =3D *(__le32 *)ptr;
> >                 arg->service_map_ext =3D ptr + sizeof(__le32);
> >                 return 0;
> >         default:
> >                 break;
> >         }
> > -       return -EPROTO;
> > +
> > +       return 0;
>=20
> I notice your v2 now returns 0 for _all_ unknown tags.  v1 just had a
> special case for "WMI_TLV_TAG_FIRST_ARRAY_ENUM".  I don't have
> enough
> experience with this driver to know which is better, but this change
> wasn't mentioned in the changes from v1.  I guess you had a change of
> heart and decided this way was better?

Earlier patchset which added a case for " WMI_TLV_TAG_FIRST_ARRAY_ENUM", =
still returned error if there is any other TLV except for the two cases =
handled.
This leaves the possibility of an error when a new TLV gets added to =
this service_available message.

Since we are using the "valid" flag to indicate the validity of a =
particular tag, we need not return failure in any case. This makes it =
scalable (and maintains backward compatibility), in case extra TLVs are =
added to this message in future.

>=20
>=20
> >  }
> >
> >  static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
> > diff --git a/drivers/net/wireless/ath/ath10k/wmi.c
> b/drivers/net/wireless/ath/ath10k/wmi.c
> > index 1fa7107..2e4b561 100644
> > --- a/drivers/net/wireless/ath/ath10k/wmi.c
> > +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> > @@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct
> ath10k *ar, struct sk_buff *skb)
> >                             ret);
> >         }
> >
> > -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar-
> >wmi.svc_map,
> > -                              =
__le32_to_cpu(arg.service_map_ext_len));
> > +       if (arg.service_map_ext_valid)
> > +               ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar-
> >wmi.svc_map,
> > +                                      =
__le32_to_cpu(arg.service_map_ext_len));
>=20
> Your new patch still requires the caller to init the
> "service_map_ext_valid" to false before calling, but I guess there's
> not a whole lot more we can do because we might be parsing more than
> one tag.  It does seem nice that at least we now have a validity bit
> instead of just relying on a non-zero length to be valid.
>=20
> It might be nice to have a comment saying that it's up to us to init
> "arg.service_map_ext_valid" to false before calling
> ath10k_wmi_pull_svc_avail(), but I won't insist.  Maybe that's obvious
> to everyone but me...

I will wait for a couple of days, if there are any other comments, to =
post a v3 addressing all of them together.
This approach of having a argument initialized to parse TLVs is used for =
many other wmi events as well.

>=20
>=20
> -Doug

