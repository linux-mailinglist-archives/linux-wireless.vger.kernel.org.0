Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46F7027D7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjEOJHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjEOJHO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 05:07:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E341BE;
        Mon, 15 May 2023 02:07:13 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QKYMl4LKRzLq0y;
        Mon, 15 May 2023 17:04:19 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 17:07:11 +0800
Message-ID: <d8f346e6-9227-a6c0-5cdb-1db819b7d848@huawei.com>
Date:   Mon, 15 May 2023 17:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] mac80211_hwsim: fix memory leak in
 hwsim_new_radio_nl
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <johannes@sipsolutions.net>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com>
References: <20230515034712.2425489-1-shaozhengchao@huawei.com>
 <c727aa9936c597d8297ab5659eba4e934f59349f.camel@microchip.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <c727aa9936c597d8297ab5659eba4e934f59349f.camel@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2023/5/15 16:30, Steen Hegelund wrote:
> Hi Shao,
> 
> On Mon, 2023-05-15 at 11:47 +0800, Zhengchao Shao wrote:
>> [You don't often get email from shaozhengchao@huawei.com. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> When parse_pmsr_capa failed in hwsim_new_radio_nl, the memory resources
>> applied for by pmsr_capa are not released. Add release processing to the
>> incorrect path.
>>
>> Fixes: 92d13386ec55 ("mac80211_hwsim: add PMSR capability support")
>> Reported-by: syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/wireless/virtual/mac80211_hwsim.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c
>> b/drivers/net/wireless/virtual/mac80211_hwsim.c
>> index 9a8faaf4c6b6..6a50858a5645 100644
>> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
>> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
>> @@ -5965,8 +5965,10 @@ static int hwsim_new_radio_nl(struct sk_buff *msg,
>> struct genl_info *info)
>>                          goto out_free;
>>                  }
>>                  ret = parse_pmsr_capa(info->attrs[HWSIM_ATTR_PMSR_SUPPORT],
>> pmsr_capa, info);
>> -               if (ret)
>> +               if (ret) {
>> +                       kfree(pmsr_capa);
> 
> This should not be needed, see below.
> 
>>                          goto out_free;
>> +               }
>>                  param.pmsr_capa = pmsr_capa;
> 
> 
> Why don't you just move this line up before the parse_pmsr_capa as there is
> already a kfree(param.pmsr_capa) under the out_free label?
> 

Hi Steen:
	Your suggestion looks good. I will send V2.

Zhengchao Shao

>>          }
>>
>> --
>> 2.34.1
>>
>>
> 
> BR
> Steen
