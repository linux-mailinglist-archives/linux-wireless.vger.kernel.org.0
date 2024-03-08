Return-Path: <linux-wireless+bounces-4501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5BD876A20
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 18:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A9D1F225A7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Mar 2024 17:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB118C1A;
	Fri,  8 Mar 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AEjDaLVI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227631E4A9
	for <linux-wireless@vger.kernel.org>; Fri,  8 Mar 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919851; cv=none; b=NBVywrjTD9876WYdutkB0NuEsxrlGd88bNzqBK3qN5MSA/9FZwl2HXObteLXYlXbpzQa79dMAKjLA89Rg91zTkgeQSnKOD9hU5kOH3b6AS+c/KSeW57mU8yaS3yoUHAJ/u16f+wtN5sAblcvm5DoFGd1pQeyOAbZu4+aGQ+mFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919851; c=relaxed/simple;
	bh=LkeOnudSuWPolOTOChhjMlm5fRCbUIX7mTSVjYBlHA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBeonq0QJQgMK4XxhKrzBHcPW7vnVmaVzG6RDFx/W96CUEikDsaRo/7e0tmpi+aUrmgqxTzO72RLOyi2FpeDMMsnB33dnKcqOuiEgl+LUxNZVLq1QVp71Go8VdjGpLr5OThanWHNKcCDzFN1X5vF/K3CrN0gVOIfwLqYcflPbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AEjDaLVI; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 37F0560006B;
	Fri,  8 Mar 2024 17:44:07 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4968513C2B0;
	Fri,  8 Mar 2024 09:44:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4968513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709919845;
	bh=LkeOnudSuWPolOTOChhjMlm5fRCbUIX7mTSVjYBlHA8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AEjDaLVICTqsWVDL3oi3aXDhuZRjK2lStysNArsJU2viBe8N/XTljuHrbrnqLP0Yc
	 As3SsTSo+DnnaYt7P9utyMCrjR5bkq2PvsSw/JRodLo8oR6owIwOQ7RQErUq2LXfcF
	 9jCX67tql6Q+2Okw4AkaEkDSRmIRk8KiYXovgSp4=
Message-ID: <69b95f70-d43f-4ed5-9aa6-5a3f498700bf@candelatech.com>
Date: Fri, 8 Mar 2024 09:44:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Improve bss-color configuration.
Content-Language: en-MW
To: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org
References: <20240307181039.3219840-1-greearb@candelatech.com>
 <7ab9885b-5fb6-4686-b29b-d287e569293b@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <7ab9885b-5fb6-4686-b29b-d287e569293b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1709919847-m8eLzND5mFx7
X-MDID-O:
 us5;ut7;1709919847;m8eLzND5mFx7;<greearb@candelatech.com>;4d73edfb1b11e4059731496ff152f6e4

On 3/8/24 09:40, Jeff Johnson wrote:
> On 3/7/2024 10:10 AM, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Always tell driver to apply bss color settings if beacon indicates
>> the bss coloring has been set.
> 
> why? please describe the problem you are fixing

To ensure driver is set to known state.  This does not fix any known bug,
but seems appropriate, and I noticed driver wasn't being set to
disabled when BSS color was disabled while debugging some other issues
(the driver in question defaulted to disabled).

>> And only enable bss coloring if beacon indicates bss color setting
>> is valid and also enabled.

This seems more correct behaviour to me.  It does not fix any known
problem.

Thanks,
Ben

>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   net/mac80211/cfg.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>> index 327682995c92..aaa62c05428c 100644
>> --- a/net/mac80211/cfg.c
>> +++ b/net/mac80211/cfg.c
>> @@ -1314,7 +1314,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>>   			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
>>   		changed |= BSS_CHANGED_HE_OBSS_PD;
>>   
>> -		if (params->beacon.he_bss_color.enabled)
>> +		if (params->beacon.he_bss_color_valid)
>>   			changed |= BSS_CHANGED_HE_BSS_COLOR;
>>   	}
>>   
>> @@ -1494,6 +1494,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>   	int err;
>>   	struct ieee80211_bss_conf *link_conf;
>>   	u64 changed = 0;
>> +	bool color_en;
>>   
>>   	lockdep_assert_wiphy(wiphy);
>>   
>> @@ -1530,9 +1531,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
>>   	if (err < 0)
>>   		return err;
>>   
>> -	if (beacon->he_bss_color_valid &&
>> -	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
>> -		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
>> +	color_en = beacon->he_bss_color.enabled && beacon->he_bss_color_valid;
>> +	if (color_en != link_conf->he_bss_color.enabled) {
>> +		link_conf->he_bss_color.enabled = color_en;
>>   		changed |= BSS_CHANGED_HE_BSS_COLOR;
>>   	}
>>   
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


