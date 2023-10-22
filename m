Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02AD7D2553
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjJVSbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 14:31:08 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFDAE0
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 11:31:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DDFD09C0061;
        Sun, 22 Oct 2023 18:31:01 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.115.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1AEA713C2B0;
        Sun, 22 Oct 2023 11:31:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1AEA713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1697999461;
        bh=IvUm6CLxAh5K+bEKgJ/6vshzfMblN9ozFAOHDJzxQDI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XgaqzUQhNuooxsvGmP+d0ctaS9fDuOUpSvGwEW7E6dZ5zfog65DcnMDm/hrl+SJcn
         Vk2CZhDmOBEIYuYMzUnWbB4CLJ1jkz2tQaS0VmyjvP/1a9JTP28lMXlgDXdmvOYlcJ
         R/Po3ydiGQ8uUfAQ8os7EepwHNRt2/DzGDNTeQw0=
Subject: Re: [PATCH] wifi: wireless: Fix bad memory passed in
 inform_single_bss_data.
To:     James Dutton <james.dutton@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <20231021154827.1142734-1-greearb@candelatech.com>
 <CAAMvbhHqbXXgF6FpPoWnqKbn=0A0br55wLN9T1xfnwRyiwvnuw@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <4c25e9a2-1669-264d-4a86-a53f5a386f0e@candelatech.com>
Date:   Sun, 22 Oct 2023 11:30:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAMvbhHqbXXgF6FpPoWnqKbn=0A0br55wLN9T1xfnwRyiwvnuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1697999462-gpaeC5IXyYVC
X-MDID-O: us5;at1;1697999462;gpaeC5IXyYVC;<greearb@candelatech.com>;cdf7db34a5aabb5f190d60746317ab8f
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/22/23 5:14 AM, James Dutton wrote:
> On Sat, 21 Oct 2023 at 16:52, <greearb@candelatech.com> wrote:
>>
>> From: Ben Greear <greearb@candelatech.com>
>>
>> The sins of similar variable names and passing void pointers
>> are seen again in wireless-next tree.
>>
>> Wrong data was passed into the rdev_inform_bss method causing
>> crashes.
>>
> 
> Is there any good reason for the void pointers?
> The patch you propose fixes the immediate problem, but if the void
> pointers were replaced with struct pointers, the compiler could catch
> this sort of problem.
> I imagine there could be similar confusion with this struct and
> function having the same name:
> 0 scan.c 1999 struct cfg80211_inform_single_bss_data {
> 1 scan.c 2023 cfg80211_inform_single_bss_data(struct wiphy *wiphy,
> 
> Maybe renaming the following:
> struct cfg80211_inform_bss *drv_data = data->drv_data;
> to
> struct cfg80211_inform_bss *c_inform_bss1 = data->drv_data;
> would reduce the confusion.

It takes a lot of time and patience to get more complicated patches upstreamed,
so maybe someone else has interested in pursuing that.

Probably a somewhat generic call-back struct could be used to pass info back to
the mac80211 stack instead of using the void*, but that would require touching
a larger set of drivers most likely.

I am tracking down more crash bugs in the mean time.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
