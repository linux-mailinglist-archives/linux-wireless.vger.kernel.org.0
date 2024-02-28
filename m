Return-Path: <linux-wireless+bounces-4187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7C86AE77
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF48297379
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182223BBD5;
	Wed, 28 Feb 2024 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+RbXO7u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90113BBC4
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121255; cv=none; b=bzSf1SDj8ZKTd/ZePWgBckcIK3ojlYQXQWEwrF3CyctdaR9wmH5RKMnz3rLHOYV6z1ODZ62mhS8avezFIiA5JBzE1nRjWLhLq6qpKn9r71WQs/dQ+HZagdVlAR+pq6rwCTUZuRn5Nmph35rBARpqlb0vAzNol3tCT1GrChM5M70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121255; c=relaxed/simple;
	bh=nqMafNlXl1HPu7b7h2D4wOn/LYFJbvKOatfRE8tIYOQ=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=czrlUnu6vt4MzbFcq9JdDSnnOcULd6KLBrpoIf12j1kU4KxL2bm6IOE5hMRJY0Ux1Lr/kHElXwS2GTeH8izBw//Vl78JBaasFWwSZl14r+b2JkIx11sgxLmMh7zDAUvU3Zs3YN8dXBkNm+uxSf5ew+tJyrWSMb6SXSZ2jHNy89s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+RbXO7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210D5C433C7;
	Wed, 28 Feb 2024 11:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709121254;
	bh=nqMafNlXl1HPu7b7h2D4wOn/LYFJbvKOatfRE8tIYOQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=c+RbXO7uaPl/MFkWqAMpm0Ae0N9i0yr9iPRslSJcxe4gvbTuGY2s0WM0M54Gxe+mZ
	 czSuP4f/Ym4yzCmdIwgjORxTI84nbVYoLmCbVOZfkF4dNMFqirdW3oZuW3KwJdDxun
	 3jdZL5iyG9csKeX0w6NuU0IBWv9yy5JUU+1Bxr8gesaXW+Hy+J7udTWCugxxpdVUlX
	 /YIzsc91tiE4FpNzMk3TQ7XiKhcmzXu301ywE1AlAJXLAwGzkax+6RU+EuM50j82OW
	 HO2fkgab5EMPK5E3g24aKqP92ue2SQiKQxyUcl23OpKI1V1hL36OCKJ4xFrVhLcbM9
	 v8xEETfSfecLw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bitfield: suppress "dubious: x & !y" sparse warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240223100146.d243b6b1a9a1.I033828b1187c6bccf086e31400f7e933bb8373e7@changeid>
References: 
 <20240223100146.d243b6b1a9a1.I033828b1187c6bccf086e31400f7e933bb8373e7@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Jeff Johnson <jjohnson@kernel.org>, ath11k@lists.infradead.org,
 Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912125112.3868947.18107049542995601682.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 11:54:12 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's a somewhat common pattern of using FIELD_PREP()
> even for single bits, e.g.
> 
>  cmd->info1 |= FIELD_PREP(HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP,
>                           !!(params.flags & HAL_SRNG_FLAGS_MSI_SWAP));
> 
> which might as well be written as
> 
>  if (params.flags & HAL_SRNG_FLAGS_MSI_SWAP)
>    cmd->info1 |= HTT_SRNG_SETUP_CMD_INFO1_RING_FLAGS_MSI_SWAP;
> 
> (since info1 is fully initialized to start with), but in
> a long chain of FIELD_PREP() this really seems fine.
> 
> However, it triggers a sparse warning, in the check in
> the macro for whether a constant value fits into the mask,
> as this contains a "& (_val)". In this case, this really
> is always intentional, so just suppress the warning by
> adding "0+" to the expression, indicating explicitly that
> this is correct.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Patch applied to wireless-next.git, thanks.

416eb60317c6 bitfield: suppress "dubious: x & !y" sparse warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240223100146.d243b6b1a9a1.I033828b1187c6bccf086e31400f7e933bb8373e7@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


