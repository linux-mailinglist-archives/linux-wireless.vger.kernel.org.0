Return-Path: <linux-wireless+bounces-28534-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED095C314EA
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCC3AA2A9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8199732573A;
	Tue,  4 Nov 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnJx1Xs+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9E31B822;
	Tue,  4 Nov 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264328; cv=none; b=Jmb6bOJZu5b0eDC9qLl0k1ayfhpbL3Se3PwFp5u9oB2SLh5x+p1w64E1N5eRC/1UuNVElGAtN02PIG6jaGGvKYyrEx8kC4tU8IkYdu5OHpGCHNZBRiG7t+F3z2gNXRUYqdY3HK3jyO+Z15kxcNDIK6+N0Ql8KJF46savbVF+pXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264328; c=relaxed/simple;
	bh=mbfY2Aj5w6JYGO9ivAENnFh7/FZ0WRwLCEozi5mq2Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpmdLDOF7kfHE5yQ1Jg/HDnNtWDkWL4XMTEJjBQw+AZIQVVZLbpbvU5OdP6r4lNnJj10c5fmvwnjjx9dzuhad7Jw8d0ZLxWY2twHDgDibohbLkJXm6lUuXNFuzZ/7TZaarp4paXWCCA0Cprg+Xkp2d4z3sBZVmF+4lipMuOfWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnJx1Xs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98580C4CEF7;
	Tue,  4 Nov 2025 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264325;
	bh=mbfY2Aj5w6JYGO9ivAENnFh7/FZ0WRwLCEozi5mq2Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnJx1Xs+T4cCznIotMtrHqB0c2H7+yjjU3kpWBmv0NL9UVUPQ4cp1PEy2AzG5W3f4
	 b2gQJ+MGghDrJ4xHKdmpy56Q3h2aX1/3+m4zmiVjqeJMwTfxymIXM/JFXVZNlDjohq
	 V8Hi551mMu9ZwVzDWYs0I7OQtq1dn78WVrAHws+rCk0qpmD/Hfclrn4MioNseGYKWE
	 fQzqkZTvvBZARsfyut7S/j+GxtWmjltBgGGuPCfatwUhpJULFLnf2p0s8SqAxX/t/o
	 5odnpDTg6pjStjLjDZQ6Ps2ukjrmMCog1jfOK7j3WE8f9movVDq7NnjbKklc79G9qF
	 sL/cYUlkX+rMQ==
Date: Tue, 4 Nov 2025 08:52:04 -0500
From: Sasha Levin <sashal@kernel.org>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, patches@lists.linux.dev,
	stable@vger.kernel.org, Arien Judge <arien.judge@morsemicro.com>,
	chunkeey@googlemail.com, pkshih@realtek.com,
	alexander.deucher@amd.com, alexandre.f.demers@gmail.com,
	tglx@linutronix.de, namcao@linutronix.de, bhelgaas@google.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] wifi: mac80211: support parsing S1G
 TIM PVB
Message-ID: <aQoFBCjATfTapZDj@laps>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-99-sashal@kernel.org>
 <72966d6ccecfcf51f741ca8243e446a0aaa9b5c1.camel@sipsolutions.net>
 <ipjmlu4muicsgnm7kbkmp5pbcvjyjobne4zo4p4cjxv45la6cy@clmzwkjamyi7>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ipjmlu4muicsgnm7kbkmp5pbcvjyjobne4zo4p4cjxv45la6cy@clmzwkjamyi7>

On Sun, Oct 26, 2025 at 02:23:56PM +1100, Lachlan Hodges wrote:
>On Sat, Oct 25, 2025 at 08:36:04PM +0200, Johannes Berg wrote:
>> On Sat, 2025-10-25 at 11:55 -0400, Sasha Levin wrote:
>> >
>> > LLM Generated explanations, may be completely bogus:
>> >
>> > YES
>> >
>> > - Fixes a real functional gap for S1G (802.11ah):
>>
>> I guess, but ... there's no real driver for this, only hwsim, so there
>> isn't really all that much point.
>
>This also only includes the decoding side.. so mac80211 would be able to
>decode the S1G TIM but not encode it ? Additionally there's _many_ functional
>gaps pre 6.17 so I agree that this probably isn't a good candidate.

Dropped, thanks!

-- 
Thanks,
Sasha

