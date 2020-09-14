Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F42693B7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgINRkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgINRkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 13:40:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52865C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Sep 2020 10:40:05 -0700 (PDT)
Received: from [2a04:4540:1403:100:ec10:a302:c6a0:1f5f]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kHsSO-0006j1-FM; Mon, 14 Sep 2020 19:40:00 +0200
Subject: Re: [PATCH V6 2/2] ath11k: add support for setting fixed HE
 rate/gi/ltf
To:     Aloka Dixit <alokad@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Miles Hu <milehu@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
References: <20200804081630.2013619-2-john@phrozen.org>
 <010101746c53c3fc-6b47ad5d-f740-4029-9a89-2ba9bef427f3-000000@us-west-2.amazonses.com>
 <010101747ecf2d5c-5543939f-2417-438a-8d0a-c31832121a00-000000@us-west-2.amazonses.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <ebf50ae1-910c-fab4-83e7-24677ae87243@phrozen.org>
Date:   Mon, 14 Sep 2020 19:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <010101747ecf2d5c-5543939f-2417-438a-8d0a-c31832121a00-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11.09.20 22:15, Aloka Dixit wrote:
> On 2020-09-07 23:07, Kalle Valo wrote:
>> John Crispin <john@phrozen.org> wrote:
>>
>>> From: Miles Hu <milehu@codeaurora.org>
>>>
>>> This patch adds ath11k support for setting fixed HE rate/gi/ltf 
>>> values that
>>> we are now able to send to the kernel using nl80211. The added code is
>>> reusing parts of the existing code path already used for HT/VHT. The 
>>> new
>>> helpers are symmetric to how we do it for HT/VHT.
>>>
>>> Signed-off-by: Miles Hu <milehu@codeaurora.org>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>
>> Depends on:
>>
>> eb89a6a6b7a1 nl80211: add support for setting fixed HE rate/gi/ltf
>>
>> Currently in net-next.
>
> Hi Kalle and John,
> This patch includes auto-rate support as well which is part of the CAF 
> changes John mentioned in v55 change-log.
> Auto-rate part was added by me into CAF.
> Please add my sign-off on this patch.
> Or let me know if you decide to remove that particular portion, then I 
> will send a separate patch.
> Thanks.

Hi Kalle,

please ignore this patch for now

     John

