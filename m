Return-Path: <linux-wireless+bounces-26586-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A12B3459D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9373B23C1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAD2FE063;
	Mon, 25 Aug 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="JYbDW4d9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6212FE041
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135246; cv=none; b=lPAeBtcldLxX5RPwEwvljgpFmkUnD5a8cxb9nE3FFMZ5f03Xy6O0PiAKB+I91eZsVOwPB1WF+g9MTafINyaHCRCcMTxUdEVw2E6NR/9//5RIi4ACIHe2/BuIpBu+NLO+kPL2mEYEWVk8Zn98PCIbljTajwlPhOgYFxTXC589G4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135246; c=relaxed/simple;
	bh=gSRyg3SQwxvzfHGRbjIT5rOwkHa8j1NtJWWkBnfepj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx49Td9sLjG9kNxq7MyI/yMaJdE6ihH5k9Rq/HWXEUJpxUFwcJVzlNEl+tFjqx71jpgFWCLNYPHc1EB8Ez0POmWFjQxXTnq2H2h6XhObfaxF3Owi6KpCbvjx7CVgl8E2dmjusMJ6NL6/usJsKDtGo4d3F1dvdOyxvL3AkkauFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=JYbDW4d9; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 340081001F5;
	Mon, 25 Aug 2025 15:20:35 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.33.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id B308A137575;
	Mon, 25 Aug 2025 08:20:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B308A137575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1756135234;
	bh=gSRyg3SQwxvzfHGRbjIT5rOwkHa8j1NtJWWkBnfepj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JYbDW4d9e057g9SqSmid8Xslz/23UU4jqHJmhAv7ex1unlmNSlEb0LaSOB27xYvLJ
	 kquNuk1eO6L6KSFLBn0K7/A+TgMD8uDcGhBUR7Wpy+Bj+hUH1SM/IjN9sRAVjSyztb
	 B7vbIx04fFUOKhTxtFSWhg7H9NmXu5B3CzWmp4DI=
Message-ID: <e311453b-ddc5-438a-8d4a-da33040feb17@candelatech.com>
Date: Mon, 25 Aug 2025 08:20:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VRF and UDP broadcast frames
To: David Ahern <dsahern@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>
References: <39bf5755-254b-e7b8-cc15-500be99d0a6b@candelatech.com>
 <511a143b-183d-40aa-926c-25931e03b2f4@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <511a143b-183d-40aa-926c-25931e03b2f4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1756135236-tK0ao4Jdm8KY
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1756135236;tK0ao4Jdm8KY;<greearb@candelatech.com>;4c2240863895b102c0149f3444b48d5f
X-PPE-TRUSTED: V=1;DIR=OUT;

On 8/25/25 07:16, David Ahern wrote:
> [ cc'ed Ido ]
> 
> On 8/22/25 1:16 PM, Ben Greear wrote:
>> Hello,
>>
>> Assume I have a network interface assigned to a VRF (wifi AP interface
>> is what I'm testing now).
>> I would like to have it be able to send and receive UDP broadcast
>> frames.  I am binding the socket
>> to the AP netdev with SO_BINDTODEVICE.  From what I can tell, the socket
>> at least cannot receive
>> UDP broadcasts sent to it.  I do see the broadcast arriving on the AP
>> interface if I run tshark.
>>
>> Is there any particular issue with UDP broadcast sockets in VRF?  Do I
>> have to instead
>> bind to the vrf netdev instead of the ap netdev?
> 
> I am not aware of any issues with VRF and broadcast, but the fcnal-test
> suite (covers permutations across the uapi) is lacking broadcast tests.
> 
> As I recall you tend to run relatively new kernels, so either device
> should work.
> 
> I use the fib:* tracepoints as a start point for debugging cases like this.

I think I just had general mis-understanding about how udp bcast worked.
It seems that if you bind the socket to a specific IP on the interface,
it will not receive bcast frames, even if you set the broadcast flag on
the socket.  It will send bcast frames fine when bound like this.

But, if you bind your socket to 255.255.255.255, then it will receive
packets sent to 255.255.255.255 (but not packets sent to 192.168.1.255, for instance).

I was expecting it to be a bit more lenient about how it receives udp
bcast frames.

While poking at this, I found the 'socat' tool, which seems good for testing
this.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


