Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2491A10EF02
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 19:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfLBSRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 13:17:32 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:39014 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfLBSRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 13:17:32 -0500
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1544F137531;
        Mon,  2 Dec 2019 10:17:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1544F137531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1575310651;
        bh=/2PhJ5xFWBl4QKp0sJThhBjgqj8x5G6dX5WbrLLGJX0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JAGV8C+RWwb5o5IPTnPBPM+9aoTmOfZqCQelhV3/V4iGkHhD55Z+syJ14fM89ZxNV
         7GqV228r75AOkhy/jxschYh8L9Y5clW7j8FtAnA4XjPrb8ePP6/vZI+NK39ejudH7/
         yVBOE/SvAwdKxwdn1syOVQR1iOjl0+0JS/7yNuPQ=
Subject: Re: [PATCH] ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
To:     Justin Capella <justincapella@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless@vger.kernel.org
References: <0101016eaadee57a-54500c6d-4751-423f-8bab-5acd8fad2175-000000@us-west-2.amazonses.com>
 <0101016eb61d9520-b0306a23-c9b9-4b57-b708-9f80ac47eef1-000000@us-west-2.amazonses.com>
 <CAMrEMU-VOYeHO2F5AjyWJLqgEVq5HOUHZkMJqGio1qovFPo8ug@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <b5404ac0-1be1-229f-a9e3-8033cdf7eea9@candelatech.com>
Date:   Mon, 2 Dec 2019 10:17:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMrEMU-VOYeHO2F5AjyWJLqgEVq5HOUHZkMJqGio1qovFPo8ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/1/19 8:45 PM, Justin Capella wrote:
> Are there security concerns here? Was the peer known to be authorized
> beforehand? Would it be better to just trash the peer in the event of
> a fw crash?

I think you should completely re-associate the peer(s) when firmware
crashes.  The driver does not cache all possible changes, so it cannot
exactly rebuild the config to the previous state.

Thanks,
Ben

> 
> On Thu, Nov 28, 2019 at 11:46 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Wen Gong <wgong@codeaurora.org> wrote:
>>
>>> After the firmware crashes ath10k recovers via ieee80211_reconfig(),
>>> which eventually leads to firmware configuration and including the
>>> encryption keys. However, because there is no new auth/assoc and
>>> 4-way-handshake, and firmware set the authorize flag after
>>> 4-way-handshake, so the authorize flag in firmware is not set in
>>> firmware without 4-way-handshake. This will lead to a failure of data
>>> transmission after recovery done when using encrypted connections like
>>> WPA-PSK. Set authorize flag after installing keys to firmware will fix
>>> the issue.
>>>
>>> This was noticed by testing firmware crashing using simulate_fw_crash
>>> debugfs file.
>>>
>>> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>>>
>>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> Patch applied to ath-next branch of ath.git, thanks.
>>
>> 382e51c139ef ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
>>
>> --
>> https://patchwork.kernel.org/patch/11263357/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>>
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

