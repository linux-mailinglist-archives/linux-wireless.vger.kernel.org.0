Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD31C273AEA
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgIVGaB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 02:30:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:22672 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbgIVGaB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 02:30:01 -0400
IronPort-SDR: v7mGy/EuYsDG/5aXeyr+IbErp3k17Idc5vi/3W19H8dr2YfIB3lW1meB4FC/8/3kXXvT+fqKRP
 7MxaU1upUuQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148207835"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="148207835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 23:30:00 -0700
IronPort-SDR: a+3AQIWzUtH9YC7Wt+92+oK/BmURLW6IQK9uvTN4GE4vrG4cj4EQpApcWiEXjSZbQVXTDnLnUm
 fpcEA243exxg==
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="334882644"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 23:29:58 -0700
Subject: Re: [kbuild-all] Re: [PATCH v3] ath11k: cold boot calibration support
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Arkadiusz Hiler <ahiler@codeweavers.com>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
 <202009160303.xwD2GbBx%lkp@intel.com> <87v9g7459d.fsf@codeaurora.org>
 <fef872c3-cf44-d89d-3c3a-d305e3a702a5@intel.com>
 <87lfh21hm2.fsf@codeaurora.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <1bdd758e-4853-680b-f8a7-d5db1d999e5c@intel.com>
Date:   Tue, 22 Sep 2020 14:29:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfh21hm2.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/22/20 1:54 PM, Kalle Valo wrote:
> Rong Chen <rong.a.chen@intel.com> writes:
>
>> On 9/21/20 9:40 PM, Kalle Valo wrote:
>>> kernel test robot <lkp@intel.com> writes:
>>>
>>>> Thank you for the patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on ath6kl/ath-next]
>>>> [also build test ERROR on next-20200915]
>>>> [cannot apply to v5.9-rc5]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch]
>>>>
>>>> url:
>>>> https://github.com/0day-ci/linux/commits/Sowmiya-Sree-Elavalagan/ath11k-cold-boot-calibration-support/20200915-180324
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
>>>> config: mips-allmodconfig (attached as .config)
>>>> compiler: mips-linux-gcc (GCC) 9.3.0
>>>> reproduce (this is a W=1 build):
>>>>           wget
>>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>>> -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
>>>>>> ERROR: modpost: "ath11k_cold_boot_cal"
>>>> [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!
>>> For some reason I don't see the kbuild bot report above in patchwork:
>>>
>>> https://patchwork.kernel.org/patch/11775953/
>>>
>>> This time the message ids seem to be ok:
>>>
>>> Message-Id: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>>> [...]
>>> In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>>> References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>>>
>>> If anyone has ideas why patchwork doesn't see the report, please let me
>>> know.
>>>
>> Hi Kalle,
>>
>> We hided the reports for patchwork, please see
>> https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/-/issues/21
> Didn't we discuss before and concluded that hiding the reports from
> patchwork is a VERY bad idea? As it should be the opposite, the kbuild
> reports should be visible in patchwork so that maintainers see them. For
> example, when I'm about to apply a patch I only check the comments in
> patchwork (and not from my email folder), so if the report from the bot
> is not on patchwork I will not see it.
>
> But having X-Patchwork-Hint set in the automatically created patches
> sent by kbuild bot is ok, and I believe that's what kbuild bot currently
> does. The bot should not set X-Patchwork-Hint in report emails.
>   
> Anyway, I don't think that was the problem in this case as I don't see
> X-Patchwork-Hint header set in the report above.
>

Hi Kalle,

Sorry for the misunderstanding, you reminded me that we do changed to
only set X-Patchwork-Hint for patches from bot, and I double checked the
original mail that there's no X-Patchwork-Hint in it, I have no idea why
patchwork can't see this report now.

Best Regards,
Rong Chen
