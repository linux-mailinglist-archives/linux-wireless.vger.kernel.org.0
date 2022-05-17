Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A35296B3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 03:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiEQB0k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiEQB0i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 21:26:38 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9031233EB8
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 18:26:37 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.27])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2F5211A0073;
        Tue, 17 May 2022 01:26:36 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E25AF60006B;
        Tue, 17 May 2022 01:26:35 +0000 (UTC)
Received: from [IPV6:2607:fb91:15ac:2623:6836:8737:98dc:a867] (unknown [172.56.105.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id D381313C2B1;
        Mon, 16 May 2022 18:26:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D381313C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1652750795;
        bh=/9PFVP8VfTMLRw9Cz13OGP0hwF6ZzlbMmwNcpGbAL4I=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=bSi0bV5TKyYITOcKPn+oQIh+9P1qDGzgW0yF6pzfLbrPhxjr0ujaw9ctP5c90Q+tn
         7taMjdUGJxximqP6zKUOjgT/kY+OX3u3+2EFfm6CrQMZ4yFtR4SsU9tN5L0RKbYtEI
         S78tCH/O0cr0Nk8UshGENE9ie0gGuB1UipibEI4Y=
Message-ID: <3712f8f1-f36e-23e5-d3bd-fb5b77457c7e@candelatech.com>
Date:   Mon, 16 May 2022 18:26:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] iwlwifi: RX signal improvements.
Content-Language: en-MW
From:   Ben Greear <greearb@candelatech.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20220225232842.32028-1-greearb@candelatech.com>
 <20220225232842.32028-2-greearb@candelatech.com>
 <175612fa5385cf2c30207df9012074df2c65f551.camel@sipsolutions.net>
 <d93c5295-d57d-9352-a484-548da937fb1a@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <d93c5295-d57d-9352-a484-548da937fb1a@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1652750796-0_6dZAWc-vHl
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/4/22 07:46, Ben Greear wrote:
> On 5/4/22 3:57 AM, Johannes Berg wrote:
>> On Fri, 2022-02-25 at 15:28 -0800, greearb@candelatech.com wrote:
>>>
>>> -    if (mvmsta->avg_energy) {
>>> -        sinfo->signal_avg = -(s8)mvmsta->avg_energy;
>>> +    if (iwl_mvm_has_new_rx_api(mvm)) { /* rxmq logic */
>>> +        /* Grab chain signal avg, mac80211 cannot do it because
>>> +         * this driver uses RSS.  Grab signal_avg here too because firmware
>>> +         * appears go not do DB summing and/or has other bugs. --Ben
>>> +         */
>>
>> That "--Ben" really seems inappropriate ... please take more care when
>> sending patches to the list.
> 
> I figure if I am submitting a patch that is blaming firmware, and I have no access
> to firmware to actually back up my assertion, then I should put my name on it
> so that folks looking at the driver don't think it is Intel disparaging it's own firmware.

Hello Johannes,

If there is no reasonable chance to make changes like this to iwlwifi (lockless
signal averaging is the unfixable part I think), let me know
and I'll consider the issue closed.

And, in that case, the mac80211 patch is un-needed since no driver that I know of
would need that code.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
