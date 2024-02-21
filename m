Return-Path: <linux-wireless+bounces-3873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102085E519
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4827D283E63
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219B83CDF;
	Wed, 21 Feb 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2ualo2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72557BB00;
	Wed, 21 Feb 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538415; cv=none; b=Rxzp5oEMHSHLeerwSYawNeHF2U46u2JAH5DyMxbzCL/Fv5p5KiHMCsMRAIsN3BIR+u4cKNORuyncPm5j53WzqW+B1WCYWXMlKc6Jbsx0Qmq4ZV0UytPKL+fYwbrfexodXBxAHVGe9qnCTX58YQ5NtJHQWF4BPvOLbIvKOUVbnDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538415; c=relaxed/simple;
	bh=jxZwS9DN/zj+74jkA+Tojl38QtgkRwQ4DpNjiGFaawA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J81eSvge2iKvxhU9z/VM/xizVee7ACqlO/IM0gFjZ8G7oIO5xBwdNEdQAuhtPqgfarq9VnG3lsH+hOBB0sVwp/KTbdirZYHO3ns6W0xb4tBzgNTz5sKKvx6KJwsSehwHdSVccZK43kqflS+16M34qroY2b4fS+R/2mCQFEU76lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2ualo2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF5C433F1;
	Wed, 21 Feb 2024 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538415;
	bh=jxZwS9DN/zj+74jkA+Tojl38QtgkRwQ4DpNjiGFaawA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2ualo2McOjkeWFt8Ny1g5JkA0rbFsfW+tHcf5qM2Hny6sF5bRCZiPEFjlT237Jq5
	 2GTE/Em43/ZGYALhEcStY5oPj5DfA9MgfgKGUK0nzb0GYQdeNzMh3PuXipYfgWUYr6
	 C0YC6sD/+4gZcufJszBiMpW2zpoRlQtmz4OjYrKepJhFgHWyIgXNdgNf0X4E8IdZ2y
	 fwbJC66YKfHBeAvJSt7KEBRcq/N8OrHKKftTGy7NfHQTRKTePhqcKY7uPrldc4enSd
	 vNSr+BdMXVhca85/8/GJnkWsi4vy5MGHOlu42USDa+jUpz1p0UtPOAF+NiRkZ25kDu
	 a3iVVkVNck4iA==
Date: Wed, 21 Feb 2024 11:00:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: quic_jjohnson@quicinc.com, morbo@google.com, justinstitt@google.com,
	quic_periyasa@quicinc.com, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized use of ret in
 ath12k_mac_allocate()
Message-ID: <20240221180013.GA2074929@dev-arch.thelio-3990X>
References: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
 <170731849247.2220494.17976129376947521581.kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170731849247.2220494.17976129376947521581.kvalo@kernel.org>

Hi Kalle,

On Wed, Feb 07, 2024 at 03:08:14PM +0000, Kalle Valo wrote:
> Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Clang warns (or errors with CONFIG_WERROR=y):
> > 
> >   drivers/net/wireless/ath/ath12k/mac.c:8060:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> >    8060 |         return ret;
> >         |                ^~~
> >   drivers/net/wireless/ath/ath12k/mac.c:8022:9: note: initialize the variable 'ret' to silence this warning
> >    8022 |         int ret, i, j;
> >         |                ^
> >         |                 = 0
> >   1 error generated.
> > 
> > Commit 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211
> > hw") added a completely uninitialized use of ret. Prior to that change,
> > -ENOMEM was returned to the callers of ath12k_mac_allocate() whenever
> > ath12k_mac_hw_allocate() failed. Assign that value to ret to make sure
> > it is always initialized when used and clear up the warning.
> > 
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1989i
> > Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Patch applied to ath-next branch of ath.git, thanks.
> 
> 04edb5dc68f4 wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()

It doesn't seem like this tree or branch flows into -next on its own, so
this patch is not present in and the build still breaks on
next-20240221. Can this be fixed so that this warning stops breaking our
builds?

Cheers,
Nathan

