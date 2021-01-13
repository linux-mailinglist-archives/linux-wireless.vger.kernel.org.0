Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338432F416E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 02:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbhAMB67 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 20:58:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:59524 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbhAMB67 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 20:58:59 -0500
IronPort-SDR: JJJkmFOxAO6VFR3JqMjFKPsBns4dthduZJ4KTPGKMXLwRB8FFQue/3Rp+zUh16OZ6dG7eaNiOF
 oryYvYo5qgZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174628358"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="174628358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:58:17 -0800
IronPort-SDR: wXy5/s4dFTNXnmTzpL9m3RnBZB8z6liFqxsZDLrRll5/6tUHUhs7Nv8uDD/o4Kz+h4NYLopIjr
 VbDmFwcX26gA==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="381657778"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 17:58:15 -0800
Subject: Re: [kbuild-all] Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace
 offload in suspend
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kernel test robot <lkp@intel.com>,
        wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        kbuild-all@lists.01.org, shawn.guo@linaro.org, benl@squareup.com,
        loic.poulain@linaro.org
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
 <202012290547.6ryYf96B-lkp@intel.com>
 <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
 <878s8zlnnc.fsf@codeaurora.org>
 <ae4b3e6f-a08c-e1ba-e5a1-494a7db7e0bd@intel.com>
 <877doitnd8.fsf@codeaurora.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <851a3629-8d18-08a7-2926-67dd45cabbed@intel.com>
Date:   Wed, 13 Jan 2021 09:57:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877doitnd8.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/12/21 7:18 PM, Kalle Valo wrote:
> "Chen, Rong A" <rong.a.chen@intel.com> writes:
>
>> On 1/11/2021 7:27 PM, Kalle Valo wrote:
>>> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>>>
>>>> On 28/12/2020 21:49, kernel test robot wrote:
>>>>> [auto build test ERROR on wireless-drivers-next/master]
>>>> hmm
>>>>
>>>> works against this
>>>>
>>>> * 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add
>>>> localversion-wireless-testing-ath (11 days ago)
>>> The bot tested only ath-next from ath.git, not the master branch:
>> Hi,
>>
>> Thanks for the help, we have switched to test on master branch.
> The bot was correctly testing the ath-next branch, as I use that branch
> to commit the patches. Can you still change the bot back to use
> ath-next, just as it did previously?
>
> Sorry for the confusion.
>

Got it, we'll still test ath-next branch.

Best Regards,
Rong Chen
