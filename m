Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56968664521
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjAJPoM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 10:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjAJPn3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 10:43:29 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4B7DE010;
        Tue, 10 Jan 2023 07:43:28 -0800 (PST)
Message-ID: <53b23ee9-a333-120e-8b58-cfa3a9bdaefc@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673365407;
        bh=joeZ0isSpFWCfJo9bP7lRZdTrlAemheFG8yfUEmmw0s=;
        h=Date:Subject:From:To:References:In-Reply-To;
        b=oBfHQ7QJtk5sWEMyXs1jUUCKUM6vy9bmoUBwseZQqoOK64dyvDGQpalE18Lze85HU
         O3zZ2NDPT4JWbsFu0S/zYsjJKHaNdL1lcjq/5NZcsMJOB/MKuWC6F+aXbM6XEYX79/
         MNaJ350fvM8rvdfGcW86uzJUkUbDRnoMansGYTzg=
Date:   Tue, 10 Jan 2023 16:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: ieee80211_handle_wake_tx_queue and dynamic ps regression
Content-Language: en-US
From:   Alexander Wetzel <alexander@wetzel-home.de>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
References: <19015168-c747-17b7-f0ae-9d2ee27d221c@linaro.org>
 <06f76774-1b2e-f563-7128-7d5b9547dfe9@linaro.org>
 <cf5e9339-2511-1135-71da-a8342b264414@linaro.org>
 <205fb221-f7ad-8f03-2c16-54dcbf5ecaf9@wetzel-home.de>
In-Reply-To: <205fb221-f7ad-8f03-2c16-54dcbf5ecaf9@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10.01.23 16:23, Alexander Wetzel wrote:
> On 10.01.23 15:47, Bryan O'Donoghue wrote:
>> On 10/01/2023 12:44, Bryan O'Donoghue wrote:
>>> + linux-wireless
>>> On 10/01/2023 12:35, Bryan O'Donoghue wrote:
>>>> commit a790cc3a4fad75048295571a350b95b87e022a5a 
>>>> (wake_tx_queue-broken-23-08-01)
>>>> Author: Alexander Wetzel <alexander@wetzel-home.de>
>>>> Date:   Sun Oct 9 18:30:39 2022 +0200
>>>>
>>>>      wifi: mac80211: add wake_tx_queue callback to drivers
>>>>
>>>> is causing a regression with
>>>>
>>>> - CONF_PS = 1
>>>> - CONF_DYNAMIC_PS = 0
>>>> - ieee80211_handle_wake_tx_queue
>>>>
>>>> In this case we get stuck in a loop similar to this
>>>>
>>>> // IEEE80211_CONF_CHANGE_PS
>>>> [   17.255480] wcn36xx: wcn36xx_change_ps/312 enable
>>>> [   18.088835] ieee80211_tx_h_dynamic_ps/263 setting 
>>>> IEEE80211_QUEUE_STOP_REASON_PS
>>>> [   18.088906] ieee80211_handle_wake_tx_queue/334 entry
>>>> [   18.091505] ieee80211_dynamic_ps_disable_work/2250 calling 
>>>> ieee80211_hw_config()
>>>> [   18.095370] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
>>>>
>>>> // IEEE80211_CONF_CHANGE_PS
>>>> [   18.102625] wcn36xx: wcn36xx_change_ps/312 disable
>>>> [   18.107643] wake_tx_push_queue/303 entry
>>>>
>>>> // txq is stopped here reason == IEEE80211_QUEUE_STOP_REASON_PS
>>>> [   18.107654] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
>>>> IEEE80211_QUEUE_STOP_REASON_PS true
>>>> [   18.107661] wake_tx_push_queue/324 exit
>>>> [   18.107667] ieee80211_handle_wake_tx_queue/342 exit
>>>> [   18.115560] ieee80211_handle_wake_tx_queue/334 entry
>>>> [   18.139937] ieee80211_handle_wake_tx_queue/338 wake_tx_push_queue
>>>> [   18.145163] wake_tx_push_queue/303 entry
>>>> [   18.150016] ieee80211_dynamic_ps_disable_work/2252 completed 
>>>> ieee80211_hw_config()
>>>>
>>>> // now we unset IEEE80211_QUEUE_STOP_REASON_PS but too late
>>>> [   18.151145] wake_tx_push_queue/311 q_stopped bitmask 0x00000002 
>>>> IEEE80211_QUEUE_STOP_REASON_PS true
>>>> [   18.155263] ieee80211_dynamic_ps_disable_work/2254 clearing 
>>>> IEEE80211_QUEUE_STOP_REASON_PS
>>>> [   18.162531] wake_tx_push_queue/324 exit
>>>> [   18.162548] ieee80211_handle_wake_tx_queue/342 exit
>>>> [   18.183639] ieee80211_dynamic_ps_disable_work/2259 cleared 
>>>> IEEE80211_QUEUE_STOP_REASON_PS
>>>>
>>>> // IEEE80211_CONF_CHANGE_PS runs again
>>>> [   18.215487] wcn36xx: wcn36xx_change_ps/312 enable
>>>>
>>>> We get stuck in that loop. Packets getting transmitted is a rare 
>>>> event, most are dropped.
>>
> 
> I'll need some time digest that... I report back once I get it.

Looks like the the commit 
https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
has a good chance to solve the issue:

1) Queues are stopped due to PS
2) Then there is a TX attempt. But due to the (PS) queue stop
    wake_tx_push_queue() aborts the queue run
3) Then we hit the bug the patch fixes: The queue is not marked to
    have pending packets and thus packets on it are not transmitted.

Packets get only send when you happen to try tx when the queue is 
operational. (And then you will get all the packets sitting in the queue.)

Does that make sense? And more crucial, is the patch fixing that for you?

> 
>> BTW I considered implementing a wcn36xx specific wake_tx callback - 
>> which maybe should be done anyway.
>>
>> I _don't_ see other drivers checking for q_stopped & 
>> IEEE80211_QUEUE_STOP_REASON_PS
>>
>> Should they be ?
>>
> 
> No, they should not.
> 
> My take is, that this is a bug in mac80211. I submitted patches to 
> fixing that, they have just been accepted:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
> 
> and
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20230106223141.98696-1-alexander@wetzel-home.de/
> 
> 
> Can you test if these also help here?
> 
> 
> 
>> If they should check IEEE80211_QUEUE_STOP_REASON_PS, then right now, 
>> they don't. If they shouldn't check IEEE80211_QUEUE_STOP_REASON_PS 
>> then neither should the generic replacement 
>> ieee80211_handle_wake_tx_queue()
>>
>> ---
>> bod
> 

