Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EA47701FF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 15:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjHDNju (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHDNja (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 09:39:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007849D8;
        Fri,  4 Aug 2023 06:39:21 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHR8g0bVlztR79;
        Fri,  4 Aug 2023 21:17:39 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 21:21:02 +0800
Subject: Re: [PATCH] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
To:     Simon Horman <horms@kernel.org>
CC:     <johannes@sipsolutions.net>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230803134248.42652-1-yuehaibing@huawei.com>
 <ZMvr2lNVTPLqs8Nq@kernel.org>
From:   Yue Haibing <yuehaibing@huawei.com>
Message-ID: <57db587d-c845-5ff5-7b6d-c4196a105fb4@huawei.com>
Date:   Fri, 4 Aug 2023 21:21:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <ZMvr2lNVTPLqs8Nq@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2023/8/4 2:03, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 09:42:48PM +0800, Yue Haibing wrote:
>> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
>> declared but never implemented this, remove it.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  include/net/iw_handler.h | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
>> index d2ea5863eedc..99f46f521aa7 100644
>> --- a/include/net/iw_handler.h
>> +++ b/include/net/iw_handler.h
>> @@ -432,9 +432,6 @@ struct iw_public_data {
>>  
>>  /* First : function strictly used inside the kernel */
>>  
> 
> Hi Yue Haibing,
> 
> I think you can remove the comment above and blank line below it too.
> 
>> -/* Handle /proc/net/wireless, called in net/code/dev.c */
>> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
>> -
>>  /* Second : functions that may be called by driver modules */
> 
> And work this into the comment above the to be deleted 'First :' comment.
> Something like this:

Thanks, will rework.
> 
> /*
>  * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
>  * These may be called by driver modules.
>  */ 
> 
>>  
>>  /* Send a single event to user space */
>> -- 
>> 2.34.1
>>
>>
> .
> 
