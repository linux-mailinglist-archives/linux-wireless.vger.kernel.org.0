Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A76C725E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 22:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCWVd4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCWVdz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 17:33:55 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 14:33:53 PDT
Received: from gretel.risen.be (gretel.risen.be [176.9.154.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF4375B89
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 14:33:53 -0700 (PDT)
Received: from oz.risen.be (d5152d4f6.static.telenet.be [81.82.212.246])
        by gretel.risen.be (Postfix) with ESMTPSA id 10622862878;
        Thu, 23 Mar 2023 22:24:35 +0100 (CET)
Received: from [10.10.1.112] (ap1.local.risen.be [10.10.1.11])
        by oz.risen.be (Postfix) with ESMTPSA id 40553140017;
        Thu, 23 Mar 2023 22:24:34 +0100 (CET)
Message-ID: <a9fc7a06-c13e-36ed-c112-e3eddd2aa8a0@aquazul.com>
Date:   Thu, 23 Mar 2023 22:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.2.4 and WiFi with BCM4345
Content-Language: nl-BE, fr-BE, en-GB, en-US
To:     Michael Ayers <anothergrump@runbox.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <e26eeebb-4fb0-5506-afbc-e9b56b849211@runbox.com>
 <c09e012e-7abd-7304-3721-799758a7f0e3@lwfinger.net>
 <cc6e8c12-33b7-7c42-345b-c3212b13bc77@runbox.com>
 <fa88eb52-7194-ecb2-0590-f554a12485ec@runbox.com>
 <1db6b607-faff-9ae2-0cf3-567d9c86e4ba@lwfinger.net>
 <a1953a58-9bdb-384a-42ca-503389aed8e5@runbox.com>
From:   Mourad De Clerck <bugs-kernel@aquazul.com>
In-Reply-To: <a1953a58-9bdb-384a-42ca-503389aed8e5@runbox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/20/23 02:41, Michael Ayers wrote:
> On 20/03/23 13:12, Larry Finger wrote:
>> I just noticed that the linux-wireless list was not in the Cc list - I 
>> added it. I also changed the subject to help catch the attention of 
>> the Broadcom maintainers. I am definitely not one of them.
>>
>> Your device is a BCM4345, which uses the brcmfmac driver. The dmesg 
>> output that you posted shows the firmware loading, but nothing happens 
>> beyond that. This is the point where I would expect the user-space 
>> code such as NetworkManager to take over. What code do you use to 
>> control wifi? Did that change when your kernel was updated?
>>
> Larry,
> 
> I'm using NetworkManager but I also tried Wicked with the same results.
> 
> NetworkManager tries to connect but fails.


Hi,

I think I may be hitting the same bug. I have this device:

02:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries 
BCM4350 802.11ac Wireless Network Adapter [14e4:43a3] (rev 05)

This is a 2017 MacBookPro14,1.

NetworkManager fails to connect when booting Linux v6.2.5, but seems to 
have no problems with v6.2.1.

Let me know if you need more information.

-- Mourad

