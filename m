Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659C51BBEB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 19:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfEMR1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 13:27:41 -0400
Received: from [208.74.158.174] ([208.74.158.174]:41392 "EHLO
        mail3.candelatech.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfEMR1l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 13:27:41 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 9482913755C;
        Mon, 13 May 2019 10:27:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9482913755C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1557768460;
        bh=tTAiA0AgbxteuS40Hhtu6vXzfOGC3zPDyDxoKrOsPKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mQKsO+4RCBMhIsatGJBBetn1h3IEgK3A/U+dVUsxza84o8QEBz8eit2ZHuTfMMGVG
         CZsFmrKFLuWZfWriIz5IF9DtUV6pXoGo7cpV3akS301bVnLzhquUrJ2U4K6+0edgZb
         YI/zAvVThH4MlQMhYYRwhJOQE5xSasNy/JswMpMQ=
Subject: Re: ath10k 5Ghz RSSI low
To:     Sam Samy <to.swami1@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <CAPGJ1o_KskiCKQ8V-6U0nxWGgXXa4NWHV0EEwo41bMPSj1bbdg@mail.gmail.com>
 <CAPGJ1o9qDYPQF882cw65uysjCmUYi6kJCmL2EUa0AXbwHj59Mg@mail.gmail.com>
 <a236cf47-556d-c515-0093-82dce6e8ad8e@candelatech.com>
 <CAPGJ1o96QSfoFzFpSPbh_4TwSgAU-1FGhX6P5MVCmfZv_bugHw@mail.gmail.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <79695018-5ac9-d7c8-a386-c6dd3f9ed474@candelatech.com>
Date:   Mon, 13 May 2019 10:27:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPGJ1o96QSfoFzFpSPbh_4TwSgAU-1FGhX6P5MVCmfZv_bugHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/13/19 10:26 AM, Sam Samy wrote:
> hi Ben,
> 
>> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
>> please try QCA firmware and let me know if that fixes the problem.
>>
>    I tried both. Both have the same problem. I tried various versions
> of the both(-ct and QCA) firmware as well. All have the same problem.

Probably it is a board-file and/or calibration data issue then.

The debugfs 'ath10k/tpc_stats' file may show very low values?

Thanks,
Ben

> 
> Thanks
> 
> On Mon, May 13, 2019 at 10:00 AM Ben Greear <greearb@candelatech.com> wrote:
>>
>> On 5/13/19 9:56 AM, Sam Samy wrote:
>>>    Hi,
>>>    I installed master branch openwrt onto Asus MAP-AC2200 AP. It has tri
>>> band. Its based on IPQ4019 DK04 QCA reference platform. 2 radios
>>> (2Ghz/5Ghz) on AHB bus and one 5GHZ on PCIe bus. Its generally working
>>> fine except one problem in 5Ghz. On both the 5Ghz radios the RSSI is
>>> pretty low on any channel I put it in.  In one feet range I see -60dB
>>> RSSI, where as the stock firmware that came with the AP gives an RSSI
>>> of -36dB at one foot distance.The downstream transmit rates are MCS8/9
>>> for most part. The 2Ghz is working fine. Its using the cal data from
>>> the flash that came with the AP.
>>>
>>>    Can you please suggest anyway to debug this or improve the RSSI?
>>>
>>>    Thanks you!
>>>
>>
>> Hello, what firmware are you using (ath10k-ct, or QCA?)  If using -ct firmware,
>> please try QCA firmware and let me know if that fixes the problem.
>>
>> Thanks,
>> Ben
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
>>
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

