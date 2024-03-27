Return-Path: <linux-wireless+bounces-5374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F9088EB99
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 17:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E439293BE3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F70149E1F;
	Wed, 27 Mar 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nOgGCeYW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F92212F583
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558146; cv=none; b=Ckfc91V9cmjNiea7FhXfCnixZEKfQbdcPHUoBQ+OSgBpYD6cu1TjcwSVlw/kAnWKZ+6IuaHopgwHuYdi+noqf6ZUOBIQS45fihxtQeH62PEU7Av40gc+kAVOjpQ1DkIo/HhjQckygS+lHSM1BoQzvGqGT3AjGALcir4ygKK+mpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558146; c=relaxed/simple;
	bh=tbp6KZ04r4B1c4Q0pk1lD2JPlBlcT8pOim03CLlTlzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlAmA/YTiNT+Aam7hrIfaGEyAF6vPHNqjeihiqJ5Pg4MywAX6zAk2naxDV9NXaGqSuNpZKx7k5/rI0O4/dvpNZYd8xG16zXo2hjguuEwR11DdEd8CtlPlu/bnez5s3B61yK6BPAgd5adFUpuMb3w7lgT5eaaBTj0uYuJiPzpelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nOgGCeYW; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4373710006B;
	Wed, 27 Mar 2024 16:49:03 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E485113C2B0;
	Wed, 27 Mar 2024 09:49:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E485113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711558142;
	bh=tbp6KZ04r4B1c4Q0pk1lD2JPlBlcT8pOim03CLlTlzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nOgGCeYWkHCdJmloX9UY/SFiccBZzLG0Agj7Z4941EkMnUYEMa0fkkLzAXOpeW/0K
	 mCUJf0BokAD4gzMWEg9byoNrhPpeigj84b0QT97YaM7ZgAquZIlabOckIb3IS5KCWH
	 Lae4QJDMY534EdffuSQohcla8Z8JfBq/+2YMJjyk=
Message-ID: <2dda8ef8-b004-2afc-c398-5a3c92aa7267@candelatech.com>
Date: Wed, 27 Mar 2024 09:49:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: mt76: mt7925: Fix invalid chandef access.
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20240320192723.3440938-1-greearb@candelatech.com>
 <ZftrMyXvN7JcWhHH@lore-desk>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZftrMyXvN7JcWhHH@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711558143-YeMDW48QTesw
X-MDID-O:
 us5;ut7;1711558143;YeMDW48QTesw;<greearb@candelatech.com>;0161bc757c83381a5b931166ef547186

On 3/20/24 16:03, Lorenzo Bianconi wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> mt76.ctx can be null, and that causes chandef to be null.
>> Use logic found in similar code paths to use chandef
>> from the phy object in case ctx is NULL.
>>
>> With this, my system no longer crashes, but STA will still not
>> associate.
> 
> Hi Ben,
> 
> can you please add 'Fixes' tag to help people backporting the fix?
> I think it is:
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")

I'm not able to reproduce the crash on upstream drivers, the crash only happened when
I had a local patch that caused it to not associate.

I still think the patch should go upstream as there may be other paths to hit the bug,
but maybe it doesn't need to be backported?

Let me know if you still want me to do the Fixes thing.

Thanks,
Ben

> 
> Regards,
> Lorenzo
> 
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>> index bd37cb8d734b..feb818411a25 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
>> @@ -1502,7 +1502,8 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
>>   		       struct ieee80211_vif *vif, struct ieee80211_sta *sta)
>>   {
>>   	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
>> -	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
>> +	struct mt76_phy *mphy = mvif->phy->mt76;
>> +	struct cfg80211_chan_def *chandef = mvif->mt76.ctx ? &mvif->mt76.ctx->def : &mphy->chandef;
>>   	struct sta_rec_phy *phy;
>>   	struct tlv *tlv;
>>   	u8 af = 0, mm = 0;
>> @@ -1569,7 +1570,8 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
>>   			     struct ieee80211_vif *vif, struct ieee80211_sta *sta)
>>   {
>>   	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
>> -	struct cfg80211_chan_def *chandef = &mvif->mt76.ctx->def;
>> +	struct mt76_phy *mphy = mvif->phy->mt76;
>> +	struct cfg80211_chan_def *chandef = mvif->mt76.ctx ? &mvif->mt76.ctx->def : &mphy->chandef;
>>   	enum nl80211_band band = chandef->chan->band;
>>   	struct sta_rec_ra_info *ra_info;
>>   	struct tlv *tlv;
>> -- 
>> 2.42.0
>>
>>

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



