Return-Path: <linux-wireless+bounces-5585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74818892005
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 16:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295811F3204E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEB214A098;
	Fri, 29 Mar 2024 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="WIktj+v1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6914A4EE
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723661; cv=none; b=UpKInAbRwwsyCNvZPC28ncm5RRjIezmjKaciklH2YhQTPxxCD9KM9LtM+vJa+4TO9JzKjD1/td33KS2BMv/lYbm3I6wzvwi2xGVWdVUfLLXz+yY6f0LDTiYwxyOX+Ttv+49YRSUKPICtUDrZiOuzNbGsANOlC6is3Op/mNGRTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723661; c=relaxed/simple;
	bh=P1Tei7DbL1b3vhxAkx+6T+RFMUZA0gXXejzIEwlMyFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3cZecbtoZYs0e2uV9n0tB+PyS+plrd4jNRG3y46pkLwpCQmXG9JMCl4qAtZSvheHZpWaRhpOHJLciLWA636p6MVc6LWgm6H0fJuRb5as4hmGL2lnjAMX3mbJFhvZWSS00SRNOqMi1SLTxmS86gWxwbeZxZZWazvpOP2szSfy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=WIktj+v1; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F09C280097;
	Fri, 29 Mar 2024 14:47:31 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.47.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 87C9D13C2B0;
	Fri, 29 Mar 2024 07:47:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 87C9D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1711723648;
	bh=P1Tei7DbL1b3vhxAkx+6T+RFMUZA0gXXejzIEwlMyFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WIktj+v18eFvR/M60pOW7q4mDtCPBrV3Pn6pq8MgN78zumFIapUeJhoGqOpGxu/+z
	 oMESzeOMdB7fdCZjhubaLi2r3zep16B2MOAJMCyktHplDA3YSi8aKNOt8oEIfWdVTC
	 55FzjgJLaNeoU7oZOtqCdtImjHucAzGClwcYjc5U=
Message-ID: <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
Date: Fri, 29 Mar 2024 07:47:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-MW
To: Johannes Berg <johannes@sipsolutions.net>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1711723653-p9K0gkySMaQY
X-MDID-O:
 us5;at1;1711723653;p9K0gkySMaQY;<greearb@candelatech.com>;e45dbe21c4fc86b950914d8831baea70

On 3/29/24 07:30, Johannes Berg wrote:
> On Fri, 2024-03-29 at 19:41 +0530, Vasanthakumar Thiagarajan wrote:
>>>
>>>> + * @hw_chans: list of the channels supported by every constituent underlying
>>>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>>>> + *	one wiphy can advertise the list of channels supported by each physical
>>>> + *	hardware in this list. Underlying hardware specific channel list can be
>>>> + *	used while describing interface combination for each of them.
>>>
>>> I'd expect there to be a limit on channels being within a single band on
>>> a single "hardware"?
>>>
>>
>> There are ath12k hardware supporting multiple band which need to be
>> registered under one mac80211_hw/wiphy. This design is to support such
>> hardware.
> 
> Oh OK, that was something that I didn't have in mind any more, or never
> knew or paid attention to.

Would it work to leave the phy reporting pretty much as it is now, but add
a 'associated_peer_radios' list section, so that each phy could report the phys
associated with it?  Then user-space, driver, mac80211 etc could look up the
other phys as needed to get a full picture?

At least with mtk 7996, it appears there will be 3 single-band phys can can be used
independently, but I assume when they have MLO support, those three will be logically
grouped.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


