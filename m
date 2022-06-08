Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656A5429F0
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiFHIxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiFHIw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A921BEA4
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654675833; x=1686211833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r2irToGGOWp7Cq5lhJLCsoXuf9Hr9rpMcSW/+D9AlXI=;
  b=fdcpAfLXja1vxWB0G+wwmSDdI2pddqkP5HUtcstgkmMbWdmDPVeoPe6x
   yxv3sYQAPl9kjaSuZYYQ2s2Z/HFoYhGoJGEFgwZOhBvqYzFunIiK8Z0Xp
   cOPNPubTexjHONcLVgZJardAErs41eNODDfXxBliJHmlnajWC0+5bD8jK
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2022 01:10:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 01:10:32 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 01:10:32 -0700
Received: from [10.216.28.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 01:10:31 -0700
Message-ID: <2a8e08b3-4c93-4a29-a2ac-8f7c122e1aaa@quicinc.com>
Date:   Wed, 8 Jun 2022 13:40:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
 <a2cc93f959394a3430755d4664d9f2abeabb3ab7.camel@sipsolutions.net>
 <e75ddf50-348b-eaf2-4033-6a32ef65a41c@quicinc.com>
 <3fa8911111ff380615ca5b3ffcd61644fae5e8ea.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <3fa8911111ff380615ca5b3ffcd61644fae5e8ea.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 6/8/2022 1:29 PM, Johannes Berg wrote:
> On Wed, 2022-06-08 at 13:15 +0530, Veerendranath Jakkam wrote:
>> On 6/8/2022 1:01 PM, Johannes Berg wrote:
>>> On Mon, 2022-06-06 at 23:01 +0530, Veerendranath Jakkam wrote:
>>>
>>>> +	if (cr->status == WLAN_STATUS_SUCCESS) {
>>>> +		for_each_valid_link(cr, link) {
>>>> +			if (!cr->links[link].bss)
>>>> +				break;
>>>> +		}
>>>> +
>>>> +		WARN_ON_ONCE((!cr->valid_links && link != 1) ||
>>>> +			     (cr->valid_links &&
>>>> +			      link != ARRAY_SIZE(wdev->links)));
>>>> +
>>> I will say I'm not super happy with using the link variable after the
>>> loop, that always feels a bit magic to me, especially if the loop is
>>> hidden like that...
>>>
>>> But I guess I don't see a lot of alternatives here, other than open-
>>> coding it, or keeping track of "how many BSSes do I have".
>>
>> Since we need to WARN even if single BSS is not present I think we can
>> use "bss_not_found" flag?
>>
>>> Actually, for the MLO case, is this even valid? link[14] could be set,
>>> so you wouldn't break, ending up with link==15? Or am I confused?
>> In MLO case the link value will be always 15 after loop completes if
>> bsses are available for all valid links since the check is only for the
>> valid links
>>
>> so, In above case also when "link==15" the condition fails and WARN will
>> be skipped right.
>>
> Ah, indeed. I was thinking of the 'break', but you only get there for
> valid links and the valid links should indeed have a .bss pointer.
>
> OK, so I guess let's leave it as is, that way we check both cases
> accurately.
>
> johannes


Now I am thinking we can simply do like this. Sorry,  somehow I made it 
complex earlier.. :)

+	if (cr->status == WLAN_STATUS_SUCCESS) {
+		for_each_valid_link(cr, link) {
+			if (WARN_ON_ONCE(!cr->links[link].bss))
+				break;
+		}

