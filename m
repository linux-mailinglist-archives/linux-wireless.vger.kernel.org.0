Return-Path: <linux-wireless+bounces-15575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABA9D53F4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 21:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CA61F23177
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C121AAE38;
	Thu, 21 Nov 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="StsbVsMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669C1D4144
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220703; cv=none; b=ChK2+VxSzbYDOAsifsUyvYmLSiWKKRQ+oLa/I62g8xov7KoFqC7eQ0nTjb/HpXbh0qP+oLFF42AYRDHt+Wo0E/orYGb9TCtOM7k8sOJKg0xmfPmWh+6Tf5uTmfa6Ds0h24g0YzsjnBeVtygjhZmE5+K96E1XT641dlc0s5UoVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220703; c=relaxed/simple;
	bh=Wv9HSib9QQ/0Juvmh266G1Jw/M46TEzFq80KfgWGHYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bj7MotYeicpGwPGQxCFknIAx47IzvkvlsiTAV/nL9S/szJhA8qBCcGYaqUQrRUWdOw+BhebPFrb+XgZnjesVshl3AFVoFu17l7Ixh1KtuKUG08ko6SCKCUzRg6Z5e6zupxaLAXXoqZai+NalMxOnP/2JduxOwANNVndb7T83Tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=StsbVsMm; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4D427C0081;
	Thu, 21 Nov 2024 20:24:53 +0000 (UTC)
Received: from [IPV6:2607:fb90:731f:1540:c582:3c6e:e21c:730a] (unknown [172.56.240.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7E29113C2B0;
	Thu, 21 Nov 2024 12:24:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7E29113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732220692;
	bh=Wv9HSib9QQ/0Juvmh266G1Jw/M46TEzFq80KfgWGHYI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=StsbVsMmxhFoWQtMXIMQo5mT/J7BbXPnngsNNkdN72wI0EpJY0yMpxdLjRbL2rlE6
	 uJrB3F+rbEq58AoKTSpr5lfddQYu7CHM7mLxsaO4ff1dgkxHcGD21b1vvXJAt3Zas5
	 ZVBCPYpICq+H3+q5my0nt5/YLbDbBs6WFI/GJLkE=
Message-ID: <2eb6cc22-4148-42c4-8cea-b1db0846a63b@candelatech.com>
Date: Thu, 21 Nov 2024 12:24:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20240828202630.2151365-1-greearb@candelatech.com>
 <MW5PR11MB5810BAD7A2731D2DDACF5F7BA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <MW5PR11MB5810BAD7A2731D2DDACF5F7BA3222@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1732220694-aQv__jDbPQRN
X-MDID-O:
 us5;ut7;1732220694;aQv__jDbPQRN;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/21/24 12:11 PM, Korenblit, Miriam Rachel wrote:
> 
> 
>> -----Original Message-----
>> From: greearb@candelatech.com <greearb@candelatech.com>
>> Sent: Wednesday, 28 August 2024 23:26
>> To: linux-wireless@vger.kernel.org
>> Cc: Ben Greear <greearb@candelatech.com>
>> Subject: [PATCH 1/2] wifi: iwlwifi: Fix eMLSR band comparison.
>>
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Do not make assumptions about what band 'a' or 'b' are on.
>> And add new reason code for when eMLSR is disabled due to band.
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   drivers/net/wireless/intel/iwlwifi/mvm/link.c | 13 ++++++++++---
>> drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>> b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>> index bb3de07bc6be..f3fb37fec8a8 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
>> @@ -16,6 +16,7 @@
>>   	HOW(EXIT_LOW_RSSI)		\
>>   	HOW(EXIT_COEX)			\
>>   	HOW(EXIT_BANDWIDTH)		\
>> +	HOW(EXIT_BAND)			\
>>   	HOW(EXIT_CSA)			\
>>   	HOW(EXIT_LINK_USAGE)
>>
>> @@ -750,11 +751,17 @@ bool iwl_mvm_mld_valid_link_pair(struct
>> ieee80211_vif *vif,
>>   	    iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
>>   		return false;
>>
>> -	if (a->chandef->width != b->chandef->width ||
>> -	    !(a->chandef->chan->band == NL80211_BAND_6GHZ &&
>> -	      b->chandef->chan->band == NL80211_BAND_5GHZ))
>> +	if (a->chandef->width != b->chandef->width)
>>   		ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
>>
>> +	/* Only supports 5g and 6g bands at the moment */
>> +	if (((a->chandef->chan->band != NL80211_BAND_6GHZ) &&
>> +	     (a->chandef->chan->band != NL80211_BAND_5GHZ)) ||
>> +	    ((b->chandef->chan->band != NL80211_BAND_6GHZ) &&
>> +	     (b->chandef->chan->band != NL80211_BAND_5GHZ)) ||
>> +	    (a->chandef->chan->band == b->chandef->chan->band))
>> +		ret |= IWL_MVM_ESR_EXIT_BAND;
>> +
>>   	if (ret) {
>>   		IWL_DEBUG_INFO(mvm,
>>   			       "Links %d and %d are not a valid pair for EMLSR, a-
>>> chwidth: %d  b: %d band-a: %d  band-b: %d\n", diff --git
>> a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> index ac4e135ed91b..22bec9ca46bb 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>> @@ -368,6 +368,7 @@ struct iwl_mvm_vif_link_info {
>>    *	preventing the enablement of EMLSR
>>    * @IWL_MVM_ESR_EXIT_CSA: CSA happened, so exit EMLSR
>>    * @IWL_MVM_ESR_EXIT_LINK_USAGE: Exit EMLSR due to low tpt on secondary
>> link
>> + * @IWL_MVM_ESR_EXIT_BAND: Exit EMLSR due to incompatible Bands
>>    */
>>   enum iwl_mvm_esr_state {
>>   	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x1,
>> @@ -382,6 +383,7 @@ enum iwl_mvm_esr_state {
>>   	IWL_MVM_ESR_EXIT_BANDWIDTH	= 0x80000,
>>   	IWL_MVM_ESR_EXIT_CSA		= 0x100000,
>>   	IWL_MVM_ESR_EXIT_LINK_USAGE	= 0x200000,
>> +	IWL_MVM_ESR_EXIT_BAND		= 0x400000,
>>   };
>>
>>   #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
>> --
>> 2.42.0
>>
> Hi Ben.
> 
> It is actually required that a (the better link) will be on 6 GHz and b on 5 GHz
> Regarding the new exit reason, it is not really needed as we can easily differentiate between the cases (from other logs)

Hello Miri,

I tested this patch, and it fixed problems for me when I ran a test that created
interfering traffic on 5ghz and then later on 6Ghz.  I expected eMLSR mode to stay
active no matter where the interfering traffic existed.  With this patch, and a few
others I posted, the be200 then works fairly well.

6Ghz is not always better, for instance in case where it is congested with
external traffic.

Can you please let me know *why* you think the better link must always be 6ghz in this case?

Thanks,
Ben

> 
> NACK.
> 
> Thanks,
> Miri


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

