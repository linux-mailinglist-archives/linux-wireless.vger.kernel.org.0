Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE61C4A97
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 01:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgEDXtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 19:49:21 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:55250 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgEDXtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 19:49:21 -0400
Received: from [192.168.254.4] (unknown [50.34.219.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 70B6A13C2B0;
        Mon,  4 May 2020 16:49:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 70B6A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1588636160;
        bh=FOB1U3QVYCyG3wm/IhkIjxv7yks2Kjv4QKsl8PiY2XI=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=rYVmW9zddMvVkJtdh6fQKF9z6ggOQhrOrWt5RnIty5MjBywlAbB7z3iQErMSEKz9s
         jcNBAcHhXe/yEYB02rQ0Bj7JdhvEag92sGPfxuVVXVJ5NWq2EMYzbJwbuTt0HuXhYH
         BS4jR+VTl9QBkB2gBIhzJJ0Q0M+K1sEOQcqtkd9s=
Subject: Re: [PATCH 1/2] ath10k: use cumulative survey statistics
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Markus Theil <markus.theil@tu-ilmenau.de>
References: <20200504154122.91862-1-markus.theil@tu-ilmenau.de>
 <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
From:   Ben Greear <greearb@candelatech.com>
Message-ID: <323b4d4f-a967-cf63-6f5a-04f53802c50a@candelatech.com>
Date:   Mon, 4 May 2020 16:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <f772b7bf0eac31516a4e28719c1938f2@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 05/04/2020 04:46 PM, Rajkumar Manoharan wrote:
> On 2020-05-04 08:41, Markus Theil wrote:
>> ath10k currently reports survey results for the last interval between each
>> invocation of NL80211_CMD_GET_SURVEY. For concurrent invocations, this
>> can lead to unexpectedly small results, e.g. when hostapd uses survey
>> data and iw survey dump is invoked in parallel. Fix this by returning
>> cumulative results, that don't depend on the last invocation. Other
>> drivers, e.g. ath9k or mt76 also use this behavior.
>>
>> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
>>
>
> IIRC this was fixed a while ago by below patch. Somehow it never landed in ath.git.
> Simple one line change is enough.
>
> https://patchwork.kernel.org/patch/10550707/
>
> -Rajkumar

Have you tested this with wave-1?  Lots of older, at least, firmware has brokenness in this area.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
