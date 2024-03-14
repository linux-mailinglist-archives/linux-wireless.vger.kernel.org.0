Return-Path: <linux-wireless+bounces-4761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641387C178
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0759F1F21F3A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB1B73526;
	Thu, 14 Mar 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvvSvmap"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665D7351E
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434705; cv=none; b=bZA3wv+wfONkDNzgOy0nEXHGgIC12y7TO0UB7VnkOIhDDbIH7g55nasZkO8taitnjmD2Blbvw0wA5Eo+gQTbPeH2YBBs44qs4aImaNT9fNAdJV63ie3Jkl3UtZum/1FlfzIRa9p3E0OCe35ZYlS9Deo2mLEWlCZPD2dy6LzNGJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434705; c=relaxed/simple;
	bh=3rUj+mXvS6cQYpRc7HsWZ1EgGhCgHVdn29FomCViicU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GTzUtydnBj2mSy1IVSyy+bGUpczhA4lQcxVEZvM2W1PWQW+gXTyz9fHp+SR7ImgGHoPx7ftWuZEKaNk0lPRA8pnR/Wzr863Hfh0u864+nSRD0sqhNg7cfVYfNxJ4jeGt4KwA9URgQqMoIHTmLiyXdYKRK/MicCEIMvAlckbjwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvvSvmap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D58DC433F1;
	Thu, 14 Mar 2024 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710434705;
	bh=3rUj+mXvS6cQYpRc7HsWZ1EgGhCgHVdn29FomCViicU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PvvSvmapt1obVEFRIEgdCGApBQKWx+t2FVCtYbnwFEC7JXMloJ78Cal02lQFQD7Sl
	 QYFn/tuRgDBS/rW4Z0CKhkxkEV1Ks0qNrMoC8hRGPrsAkMeFp+pEmbZJIBkMwrZwzC
	 MVPLiIy8Yj2qI4vL0Y+WekYRZm0JZeV1WkfgzxEJ55gajYibvVGgDEigZO+TIs5KEF
	 qexHDpgVTYBA3v7o3nU4MBCbFb/P++9iGb/eCmzIe7sVLOHavTsRVHXFQ8hh3Dfzbp
	 6E2bhPtyiEU8qEw8BwtYNAFMtiRIIfxClgX12qXghaGd04YyfehepzCPhSnlU6Nt26
	 w0Y+EutFr2XJQ==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  ath12k@lists.infradead.org
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
	<20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
	<87bk7g4x08.fsf@kernel.org>
	<09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
	<87plvwepjq.fsf@kernel.org>
	<db6a60e0dbd66f307a5890d958f67029ad5bcb4f.camel@sipsolutions.net>
Date: Thu, 14 Mar 2024 18:45:02 +0200
In-Reply-To: <db6a60e0dbd66f307a5890d958f67029ad5bcb4f.camel@sipsolutions.net>
	(Johannes Berg's message of "Thu, 14 Mar 2024 17:40:21 +0100")
Message-ID: <87le6kep9t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2024-03-14 at 18:39 +0200, Kalle Valo wrote:
>> Johannes Berg <johannes@sipsolutions.net> writes:
>> 
>> > On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>> > > 
>> > > > -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
>> > > > +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>> > > 
>> > > I think we should add the same for ath12k, right?
>> > > 
>> > 
>> > It's really up to you, I think. I'm hoping to even get this into stable,
>> > FWIW.
>> 
>> ath12k doesn't support MLO yet but I feel that disabling wext already
>> now would be consistent from user's point of view.
>
> Ah, you're in the situation where wext is still enabled now, but will
> disappear when you enable MLO.

Exactly.

> Agree then that it would make sense to disable wext right now so it's
> not a software upgrade for the same hardware that removes it.

Good, thanks for confirming.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

