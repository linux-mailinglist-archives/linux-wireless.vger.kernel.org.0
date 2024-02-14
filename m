Return-Path: <linux-wireless+bounces-3595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C48551BF
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE052992F5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A0512A142;
	Wed, 14 Feb 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="V2P9hVhx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531051272D7
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934149; cv=none; b=UOoZYbhbO/QvW22gvYcF/jdXJxWC1dcP3Q3+B6KNRIq7xHH+GDp9VSMDTIUvIlYn3X2JQ4ZAJKmpWlB7Z0O2Gw9jTmpjGlpjRPp7ySzQF8LMR87kPfJK8o+eKWmK+LK4ACql8fDERGikXh70tF8eSnWbRpHVRKIJpcTs6JXgcfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934149; c=relaxed/simple;
	bh=Slk+qe7+wd3UQjJPJZX28GS89SLvGOhwEQPTnKc8Too=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qkuoti2mHPMuzzjdZB8+m08yARjz5BgQ62WGVLfN4WKFiBjHmHIEcUrXUz58XlXxGa158CSNHGHSBZG0UjGOKgRgiuns8249fGRfQdD7CFMFgC2MTiE//+1SJ+wxnQP9eTImmyctTwv9Ot5oxL5Z66D4PcQgryIlvfTYXgw4PBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=V2P9hVhx; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5756FB00082;
	Wed, 14 Feb 2024 18:08:59 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 9648013C2B0;
	Wed, 14 Feb 2024 10:08:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 9648013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1707934138;
	bh=Slk+qe7+wd3UQjJPJZX28GS89SLvGOhwEQPTnKc8Too=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=V2P9hVhxRj26JlYVXKdUpnY1AaH4t1fxnXZ+o3h34zMNIJobhlxWmn7xDdQa53d7A
	 RYg3wJsHoN920ijSVd0wQr+3iP4AW8FfTPblmoyei2inhWbor7j43cBPPNsBIeOMW9
	 U59BIznvHhgI4hUImBe3ZCO8hS9SKkNaBmRrG/Bc=
Message-ID: <35f63154-eb24-c279-9ae3-096f3aec75bc@candelatech.com>
Date: Wed, 14 Feb 2024 10:08:58 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
Content-Language: en-US
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
 <MW5PR11MB581035988083537C57286DADA34E2@MW5PR11MB5810.namprd11.prod.outlook.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <MW5PR11MB581035988083537C57286DADA34E2@MW5PR11MB5810.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1707934140-Q2_W04j051EM
X-MDID-O:
 us5;ut7;1707934140;Q2_W04j051EM;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7

On 2/13/24 22:08, Korenblit, Miriam Rachel wrote:
> : iwlwifi RFC related to iwl_mvm_tx_reclaim
>>
>> Hello,
>>
>> I'm seeing a crash due to accessing an 'sta' object in this method that is '-2' as
>> integer.
>>
>> It fails the initial check for null STA, but I'm thinking it might should check for
>> IS_ERR(sta) as well.
>>
>> (I have my own patch that references sta before the IS_ERR check later in the
>> code, and this causes the crash I'm seeing.  I guess upstream will not crash in this
>> situation.).
>>
>> My question:  Is the patch below a preferred approach, or should I add special
>> checks to where I access sta and only exit the method lower where it already has
>> the IS_ERR(sta) check?
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
>> b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
>> index 0567f4eefebc..bd3d2fe424cd 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
>> @@ -2337,7 +2337,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm
>> *mvm, int sta_id, int tid,
>>           sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
>>
>>           /* Reclaiming frames for a station that has been deleted ? */
>> -       if (WARN_ON_ONCE(!sta)) {
>> +       if (IS_ERR(sta) || !sta) {
>>                   rcu_read_unlock();
>>                   return;
>>           }
>>
> 
> Hi,
> 
> Did you see this: 2b3eb122342c?
> 
> This can explain why the code is how it is.
> And no, you should not access the sta pointer before checking if IS_ERR.

Thanks for the pointer.  I think if I ever see the WARN_ON_ONCE(!sta) hit then
I'd want to just try to remove that and let the reclaim code work, and check for null in the IS_ERR() logic
added by the patch you referenced.

But I have not seen sta be NULL, and Johannes is fine with current code, so for now
I think it is fine as is.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



