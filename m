Return-Path: <linux-wireless+bounces-15102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89D9C0A64
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3073B224F4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3932144BE;
	Thu,  7 Nov 2024 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="KBoo39EJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061862144AD
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994685; cv=none; b=MjxhxjmWNr/UpnqmxSTR6GXF8bK9rYRpLCsJ16wZoJ4DsPyCbakiGh7Bg3HQdI1N/2xzGiOfPwICs2bdp7oKc8V8Xihs79Qw384wqDgGNH3UCDC37Bqp2PDutgImj3oL2snZW6UqZ4XXvr15HRVsOamw/btFlsxEW+IiE3UKQ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994685; c=relaxed/simple;
	bh=9xCjmAG6yjYlwkjfafAKvEuz6ObxmKIEaZzHqjo5L/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kPbrlXLp4TvCA0ywrQCmibciWGGHIqrZuEm3BsiFfnyQyhnesYAySp4wEovJvFwR8nZyiKsZeHEcGedjaXqo0Fp1EMLpa4pQn25xQgHpF0Qh2xgTQM413nJQQv9Gm5jTATltTAakwAAQFfM1rZzH0phZxpQrzf9tB8+UJHg0Fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=KBoo39EJ; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6F6F928006B;
	Thu,  7 Nov 2024 15:51:15 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id EBCD413C2B0;
	Thu,  7 Nov 2024 07:51:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com EBCD413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1730994674;
	bh=9xCjmAG6yjYlwkjfafAKvEuz6ObxmKIEaZzHqjo5L/w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KBoo39EJBA6RXzsq3a3y/eiGpFhQJ4CSfsrivCKrPLIvc5yFab2X0pI56UX8BzYYc
	 E9hwi8UUCeoAc23lKHrZ8RpN4F2hHqrCZWQdQlt1El82okA4nsh6TAnH87eaoWbMGJ
	 h9ODAXO6bjdMEb1TpP7twWjdBS3ZaBvBayLLiDEo=
Message-ID: <f42ab1f0-83d0-0a12-1389-2e37463ac910@candelatech.com>
Date: Thu, 7 Nov 2024 07:51:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/2] wifi: mac80211: Assign tx-stats to the proper
 link.
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20241009164904.3906438-1-greearb@candelatech.com>
 <20241009164904.3906438-2-greearb@candelatech.com>
 <73b1eb45e666aff20cf1debfdee1b60b44b82b46.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <73b1eb45e666aff20cf1debfdee1b60b44b82b46.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1730994676-krjJt6BvsvDp
X-MDID-O:
 us5;ut7;1730994676;krjJt6BvsvDp;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/7/24 06:43, Johannes Berg wrote:
> On Wed, 2024-10-09 at 09:49 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> For drivers that can report the tx link-id, account tx
>> stats against that link.  If we cannot determine tx link,
>> then use deflink.
> 
> I was hoping Miri would look at the other patch ... but now that I
> consider it again, this should probably come with some documentation
> updates? Right now, it only says:
> 
>   * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
>   *      frame should be transmitted on the specific link. This really is
>   *      only relevant for frames that do not have data present, and is
>   *      also not used for 802.3 format frames. Note that even if the frame
>   *      is on a specific link, address translation might still apply if
>   *      it's intended for an MLD.
> 
> and actually it's in the _control_ section of the TX info, so it's not
> generally even preserved over to the _status_ section.
> 
> So rather than reusing this, we probably just need to introduce a new
> _status_ field for it. And probably make it link_id+1 so 0 means no
> value (this works because link ID 15 is invalid).

Where would you like this new field added?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



