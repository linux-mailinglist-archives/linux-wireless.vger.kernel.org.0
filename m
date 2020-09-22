Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883F273A05
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgIVFIk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:08:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:25727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgIVFIk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:08:40 -0400
IronPort-SDR: QDix34jDfMdZwC7RCB7xNqKU7U83y8Weu6N7QqUsmgRV8EebPjNZjP0GIQeO0H5FItS8E8k/En
 rJENyYrD5ZbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222126429"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="222126429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 22:08:40 -0700
IronPort-SDR: fn1+MUgA98m8APppssuckfpm6YMymrFrbRNG3QVi/fvFRcTTHZ5Stz0f7NiKfNZjJeG9ipUxQk
 pFoi26Nf++3A==
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="334851899"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 22:08:38 -0700
Subject: Re: [kbuild-all] Re: [PATCH v3] ath11k: cold boot calibration support
To:     Kalle Valo <kvalo@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Cc:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kbuild-all@lists.01.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
 <202009160303.xwD2GbBx%lkp@intel.com> <87v9g7459d.fsf@codeaurora.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <fef872c3-cf44-d89d-3c3a-d305e3a702a5@intel.com>
Date:   Tue, 22 Sep 2020 13:07:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87v9g7459d.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/21/20 9:40 PM, Kalle Valo wrote:
> kernel test robot <lkp@intel.com> writes:
>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on ath6kl/ath-next]
>> [also build test ERROR on next-20200915]
>> [cannot apply to v5.9-rc5]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Sowmiya-Sree-Elavalagan/ath11k-cold-boot-calibration-support/20200915-180324
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
>> config: mips-allmodconfig (attached as .config)
>> compiler: mips-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
>>>> ERROR: modpost: "ath11k_cold_boot_cal"
>> [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!
> For some reason I don't see the kbuild bot report above in patchwork:
>
> https://patchwork.kernel.org/patch/11775953/
>
> This time the message ids seem to be ok:
>
> Message-Id: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
> [...]
> In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
> References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>
> If anyone has ideas why patchwork doesn't see the report, please let me
> know.
>

Hi Kalle,

We hided the reports for patchwork, please see 
https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/-/issues/21

Best Regards,
Rong Chen
