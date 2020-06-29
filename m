Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5720D221
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgF2Sqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 14:46:48 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42383 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbgF2Sqq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593456406; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=UN67+6exueZt49OSSOSCDajV8YbGx6Hd7cdOXnOfMkk=; b=gl9LKNEzzfyGo1hwwjKFFbONQusjZxmjKZY5WH+mXcJgUUpP+bFuKZtP1WButFFWcV6aWd9g
 SkWgDGdSh1i18jJ4Am3d5uXc3y9K4uxHjHiMRB/y1H0R9F8LfYggPAzDW4DxrD6r3ec8Cori
 cmzrerPVlah3ItSPnQHENuhHYrY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ef9daf68fe116ddd98d18b9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 12:13:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D3F7DC433CB; Mon, 29 Jun 2020 12:13:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26A85C433C6;
        Mon, 29 Jun 2020 12:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26A85C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Doug Anderson'" <dianders@chromium.org>,
        "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'linux-wireless'" <linux-wireless@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>
References: <1593194502-13164-1-git-send-email-pillair@codeaurora.org> <1593194502-13164-3-git-send-email-pillair@codeaurora.org> <CAD=FV=V1C2Lu31n8xQ8HPf21fNo_Da2SLtZAeStFBEou9+geEA@mail.gmail.com>
In-Reply-To: <CAD=FV=V1C2Lu31n8xQ8HPf21fNo_Da2SLtZAeStFBEou9+geEA@mail.gmail.com>
Subject: RE: [PATCH 2/2] ath10k: Add support for chain1 regulator supply voting
Date:   Mon, 29 Jun 2020 17:43:35 +0530
Message-ID: <000301d64e0e$b9e32c70$2da98550$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOP6JTmaF44S4OU0UHs+POXUh10gKWMw65AYCLAK6nXugGkA==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Doug Anderson <dianders@chromium.org>
> Sent: Saturday, June 27, 2020 3:22 AM
> To: Rakesh Pillai <pillair@codeaurora.org>; Kalle Valo
> <kvalo@codeaurora.org>
> Cc: ath10k@lists.infradead.org; open list:OPEN FIRMWARE AND FLATTENED
> DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-wireless =
<linux-
> wireless@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 2/2] ath10k: Add support for chain1 regulator =
supply
> voting
>=20
> Hi,
>=20
> On Fri, Jun 26, 2020 at 11:02 AM Rakesh Pillai =
<pillair@codeaurora.org> wrote:
> >
> > Add support to vote for chain-1 voltage regulator
> > in WCN3990.
> >
> > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/snoc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/snoc.c
> b/drivers/net/wireless/ath/ath10k/snoc.c
> > index 645ed5f..407a074 100644
> > --- a/drivers/net/wireless/ath/ath10k/snoc.c
> > +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> > @@ -45,6 +45,7 @@ static const char * const ath10k_regulators[] =3D =
{
> >         "vdd-1.8-xo",
> >         "vdd-1.3-rfa",
> >         "vdd-3.3-ch0",
> > +       "vdd-3.3-ch1",
>=20
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>=20
> ...with the slight nit that ${SUBJECT} and description should probably
> call it "chan1" and not "chain1".  Presumably the maintainer can fix
> when applying.
>=20
> -Doug

Hi Doug,

It has to be chain1 only, not chan1.
This is the power supply rail for the wlan-chain1=20

