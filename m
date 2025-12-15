Return-Path: <linux-wireless+bounces-29739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E326CBC6FC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 05:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96183301C0AF
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 04:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E731ED78;
	Mon, 15 Dec 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="SpArnzPt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail66.out.titan.email (mail66.out.titan.email [3.216.99.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4694931ED72
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.216.99.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770672; cv=none; b=jwhJi0+QSlZo++39Y7zm4WDIplE7CxCviZvLjYIPuXl3VUqY2ksxQNFARC4McJ4SAI4tGeUHWTZAfwxZ2WVuPvLjCSpqic9WvdKG+sPgmHxVRz9SPsAktDnLVhH2Pe7tlmHx+wj1VS8GN64IIyFnut+2tF5ji5IhgUVA7MiLbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770672; c=relaxed/simple;
	bh=J18Jw5H9RPUchSnE0svQUKBZBIqeUdP4PUjtGE7O8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR58pmTeTTUHS28RDFypR6ZIehsoDMRDs2xYfwk3Gm1zuiYM3YqFcEGSl6qAWp+wXV+7Vzk1bHSm06IuOQPWG6TRO1i0OL0BuyNl1Gsi8rccfsKDwvK3c4Xxp+3jl3UCvvTQDC2iwW9SVRAQ880VMaa1Eh/q4K3+Pp3XrgMBIGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=SpArnzPt; arc=none smtp.client-ip=3.216.99.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dV5VF1n63z2xBK;
	Mon, 15 Dec 2025 03:42:29 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=bKCrOiA7/P+MZsTh36bLrFTi2l+0P02csnPywnMu9Xg=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=from:cc:message-id:to:in-reply-to:date:references:subject:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765770149; v=1;
	b=SpArnzPtGR+gmQFp9upU0+tvZNQLhbhEhkIHW65IPvqideBGFZeY6JqgmPNywozHVBiOrjJh
	deVfVmvu+zVYhu3g5X7f/e+4GvBMf/EykstgPEEvJ9xXoRuMRXoC4WAv9hQEjZIJ4nyvwQQwqgv
	YHSonP3FxumyFpYuQsYVcNI8=
Received: from pie (unknown [117.171.66.90])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dV5V874j5z2x9X;
	Mon, 15 Dec 2025 03:42:24 +0000 (UTC)
Date: Mon, 15 Dec 2025 03:42:17 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: David Wang <00107082@163.com>, thostet@google.com
Cc: daniel.gabay@intel.com, jeffbai@aosc.io, johannes.berg@intel.com,
	kexybiscuit@aosc.io, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com,
	nathan@kernel.org, netdev@vger.kernel.org,
	pagadala.yesu.anjaneyulu@intel.com, richardcochran@gmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH iwlwifi-fixes] wifi: iwlwifi: Implement settime64 as stub
 for MVM/MLD PTP
Message-ID: <aT-DmZTh_8I13Mg1@pie>
References: <20251204123204.9316-1-ziyao@disroot.org>
 <20251214101257.4190-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214101257.4190-1-00107082@163.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765770149083250194.27573.1538939435451385954@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=TPG/S0la c=1 sm=1 tr=0 ts=693f83a5
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=QyXUC8HyAAAA:8 a=LpNgXrTXAAAA:8 a=SYGaFrxvNFvLGzGqgu4A:9
	a=CjuIK1q_8ugA:10 a=LqOpv0_-CX5VL_7kjZO3:22 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

On Sun, Dec 14, 2025 at 06:12:57PM +0800, David Wang wrote:
> On Thu, Dec 04, 2025 at 12:32:04PM +0000, Yao Zi wrote:
> > Since commit dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if
> > required ops are NULL"), PTP clock registered through ptp_clock_register
> > is required to have ptp_clock_info.settime64 set, however, neither MVM
> > nor MLD's PTP clock implementation sets it, resulting in warnings when
> > the interface starts up, like
> > 
> > WARNING: drivers/ptp/ptp_clock.c:325 at ptp_clock_register+0x2c8/0x6b8, CPU#1: wpa_supplicant/469
> > CPU: 1 UID: 0 PID: 469 Comm: wpa_supplicant Not tainted 6.18.0+ #101 PREEMPT(full)
> > ra: ffff800002732cd4 iwl_mvm_ptp_init+0x114/0x188 [iwlmvm]
> > ERA: 9000000002fdc468 ptp_clock_register+0x2c8/0x6b8
> > iwlwifi 0000:01:00.0: Failed to register PHC clock (-22)
> > 
> > I don't find an appropriate firmware interface to implement settime64()
> > for iwlwifi MLD/MVM, thus instead create a stub that returns
> > -EOPTNOTSUPP only, suppressing the warning and allowing the PTP clock to
> > be registered.
> 
> This seems disturbing....If a null settime64 deserve a kernel WARN dump, so should
> a settime64 which returns error.

They're separate things. A ptp clock implementing not provinding
settime64() or gettime64()/gettimex64() callback will crash when
userspace tries to call clock_gettime()/clock_settime() on it, since
either ptp_clock_settime() or ptp_clock_gettime() invokes these
callbacks unconditionally.

However, failing with -ENOTSUPP/-EOPNOTSUPP when clock_settime() isn't
supported by a dynamic POSIX clock device is a documented behavior, see
man-page clock_getres(2).

> Before fixing the warning, the expected behavior of settime64 should be specified clearly,

I think failing with -EOPNOTSUPP (which is the same as -ENOTSUPP on
Linux) when the operation isn't supported is well-documented, and is
suitable for this case.

One may argue that it'd be helpful for ptp_clock_register() to provide
a default implementation of settime64() that always fails with
-EOPNOTSUPP when the driver doesn't provide one.

However, it's likely a programming bug when gettime64()/settime64() is
missing, so the current behavior of warning sounds reasonable to me.

> hence why the dfb073d32cac ("ptp: Return -EINVAL on ptp_clock_register if required ops are NULL")?

You may be interested in the original series[1] where the idea of
warning for missing settime64/gettime64/gettimex64 callbacks came up.

Also cc Kuniyuki, in case that I missed something or got it wrong.

> 
> David

Best regards,
Yao Zi

> > 
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Closes: https://lore.kernel.org/all/20251108044822.GA3262936@ax162/
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> 

[1]: https://lore.kernel.org/all/20251028095143.396385-1-junjie.cao@intel.com/

