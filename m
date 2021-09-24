Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F64416D73
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Sep 2021 10:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244626AbhIXIJY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 04:09:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54857 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244619AbhIXIJV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 04:09:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632470868; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=oagsw+UheuBzr8hFvh9igKPmwL4Ple1Gl74ol+OtCSE=; b=BNuAluBVxibf170fLIrLgqnUi+5cpVNgy/SXNozDJ7pfUZD4jZODi0yOX/XYPl1oa9Lnqovr
 b0pRhlAMNsNLnfw1LnPlNj34gGvtKBQ4XP9DTIbLSGFnbyZHySJS56APeKhNn6XwYV/rtsey
 zgV6nNMIuVy7LRMUSVWTcY+jY54=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 614d8751ebab839292407c3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Sep 2021 08:07:45
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5512C4338F; Fri, 24 Sep 2021 08:07:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from PILLAIR1 (unknown [103.155.222.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63179C43618;
        Fri, 24 Sep 2021 08:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 63179C43618
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>,
        "'Stephen Boyd'" <swboyd@chromium.org>
Cc:     <ath10k@lists.infradead.org>, <govinds@codeaurora.org>,
        <kuabhs@chromium.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <youghand@codeaurora.org>
References: <002501d7af73$ae0a7620$0a1f6260$@codeaurora.org>    <CAE-0n52DcCwcdR07fvMLrj=RJFtNthy0FdWmt1gBWiD9eLrOvQ@mail.gmail.com> <87bl4itnd8.fsf@codeaurora.org>
In-Reply-To: <87bl4itnd8.fsf@codeaurora.org>
Subject: RE: [PATCH] ath10k: Don't always treat modem stop events as crashes
Date:   Fri, 24 Sep 2021 13:37:37 +0530
Message-ID: <005101d7b11b$405bf280$c113d780$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIYJ9kKn6Tt/ByohP9gdNhIBlqrqgHHLrXjAbRpcN6rFgnMgA==
Content-Language: en-us
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Friday, September 24, 2021 1:30 PM
> To: Stephen Boyd <swboyd@chromium.org>
> Cc: pillair@codeaurora.org; ath10k@lists.infradead.org;
> govinds@codeaurora.org; kuabhs@chromium.org; linux-arm-
> msm@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> wireless@vger.kernel.org; netdev@vger.kernel.org;
> youghand@codeaurora.org
> Subject: Re: [PATCH] ath10k: Don't always treat modem stop events as
> crashes
> 
> Stephen Boyd <swboyd@chromium.org> writes:
> 
> > Quoting pillair@codeaurora.org (2021-09-21 22:35:34)
> >> On 9/5/21 4:04 PM, Stephen Boyd wrote:
> >>
> >> > +static int ath10k_snoc_modem_notify(struct notifier_block *nb,
> >> > +unsigned long
> > [...]
> >>
> >> > +
> >>
> >> > +          return NOTIFY_OK;
> >>
> >> > +}
> >>
> >>
> >>
> >> Thanks for posting the patch. It would be preferable to use a
> >> different flag instead of ATH10K_SNOC_FLAG_UNREGISTERING,
> >>
> >> since we are not unloading the ath10k driver.
> 
> Weird, I don't see pillair's email on patchwork[1] and not in the ath10k
list
> either. Was it sent as HTML or something?

Hi Kalle,
Yes, I replied via the "In-reply-to" from the patchworks[1] link.

Thanks,
Rakesh Pillai

> 
> [1] https://patchwork.kernel.org/project/linux-
> wireless/patch/20210905210400.1157870-1-swboyd@chromium.org/
> 
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

