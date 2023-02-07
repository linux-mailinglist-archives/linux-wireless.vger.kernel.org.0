Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2D68DE32
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjBGQtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 11:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjBGQtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 11:49:21 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA739CFA
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 08:49:18 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 59C109C0077;
        Tue,  7 Feb 2023 16:49:06 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 82BC913C2B0;
        Tue,  7 Feb 2023 08:49:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 82BC913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1675788545;
        bh=DK+d9Un+IBSn8UC6MmI+0Fna6vNI8nOKW/ApKn31sk0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R1SPaW1bQsHUsbQKC8R19hK9dwSkR08ukJk7+s8aNFL7OSy8Dkyg6VrAt+CvDIbw5
         9OfGk3ViE7ex0RWxEp2SAp6WfnTWlVaZpXkuDyI4UnXKdpDkvolPQPtVwZdQyTha+W
         H2VZmCNdOB1RKeqnIfccfs/ITUgkk8qspMTzROr0=
Message-ID: <bca9544a-1b79-6c17-d52d-cb1869507c88@candelatech.com>
Date:   Tue, 7 Feb 2023 08:49:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH] wifi: mt76: mt7916: Support per-radio configuration
 'firmware' file.
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, carson.vandegriffe@candelatech.com
Cc:     linux-wireless@vger.kernel.org
References: <20230123175500.3375542-1-carson.vandegriffe@candelatech.com>
 <87lel97bko.fsf@kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <87lel97bko.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1675788557-e97eTUhfZcLo
X-MDID-O: us5;at1;1675788557;e97eTUhfZcLo;<greearb@candelatech.com>
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/7/23 07:13, Kalle Valo wrote:
> carson.vandegriffe@candelatech.com writes:
> 
>> From: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
>>
>> This lets users specify the upper band that the 7916 radio should use.
>> Upon reboot, the 7916 will be using that upper band.
>>
>> Example config file:
>>
>> myhost@: cat /usr/lib/firmware/mediatek/fwcfg-mmio-0000\:04\:00.0.txt
>>
>> high_band=6
>>
>> Signed-off-by: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
> 
> So this is basically an .ini file with settings for the driver? It's a
> long standing request feature request how wireless drivers should handle
> thatbut there's still no resolution. Having an ASCII parser in the
> driver does not sound a good idea.

It has been many years, no one has offered a better solution that I'm
aware of, so....how long to wait?

Perhaps the parsing logic could move to some helper methods higher in the stack and create a table of
key/value pairs to be used by drivers so that multiple drivers could more easily re-use the parsing
code?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


