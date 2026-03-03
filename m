Return-Path: <linux-wireless+bounces-32396-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPEaFH/vpmlKaQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32396-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:26:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F61F16C1
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BBD8306512C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D11946DA;
	Tue,  3 Mar 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="rzrlDG3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705633914FF
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547691; cv=none; b=r0d8cSgLmC9sUnkj6ZJCz6mizh7V4d1512SnS8nDR5TmJMH6c5dp+PObE4eD0laGCEAb2QX9sTFFREh06Ob8j2GErMZ2/oZehvVL/dBTvvO2/I7rPIVNJx/ENO0wBQ0RudyUGvXfNqzftQGLO8r/ufhK70m13FUde31LRSNAe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547691; c=relaxed/simple;
	bh=50LZceDftR06qK84PBs0P8lmoFCTVhJ2uTQv07UJTrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dNLDXVRFw2rXSiqRoGZUcmqv4KCKSekW90gqVpE2JlQ7ZECcy0Ngm87baTh+1luBBjTbceYGR1YNoD4ye0Cnf9bDk8Mwwnx8Kfqve7Zv5rygDGMYZ4oz7fFIrDvx4BjuyCWmcV7IyDD+yX8VAbvrTKF8osKFNk4Lk0W940wGZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=rzrlDG3e; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2E5E1240071;
	Tue,  3 Mar 2026 14:21:28 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.34.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id C8B6C13C2B1;
	Tue,  3 Mar 2026 06:21:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C8B6C13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772547685;
	bh=50LZceDftR06qK84PBs0P8lmoFCTVhJ2uTQv07UJTrM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rzrlDG3evQQHWqJWZD6AIhY1t2ooF7wSbdHC+ePn/MgQU72l5mnFWmCyvkE2uZgJc
	 NxJ/9cafi8v3vBS64QAIYEBGLktBtZskmzevk5VHkpkTIAicrqGRBK3RXUsntGnTrD
	 Q0trm2YnjqOJ3hIdk4nHOY3oIcj6H9RMGO7t33Yg=
Message-ID: <495b7e8d-454c-4c0f-8976-c31fcee0783d@candelatech.com>
Date: Tue, 3 Mar 2026 06:21:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi-mld: Fix fw id leak in OOM case
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <02f66cee-4892-24a3-9a07-1e722fe8888f@candelatech.com>
 <DM3PPF63A6024A927179DD5C6D8BEB45B11A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <DM3PPF63A6024A927179DD5C6D8BEB45B11A37FA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772547689-k5R9R0FAxsK3
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772547689;k5R9R0FAxsK3;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: F27F61F16C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-32396-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 23:28, Korenblit, Miriam Rachel wrote:
> 
> 
>> -----Original Message-----
>> From: Ben Greear <greearb@candelatech.com>
>> Sent: Tuesday, March 3, 2026 1:07 AM
>> To: linux-wireless <linux-wireless@vger.kernel.org>; Korenblit, Miriam Rachel
>> <miriam.rachel.korenblit@intel.com>
>> Subject: iwlwifi-mld: Fix fw id leak in OOM case
>>
>> Hello Miriam,
>>
>> I believe you will want to add something like this to your driver to clear the
>> fw_id_to_link_sta ID in case you hit the ENOMEM case.
>>
>> I have no reason to believe I am actually hitting this error case, but I saw this
>> questionable code while looking for reasons for the use-after-free I am hitting.
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
>> b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
>> index 5fb2a46241e4..de9939ad1d58 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
>> @@ -535,13 +535,19 @@ iwl_mld_add_link_sta(struct iwl_mld *mld, struct
>> ieee80211_link_sta *link_sta)
>>           ret = iwl_mld_allocate_link_sta_fw_id(mld, &fw_id, link_sta);
>>           if (ret)
>>                   return ret;
>>
>>           if (link_sta == &link_sta->sta->deflink) {
>>                   mld_link_sta = &mld_sta->deflink;
>>           } else {
>>                   mld_link_sta = kzalloc(sizeof(*mld_link_sta), GFP_KERNEL);
>> -               if (!mld_link_sta)
>> +               if (!mld_link_sta) {
>> +                       IWL_ERR(mld, "mld-add-link-sta, OOM, clearing
>> fw_id_to_link_sta[%d]\n",
>> +                               fw_id);
>> +                       RCU_INIT_POINTER(mld->fw_id_to_link_sta[fw_id],
>> + NULL);
>>                           return -ENOMEM;
>> +               }
>>           }
>>
>> Thanks,
>> Ben
>>
>> --
>> Ben Greear <greearb@candelatech.com>
>> Candela Technologies Inc  http://www.candelatech.com
> 
> Please send a patch

Are you fine with having IWL_ERR in the patch like I have above?

Thanks,
Ben

> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


