Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BA67BAF60
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 01:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjJEXjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 19:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJEXjC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 19:39:02 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F98AE7
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 16:39:01 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3E1902C006C;
        Thu,  5 Oct 2023 23:38:59 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 91B6713C2B0;
        Thu,  5 Oct 2023 16:38:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 91B6713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1696549138;
        bh=VEMoDBukjCDX99Abs1IDmwidxRDC+f6alGTuu90HfJI=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=Ton1bZP5n09ngrJPb9m8QkhTkZyHnKHviEdjKIfIU/KmAv5W2jLNh9auMrMHsFdx9
         VAqu4Lj4shlsVsi2Hjc3FwGDMXn5rn17cf7kNIdeE4U8n804mpKod5vUosMyzQGRoY
         7k8wmPbseT56MtHP04HfapbaC1/n47MVouc72oWk=
Message-ID: <b6cb54b5-4c37-8c88-beb3-5fc14bb1aaee@candelatech.com>
Date:   Thu, 5 Oct 2023 16:38:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mac80211: Allow STA to connect in AX mode to MLD AP.
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20231003164326.857433-1-greearb@candelatech.com>
 <4ae5a8dbe80e0eb0b96e9165892746fc3b3e9197.camel@sipsolutions.net>
 <22462d21-86c0-a2f0-265f-044bfb14719a@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <22462d21-86c0-a2f0-265f-044bfb14719a@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1696549140-4_9Y3U0dyZIu
X-MDID-O: us5;at1;1696549140;4_9Y3U0dyZIu;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/4/23 13:36, Ben Greear wrote:
> On 10/4/23 12:38, Johannes Berg wrote:
>> On Tue, 2023-10-03 at 09:43 -0700, greearb@candelatech.com wrote:
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> Check if user has configured STA to be AX mode, and if so,
>>> skip the check for MLD elements (as they would not be needed
>>> in AX mode).
>>
>> Eh, no, I think this is wrong.
>>
>>>
>>>           if (ieee80211_vif_is_mld(&sdata->vif)) {
>>
>> If you get past this if, you've (locally) committed to doing EHT
>> already, not just HE (née 11ax), so should have an EHT connection?
>>
>> Though the change is hard to read - but why are you telling the
>> supplicant to connect with MLO if you wanted to not use EHT?
> 
> It is mostly white-space changes, but the diff is ugly.
> 
> I caused the DISABLE_EHT flag to be set in mac80211, and that generally
> seems to work in my kernel, but something is still trying to do MLO I guess.
> 
> I did not specifically tell supplicant to do MLO, and in fact I told
> it to disable_be, but maybe that is not fully implemented.  My supplicant
> is a few months old vs upstream at this point.

I created a patch to supplicant where it will disable MLO if disable_eht
is true, and that seems to have properly associated a non-MLO station
in AX mode.

So I agree that my patch to the kernel is not needed.

Thanks for the patch review and comments.

Thanks,
Ben

