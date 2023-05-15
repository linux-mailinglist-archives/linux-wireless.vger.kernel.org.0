Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F305702B0D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbjEOLHR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 07:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjEOLHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 07:07:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE3E5B;
        Mon, 15 May 2023 04:07:14 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKc0Z4yXVzqSLx;
        Mon, 15 May 2023 19:02:54 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 19:07:12 +0800
Message-ID: <49995bdd-c29a-856c-3f92-398852a2705e@huawei.com>
Date:   Mon, 15 May 2023 19:07:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v2] mac80211_hwsim: fix memory leak in
 hwsim_new_radio_nl
To:     Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jaewan@google.com>, <steen.hegelund@microchip.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com>
References: <20230515092227.2691437-1-shaozhengchao@huawei.com>
 <87ilctn9ip.fsf@kernel.org>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <87ilctn9ip.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2023/5/15 19:01, Kalle Valo wrote:
> Zhengchao Shao <shaozhengchao@huawei.com> writes:
> 
>> When parse_pmsr_capa failed in hwsim_new_radio_nl, the memory resources
>> applied for by pmsr_capa are not released. Add release processing to the
>> incorrect path.
>>
>> Fixes: 92d13386ec55 ("mac80211_hwsim: add PMSR capability support")
>> Reported-by: syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: move the value assigned to pmsr_capa before parse_pmsr_capa
>> ---
>>   drivers/net/wireless/virtual/mac80211_hwsim.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> drivers/net/wireless changes go to wireless-next, not net-next. But no
> need to resend because of this.
> 

Thank you for the reminder. I will pay attention next time.

Zhengchao Shao
