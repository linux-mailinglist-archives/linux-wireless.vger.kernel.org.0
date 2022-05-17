Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ECC52AB3F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352391AbiEQSxb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352384AbiEQSx3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 14:53:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD4A4D9F2
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652813608; x=1684349608;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NZ7QfWWKe4HoEz0KEoJxO28mS9MCd0dmXFhU4YO+Ha4=;
  b=CyQLj2FKWjBtc22/f/4TG+WItfVLATN/m7r7+XdEOQuoH0zACTyXXqGJ
   U4SaHw4gix+z4T14vfgkCGmiLLkiuAMzj0LqiTq4Q42Kv1GJeoN1SeB61
   5A4kKI71kmQEEOC2zFyumndC5wrfzhlKsJUzcBNT4Tpko/CK1QxqcZVIq
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 May 2022 11:53:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 11:53:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 17 May 2022 11:53:27 -0700
Received: from [10.48.243.147] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 11:53:26 -0700
Message-ID: <1602f8ad-4d2c-82d3-a3e5-15c981b815b1@quicinc.com>
Date:   Tue, 17 May 2022 11:53:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 1/3] cfg80211: additional processing in
 NL80211_CMD_SET_BEACON
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220516202454.4925-1-quic_alokad@quicinc.com>
 <20220516202454.4925-2-quic_alokad@quicinc.com> <87v8u4wyw4.fsf@kernel.org>
 <c41731aea4fc043bad1ab6db724c2283df0a3d42.camel@sipsolutions.net>
From:   Aloka Dixit <quic_alokad@quicinc.com>
In-Reply-To: <c41731aea4fc043bad1ab6db724c2283df0a3d42.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/17/2022 3:50 AM, Johannes Berg wrote:
> On Tue, 2022-05-17 at 07:45 +0300, Kalle Valo wrote:
>>
>>> +++ b/include/net/cfg80211.h
>>> @@ -4200,7 +4200,7 @@ struct cfg80211_ops {
>>>   	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
>>>   			    struct cfg80211_ap_settings *settings);
>>>   	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
>>> -				 struct cfg80211_beacon_data *info);
>>> +				 struct cfg80211_ap_settings *info);
>>
>> Shouldn't patch 3 folded into patch 1? I don't see how patch 1 as is
>> would compile without warnings.
>>
> Yes, and parts of patch 2 as well.
> 
> johannes


Little confused now between above comments and the following one:
https://patchwork.kernel.org/project/linux-wireless/patch/20220509225237.15955-1-quic_alokad@quicinc.com/

Even if all driver changes from patch #3 are put with patch #1, it still 
won't compile successfully without patch #2. Hence I had added all files 
in a single patch for v4.

I'm now thinking that what you meant is split the actual FILS discovery 
processing in a separate patch but keep the API changes (cfg80211, 
mac80211 and drivers) in the first patch file.

Will do that in the next version.

Thanks
