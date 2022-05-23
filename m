Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570425314C4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiEWN2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiEWN2C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 09:28:02 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B583B008
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653312461; x=1684848461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kHc3KqmBdM6mJvbqMYy3nEBSN+7+RCaWf3X3ZqoKU70=;
  b=JqO930CMe7+GPMP1G/laj8bpga6QH08REhoijvjDy7Bbt1lOZFBCGpN7
   oKX4/8Cr8+pPlfHNtwFLhvA/Cl9F2YWR/M2gTOYR9uSqVtWp4xT8XLjjK
   y3MKx+AXOMwWRr8dzupRqqx44JyjL4Afji9LmbYKxQ08CHemgggTsGXGb
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 May 2022 06:27:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 06:27:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 06:27:41 -0700
Received: from [10.216.30.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 06:27:39 -0700
Message-ID: <12c8d629-86b0-1cd9-18f2-eeafccf36714@quicinc.com>
Date:   Mon, 23 May 2022 18:57:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3] cfg80211: Increase akm_suites array size in
 cfg80211_crypto_settings
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1653024702-5304-1-git-send-email-quic_vjakkam@quicinc.com>
 <a8a3b56b-5e82-28cb-bd61-e338bae25df2@quicinc.com>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <a8a3b56b-5e82-28cb-bd61-e338bae25df2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/20/2022 9:45 PM, Jeff Johnson wrote:
> On 5/19/2022 10:31 PM, Veerendranath Jakkam wrote:
>> Increase akm_suites array size in struct cfg80211_crypto_settings to 10
>> and advertise the capability to userspace. This allows userspace to send
>> more than two AKMs to driver in netlink commands such as
>> NL80211_CMD_CONNECT.
>>
>
> I have some grammar nits below...
>> This capability needed for implementing WPA3-Personal transition mode
>
> capability *is* needed
>
>> correctly with any driver that handles roaming internally. Currently,
>> the possible AKMs for multi-AKM connect can include PSK, PSK-SHA-256,
>> SAE, FT-PSK and FT-SAE since the count is already 5, Increasing
>
> ...and FT-SAE. Since the count is already 5, increasing...
>
>> the akm_suites array size to 10 should be reasonable for future
>> usecases.
>
> /jeff


Thanks Jeff. Fixed the suggested grammar nits in v5

--

veeru

