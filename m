Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276B6C08FC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 03:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCTCqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Mar 2023 22:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCTCqa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Mar 2023 22:46:30 -0400
X-Greylist: delayed 3889 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Mar 2023 19:46:27 PDT
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67320574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 19:46:27 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <anothergrump@runbox.com>)
        id 1pe4Wk-00C0YF-HA
        for linux-wireless@vger.kernel.org; Mon, 20 Mar 2023 02:41:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=repfvoxsIGsvMfsHohaMheZYpdwyWg1mmGI9ZExdixM=; b=vCcX+9PKgb/cnb2f+C4sF2/yFM
        NZPU1xGovtDBvi/SQ9OxYbBpQnW8ikUlmVU8blDPhAZeCtcMGSZ9PK65XUbyWckIWGPxIZ2TJQAUF
        Yb3NP+CtZ5UQ4IfeflV2rooD344e99uTD+PT4HDznb24jEbwcH1womM7y/AYp1NPvLDq/otpNMGVR
        eq2TsV0Hp0ljnKMKOWC+tWC6zSl2Go8OnA+elQIpWC4l4f5j9wAbzRIQ9nA5/Iz55EXOCF2Op/NsA
        TUxw+hJIzZA+bqcfYkYagYhsGJlN1S9Ap3flderGnjms9MezCXNbVUrFgRVDWZ9mMliMw+xFxFhrs
        5P5hMtIA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <anothergrump@runbox.com>)
        id 1pe4Wj-00056U-TN; Mon, 20 Mar 2023 02:41:34 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (587639)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pe4Wg-0002N8-89; Mon, 20 Mar 2023 02:41:30 +0100
Message-ID: <a1953a58-9bdb-384a-42ca-503389aed8e5@runbox.com>
Date:   Mon, 20 Mar 2023 14:41:25 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Kernel 6.2.4 and WiFi with BCM4345
Content-Language: en-US
To:     arm@lists.opensuse.org
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <e26eeebb-4fb0-5506-afbc-e9b56b849211@runbox.com>
 <c09e012e-7abd-7304-3721-799758a7f0e3@lwfinger.net>
 <cc6e8c12-33b7-7c42-345b-c3212b13bc77@runbox.com>
 <fa88eb52-7194-ecb2-0590-f554a12485ec@runbox.com>
 <1db6b607-faff-9ae2-0cf3-567d9c86e4ba@lwfinger.net>
From:   Michael Ayers <anothergrump@runbox.com>
In-Reply-To: <1db6b607-faff-9ae2-0cf3-567d9c86e4ba@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 20/03/23 13:12, Larry Finger wrote:
> On 3/19/23 14:35, Michael Ayers wrote:
>>
>> On 20/03/2023 08:24, Michael Ayers wrote:
>>>
>>> On 20/03/2023 07:58, Larry Finger wrote:
>>>> On 3/19/23 13:20, Michael Ayers wrote:
>>>>> Kernel 6.2.4-1-default has broken wifi on the Pinebook pro, kernel 
>>>>> 6.2.1-1-default works fine.
>>>>>
>>>>> Logs give me so much information that I am not sure where to begin.
>>>>
>>>> The first piece of information would be to tell us what what device 
>>>> you have. The Pinebrook Pro web site says that you have an 802.11ac 
>>>> (Wifi 5) device, but not who made it. The output of 'lspci -nn' or 
>>>> 'lsusb' would be useful.
>>>>
>>>> You should also run the command 'sudo dmesg > dmesg.txt', and post 
>>>> dmesg.txt at pastebin.com, or some similar site. Report the URL 
>>>> back with the ouput of the two commands above. Do not attach 
>>>> dmesg.txt to your reply. There are thousands of readers of this 
>>>> list that do not care, thus they should not be forced to download 
>>>> such stuff.
>>>>
>>>> Larry
>>>>
>>>>
>>> The wifi device would seem to be a Broadcom 4345 and if I've done 
>>> this right this: https://pastebin.com/rz2wnuVt should be the link to 
>>> dmesg.txt.
>>>
>>> MIke
>>
>>
>> Sorry that is the wrong dmesg link it should be: 
>> https://pastebin.com/SE0DV7XP
>
> Mike,
>
> I just noticed that the linux-wireless list was not in the Cc list - I 
> added it. I also changed the subject to help catch the attention of 
> the Broadcom maintainers. I am definitely not one of them.
>
> Your device is a BCM4345, which uses the brcmfmac driver. The dmesg 
> output that you posted shows the firmware loading, but nothing happens 
> beyond that. This is the point where I would expect the user-space 
> code such as NetworkManager to take over. What code do you use to 
> control wifi? Did that change when your kernel was updated?
>
> Larry
>
>
Larry,

I'm using NetworkManager but I also tried Wicked with the same results.

NetworkManager tries to connect but fails.

Mike

