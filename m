Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F4563478
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 15:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiGANkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGANkV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 09:40:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16C414D14
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656682820; x=1688218820;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6V/J17CTcEOpi2wnR6rdzq3pXlwGa7b9Lzasu3/p9CU=;
  b=JlM4Umhg5h+VgMyuq53j3CdH+OZCj0U+KBDDP1zW+l3Y3rQjxmZLBpBr
   gqElZ5Yh1nExXMysK7MQ+kXqHXPmoUm/5zI9AHwE8h/H+4EZBpKQaKfvz
   INZS6YdXbq6Aac9enNi3cKfldp0AxJmasMCISy/iqNovzZLopinJ99j4L
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Jul 2022 06:40:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:40:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 1 Jul 2022 06:40:20 -0700
Received: from [10.201.27.145] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 1 Jul 2022
 06:40:18 -0700
Message-ID: <1d9a2b03-82c2-593c-d4ae-7f3cba6cecfe@quicinc.com>
Date:   Fri, 1 Jul 2022 19:10:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] mac80211: fix mesh airtime link metric estimating
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220601070115.24340-1-quic_adisi@quicinc.com>
 <83e4ceafddc3227934b520368dcc2cdca680171d.camel@sipsolutions.net>
Content-Language: en-US
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <83e4ceafddc3227934b520368dcc2cdca680171d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/1/2022 15:01, Johannes Berg wrote:
> On Wed, 2022-06-01 at 12:31 +0530, Aditya Kumar Singh wrote:
>>
>> +	/* use rate info set by the driver directly if present */
>> +	if (st->rate)
>> +		rinfo = sta->tx_stats.last_rate_info;
>>
> 
> This doesn't apply anymore due to 44fa75f207d8 ("mac80211: extend
> current rate control tx status API") and the MLO work.
> 
> johannes
Yes correct. Sure, I will re-base to latest HEAD and resend v2.

- Aditya Kumar Singh
