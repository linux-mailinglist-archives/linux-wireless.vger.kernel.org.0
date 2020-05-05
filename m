Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E841C4AD3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 02:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgEEACo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 20:02:44 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:56628 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgEEACo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 20:02:44 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 3010E13C2B0;
        Mon,  4 May 2020 17:02:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3010E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588636963;
        bh=Um9qS9gMVFpziLD0y++FXs7GTlBwSq6hU8KvFDT7SJo=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=sC8XmVRNtusQqXdUSdOe55Fc0/SoPRkDS5IAa/StrszxF7pC/ry6Rixw6F091F7Y+
         S6p2loQuzVK5Cy5UeEBEbmIdyAu43kVfYJ/kGrUW8v82gABb4bX5+1+y6OsWZ5QCTg
         EG1AnFRc11nQX9b+9W/Evoueh8vZ6huuRdauYVoY=
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
 <323b4d4f-a967-cf63-6f5a-04f53802c50a@candelatech.com>
 <4b03993ba81a8e9ebb1203c0b8aa90f6@codeaurora.org>
Cc:     linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        kvalo@codeaurora.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <9044aa57-ceb2-fecd-e220-eb8b7c0db4b5@candelatech.com>
Date:   Mon, 4 May 2020 17:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4b03993ba81a8e9ebb1203c0b8aa90f6@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/04/2020 04:52 PM, Rajkumar Manoharan wrote:
> On 2020-05-04 16:49, Ben Greear wrote:
>> On 05/04/2020 04:46 PM, Rajkumar Manoharan wrote:
>>> On 2020-05-04 08:41, Markus Theil wrote:
>>>> ath10k currently reports survey results for the last interval between each
>>>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
>>>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>>>> data and iw survey dump is invoked in parallel. Fix this by returning
>>>> cumulative results, that don't depend on the last invocation. Other
>>>> drivers, e.g. ath9k or mt76 also use this behavior.
>>>>
>>>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>>>>
>>>
>>> IIRC this was fixed a while ago by below patch. Somehow it never landed in ath.git.
>>> Simple one line change is enough.
>>>
>>> https://patchwork.kernel.org/patch/10550707/
>>>
>>> -Rajkumar
>>
>> Have you tested this with wave-1?  Lots of older, at least, firmware
>> has brokenness in this area.
>>
> Yes. It was tested in wave-1 as well. Venkat replied to your comment on original change.

Ahh, sorry I missed that.

Hopefully no one is using the broken firmware anymore then!

--Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
