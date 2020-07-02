Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910AE211C5D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2020 09:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGBHFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jul 2020 03:05:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12717 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGBHFV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jul 2020 03:05:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593673521; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=3fwwa5vI58tW/Skqz+I+1rB/iH0AQQKspXiTMKHBrjY=; b=xGIh7kmZck8DGAPVbobJATDezJ4aNRuFQe5Tq9vpEM5TR10DDdwrN4bS7p+E/SR9ndlwSh5L
 msOhyGLO3U006UHVFlH5kc7802OPthupjQPC99dj+vy1kQ2BcQtBeNksiP7zI4ClZcgGnepj
 dbKlaihS4IZqBrqtqUMw5i+3WSM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5efd8721ad153efa343d5f61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Jul 2020 07:05:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8FF6FC433C8; Thu,  2 Jul 2020 07:05:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24D13C433C6;
        Thu,  2 Jul 2020 07:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24D13C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        Venkateswara.Kaja@microchip.com, linux-wireless@vger.kernel.org,
        Nicolas.Ferre@microchip.com, Sripad.Balwadgi@microchip.com,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
        <87ftaketkw.fsf@tynnyri.adurom.net>
        <20200624091000.GD1731290@kroah.com> <87366kztcr.fsf@codeaurora.org>
        <20200624145254.GA1876138@kroah.com> <87a70qe6fb.fsf@codeaurora.org>
        <20200626134610.GB4095392@kroah.com>
Date:   Thu, 02 Jul 2020 10:05:01 +0300
In-Reply-To: <20200626134610.GB4095392@kroah.com> (Greg KH's message of "Fri,
        26 Jun 2020 15:46:10 +0200")
Message-ID: <87a70ibdnm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Jun 26, 2020 at 08:34:48AM +0300, Kalle Valo wrote:
>
>> And Ajay already submitted that the simple rename patch proposed, thanks
>> Ajay!
>> 
>> https://patchwork.kernel.org/patch/11625025/
>> 
>> And indeed the patch is simple as it can get. So Greg, if it's ok for
>> you I would like to apply that simple patch to wireless-drivers-next.
>> 
>> > Note, I can't guarantee that I'll not take any wilc1000 patches, I'll
>> > probably forget, but git mv will handle all of that just fine.
>> 
>> Good point. To be on the safe side one option is that if I create a
>> topic branch for this simple patch and use v5.8-rc1 as the baseline.
>> Then I would pull the topic branch to wireless-drivers-next and you
>> could pull it to staging-next. That way you would not have wilc1000 in
>> your tree anymore and no accidental submission or commits either :) What
>> do you think?
>
> That sounds great, I will be happy to pull such a branch.

Great! Sorry for taking so long, I'm on vacation right now, but here's
the immutable branch:

git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git wilc1000-move-out-of-staging

I have pulled it into wireless-drivers-next now.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
