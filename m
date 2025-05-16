Return-Path: <linux-wireless+bounces-23106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EBABA69E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 01:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DF71BC46E2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB4280326;
	Fri, 16 May 2025 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="durUsYM3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F819E96A;
	Fri, 16 May 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438631; cv=none; b=Y86mFegqW/N1HS/ktW1bKPuLMT3eiNmcw2Kx94L8V7FnyHIoUgsYTRlbevEvxadEWYv8hAMC5YBg++mhNqjxZEB5p4xv0q+n+7S1zTE3S/lvnJf5W8QeY12OHYSbSEF4ntgBzFojsG5r3YR7O5Pm7pCvpoG2sVNx0CT78wZQgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438631; c=relaxed/simple;
	bh=eU9So2H6JSVDR9DdL0BVFCQ2KUNrQq3i2KN/hSHRM9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCSb6mjbASjWLJv04cytpSY4r+Ylnthg5H+k2zseehmKOY/uEfk659wmVUpp61QUA5n+k9zZzCibyFkK2PZtWnGlWEUiMLbcYnWw7+5X87TwBMVaz8ldS+rdMcUbzimjRwOTAEPXOKVOObHayW2ykrt6QHM7H7ur19o7Add/kg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=durUsYM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08FC4CEE4;
	Fri, 16 May 2025 23:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438630;
	bh=eU9So2H6JSVDR9DdL0BVFCQ2KUNrQq3i2KN/hSHRM9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=durUsYM3g40FA3CUdtDkMf7//4AvpmdUCfgbNzlw3a6jdXi4j9KyEi6w7nV8qIhfW
	 /5DrzbKW5KVdEZIk6eUFeH6ywMu8ejti6U8i7VUAEEkLogeXuMs/NcDMYt6+LT6ttC
	 nTGXN+WReoCNV/b6R9nT2SbCti4wV+PiwRWJNQE3vf7xhEraT1dC6eKkTE1Y9ZJ6HM
	 lBr3sraiuvgISqQODF7OTpWoXaaidzk4C542JLnsgKhb+ABdVxAoMVKUCPHV2a0UZ0
	 oYZHXsBxMHBygUvsuV9ghbkB7qYIuJiwQkz5ZRJ3Air+AfJTCP6wux1YG8B3jotvqS
	 PAKq04FoI77EA==
Date: Fri, 16 May 2025 16:37:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [PATCH net-next] net: netlink: reduce extack cookie size
Message-ID: <20250516163709.5cbd66bc@kernel.org>
In-Reply-To: <20250516115927.38209-2-johannes@sipsolutions.net>
References: <20250516115927.38209-2-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 13:59:27 +0200 Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Seems like the extack cookie hasn't found any users outside
> of wireless, which always uses nl_set_extack_cookie_u64().
> Thus, allocating 20 bytes for it is pointless, reduce that
> to 8 bytes, and add a BUILD_BUG_ON() to ensure it's enough
> (obviously it is, for a u64, but in case it changes again.)

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

