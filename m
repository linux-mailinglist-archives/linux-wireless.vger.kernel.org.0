Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B733C2F2D3A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jan 2021 11:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhALKwK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jan 2021 05:52:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:43695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbhALKwK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jan 2021 05:52:10 -0500
IronPort-SDR: QzqK1ZK8UIh2lK2ilU730hRELjiloDiaQtHYb+MPYKd2rtR7qD6xOOed2Mh1/jyeJOzqFwDkTN
 kdUvgSivVHDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177245500"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="177245500"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 02:51:29 -0800
IronPort-SDR: jOPlnp/6POPGwnNmqLxGZq9E5EixLYPHTWpn4i30CbWz6l4ruNXzyWLR1wES7Fq9xSQu9AxRsz
 A6iWuNWeIigw==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="424117153"
Received: from yongchon-mobl2.ccr.corp.intel.com (HELO [10.249.173.192]) ([10.249.173.192])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 02:51:26 -0800
Subject: Re: [kbuild-all] Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace
 offload in suspend
To:     Kalle Valo <kvalo@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, kbuild-all@lists.01.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
 <202012290547.6ryYf96B-lkp@intel.com>
 <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
 <878s8zlnnc.fsf@codeaurora.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ae4b3e6f-a08c-e1ba-e5a1-494a7db7e0bd@intel.com>
Date:   Tue, 12 Jan 2021 18:51:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <878s8zlnnc.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 1/11/2021 7:27 PM, Kalle Valo wrote:
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
> 
>> On 28/12/2020 21:49, kernel test robot wrote:
>>> [auto build test ERROR on wireless-drivers-next/master]
>>
>> hmm
>>
>> works against this
>>
>> * 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add
>> localversion-wireless-testing-ath (11 days ago)
> 
> The bot tested only ath-next from ath.git, not the master branch:

Hi,

Thanks for the help, we have switched to test on master branch.

Best Regards,
Rong Chen

> 
> [auto build test ERROR on wireless-drivers-next/master]
> [also build test ERROR on wireless-drivers/master ath6kl/ath-next v5.11-rc1 next-20201223]
> 
> I'm guessing that this build error is due to some API changes in
> net-next. I'm planning to update ath.git tree today to v5.11, hopefully
> that clears up the issue.
> 
