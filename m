Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80E910C1F9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 02:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfK1Bxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 20:53:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:5361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728092AbfK1Bxp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 20:53:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:53:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="203276758"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2019 17:53:42 -0800
Subject: Re: [kbuild-all] Re: [PATCH] libertas: Fix two buffer overflows at
 parsing bss descriptor
To:     Guenter Roeck <linux@roeck-us.net>,
        Philip Li <philip.li@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     kbuild test robot <lkp@intel.com>, huangwenabc@gmail.com,
        kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        linux-distros@vs.openwall.org, security@kernel.org,
        libertas-dev@lists.infradead.org
References: <20191122052917.11309-1-huangwenabc@gmail.com>
 <201911241536.lyRxx5Oc%lkp@intel.com>
 <0101016ea290854e-f5721fd1-1ca7-49ab-9c10-85277bc46c64-000000@us-west-2.amazonses.com>
 <20191125142952.GA4090@intel.com> <20191127182335.GA28398@roeck-us.net>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <8437d4ba-1d2b-eae7-28e3-5af9c9d7e572@intel.com>
Date:   Thu, 28 Nov 2019 09:53:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191127182335.GA28398@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/28/19 2:23 AM, Guenter Roeck wrote:
> On Mon, Nov 25, 2019 at 10:29:52PM +0800, Philip Li wrote:
>> On Mon, Nov 25, 2019 at 12:36:50PM +0000, Kalle Valo wrote:
>>> kbuild test robot <lkp@intel.com> writes:
>>>
>>>> Thank you for the patch! Perhaps something to improve:
>>>>
>>>> [auto build test WARNING on wireless-drivers-next/master]
>>>> [also build test WARNING on v5.4-rc8 next-20191122]
>>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/huangwenabc-gmail-com/libertas-Fix-two-buffer-overflows-at-parsing-bss-descriptor/20191124-142236
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
>>>> config: sh-allmodconfig (attached as .config)
>>>> compiler: sh4-linux-gcc (GCC) 7.4.0
>>>> reproduce:
>>>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>          chmod +x ~/bin/make.cross
>>>>          # save the attached .config to linux build tree
>>>>          GCC_VERSION=7.4.0 make.cross ARCH=sh
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>     drivers/net/wireless/marvell/libertas/cfg.c: In function 'lbs_ibss_join_existing':
>>>>>> drivers/net/wireless/marvell/libertas/cfg.c:1788:3: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>> I was wondering why I didn't see this mail in patchwork:
>>>
>>> https://patchwork.kernel.org/patch/11257187/
>>>
>>> And then I noticed this:
>>>
>>> X-Patchwork-Hint: ignore
>>>
>>> kbuild team, why are you adding that header? It's really bad for a
>> thanks for the feedback, early on we received another feedback to suggest
>> for adding this, refer to https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/issues/21
>> for detail. Since there's no further input regarding this usage, we keep
>> that flag. If this is not suitable, we can investigate other way to fullfill
>> both requirements.
>>
> I second Kalle's comment; this is really bad.
>
> Note that the above referenced link suggested to add
> 	X-Patchwork-Hint: comment
> to e-mail headers. Instead, you added:
> 	X-Patchwork-Hint: ignore
> which is substantially different. Also, the problem was with a _patch_
> sent by the robot, not with direct feedback. On top of that, the
> suggestion was really to add "X-Patchwork-Hint: comment" to _patches_
> sent by the robot, not to everything. It should be fine to add
> "X-Patchwork-Hint: ignore" to patches only as long as other feedback
> is still provided and added to patchwork. That should meet all
> requirements.
>
> Thanks,
> Guenter

Hi Kalle, Guenter

Thanks so much for your help, we have removed the hint header in build 
report mails and
still keep it in patch mails.

Best Regards,
Rong Chen

>
>>> maintainer like me who uses patchwork actively, it means that all these
>>> important warnings are not visible in patchwork and can be easily missed
>>> by the maintainers.
>>>
>>> -- 
>>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>>> _______________________________________________
>>> kbuild-all mailing list -- kbuild-all@lists.01.org
>>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

