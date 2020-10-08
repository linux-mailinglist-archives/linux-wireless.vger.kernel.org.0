Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AAA287C97
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 21:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgJHTmP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHTmP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 15:42:15 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9DC0613D2;
        Thu,  8 Oct 2020 12:42:15 -0700 (PDT)
Received: from [2a04:4540:1402:c000:5999:1c17:bedf:f05d]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kQbno-000713-5y; Thu, 08 Oct 2020 21:42:12 +0200
Subject: Re: [PATCH V3 2/9] mac80211: add multiple bssid support to interface
 handling
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     linux-wireless-owner@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20200812150050.2683396-1-john@phrozen.org>
 <20200812150050.2683396-3-john@phrozen.org>
 <6e914f17bc1fcd57bfb1a0d9f68fe4ad@codeaurora.org>
 <cc1fd0b5-d12f-0cdc-f918-b8f761b18c88@phrozen.org>
 <54033ab6e1bcf7ecda314c3ec81f1736@codeaurora.org>
From:   John Crispin <john@phrozen.org>
Message-ID: <95f54d65-cd6d-7cb1-65c6-53a969dd8601@phrozen.org>
Date:   Thu, 8 Oct 2020 21:42:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <54033ab6e1bcf7ecda314c3ec81f1736@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 08.10.20 19:21, Pradeep Kumar Chitrapu wrote:
> On 2020-10-08 01:06, John Crispin wrote:
>> On 08.10.20 02:33, Pradeep Kumar Chitrapu wrote:
>>>>
>>>>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
>>>> wireless_dev *wdev)
>>>>  {
>>>> +    struct ieee80211_sub_if_data *sdata;
>>>> +    struct ieee80211_vif *child, *tmp;
>>>> +
>>>> +    sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
>>>> +    if (sdata->vif.type == NL80211_IFTYPE_AP) {
>>> Hi John, Observed a NULL ptr dereference error here..
>>>
>>> Thanks
>>> Pradeep
>>
>>
>> how did you trigger it ?
>>
>>     John
> Hi
>
> Deleted the interface and did rmmod and insmod of 
> cfg80211/mac80211/ath modules.
>
> [  883.565933] Unable to handle kernel NULL pointer dereference at 
> virtual address 00000000
> [  883.565970] pgd = b311c000
> [  883.573357] [00000000] *pgd=00000000
> [  883.579021] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [  883.848257] task: bd1ac600 ti: b027a000 task.ti: b027a000
> [  883.852904] PC is at ieee80211_del_iface+0x34/0x90 [mac80211]
> [  883.858333] LR is at extack_doit+0x20/0x6c [compat]
> [  884.092936] [<c751fbd8>] (ieee80211_del_iface [mac80211]) from 
> [<7f56181c>] (extack_doit+0x20/0x6c [compat])
> [  884.100991] [<7f56181c>] (extack_doit [compat]) from [<8076a340>] 
> (genl_rcv_msg+0x27c/0x300)
> [  884.110854] [<8076a340>] (genl_rcv_msg) from [<807696c0>] 
> (netlink_rcv_skb+0x58/0xb4)
>
> Thanks
> Pradeep
>
last I tested rmmod/insmod will always crash the kernel when using ath11k

however i'll ass !NULL guard in the next series

     John

