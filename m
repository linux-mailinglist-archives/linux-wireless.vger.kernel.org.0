Return-Path: <linux-wireless+bounces-29559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C68ECAA8C8
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 16:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862C230A9119
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Dec 2025 15:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22802246778;
	Sat,  6 Dec 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFFdYhqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE913AA2F;
	Sat,  6 Dec 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765033310; cv=none; b=Vnr09pna4klaGuGMnLXHysCrxaTLJPJsy/Dt5vKuhJNvdEljpi9PGwNaLOpnyPZTF+vR2zCSimYOir21ItFVtUeYavCEhLRVW4qfxcP3blCNIFefcjQ//WO1F/NFD5xZOIbFXo/oyqdaMoYY9tJSsDCMdXvwiabvJ1Q5PDKN+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765033310; c=relaxed/simple;
	bh=7zQZp9gSG5slwJhE/n6/Q6eXVElwKEeuSY5VlUi3fVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDRdDswKJQzBqXBPOkpRtC9xili3APBLMKPV8zik4KBQ1QeHKZ1VrR2rVOxVO1D5c7sclGkrECc+46s2tfpSZEOzIkouj7xfxlgaSDC/Sk3LHbO4KQema469VcSDWe6u2/EJSbybc9BwIiQg64sJbibR2YwdJmO2HZ6l/0nBKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFFdYhqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED8C4CEF5;
	Sat,  6 Dec 2025 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765033308;
	bh=7zQZp9gSG5slwJhE/n6/Q6eXVElwKEeuSY5VlUi3fVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFFdYhqOhxcPxNpZWOtmX/NmCda/sPfjTmddspnbjYpMgfg/dIvJ+iRWnYfwVHmZr
	 aFn4CCtqfKwItFY/yL5D7eQPqAZKVke8j6BLhh0tUgrohO0j498qWYCyKZSbwyr9M/
	 JNB7QnKcJ9nEnEc5GETJaJvIfmngGTWbV/XafjMXNO2w8pJ4WaQ62GsRBsEiLA8gyD
	 sfdA3Eubnu6ObpHEYzZ7CE5jlwF1GieX8A1jkEuEfC2YMVAOBKMuyRZGQUztBvxE8e
	 6G3RqZn1gnhc4CEESxATCqxy+wpVLxKlY8t58o/zbotGzLxd4y3QTy1jH8PsHN0Eo8
	 c7tSz8/ypwptQ==
Date: Sat, 6 Dec 2025 15:01:44 +0000
From: Simon Horman <horms@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Message-ID: <aTRFWCGHO-eU6_JV@horms.kernel.org>
References: <20251204123204.9316-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204123204.9316-1-ziyao@disroot.org>

On Thu, Dec 04, 2025 at 12:32:04PM +0000, Yao Zi wrote:
> Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> required ops are NULL"), PTP clock registered through ptp_clock_register
> is required to have ptp_clock_info.settime64 set, however, neither MVM
> nor MLD's PTP clock implementation sets it, resulting in warnings when
> the interface starts up, like
> 
> WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> 
> I don't find an appropriate firmware interface to implement settime64()
> for iwlwifi MLD/MVM, thus instead create a stub that returns
> -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> be registered.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Reviewed-by: Simon Horman <horms@kernel.org>


