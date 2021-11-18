Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5745611E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 18:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbhKRRJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 12:09:25 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:34880 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233906AbhKRRJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 12:09:25 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.123])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1DF631C007D;
        Thu, 18 Nov 2021 17:06:24 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0348D4C0156;
        Thu, 18 Nov 2021 17:06:22 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4D24613C2B0;
        Thu, 18 Nov 2021 09:06:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4D24613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637255162;
        bh=uLWiOIoNJ0vDtdmC87VDaGLbvgEiFz1nKkFbVFvXMbQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=pMYWbCbbTGMLB7ajLiG/mUE06NQUWKj5GovZI2XgWLbzuJmm9tACQuL1r1O1a+/+d
         PjnRcZFZHzFkgvYrLsiuKCVFmuOkYzbBS49rTrkDg5yq5HcntihXvGnVUA3JCRmK6L
         qkeWAzowg99HMhySbngqS38V09uRM/Shh6MGjbrA=
Subject: Re: [PATCH 4/8] mt76: mt7915: add note about TXSFM 0x2
To:     Ryder Lee <ryder.lee@mediatek.com>, linux-wireless@vger.kernel.org
References: <20211118164549.3863-1-greearb@candelatech.com>
 <20211118164549.3863-4-greearb@candelatech.com>
 <d8e9f53e4f6fc613ed6524abec050d248e448eeb.camel@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <4527b220-fe07-b7b5-658c-dfc231270feb@candelatech.com>
Date:   Thu, 18 Nov 2021 09:06:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d8e9f53e4f6fc613ed6524abec050d248e448eeb.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1637255184-zJRqSQunSu05
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/21 9:02 AM, Ryder Lee wrote:
> On Thu, 2021-11-18 at 08:45 -0800, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> This format needs a special command to enable, and is not enabled
>> by default.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
>> b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
>> index 7a2c740d1464..b66e740832e4 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
>> @@ -348,6 +348,9 @@ struct mt7915_tx_free {
>>   
>>   #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
>>   
>> +/* The F0 variables are for TXSFM 0x0 and 0x1.  The F1 variables
>> + * are for TXSFM 0x2 aka PPDU format.
>> + */
>>   #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
>>   #define MT_TXS5_F0_QOS			BIT(30)
>>   #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
> 
> Now that we don't need it why should it needs a special command.

It can be hard for a new developer to the driver to understand
the firmware API, so a comment could save the next person to look
at this some time and trouble.

Thanks,
Ben

> 
> Ryder
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

