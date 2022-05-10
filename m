Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE4522493
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 21:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiEJTRR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiEJTRQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 15:17:16 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CC2609E1
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 12:17:14 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.179])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 43CAD2006B;
        Tue, 10 May 2022 19:17:13 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ED74CAC0082;
        Tue, 10 May 2022 19:17:12 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 71BEF13C2B0;
        Tue, 10 May 2022 12:17:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 71BEF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1652210232;
        bh=a+DETeVVzyxfwDRqN/z04fSHCz58SMe4mhdhxXlnLro=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=T7E7CkmF0S5TnxcUp7LhVlZO2sXy5aS7Xq1YM6K0X+7aG6Gk07sFnwqq6vErPmNz8
         V4dTp8Nh+iPZuVH3JTaY1jKiNkyip7UFBGZwXuH0cUK2k89vmpOPxTrWhDf21+5bit
         kVm6ZiOHL95MEYum0mP6xgD8KsmiGXAMRNIGe+XM=
Subject: Re: AP + STA on DFS channel breaks DFS detection.
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <c937f0dc-5be7-8986-01a5-152c6b20e868@candelatech.com>
 <4281590ec280540e52202e052a23cbba3a33a474.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f90b2b0f-df5c-88e7-8417-c0060f386779@candelatech.com>
Date:   Tue, 10 May 2022 12:17:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4281590ec280540e52202e052a23cbba3a33a474.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1652210233-hmcHmPVXYDUb
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/10/22 7:31 AM, Johannes Berg wrote:
> On Wed, 2022-04-27 at 14:32 -0700, Ben Greear wrote:
>> I am using 5.17.4+ kernel, MT7915 radios.  One radio (wiphy0) is acting as AP on
>> channel 132.  It starts, does CAC and starts working fine.
>>
>> Then, I bring up a station on wiphy1 (on same machine).  The STA connects to the AP
>> on wiphy0 and starts running traffic for a short time (usually < 1 minute).  And then
>> the AP gets stopped.  I don't think this is specific to connecting AP to STA on same machine,
>> probably if STA connected to another AP on channel 132 it would have same issue.
>>
>> I think I have tracked this down by adding prints and WARN_ON to find
>> the interesting state changes.  It looks like when the STA changes its
>> regdom (probably because it is admin-up and/or associated to the AP), then the state of the
>> channel's dfs_state is reset.  Channel objects are per band, not per wiphy.
> 
> Actually, they are per wiphy, unless the driver sets up something else?
> I couldn't really figure out the code there, but it looked dynamically
> allocated, so not sure...
> 
>> And then a bit later, a timer kicks off and decides that CAC has not completed
>> (because it already completed earlier on the AP, but chan->dfs_state was lost,
>> and STA will not do CAC anyway.)
>>
>> So, question is, how in the world to fix this properly!
>>
> 
> Good question!
> 
> But I'm not sure your description of this is quite right - the point
> isn't that the channels are shared, the point is that you're getting to
> update_all_wiphy_regulatory() which does update _all_ of the devices,
> since you've just switched the regulatory domain.

It is a tangled mess of code, but if I understand it properly, the channel objects
*are* shared between wiphy devices, and...not sure it really matters either way,
since logically the regdom stuff is combined and then the values that are actually
used are the subset that is supported by all regdom configuration?  Maybe there
are special cases to that for things like iwlwifi that does its own regdom
stuff too...but I was only using mtk radios int his particular test case.

> 
> I guess if the rules are identical on a given channel before/after the
> regdomain switch, we might get away with not resetting the dfs_state?

Yes, and it seems very painful to properly make that determination the way
the regdom code is currently implemented:  I could not see a clean way to grab
a 'before' and 'after' snapshot to compare against.  During the regdom rebuild process,
the regdom changes with each new regdom input applied, so you cannot really check
incremental changes to detect a change in the end result.

Thanks,
Ben

> 
> johannes
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

