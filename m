Return-Path: <linux-wireless+bounces-29107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2131C6AB8B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 50D102C286
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 16:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC136C583;
	Tue, 18 Nov 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="dwtGxNE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34A31B81D
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484480; cv=none; b=P4UFa/2gjBoxlwAkmLwMPFNDSSrTAaCf1lA+iQP6NOVpfysZtEynmM/yDKfS4qknmgC3FJT/WNudDspp4qcEnU9nqEJkhv3yqIDEcb1OtU+yYLDyKoxLekdw54FUu+pGyPK1bULA9Pjt0Bd01XdFg250XPj+3J4zOrgBBQDQunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484480; c=relaxed/simple;
	bh=lLSgYY3i5r+JgI9mN8z2RZ2BOLs5IO10SpxyYmXDv90=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e8l2YRnWE5oYvPWdVV3dAut8otXOi9lhq7/kFTWNdSVopHmvfTE9zRuy5VNPTpaCvp58d10CEn/gMOaOLOhagkw3uEtwaI7xhzso29QyIk3SI/o/WFc/M7gbHRo4rs24yT92RjP5J6Yhan/tjSDoEZpzoiSiuqnR6elDnAuJ3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=dwtGxNE8; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 66EC580086;
	Tue, 18 Nov 2025 16:47:56 +0000 (UTC)
Received: from [172.18.0.200] (unknown [64.190.177.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id D6F7913C2B3;
	Tue, 18 Nov 2025 08:47:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D6F7913C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1763484474;
	bh=lLSgYY3i5r+JgI9mN8z2RZ2BOLs5IO10SpxyYmXDv90=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dwtGxNE8D2O5KtiBt96gX6CjYuJoeoCE1Rog9sZCvymughAqEAVqOIlcR7TCAcJnC
	 tDCrN/q40zBN/D2AJyM15asJy7/5GNSbGe3tCrmj61j3LYO1FAdinQZ04N5yvFEW+T
	 H68wkVK1Ua6E/P2iaULxNGk3reDjbn9JDcrqpqLg=
Message-ID: <6180e894-0071-470a-a8c6-59cdf888488d@candelatech.com>
Date: Tue, 18 Nov 2025 08:47:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: fix multi-radio on-channel scanning
From: Ben Greear <greearb@candelatech.com>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>
References: <20251118102723.47997-1-nbd@nbd.name>
 <c1557aad-e2ea-4a31-960b-16694569b4de@candelatech.com>
Content-Language: en-MW
Organization: Candela Technologies
In-Reply-To: <c1557aad-e2ea-4a31-960b-16694569b4de@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1763484477-EUIUn3fIT26M
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1763484477;EUIUn3fIT26M;<greearb@candelatech.com>;f011ffe4f9d64eb14099b4b464132aed
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/18/25 5:46 AM, Ben Greear wrote:
> On 11/18/25 2:27 AM, Felix Fietkau wrote:
>> From: Chad Monroe <chad@monroe.io>
>>
>> avoid unnecessary channel switch when performing an on-channel scan
>> using a multi-radio device.
>>
>> Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
>> Signed-off-by: Chad Monroe <chad@monroe.io>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   drivers/net/wireless/mediatek/mt76/scan.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
>> index ff9176cdee3d..0b1922f7792e 100644
>> --- a/drivers/net/wireless/mediatek/mt76/scan.c
>> +++ b/drivers/net/wireless/mediatek/mt76/scan.c
>> @@ -16,7 +16,7 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
>>       clear_bit(MT76_SCANNING, &phy->state);
>> -    if (dev->scan.chan && phy->main_chandef.chan &&
>> +    if (dev->scan.chan && phy->main_chandef.chan && phy->offchannel &&
>>           !test_bit(MT76_MCU_RESET, &dev->phy.state))
>>           mt76_set_channel(phy, &phy->main_chandef, false);
>>       mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
>> @@ -94,7 +94,7 @@ void mt76_scan_work(struct work_struct *work)
>>           return;
>>       }
>> -    if (dev->scan.chan && phy->num_sta) {
>> +    if (dev->scan.chan && phy->num_sta && phy->offchannel) {
>>           dev->scan.chan = NULL;
>>           mt76_set_channel(phy, &phy->main_chandef, false);
>>           goto out;
>> @@ -102,20 +102,22 @@ void mt76_scan_work(struct work_struct *work)
>>       dev->scan.chan = req->channels[dev->scan.chan_idx++];
>>       cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
>> -    mt76_set_channel(phy, &chandef, true);
>> +    if (dev->scan.chan != phy->main_chandef.chan)
>> +        mt76_set_channel(phy, &chandef, true);
> 
> Do you still need to call the cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
> method above if scan.chan == main_chandef.chan?
> 
> Thanks,
> Ben

Nevermind, I see why you need it.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

