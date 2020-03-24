Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB13B191417
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 16:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCXPT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 11:19:59 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:12560 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727682AbgCXPT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 11:19:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585063197; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Rju35+TVYa94gaMTbrqQo+7mYnKJUtxXoZDX5XaReoo=; b=ulDE7g/JBSxhel82WIwofwCMk+KxSmAH3WsTRWKdD2Js9GGJM3yCCxs/jCDrHAE0Ts1QSp6l
 jC8sRXtlvjfhOf077MSoF4bBKDtRGEAfTvBkzrx0Gz4rNAQnEluFmqKhKnn8eec46c+v2Bbi
 xq34LMkwNJUXJBBnoy6kdgQ03aU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a250e.7efbf8704998-smtp-out-n01;
 Tue, 24 Mar 2020 15:19:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1452AC433CB; Tue, 24 Mar 2020 15:19:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B018FC433BA;
        Tue, 24 Mar 2020 15:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B018FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Philip Li <philip.li@intel.com>,
        kbuild test robot <lkp@intel.com>, huangwenabc@gmail.com,
        kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        libertas-dev@lists.infradead.org
Subject: Re: [kbuild-all] Re: [PATCH] libertas: Fix two buffer overflows at parsing bss descriptor
References: <20191122052917.11309-1-huangwenabc@gmail.com>
        <201911241536.lyRxx5Oc%lkp@intel.com>
        <0101016ea290854e-f5721fd1-1ca7-49ab-9c10-85277bc46c64-000000@us-west-2.amazonses.com>
        <20191125142952.GA4090@intel.com>
        <20191127182335.GA28398@roeck-us.net>
        <8437d4ba-1d2b-eae7-28e3-5af9c9d7e572@intel.com>
Date:   Tue, 24 Mar 2020 17:19:35 +0200
In-Reply-To: <8437d4ba-1d2b-eae7-28e3-5af9c9d7e572@intel.com> (Rong Chen's
        message of "Thu, 28 Nov 2019 09:53:18 +0800")
Message-ID: <87369x4w6w.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 11/28/19 2:23 AM, Guenter Roeck wrote:
>> On Mon, Nov 25, 2019 at 10:29:52PM +0800, Philip Li wrote:
>>> On Mon, Nov 25, 2019 at 12:36:50PM +0000, Kalle Valo wrote:
>>>> kbuild test robot <lkp@intel.com> writes:
>>>>
>>>>> Thank you for the patch! Perhaps something to improve:
>>>>>
>>>>> [auto build test WARNING on wireless-drivers-next/master]
>>>>> [also build test WARNING on v5.4-rc8 next-20191122]
>>>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>>>
>>>>> url:    https://github.com/0day-ci/linux/commits/huangwenabc-gmail-com/libertas-Fix-two-buffer-overflows-at-parsing-bss-descriptor/20191124-142236
>>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
>>>>> config: sh-allmodconfig (attached as .config)
>>>>> compiler: sh4-linux-gcc (GCC) 7.4.0
>>>>> reproduce:
>>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>          chmod +x ~/bin/make.cross
>>>>>          # save the attached .config to linux build tree
>>>>>          GCC_VERSION=7.4.0 make.cross ARCH=sh
>>>>>
>>>>> If you fix the issue, kindly add following tag
>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>
>>>>> All warnings (new ones prefixed by >>):
>>>>>
>>>>>     drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_ibss_join_existing':
>>>>>>> drivers/net/wireless/marvell/libertas/cfg.c:1788:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>>> I was wondering why I didn't see this mail in patchwork:
>>>>
>>>> https://patchwork.kernel.org/patch/11257187/
>>>>
>>>> And then I noticed this:
>>>>
>>>> X-Patchwork-Hint: ignore
>>>>
>>>> kbuild team, why are you adding that header? It's really bad for a
>>> thanks for the feedback, early on we received another feedback to suggest
>>> for adding this, refer to
>>> https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/issues/21
>>> for detail. Since there's no further input regarding this usage, we keep
>>> that flag. If this is not suitable, we can investigate other way to fullfill
>>> both requirements.
>>>
>> I second Kalle's comment; this is really bad.
>>
>> Note that the above referenced link suggested to add
>> 	X-Patchwork-Hint: comment
>> to e-mail headers. Instead, you added:
>> 	X-Patchwork-Hint: ignore
>> which is substantially different. Also, the problem was with a _patch_
>> sent by the robot, not with direct feedback. On top of that, the
>> suggestion was really to add "X-Patchwork-Hint: comment" to _patches_
>> sent by the robot, not to everything. It should be fine to add
>> "X-Patchwork-Hint: ignore" to patches only as long as other feedback
>> is still provided and added to patchwork. That should meet all
>> requirements.
>>
>> Thanks,
>> Guenter
>
> Hi Kalle, Guenter
>
> Thanks so much for your help, we have removed the hint header in build
> report mails and still keep it in patch mails.

This is now working perfectly, here's a recent example:

https://patchwork.kernel.org/patch/11431301/

I cannot stress enough how much seeing kbuild bot warning in patchwork
helps my work as a maintainer. So thank you Guenter for the support and
Rong fixing it!

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
