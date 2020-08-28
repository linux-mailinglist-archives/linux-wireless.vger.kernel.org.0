Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0B255A59
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgH1MjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 08:39:00 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56760 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729331AbgH1Mh6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 08:37:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598618277; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=HcPm6uanbnSQDeODcZhSA9sG6LtPllH/vG6zVc29+Uc=; b=OL09oPs0QZPR9phcaFmSz9mUlqzTX6hZr60fC9bVbsOMaQAeYpeK5uTAasVusMYG+v8Jfugy
 4ka3bgFbiMxYTOJ53poTosodjs8raQsAUbzRnFhr5WRxpKnJO54mTCJvhB0dOy+TZxAlULAo
 NzXDMmXtTHf4cRWL0muwgZLPg8g=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f48faa563431d11444e8919 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:37:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33C4BC433A0; Fri, 28 Aug 2020 12:37:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8131BC433CB;
        Fri, 28 Aug 2020 12:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8131BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Ondrej Zary <linux@zary.sk>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Reed <breed@users.sourceforge.net>,
        Javier Achirica <achirica@users.sourceforge.net>,
        Jean Tourrilhes <jt@hpl.hp.com>,
        Fabrice Bellet <fabrice@bellet.info>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 12/30] net: wireless: cisco: airo: Fix a myriad of coding style issues
References: <20200814113933.1903438-1-lee.jones@linaro.org>
        <202008172335.02988.linux@zary.sk> <87v9h4le9z.fsf@codeaurora.org>
        <202008272223.57461.linux@zary.sk> <87lfhz9mdi.fsf@codeaurora.org>
        <20200828100834.GG1826686@dell>
Date:   Fri, 28 Aug 2020 15:37:50 +0300
In-Reply-To: <20200828100834.GG1826686@dell> (Lee Jones's message of "Fri, 28
        Aug 2020 11:08:34 +0100")
Message-ID: <87lfhz7xpd.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> On Fri, 28 Aug 2020, Kalle Valo wrote:
>
>> Ondrej Zary <linux@zary.sk> writes:
>> 
>> > On Thursday 27 August 2020 09:49:12 Kalle Valo wrote:
>> >> Ondrej Zary <linux@zary.sk> writes:
>> >> 
>> >> > On Monday 17 August 2020 20:27:06 Jesse Brandeburg wrote:
>> >> >> On Mon, 17 Aug 2020 16:27:01 +0300
>> >> >> Kalle Valo <kvalo@codeaurora.org> wrote:
>> >> >> 
>> >> >> > I was surprised to see that someone was using this driver in 2015, so
>> >> >> > I'm not sure anymore what to do. Of course we could still just remove
>> >> >> > it and later revert if someone steps up and claims the driver is still
>> >> >> > usable. Hmm. Does anyone any users of this driver?
>> >> >> 
>> >> >> What about moving the driver over into staging, which is generally the
>> >> >> way I understood to move a driver slowly out of the kernel?
>> >> >
>> >> > Please don't remove random drivers.
>> >> 
>> >> We don't want to waste time on obsolete drivers and instead prefer to
>> >> use our time on more productive tasks. For us wireless maintainers it's
>> >> really hard to know if old drivers are still in use or if they are just
>> >> broken.
>> >> 
>> >> > I still have the Aironet PCMCIA card and can test the driver.
>> >> 
>> >> Great. Do you know if the airo driver still works with recent kernels?
>> >
>> > Yes, it does.
>> 
>> Nice, I'm very surprised that so old and unmaintained driver still
>> works. Thanks for testing.
>
> That's awesome.  Go Linux!
>
> So where does this leave us from a Maintainership perspective?  Are
> you still treating the driver as obsolete?  After this revelation, I
> suggest not.  So let's make it better. :)

Yeah, I can take patches to airo now. I already applied this one.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
