Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA666285B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 15:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjAIOW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 09:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAIOWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 09:22:25 -0500
X-Greylist: delayed 992 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 06:22:24 PST
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6405265F6
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 06:22:24 -0800 (PST)
Message-ID: <3372b42f-b9bf-20e8-35f9-5370571a9e35@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673274143;
        bh=bwNb7nOomg5nRnP4yNloacF+RTZCjPvfmUfkMsxtiGc=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=nBglt9/JsSg8JFVO+h3aaMepjYeqbtULg9i0O7VXy9Ppj9A6cDsD5ASEgcLBbTO6x
         DWOqi4Q09M30klD3ynIO9RzV/Bxjgi9InzzKgicQekjDnAE+4bKv02dqBGbCyfV1VI
         gmeZ+9CMtifYC4pQWlbkAhwX9YaA/UE9G7NrXqv0=
Date:   Mon, 9 Jan 2023 15:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] wifi: mac80211: change initialize for sk_buff in
 ieee80211_tx_dequeue()
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wen Gong <quic_wgong@quicinc.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20221212083607.21536-1-quic_wgong@quicinc.com>
 <20230105052647.GA2477583@roeck-us.net>
 <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
In-Reply-To: <d28c6340-7ad2-d7f6-939d-3a1a057cb7da@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 09.01.23 15:05, Alexander Wetzel wrote:
> On 05.01.23 06:26, Guenter Roeck wrote:
>> On Mon, Dec 12, 2022 at 03:36:07AM -0500, Wen Gong wrote:
>>> The sk_buff is only set to NULL when initialize, sometimes it will goto
>>> label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
>>> which is already freed. If it run into the "goto out" after arrived to
>>> label "begin", then it will return a sk_buff which is freed, it is a
>>> risk for use-after-free.
>>>
>>> Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers 
>>> without holding fq->lock")
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>>
>> I don't see any progress on this patch. Is there a problem with it ?
>> Did it get lost ?
>>
> 
> Looks ok for me. But I just noticed that my patch
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> 
> should also fix the issue as an unintended side effect.

Sorry that statement was incomplete: It's only fixed when
https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
and
https://patchwork.kernel.org/project/linux-wireless/patch/20230106223141.98696-1-alexander@wetzel-home.de/

are applied.








