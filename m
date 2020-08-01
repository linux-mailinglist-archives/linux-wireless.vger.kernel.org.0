Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F44223508A
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Aug 2020 07:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHAFKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Aug 2020 01:10:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:34993 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgHAFKO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Aug 2020 01:10:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596258614; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=+wYIer0V10xv0NSE/QIM8w7LTq7I6dxcydeczBC4CNA=; b=QLa8kE/aVaraocLipBddhEyuH/X1PfH50Uj2NSjIL9IsqUbAuwaojAM8s1LQ0U0lWP8dyaRM
 kIDNgXt5YDA/OnlTcpYWjdr4spjj0dFyLmifitmzyBiTtOjvbxwm+wXLNxXzCWmB/s6wMNXh
 txVh6x3wAV8tTKhWQ3lQF1k9BiU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f24f934798b102968c07985 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 05:10:12
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 533EAC433CB; Sat,  1 Aug 2020 05:10:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [49.205.240.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B40FC433C9;
        Sat,  1 Aug 2020 05:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B40FC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Florian Fainelli'" <f.fainelli@gmail.com>,
        <ath10k@lists.infradead.org>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kvalo@codeaurora.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <netdev@vger.kernel.org>
References: <1596220042-2778-1-git-send-email-pillair@codeaurora.org> <c6c5b3c5-f862-9cee-6863-24f666cc28f5@gmail.com>
In-Reply-To: <c6c5b3c5-f862-9cee-6863-24f666cc28f5@gmail.com>
Subject: RE: [PATCH v2 0/3]
Date:   Sat, 1 Aug 2020 10:40:03 +0530
Message-ID: <000701d667c2$0782fe70$1688fb50$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG33jQ4R3ZVYFu9l+A0slgX59AuwQM6QXA+qUX1HuA=
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Florian Fainelli <f.fainelli@gmail.com>
> Sent: Saturday, August 1, 2020 12:17 AM
> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> kvalo@codeaurora.org; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org
> Subject: Re: [PATCH v2 0/3]
>=20
> On 7/31/20 11:27 AM, Rakesh Pillai wrote:
> > The history recording will be compiled only if
> > ATH10K_DEBUG is enabled, and also enabled via
> > the module parameter. Once the history recording
> > is enabled via module parameter, it can be enabled
> > or disabled runtime via debugfs.
>=20
> Why not use trace prints and retrieving them via the function tracer?
> This seems very ad-hoc.

Tracing needs to be enabled to capture the events.
But these events can be turned on in some kind of a debug build and =
capture the history to help us debug in case there is a crash.
It wont even allocate memory if not enabled via module parameter.

>=20
> >
> > ---
> > Changes from v1:
> > - Add module param and debugfs to enable/disable history recording.
> >
> > Rakesh Pillai (3):
> >   ath10k: Add history for tracking certain events
> >   ath10k: Add module param to enable history
> >   ath10k: Add debugfs support to enable event history
> >
> >  drivers/net/wireless/ath/ath10k/ce.c      |   1 +
> >  drivers/net/wireless/ath/ath10k/core.c    |   3 +
> >  drivers/net/wireless/ath/ath10k/core.h    |  82 ++++++++++++
> >  drivers/net/wireless/ath/ath10k/debug.c   | 207
> ++++++++++++++++++++++++++++++
> >  drivers/net/wireless/ath/ath10k/debug.h   |  75 +++++++++++
> >  drivers/net/wireless/ath/ath10k/snoc.c    |  15 ++-
> >  drivers/net/wireless/ath/ath10k/wmi-tlv.c |   1 +
> >  drivers/net/wireless/ath/ath10k/wmi.c     |  10 ++
> >  8 files changed, 393 insertions(+), 1 deletion(-)
> >
>=20
>=20
> --
> Florian

