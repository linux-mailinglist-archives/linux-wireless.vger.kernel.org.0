Return-Path: <linux-wireless+bounces-4767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59E87C2A5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A48286D73
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C674E0F;
	Thu, 14 Mar 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5vkYECx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529974E0A
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440915; cv=none; b=l+Cuf8H8mYWG2OmrFvD4LUMnu7YKM0YE5RVTZShnxA0Mhwc0SVebsFbI8eKlrqGeRsj9FU5idvWX1uVXlRItC0qxUSjjy1QDLbtJKMTFuHnaHLjvW+xI6ZuM6U7YJBVtuQ+kSWPuoKspbjuU/xto5sbf0B3YfoBoIcjc+vd7X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440915; c=relaxed/simple;
	bh=NTXQxwuJ31ty4EL4cdcFnyfkJRuGxEuDEQ/8YoGL0aM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U9dIpvOuqtrpKesfn20qKmJkmyCSirHAYzJskytW9sjL23kIZVWPjWlr65ublBPmgIjgJ75umxkenZ5zY/XzmQm0I+1XQcz/s5veJv3G4PsfffmKon7KzSOrqC7rWLV9LchHXAKIfgTT045xO0hO9t6qWqK/kOAZ2H47zeYNT88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5vkYECx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC41C433C7;
	Thu, 14 Mar 2024 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710440914;
	bh=NTXQxwuJ31ty4EL4cdcFnyfkJRuGxEuDEQ/8YoGL0aM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e5vkYECxZwUvcrwGnTINr2Jf5n9ogUcMPt9qTRrIX980vjEc1ZrwMPQH0aJlRar8W
	 fWnNCz6et9YZKaU390+WgC5bS/vzLsu8guBdScxbE1+EvKdSZf04/6OeJHGDZiWatb
	 dpXB1zhShbYngHJDrFFA2oiRokOqqtihVbWvrxVKzQmiTkAJwT1Q4lwM2TpRziwlio
	 N1iLFWdNW+JpF7AVOPmIZdJX4mSKK8Bu5xxbme280aY/DDqxh9Y9c4Xq2BEz17ndBa
	 s6aaCK5VbXaqQ8jgvpJm/iRvMdiBEQ/mfwCCJfwfmI2ocdrvcbX68G7CM1CHeP/sSI
	 a5QryMBoJM8IA==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
  <linux-wireless@vger.kernel.org>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  <ath12k@lists.infradead.org>
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	<20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	<87bk7g4x08.fsf@kernel.org>
	<09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
	<87plvwepjq.fsf@kernel.org>
	<50b2d162-00a1-4001-894b-d5560c4226b2@quicinc.com>
Date: Thu, 14 Mar 2024 20:28:31 +0200
In-Reply-To: <50b2d162-00a1-4001-894b-d5560c4226b2@quicinc.com> (Jeff
	Johnson's message of "Thu, 14 Mar 2024 09:42:08 -0700")
Message-ID: <87h6h8ekhc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/14/2024 9:39 AM, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>>> On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>>>>
>>>>> -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
>>>>> +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>>>>
>>>> I think we should add the same for ath12k, right?
>>>>
>>>
>>> It's really up to you, I think. I'm hoping to even get this into stable,
>>> FWIW.
>> 
>> ath12k doesn't support MLO yet but I feel that disabling wext already
>> now would be consistent from user's point of view.
>
> Now that I understand what this is doing I completely agree. We should prevent
> the use of wext with ath12k.

And thinking more about this I think it would be good that other drivers
supporting Wi-Fi 7 hardware do the same until they also support MLO. Of
course Wi-Fi 6 and older hardware should still support wext,
unfortunately :/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

