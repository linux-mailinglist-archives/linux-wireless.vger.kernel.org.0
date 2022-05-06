Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8619751DF52
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388812AbiEFS5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 14:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiEFS5D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 14:57:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D04EA28
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651863199; x=1683399199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SuwMv52npbNXfx0kPG8/lbGKnvjrMZBj3O5gaNNh3Dc=;
  b=HSyKHdeHUng0CVTN6B8PlULTOFBNl4d5Cfte9EX/AyLqCAE341BP9XiF
   D2ynj7zS1pxYSXUbkCspNniNSkYGFAyr595AtvBj0UeDjzYTfs5DLVjmd
   7j35RIJ5zX05ioZ+K8fnl0FMBX2BDjzsvtXIInZp1o0rKklXB2g5qa/9E
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 May 2022 11:53:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 11:53:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 11:53:19 -0700
Received: from [10.48.240.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 11:53:18 -0700
Message-ID: <49e5ab55-c7db-5861-4eb4-bc68dc814084@quicinc.com>
Date:   Fri, 6 May 2022 11:53:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/2] nl80211: process additional attributes in
 NL80211_CMD_SET_BEACON
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220505173449.4424-1-quic_alokad@quicinc.com>
 <20220505173449.4424-2-quic_alokad@quicinc.com>
 <5235cf9e-ad4c-3557-e1ee-d4ece1187652@quicinc.com>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <5235cf9e-ad4c-3557-e1ee-d4ece1187652@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/6/2022 11:22 AM, Jeff Johnson wrote:
> On 5/5/2022 10:34 AM, Aloka Dixit wrote:
>> -    struct cfg80211_beacon_data params;
>> +    struct cfg80211_ap_settings params;
>>       int err;
>> +    memset(&params, 0, sizeof(params));
>> +
> 
> is adding an = {} initializer preferable?
> 

I will change this from static to dynamic allocation in the next version 
instead because noticed following error with some compiler:
error: the frame size of 1032 bytes is larger than 1024 bytes 
[-Werror=frame-larger-than=]

>> +    if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
>> +        err = nl80211_parse_unsol_bcast_probe_resp(
>> +                rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
>> +                &params);
>> +        if (err)
>> +            goto out;
>> +    }
>> +
> 
> would adding a local variable 'attr' make the code more readable?
>      attr = info->attrs[NL80211_ATTR_{foo}];
>      if (attr) {
>          err = nl80211_parse_{foo}(rdev, attr, &params);
> 

Sure, thanks.
