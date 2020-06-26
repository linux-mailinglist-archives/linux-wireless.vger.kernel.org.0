Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853AF20ABDE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 07:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFZFfX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 01:35:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30499 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgFZFfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 01:35:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593149722; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bY9QyU3nQzRiiypxrj+1wXtJtZwY6va84aTQOK4tRQM=; b=GJGBTqCWpxLVEP8kX7ZDODAiFZMkSagovslUHG9g1urFtGB9DMObDEIEcrG2nj5MWoT/9u8r
 clygju8mjrg2Tupke4A3fW6vHjtObk5dt7X48go7IwWcWg7YH79kvYvmqGpBR6JKdJ9wBeAC
 91K9ZMd15T0CQVRNhB1K0bD2FBM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ef588fe86de6ccd44573a44 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Jun 2020 05:34:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B07FCC433C8; Fri, 26 Jun 2020 05:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED31DC433C6;
        Fri, 26 Jun 2020 05:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED31DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ajay.Kathat@microchip.com, devel@driverdev.osuosl.org,
        Venkateswara.Kaja@microchip.com, Sripad.Balwadgi@microchip.com,
        linux-wireless@vger.kernel.org, Nicolas.Ferre@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
        <87ftaketkw.fsf@tynnyri.adurom.net>
        <20200624091000.GD1731290@kroah.com> <87366kztcr.fsf@codeaurora.org>
        <20200624145254.GA1876138@kroah.com>
Date:   Fri, 26 Jun 2020 08:34:48 +0300
In-Reply-To: <20200624145254.GA1876138@kroah.com> (Greg KH's message of "Wed,
        24 Jun 2020 16:52:54 +0200")
Message-ID: <87a70qe6fb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 24, 2020 at 12:49:24PM +0300, Kalle Valo wrote:
>> Greg KH <gregkh@linuxfoundation.org> writes:
>> 
>> > On Wed, Jun 24, 2020 at 11:50:07AM +0300, Kalle Valo wrote:
>> >> <Ajay.Kathat@microchip.com> writes:
>> >> 
>> >> > From: Ajay Singh <ajay.kathat@microchip.com>
>> >> >
>> >> > This patch series is to review and move wilc1000 driver out of staging.
>> >> > Most of the review comments received in [1] & [2] are addressed in the
>> >> > latest code.
>> >> > Please review and provide your inputs.
>> >> >
>> >> > [1]. https://lore.kernel.org/linux-wireless/1537957525-11467-1-git-send-email-ajay.kathat@microchip.com/
>> >> > [2]. https://lore.kernel.org/linux-wireless/1562896697-8002-1-git-send-email-ajay.kathat@microchip.com/
>> >> >
>> >> > Changes since v6:
>> >> >  - added Reviewed-by tag received for DT binding document patch earlier.
>> >> >    * https://lore.kernel.org/linux-wireless/20200405013235.GA24105@bogus
>> >> >  - merged latest driver and included --base commit as suggested.
>> >> 
>> >> Greg, in preparation for moving the driver to drivers/net/wireless can I
>> >> ask you to not to take wilc1000 patches for the time being? I think that
>> >> way it would be easier to move the driver between trees if there are no
>> >> changes after v5.8-rc1. Or is there a better way handle the move?
>> >
>> > The best way is for there to be a series of patches that just adds the
>> > driver to the "real" part of the tree, and when that is merged, let me
>> > know and I will just delete the driver version in the staging tree.
>> >
>> > Does that work for you?
>> 
>> It would be fine for me but won't that approach break the build (eg.
>> allyesconfig) due to two duplicate versions of the same driver in
>> wireless-drivers-next?
>
> For maybe one day, yes, but that's all.
>
>> What I was thinking that Ajay would create a patch moving the driver
>> from drivers/staging/wilc1000 to
>> drivers/net/wireless/microchip/wilc1000. Using 'git mv' and 'git
>> format-patch --find-renames' the patch should be really small, mostly
>> just renames and small changes to Kconfig, Makefile and MAINTAINERS
>> files. But this of course would require that there are no wilc1000
>> patches in your tree until you get the driver move commit during the
>> next merge window, otherwise we would see conflicts between staging-next
>> and wireless-drivers-next.
>> 
>> But I don't have any strong opinions, whatever is easiest for everyone :)
>
> It's kind of hard to review patches that do moves, but if you all want
> to do that, that's fine with me.

Actually we have been reviewing the driver with full diffs, one file per
patch style[1], so I think everyone are happy. At least I have not heard
any complaints.

And Ajay already submitted that the simple rename patch proposed, thanks
Ajay!

https://patchwork.kernel.org/patch/11625025/

And indeed the patch is simple as it can get. So Greg, if it's ok for
you I would like to apply that simple patch to wireless-drivers-next.

> Note, I can't guarantee that I'll not take any wilc1000 patches, I'll
> probably forget, but git mv will handle all of that just fine.

Good point. To be on the safe side one option is that if I create a
topic branch for this simple patch and use v5.8-rc1 as the baseline.
Then I would pull the topic branch to wireless-drivers-next and you
could pull it to staging-next. That way you would not have wilc1000 in
your tree anymore and no accidental submission or commits either :) What
do you think?

[1 ] https://patchwork.kernel.org/project/linux-wireless/list/?series=307223&state=*&order=date

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
