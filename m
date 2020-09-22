Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981E5273A66
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 07:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgIVFyg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 01:54:36 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:24663 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgIVFyg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 01:54:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600754075; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=pHzmG2reSFC29Cp4NZpoEQAhT0EpqirgHbl17uFxyRM=; b=g7igh0Vh/8d7bzbPMdKspS9Z8jm4Xci47UiRP9NGX+vP9JNfsXjfUSS1SXK2VqD8Gi2pPOx8
 GTsS5g6uf8eAKcFzAUcfF4C62UD8waKxA6eIJBjjfRUjUMaYOA79Yh4TtscqjDvB/BcfHKZ0
 B3rc3s4nnBc+AqHVGEFo+jv47vE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f69919bc4180d293b2d9207 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 05:54:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06590C433CA; Tue, 22 Sep 2020 05:54:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F51BC433CB;
        Tue, 22 Sep 2020 05:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F51BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
Subject: Re: [kbuild-all] Re: [PATCH v3] ath11k: cold boot calibration support
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
        <202009160303.xwD2GbBx%lkp@intel.com> <87v9g7459d.fsf@codeaurora.org>
        <fef872c3-cf44-d89d-3c3a-d305e3a702a5@intel.com>
Date:   Tue, 22 Sep 2020 08:54:29 +0300
In-Reply-To: <fef872c3-cf44-d89d-3c3a-d305e3a702a5@intel.com> (Rong Chen's
        message of "Tue, 22 Sep 2020 13:07:57 +0800")
Message-ID: <87lfh21hm2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rong Chen <rong.a.chen@intel.com> writes:

> On 9/21/20 9:40 PM, Kalle Valo wrote:
>> kernel test robot <lkp@intel.com> writes:
>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on ath6kl/ath-next]
>>> [also build test ERROR on next-20200915]
>>> [cannot apply to v5.9-rc5]
>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>> And when submitting patch, we suggest to use '--base' as documented in
>>> https://git-scm.com/docs/git-format-patch]
>>>
>>> url:
>>> https://github.com/0day-ci/linux/commits/Sowmiya-Sree-Elavalagan/ath11k-cold-boot-calibration-support/20200915-180324
>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
>>> config: mips-allmodconfig (attached as .config)
>>> compiler: mips-linux-gcc (GCC) 9.3.0
>>> reproduce (this is a W=1 build):
>>>          wget
>>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>>> -O ~/bin/make.cross
>>>          chmod +x ~/bin/make.cross
>>>          # save the attached .config to linux build tree
>>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
>>>>> ERROR: modpost: "ath11k_cold_boot_cal"
>>> [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!
>> For some reason I don't see the kbuild bot report above in patchwork:
>>
>> https://patchwork.kernel.org/patch/11775953/
>>
>> This time the message ids seem to be ok:
>>
>> Message-Id: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>> [...]
>> In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>> References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
>>
>> If anyone has ideas why patchwork doesn't see the report, please let me
>> know.
>>
>
> Hi Kalle,
>
> We hided the reports for patchwork, please see
> https://gitlab.freedesktop.org/patchwork-fdo/patchwork-fdo/-/issues/21

Didn't we discuss before and concluded that hiding the reports from
patchwork is a VERY bad idea? As it should be the opposite, the kbuild
reports should be visible in patchwork so that maintainers see them. For
example, when I'm about to apply a patch I only check the comments in
patchwork (and not from my email folder), so if the report from the bot
is not on patchwork I will not see it.

But having X-Patchwork-Hint set in the automatically created patches
sent by kbuild bot is ok, and I believe that's what kbuild bot currently
does. The bot should not set X-Patchwork-Hint in report emails.
 
Anyway, I don't think that was the problem in this case as I don't see
X-Patchwork-Hint header set in the report above.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
