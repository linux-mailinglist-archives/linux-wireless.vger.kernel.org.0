Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23F245B602
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 08:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhKXH6b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 02:58:31 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:8569 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhKXH6b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 02:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637740522; x=1669276522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HLqFzv6cSMM7EHnavttffNHIaN8wJa94zAwkS/w/bbk=;
  b=NtRqbtYp0gaoAgQ820uktyMptOZcZRZNd2t1OSaGbg6and58U+R03a9Q
   mpxgfY+kc6mfZ9P8ZrddRxDzo2YVN1m7VCpPb6qt8lvrhxkVvBrPKxG+m
   dr/iQNEFS/F6sNGZu3XMfxI0CgTm8UnKaLcsX5VfnGHKLmnS4exA75MFb
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Nov 2021 23:55:22 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 23:55:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 23:55:21 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 23 Nov
 2021 23:55:19 -0800
Message-ID: <5dc61605-2ada-3c0b-64de-ea16ad31efbc@quicinc.com>
Date:   Wed, 24 Nov 2021 15:55:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
Content-Language: en-US
To:     Kalle Valo <kvalo@codeaurora.org>,
        Fabio Estevam <festevam@gmail.com>
CC:     Fabio Estevam <festevam@denx.de>, <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        <erik.stromdahl@gmail.com>, <alagusankar@silex-india.com>
References: <20210915160422.2839595-1-festevam@denx.de>
 <CAOMZO5AYUxJg4bWudT3L1P=qNR2UBcNR1zmjCf5O9_ExyPw4ww@mail.gmail.com>
 <CAOMZO5AJ8q06YTHP=p84nJnKOYU+=MKVqJ3qz3XnUGcAg0xo=g@mail.gmail.com>
 <87ilwi6lo4.fsf@codeaurora.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87ilwi6lo4.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/24/2021 3:46 PM, Kalle Valo wrote:
> Fabio Estevam <festevam@gmail.com> writes:
>
>> Hi Kalle,
>>
>> On Mon, Nov 15, 2021 at 3:06 PM Fabio Estevam <festevam@gmail.com> wrote:
>>> Hi Kalle,
>>>
>>> On Wed, Sep 15, 2021 at 1:05 PM Fabio Estevam <festevam@denx.de> wrote:
>>>> On an imx6dl-pico-pi board with a QCA9377 SDIO chip, the following
>>>> errors are observed when the board works in STA mode:
>>>>
>>>> Simply running "ssh user@192.168.0.1" causes:
>>>>
>>>> [   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
>>>> [   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>>>> [   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>>>> [   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
>>>> [   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
>>>> [   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12
>>>>
>>>> and it is not possible to connect via ssh to the other machine.
>>>>
>>>> One user inspected the size of frames on Wireshark and reported
>>>> the followig:
>>>>
>>>> "I was able to narrow the issue down to the mtu. If I set the mtu for
>>>> the wlan0 device to 1486 instead of 1500, the issue does not happen.
>>>>
>>>> The size of frames that I see on Wireshark is exactly 1500 after
>>>> setting it to 1486."
>>>>
>>>> Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
>>>> the ssh command works successfully after that.
>>>>
>>>> Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.
>>>>
>>>> Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
>>>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>>> A gentle ping on this one.
>> Any comments, please? Without this fix, we can not log via ssh to other machine.
> I don't have much time for ath10k nowadays, so expect long delays in
> reviews.
>
> I'm worried that this breaks QCA6174 SDIO support. Wen, what do you
> think of this? Is this because of differences between firmware versions
> or what?

it is added by below commit, if disable it, will significant effect 
performance.

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath11k?id=2f918ea98606100f3a6d47db7ff7c200838ec4f3

ath10k: enable alt data of TX path for sdio

The default credit size is 1792 bytes, but the IP mtu is 1500 bytes,
then it has about 290 bytes's waste for each data packet on sdio
transfer path for TX bundle, it will reduce the transmission utilization
ratio for data packet.

This patch enable the small credit size in firmware, firmware will use
the new credit size 1556 bytes, it will increase the transmission
utilization ratio for data packet on TX patch. It results in significant
performance improvement on TX path.

This patch only effect sdio chip, it will not effect PCI, SNOC etc.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200410061400.14231-3-wgong@codeaurora.org

