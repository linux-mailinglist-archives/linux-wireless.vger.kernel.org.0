Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170554C0155
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Feb 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiBVScT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Feb 2022 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiBVScS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:18 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2925256C02
        for <linux-wireless@vger.kernel.org>; Tue, 22 Feb 2022 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645554713; x=1677090713;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=LV6Zm+ZVrJRsqdDTLAlS397AQHPFGeLdrjuiXnbKyGw=;
  b=fLoJAJoyZkFzUtB+aEegOeiDfaDMWB1ELFa97og//6/Vtylq2CjdKKM+
   PBL5AneezXxPr2LAKKSIJiR0qIWHVLGiUUA9+osBMbrebD6B5e/BSzAzf
   pKdHvf9AaGe5DwvgySVSFhdZWuu3TR/WqEeufNZeoPnLBvhsyJHrfkGp1
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Feb 2022 10:31:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:31:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Feb 2022 10:31:37 -0800
Received: from [10.234.232.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 22 Feb
 2022 10:31:37 -0800
Message-ID: <857cd0ff-ee5b-65d1-2888-5d6be93976c0@quicinc.com>
Date:   Tue, 22 Feb 2022 10:31:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
Content-Language: en-US
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
 <20220214223051.3610-3-quic_alokad@quicinc.com>
 <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
 <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
In-Reply-To: <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 2/15/2022 4:37 PM, Aloka Dixit wrote:
> On 2/15/2022 12:19 AM, Johannes Berg wrote:
>> On Mon, 2022-02-14 at 14:30 -0800, Aloka Dixit wrote:
>>>
>>> +
>>> +bool cfg80211_ru_punct_bitmap_valid(const struct cfg80211_chan_def 
>>> *chandef)
>>
>> Conceptually, I'm wondering if it really belongs into the chandef? Can
>> you explain why it's part of the channel configuration? If you've got
>> two chandefs with the same control channel, CCFS and bandwidth, but
>> different puncturing, does it really make sense to treat them as two
>> separate channel contexts, e.g. in mac80211? It seems strange to do
>> that.
>>
>> johannes
> 
> Added it here so that any command working with chandef will be updated 
> without any other change.
> Example: During channel switch, user can provide a puncturing bitmap 
> with a new option I added in userspace, and because it is part of 
> chandef, the same code path validates it for that command automatically.
> 
> Regarding if different puncturing pattern should be considered as a new 
> context - yes, depending on if it is HE or non-HE mode, the new bitmap 
> may be invalid and the operation should fail.
> 
> Thanks,
> Aloka


Hi Johannes,
Any comments on the above. Thanks.
