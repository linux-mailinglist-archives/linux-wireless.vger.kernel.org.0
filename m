Return-Path: <linux-wireless+bounces-25596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213EB08953
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62895848AA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC61FBEB0;
	Thu, 17 Jul 2025 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="X/Zhj2sw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1411F4CB2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744658; cv=none; b=smT2FNChKnrprSdpoo36p+UqXRPCDvJ948tZAH923AbHGHZGZ5zE0NI384crFhva6cnxhKCw/wXDIXuycCOoe191jNEKVVDwh1BGlJ1dHzSiO76GYH2HopxmcERC/D/huTFVUMPrrDSpWAToSbA94KTDIL2N62usZWhBP2DBSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744658; c=relaxed/simple;
	bh=zSkvXX4z9mpwBWIEALRF/kJ3oVQiCMffWXJGd48lkz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iz0F+aEr86xQFbn8M0YPfN1VK15RTp7mYsyTODSmhbPPpWlQDp0PbqXjNfobAvX+f3CQ/N4HAyma2AqIJIZHAz+iFiwPmOuzqh1cD0u25276HSF4mymERHJOwfiU8nqru+i+pcrM4u7AR1R0u8/LXUUq/IgpA3RYmFFGGph/2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=X/Zhj2sw; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-953a8a3ca9; t=1752744649;
 bh=LmSV96VHNrQGJY5BI+Opr1DPFDAAZp5C9H/zCM1J1TI=;
 b=X/Zhj2swkbCcFAtzARVKbPomNP6H84ROtN2vFk0CkjPDSEZmrw9XxD1z2l79pzZVFbvE0FK/N
 ryT+P8NJIQUg5EVjn0LpNisjeAACe+s5MtigyhHFfpqQwTW+AOlt701//SoBMV4xQzPE/l1Q1PQ
 IDQe+S10j09w1XHD9C12YRTCjiLysGXpynSzktZRvpNUalnSd+roD2Pw8Fki2q63WrdprF0f2yW
 p98nv7CiqCN6ML7PkCAU835D/ZzaBhZLLYYlvyU/YhXzHrwBt+fTrb/wsoLC7+qHXrR3RVYQwGF
 LOeGrdQ3YfB9OLURsm6s/Mdf+uoHWXmSvTf6+8dWooeg==
X-Forward-Email-ID: 6878c2aef8a4ace82a39e823
X-Forward-Email-Sender: rfc822; r41k0u@ubuntu.com, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <75d0bb19-b2c5-43ba-a323-dfa18507dce5@ubuntu.com>
Date: Thu, 17 Jul 2025 14:59:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
To: Stefan Wahren <wahrenst@gmx.net>,
 Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>,
 arend.vanspriel@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com, aspriel@gmail.com,
 brcm80211-dev-list.pdl@broadcom.com, franky.lin@broadcom.com,
 hante.meuleman@broadcom.com, johannes@sipsolutions.net, kvalo@kernel.org,
 linux-wireless@vger.kernel.org, marcan@marcan.st
References: <19358720a28.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20241125064940.11746-1-renjaya.zenta@formulatrix.com>
 <59c2ab2f-57e5-4196-a7ba-5db066d38958@gmx.net>
Content-Language: en-US
From: Pragyansh Chaturvedi <r41k0u@ubuntu.com>
In-Reply-To: <59c2ab2f-57e5-4196-a7ba-5db066d38958@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I investigated this bug some time ago. I didn't do a git bisect as it 
takes forever to compile again and again, but I used GDB over SWD to 
debug this on a Raspberry Pi 5.
https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2063365 - 
specifically the 8th, 9th and 10th comment.

The regdom flags set in brcmf_setup_wiphybands (which happens during 
startup) get wiped off by restore_custom_reg_settings and the 
corresponding orig_flags contain outdated/invalid data. During a new 
disconnect-reconnect cycle, these flags retain their invalid data from 
orig_flags.

I have suggested 2 possible fixes (not patches) and I am not sure what 
the tradeoffs would be in both of those cases. One possible fix is 
changing the orig_flags for the channels at the end of 
brcmf_setup_wiphybands (which I don't think is a neat idea), the other 
is to call brcmf_setup_wiphybands during every disconnect - reconnect cycle.

I think any of these fixes is better than the current suggested 
workaround of turning of DUMP_OBSS feature. I think my findings will 
help fix this. Please suggest which of these approaches would be a more 
appropriate fix, or feel free to suggest a better approach.

Regards
Pragyansh


On 11/25/24 17:07, Stefan Wahren wrote:
> Am 25.11.24 um 07:49 schrieb Renjaya Raga Zenta:
>> On 11/23/24 4:54 PM, Arend Van Spriel wrote:
>>
>>> This was reported earlier by Stefan Wahren, but the thread ran dry.
>> Yes, I've read the whole thread. I guess what I've found is similar
>> to what Stefan found. Those channels are disabled by the driver in
>> brcmf_construct_chaninfo() but are re-enabled in reg.c.
>>
>> I see there hasn't been any conclusion yet, so I just bumped this 
>> thread.
>>
>> Stefan did a workaround by modifying brcmf_construct_chaninfo() to store
>> the IEEE80211_CHAN_DISABLED flag within orig_flags in case the flags had
>> it. I see no further ACK, so I think that's not the proper solution.
> Unfortunately I'm don't have much Wifi knowledge & time to push this
> further. So I'm would be happy, if someone take care of about this
> annoyance.
>>> So what changed a couple of days ago? System upgrade?
>> Well, I use the latest OS from Raspberry Pi, it still uses 6.6.51. I 
>> guess
>> there is no significant changes from what Stefan tried.
> I think it should be mentioned, there is no usable Raspberry Pi 5
> support in Mainline yet. So the mention version is a vendor kernel tree.
>
> Regards
>>
>> Regards,
>> Renjaya
>
>

