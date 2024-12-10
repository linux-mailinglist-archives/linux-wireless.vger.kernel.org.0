Return-Path: <linux-wireless+bounces-16178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D759EBA5B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 20:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C308D166181
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8624E23ED59;
	Tue, 10 Dec 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="W+3M30zi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111921420D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860500; cv=none; b=Ftj5jdu1G7E6WYhWrLi81JwDIAlCXYXn7QY/VK2d5BYjk2cNr1lCNm7YsrycTHMuqycF9usSifWwZ4GiKVYUTWAqMhAxAuaSbyAKFSXjqKNAW2ralB0/kcbIUlp7BxpXOuCvmjdOvX19WbAIEykN4KX32YpCMWu6SIMVp6LoG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860500; c=relaxed/simple;
	bh=hOj+7C9ZNR8//pTVIkxn6L392fi+zId+NSvhg2SPr7I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gMZ5bOjktfpWPro5C7ygFG9c32N7+vt9wlNYiAWd3n33WroD5+09rz0ojXmtUbktYI/fwMKc0IlTi4DIVOTxSaglNzLTZir6dsmdPG8e1xI5BaCW3Jskr91dUb4Mqx2BFIG1dZWtWGZZ+Pp1Ey6m9qPxcUQ31FXRpO3AegOVFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=W+3M30zi; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C60AA340081;
	Tue, 10 Dec 2024 19:54:55 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 305E713C2B0;
	Tue, 10 Dec 2024 11:54:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 305E713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733860495;
	bh=hOj+7C9ZNR8//pTVIkxn6L392fi+zId+NSvhg2SPr7I=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=W+3M30ziK+GlwJ3nicJ86fZv7TfKg1UGem3YDtAXqooXNiGnYXykq0yuNpZGJllt3
	 WEvGh/7TYt8ywflX0bzwT83LL/Ixw4vPtXKM/Zg3h/4PeBT4oIqIzSpFYCSxG69Xjs
	 66pks5ghQ5Djn5KMWnRKlb6DfcyVAy522hw6vChU=
Message-ID: <a4d7f22d-d441-5380-f4bc-782ffb5b58ad@candelatech.com>
Date: Tue, 10 Dec 2024 11:54:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240828202630.2151365-1-greearb@candelatech.com>
 <MW5PR11MB5810BAD7A2731D2DDACF5F7BA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
 <2eb6cc22-4148-42c4-8cea-b1db0846a63b@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <2eb6cc22-4148-42c4-8cea-b1db0846a63b@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1733860496-0vd-XcpLeCEu
X-MDID-O:
 us5;at1;1733860496;0vd-XcpLeCEu;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/21/24 12:24, Ben Greear wrote:
> On 11/21/24 12:11 PM, Korenblit, Miriam Rachel wrote:
>>
>>
>>> -----Original Message-----
>>> From: greearb@candelatech.com <greearb@candelatech.com>
>>> Sent: Wednesday, 28 August 2024 23:26
>>> To: linux-wireless@vger.kernel.org
>>> Cc: Ben Greear <greearb@candelatech.com>
>>> Subject: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
>>>
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> Do not make assumptions about what band 'a' or 'b' are on.
>>> And add new reason code for when eMLSR is disabled due to band.
>>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>> ---
>>>   drivers/net/wireless/intel/iwlwifi/mvm/link.c | 13 ++++++++++---
>>> drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
>>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>>> b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>>> index bb3de07bc6be..f3fb37fec8a8 100644
>>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>>> @@ -16,6 +16,7 @@
>>>       HOW(EXIT_LOW_RSSI)        \
>>>       HOW(EXIT_COEX)            \
>>>       HOW(EXIT_BANDWIDTH)        \
>>> +    HOW(EXIT_BAND)            \
>>>       HOW(EXIT_CSA)            \
>>>       HOW(EXIT_LINK_USAGE)
>>>
>>> @@ -750,11 +751,17 @@ bool iwl_mvm_mld_valid_link_pair(struct
>>> ieee80211_vif *vif,
>>>           iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
>>>           return false;
>>>
>>> -    if (a->chandef->width != b->chandef->width ||
>>> -        !(a->chandef->chan->band == NL80211_BAND_6GHZ &&
>>> -          b->chandef->chan->band == NL80211_BAND_5GHZ))
>>> +    if (a->chandef->width != b->chandef->width)
>>>           ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
>>>
>>> +    /* Only supports 5g and 6g bands at the moment */
>>> +    if (((a->chandef->chan->band != NL80211_BAND_6GHZ) &&
>>> +         (a->chandef->chan->band != NL80211_BAND_5GHZ)) ||
>>> +        ((b->chandef->chan->band != NL80211_BAND_6GHZ) &&
>>> +         (b->chandef->chan->band != NL80211_BAND_5GHZ)) ||
>>> +        (a->chandef->chan->band == b->chandef->chan->band))
>>> +        ret |= IWL_MVM_ESR_EXIT_BAND;
>>> +
>>>       if (ret) {
>>>           IWL_DEBUG_INFO(mvm,
>>>                      "Links %d and %d are not a valid pair for EMLSR, a-
>>>> chwidth: %d  b: %d band-a: %d  band-b: %d\n", diff --git
>>> a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>>> b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>>> index ac4e135ed91b..22bec9ca46bb 100644
>>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>>> @@ -368,6 +368,7 @@ struct iwl_mvm_vif_link_info {
>>>    *    preventing the enablement of EMLSR
>>>    * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
>>>    * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary
>>> link
>>> + * @IWL_MVM_ESR_EXIT_BAND: Exit EMLSR due to incompatible Bands
>>>    */
>>>   enum iwl_mvm_esr_state {
>>>       IWL_MVM_ESR_BLOCKED_PREVENTION    = 0x1,
>>> @@ -382,6 +383,7 @@ enum iwl_mvm_esr_state {
>>>       IWL_MVM_ESR_EXIT_BANDWIDTH    = 0x80000,
>>>       IWL_MVM_ESR_EXIT_CSA        = 0x100000,
>>>       IWL_MVM_ESR_EXIT_LINK_USAGE    = 0x200000,
>>> +    IWL_MVM_ESR_EXIT_BAND        = 0x400000,
>>>   };
>>>
>>>   #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
>>> -- 
>>> 2.42.0
>>>
>> Hi Ben.
>>
>> It is actually required that a (the better link) will be on 6 GHz and b on 5 GHz
>> Regarding the new exit reason, it is not really needed as we can easily differentiate between the cases (from other logs)
> 
> Hello Miri,
> 
> I tested this patch, and it fixed problems for me when I ran a test that created
> interfering traffic on 5ghz and then later on 6Ghz.  I expected eMLSR mode to stay
> active no matter where the interfering traffic existed.  With this patch, and a few
> others I posted, the be200 then works fairly well.
> 
> 6Ghz is not always better, for instance in case where it is congested with
> external traffic.
> 
> Can you please let me know *why* you think the better link must always be 6ghz in this case?

Hello Miriam,

I wanted to check to see if you still consider this patch invalid?  If so, I'll adjust
it to work better as out-of-tree patch and add it to my pile.

If you think core logic is fine but the patch needs some tweaks, please let me know your
suggestions.

Thanks,
Ben


