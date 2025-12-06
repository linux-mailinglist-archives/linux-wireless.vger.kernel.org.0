Return-Path: <linux-wireless+bounces-29564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36BCAAECE
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 23:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10BFB305D43F
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC0628642A;
	Sat,  6 Dec 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="st0ncobw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED93B8D47;
	Sat,  6 Dec 2025 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765061356; cv=none; b=bWvdrz0AG6ESNgwaAd4+mnOu0V6fEMlEbjN00Qb/G1ZeYyqagTzldPEaNwbsY1Ie7BQmncmgeIZK0uSOLO1dZLJUSy8q/4Yp5pbjPaB6r+ZHGJ/+kvo+wG81Moq8sVkGPd5/dKj2dK+aK0giqhdl35Nfu8BTKGJeyn4MqvYauQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765061356; c=relaxed/simple;
	bh=IUQ/hH7VPF1SoDvn/Dyqq+wuxhvVp/0Hq1JPBziJA64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWp2pMbecs5zjYQ38xV6X2qCohNdXe21MUSOLDcevtSvHr64CJTE7+miHn+rohitlIkFkTM6Qdi1DY9q1zNMnhKPj3PR4omVjpVyfjo/saMKfLTKfPQ9DzazC8HTo7Dkj/vqLDfM2Z7cSzauxfhqs2iWY25nQG2n0sxFR00O0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=st0ncobw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F34C4CEF5;
	Sat,  6 Dec 2025 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765061354;
	bh=IUQ/hH7VPF1SoDvn/Dyqq+wuxhvVp/0Hq1JPBziJA64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=st0ncobwc9cpWYTuI681GcN0qL9NVK42wI1kCX+EEKjPXHicfDaJpQ1FYgTCaDiFd
	 q7REefiCqYkRiOYCmbgEHqM6At2gI41sq1yhSdBMYP7UUaTsDUGBhkYuAJ2tx2Z2Mj
	 z9ith9XjjVQ/xWnmxqvOGltgplW4Be/6hT+QySHUo8vcmwrfb/X5qUSAicn8wRCz1N
	 ijlb5At7NNK4ghy3JONjoKxx4P/P/CQX0yOjg9abVhlWVe0gZEVpJ+sVVpUW+eibag
	 /neNKNKwTc7TP2xQ3Z/7NPJrn/vGRV8boRCUUXHSoEhAaU7k3qxzkzrBXoazkCPRzQ
	 tci6XN86GyL7Q==
Date: Sat, 6 Dec 2025 17:49:12 -0500
From: Sasha Levin <sashal@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] wifi: cfg80211: stop radar detection
 in cfg80211_leave()
Message-ID: <aTSy6CoUlKZy_GSs@laps>
References: <20251206140252.645973-1-sashal@kernel.org>
 <20251206140252.645973-26-sashal@kernel.org>
 <e883efe1f9e4bccb144400b82a35110c79451b37.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e883efe1f9e4bccb144400b82a35110c79451b37.camel@sipsolutions.net>

On Sat, Dec 06, 2025 at 03:55:37PM +0100, Johannes Berg wrote:
>On Sat, 2025-12-06 at 09:02 -0500, Sasha Levin wrote:
>>
>> ### Conclusion
>>
>> This commit fixes a legitimate bug but does **not** meet stable kernel
>> criteria:
>> - The maintainer did not request stable backporting
>> - The affected code only exists in kernel 6.12+, making it only relevant
>>   to the most recent stable branch if any
>> - The bug severity (warnings, not crashes/corruption/security) does not
>>   warrant the backporting effort
>> - It cannot be cleanly applied to most stable trees due to structural
>>   code differences
>>
>> **NO**
>
>:)
>
>To be fair, it's kind of a corner case that happened mostly during tests
>as far as I know, when two mesh peers getting radar detection happen to
>pick two incompatible channels and then give up, causing wpa_s to bring
>down the interface.
>
>The thing that makes this interesting is that they both detect radar at
>*precisely* the same time because they're actually simulated on a single
>Linux system, and our regulatory code tells each and every radio if any
>of them detects radar.
>
>Anyway, either way is reasonable, it's probably a much older issue than
>6.12 (then we just shuffled things around due to MLO), but the issue
>would've been around before that, and nobody really seems to have
>noticed outside this specific test.

Commits still get a review after the LLM response, which something is (IMO)
wrong :)

I'll keep it in, thanks!

-- 
Thanks,
Sasha

