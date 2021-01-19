Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68FA2FB3B9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhASIHQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 03:07:16 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:64509 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbhASIGh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 03:06:37 -0500
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 03:06:36 EST
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611043564; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8hYxoRhMSFrzpEqPXzpd/9+6QSCjcc7/qPoXubLdBlc=; b=Q/42lD856MttaD09glMVxLRWzfVQnH96Er7ZnRIz7wqF17c4kihNxABgivLc4ypNXTmiuqLC
 hZqqv9vm7KMN/pDdLQWhbIk/TWh4V+4/IhfuPiF0S2Xgu1O2qzOUwQHGkY7SmJmciolIFsau
 P06l6pmWFv8WEIeCt/agIJDQz20=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6006916f75e5c01cba08775f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 07:59:43
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB1B0C43462; Tue, 19 Jan 2021 07:59:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED820C433CA;
        Tue, 19 Jan 2021 07:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED820C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        matthias_berndt@gmx.de, mozlima@gmail.com
Subject: Re: [PATCH wireless-drivers] mt7601u: fix kernel crash unplugging the device
References: <3b85219f669a63a8ced1f43686de05915a580489.1610919247.git.lorenzo@kernel.org>
        <20210118085429.3495ee7c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAJ0CqmWJKahSkAnPg3JE_QfmWbvQA5qjEc5=v0svn+4L4yqepg@mail.gmail.com>
Date:   Tue, 19 Jan 2021 09:59:35 +0200
In-Reply-To: <CAJ0CqmWJKahSkAnPg3JE_QfmWbvQA5qjEc5=v0svn+4L4yqepg@mail.gmail.com>
        (Lorenzo Bianconi's message of "Tue, 19 Jan 2021 00:30:29 +0100")
Message-ID: <87a6t5qrvc.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> On Sun, 17 Jan 2021 22:46:01 +0100 Lorenzo Bianconi wrote:
>> > Fix the following kernel crash unplugging the usb dongle
>> >
>> > [...]
>> >
>> > Fixes: 23377c200b2eb ("mt7601u: fix possible memory leak when the device is disconnected")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>
>> A few words of explanation beyond the stack trace without line info
>> would perhaps make the review quicker..
>>
>
> Hi Jakub,
>
> right, sorry for that. I will add some more info here so Kalle can add
> it to the commit log merging the patch.
>
> "
> The following crash log can occur unplugging the usb dongle since,
> after the urb poison in mt7601u_free_tx_queue(), usb_submit_urb() will
> always fail resulting in a skb kfree while the skb has been already
> queued.
> Fix the issue enqueuing the skb only if usb_submit_urb() succeed.
> "
>
> @Kalle: is it ok or do you prefer to resubmit? (sorry for the noise)

This is ok, no need to resend. I have an edit command in my patchwork
script :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
