Return-Path: <linux-wireless+bounces-11962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394595EDEF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F481C21738
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 10:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539442AA0;
	Mon, 26 Aug 2024 10:00:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC9145B1F
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666430; cv=none; b=D7b05n/Goja59KxaSl89XVPT6IitbiC7bZmD3A5xglQbMWCBtrRQ6S+ZAz/97lKpQ05bx/W8CS18OtXhbj1JllXywbdilgUH6X2jSPWXS9u7vUNFEm8pSDfI4DxvVBckWbK20w4aOzJ++ToMzxmfmT3/IEU4NheJEbY3eS8OT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666430; c=relaxed/simple;
	bh=09jhWOnkxDVfb8Yz6zOonjn5P+Qcq8OhpPg6YtP1234=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psssEWtn8wqrMqF3i8lA52lDJ9SqNqRjSaCQvEgEouHaPb437GDtTBm2EzS0tRserczDFUqi+mwP/IQ966Se78lPYkb8Dxm3S8qYhTGECGahvdP6pHRUeNzL8A2frgIvXIFBfN5VjxXjewyDzUYkAKde4JCnWP9Wq4fcys5vs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from [IPV6:2003:c5:9714:6a90::32b] (p200300C597146a90000000000000032B.dip0.t-ipconnect.de [IPv6:2003:c5:9714:6a90::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 05C07FA131;
	Mon, 26 Aug 2024 11:51:04 +0200 (CEST)
Message-ID: <a2a5e90a-4a24-4c83-9bfe-43b4e32cf73c@simonwunderlich.de>
Date: Mon, 26 Aug 2024 11:51:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: cfg80211: Set the channel definition for the
 different Wi-Fi modes when starting CAC
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, quic_jjohnson@quicinc.com
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org, lkp@intel.com,
 llvm@lists.linux.dev, mathias.kretschmer@fit.fraunhofer.de,
 oe-kbuild-all@lists.linux.dev
References: <9809b165-8d25-4984-a1dd-6fca28f1dda9@quicinc.com>
 <20240816142418.3381951-1-ih@simonwunderlich.de>
 <6a9916848826a07ca41f1170e1d20cda9e798872.camel@sipsolutions.net>
From: Hamdi Issam <ih@simonwunderlich.de>
In-Reply-To: <6a9916848826a07ca41f1170e1d20cda9e798872.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/23/24 12:42, Johannes Berg wrote:
> On Fri, 2024-08-16 at 16:24 +0200, Issam Hamdi wrote:
>> @@ -10143,7 +10143,23 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
>>   
>>   	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
>>   	if (!err) {
>> -		wdev->links[0].ap.chandef = chandef;
>> +		switch (wdev->iftype) {
>> +		case NL80211_IFTYPE_MESH_POINT:
>> +			wdev->u.mesh.chandef = chandef;
>> +			break;
>> +		case NL80211_IFTYPE_ADHOC:
>> +			wdev->u.ibss.chandef = chandef;
>> +			break;
>> +		case NL80211_IFTYPE_OCB:
>> +			wdev->u.ocb.chandef = chandef;
>> +			break;
>>
> OCB cannot even get to this code given earlier conditions, why are you
> adding it here?

Actually I didn't test it with OCB mode, I added the check on the 
different modes to make sure that the function "wdev_chandef" return a 
no NULL chandef for the different modes.

I will remove the check on the OCB mode, if it will impact other 
implementation.

>
> I guess this should conflict:
>
> https://lore.kernel.org/linux-wireless/20240711035147.1896538-1-quic_adisi@quicinc.com/
>
> but it's probably not too hard to resolve that.
>
> johannes
Issam

