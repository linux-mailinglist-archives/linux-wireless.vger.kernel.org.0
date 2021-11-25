Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8445E0CF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbhKYTFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 14:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbhKYTDS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 14:03:18 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B49AC061748
        for <linux-wireless@vger.kernel.org>; Thu, 25 Nov 2021 11:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5Qh8CbPWy8w8H9DNtx5NktwSprKG+JU6TmFF/d5OU70=; b=hBmGezTe+n0ROXHLMSsGzeoBGn
        QdBtPIz8Wtf3Od1j6DPemUPZHGPzQScoavpzeydI9QTNh+bMRvRiLSrs6kcjXw4pJdukF6ofI8mWA
        DTLLLmTsPu3Ud+qjhBHzE48V8Lje95uo2uKN5yo0Xd01W4e1m7kSQU6H7XZxAgtaRP8A=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mqJyV-0001Wd-G8; Thu, 25 Nov 2021 20:00:03 +0100
Message-ID: <52d90d6b-6d67-776b-784d-bd4871de721b@nbd.name>
Date:   Thu, 25 Nov 2021 20:00:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] mt76: mt7915: update station's airtime and gi from event
Content-Language: en-US
To:     Ryder Lee <ryder.lee@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sujuan Chen <sujuan.chen@mediatek.com>
References: <20211125091330.27770-1-MeiChia.Chiu@mediatek.com>
 <7e06ea885e336e261b6ca458d371921df44af6b8.camel@mediatek.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <7e06ea885e336e261b6ca458d371921df44af6b8.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-25 19:56, Ryder Lee wrote:
> On Thu, 2021-11-25 at 17:13 +0800, MeiChia Chiu wrote:
>> From: MeiChia Chiu <meichia.chiu@mediatek.com>
> 
> Should be [RFC].
> 
>> To avoid race condition in firmware,
>> if firmware support airtime and gi event,
>> driver update station's airtime and gi from event.
>> 
>> Reviewed-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
>> Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
>> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
>> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
>> Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
>> 
>> ---
>>  .../net/wireless/mediatek/mt76/mt7915/init.c   |   2 +
>>  .../net/wireless/mediatek/mt76/mt7915/mac.c    |  35 ++++++++----
>>  .../net/wireless/mediatek/mt76/mt7915/mcu.c    | 138
>> ++++++++++++++++++++++++++++++++++++++++++++++++
>>  .../net/wireless/mediatek/mt76/mt7915/mcu.h    |  28 ++++++++++
>>  .../net/wireless/mediatek/mt76/mt7915/mt7915.h |  11 ++++
>>  5 files changed, 204 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> index 4b56358d..a5f6d25d 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> @@ -960,6 +960,8 @@ int mt7915_register_device(struct mt7915_dev
>> *dev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	dev->fw_ver = mt76_rr(dev, MT_SWDEF(0x7c));
>> +
>>  	return mt7915_init_debugfs(&dev->phy);
>>  }
>>  
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> index 1041d88f..b2e20251 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
>> @@ -1433,7 +1433,8 @@ mt7915_mac_tx_free(struct mt7915_dev *dev,
>> struct sk_buff *skb)
>>  		mt7915_txwi_free(dev, txwi, sta, &free_list);
>>  	}
>>  
>> -	mt7915_mac_sta_poll(dev);
>> +	if (!mt7915_firmware_offload(dev))
>> +		mt7915_mac_sta_poll(dev);
> 
> @ Sujuan, can you double check if MCU_EXT_EVENT_TXRX_AIR_TIME works for
> all firmware versions? Maybe we can use this single event directly if
> everyone agrees with this change.
> 
> I'd suggest adding some persuasive testing datas into the commit
> message to help reviewers make adjudgement.
How often is this event sent? I think the effectiveness of airtime 
fairness after this change needs to be carefully verified.

- Felix
