Return-Path: <linux-wireless+bounces-3874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A785E569
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111B6285378
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA684FD8;
	Wed, 21 Feb 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F561lTe2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4784FA5;
	Wed, 21 Feb 2024 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539666; cv=none; b=tdO+sQkpVr4NH/Hc9SXKVScuwoQwhL3YGwHNoqqlZBoclBYsqwCjKxsiZccZGOz7c9v/ue26FXy7BdY4+4DEdnBaKT/rdOhbAq+sVHW8a9YkUnxGCu+AIihOe89JcjG2ZwNl5eobv/aeRGllyHbm8f2MiviYiEjCSa7q2s57vpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539666; c=relaxed/simple;
	bh=tQaWzc3U8kyTUOyG3hGc5iK+s3OXDgj0AzeWKbHcNFY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OJacFxZj2AVayfzj1rvhKnw7xtnH8oFqV9owaLEducMB0X7LKCe+KCGdiCONiP58U2eKmHEh/lAeoLVrd9APrdwMwt/+PaUozmw6Kiz/Arbrw10udpE315Hir+SvhFIwNLq2+242kC5MHlovNQBcFtbMOKmkX3sNnYEME0YGLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F561lTe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AECEC433F1;
	Wed, 21 Feb 2024 18:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539666;
	bh=tQaWzc3U8kyTUOyG3hGc5iK+s3OXDgj0AzeWKbHcNFY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=F561lTe2JDbsfjGXvYgvVLgEO0kOuviDsp5/faAf/biHQ56QorfmvA/inS1XrvfJT
	 GGtIXWZQlyOn5zCgu/CCCVTEiD04wc86dJrO11M4oo3hNJ9x+e22aEvo5bh/vwUdvw
	 xL8M1UF4iaWsh+2Fu/L6Y1S4kB2YJ0CGKU3nn/Mf6n9ke3kq9i6sbIrpXlTbGqTm6J
	 aLMhDan+ZxNA8DQzdiZiWA26zT5RQMq+un8HT1tEe39ugLStCXw08gbBusOz086znX
	 qus+lwKIc/AqREgUHCJPCeL8CMdRHerpzHrIxreGEZJoYE8nOAyQ+WjOGOlJdhmIKi
	 3vPYYPiCARF6w==
From: Kalle Valo <kvalo@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: quic_jjohnson@quicinc.com,  morbo@google.com,  justinstitt@google.com,
  quic_periyasa@quicinc.com,  ath12k@lists.infradead.org,
  linux-wireless@vger.kernel.org,  llvm@lists.linux.dev,
  patches@lists.linux.dev
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized use of ret in
 ath12k_mac_allocate()
References: <20240205-ath12k-mac-wuninitialized-v1-1-3fda7b17357f@kernel.org>
	<170731849247.2220494.17976129376947521581.kvalo@kernel.org>
	<20240221180013.GA2074929@dev-arch.thelio-3990X>
Date: Wed, 21 Feb 2024 20:21:02 +0200
In-Reply-To: <20240221180013.GA2074929@dev-arch.thelio-3990X> (Nathan
	Chancellor's message of "Wed, 21 Feb 2024 11:00:13 -0700")
Message-ID: <87ttm1llv5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nathan Chancellor <nathan@kernel.org> writes:

> Hi Kalle,
>
> On Wed, Feb 07, 2024 at 03:08:14PM +0000, Kalle Valo wrote:
>> Nathan Chancellor <nathan@kernel.org> wrote:
>> 
>> > Clang warns (or errors with CONFIG_WERROR=y):
>> > 
>> >   drivers/net/wireless/ath/ath12k/mac.c:8060:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>> >    8060 |         return ret;
>> >         |                ^~~
>> >   drivers/net/wireless/ath/ath12k/mac.c:8022:9: note: initialize
>> > the variable 'ret' to silence this warning
>> >    8022 |         int ret, i, j;
>> >         |                ^
>> >         |                 = 0
>> >   1 error generated.
>> > 
>> > Commit 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211
>> > hw") added a completely uninitialized use of ret. Prior to that change,
>> > -ENOMEM was returned to the callers of ath12k_mac_allocate() whenever
>> > ath12k_mac_hw_allocate() failed. Assign that value to ret to make sure
>> > it is always initialized when used and clear up the warning.
>> > 
>> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1989i
>> > Fixes: 6db6e70a17f6 ("wifi: ath12k: Introduce the container for mac80211 hw")
>> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>> > Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> Patch applied to ath-next branch of ath.git, thanks.
>> 
>> 04edb5dc68f4 wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()
>
> It doesn't seem like this tree or branch flows into -next on its own, so
> this patch is not present in and the build still breaks on
> next-20240221. Can this be fixed so that this warning stops breaking our
> builds?

Yeah, ath-next is not pulled to linux-next because of "reasons". We are
planning to send ath-next pull request to wireless-next in the next few
days.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

