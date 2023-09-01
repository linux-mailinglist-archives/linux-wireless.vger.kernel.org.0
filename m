Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6778FA8A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347991AbjIAJRo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjIAJRo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 05:17:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3279DB5;
        Fri,  1 Sep 2023 02:17:41 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RcXSs6wNpz1L9Ft;
        Fri,  1 Sep 2023 17:15:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:17:38 +0800
Message-ID: <abb4efba-90b4-da14-5683-3cd96819a5e0@huawei.com>
Date:   Fri, 1 Sep 2023 17:17:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net,v2] wifi: mac80211: fix WARNING in
 ieee80211_link_info_change_notify()
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230901035301.3473463-1-shaozhengchao@huawei.com>
 <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <7127fe5a4f2cfcdc3a55269f0a427477e264fabc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 2023/9/1 14:32, Johannes Berg wrote:
> On Fri, 2023-09-01 at 11:53 +0800, Zhengchao Shao wrote:
>>
>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>> index 24315d7b3126..f79e2343dddd 100644
>> --- a/net/mac80211/main.c
>> +++ b/net/mac80211/main.c
>> @@ -285,6 +285,9 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
>>   	if (!changed || sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
>>   		return;
>>   
>> +	if (!ieee80211_sdata_running(sdata))
>> +		return;
>> +
>>   	if (!check_sdata_in_driver(sdata))
>>   		return;
>>
> 
> I don't think this is right. Do you see anything else checking that it's
> running right before checking it's in the driver? :)
> 
> Why can we even get into this call at all? I think the problem is
> already in cfg80211 allowing this.
> 
> johannes
> 

Hi johannes:
	Do you mean it shouldn't be allowed to set mcast rate when dev
is stopped, as in the following code?

--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1229,7 +1229,7 @@ rdev_set_mcast_rate(struct 
cfg80211_registered_device *rdev,
         int ret = -ENOTSUPP;

         trace_rdev_set_mcast_rate(&rdev->wiphy, dev, mcast_rate);
-       if (rdev->ops->set_mcast_rate)
+       if (rdev->ops->set_mcast_rate && netif_running(dev))
                 ret = rdev->ops->set_mcast_rate(&rdev->wiphy, dev, 
mcast_rate);
         trace_rdev_return_int(&rdev->wiphy, ret);
         return ret;


Thank you

Zhengchao Shao
