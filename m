Return-Path: <linux-wireless+bounces-18604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB5A2B363
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 21:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B39188660B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1D1D89E3;
	Thu,  6 Feb 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjUQCB9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A31D88D7
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873845; cv=none; b=q15JgQA945DdDGwcHIkOyXOB8qnpcn0xJudLu/Uqdn3T9LgtHpr5yBZoluPxi6k7+SlMKk7klp8ugbr/cXteOcim1pVRqvs6jFfJeULjYnghuhkSqJTcVrW055mj2PGxBws6FunIO6Z89GN7s/swFVGun7J83fmJEm/rYbArWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873845; c=relaxed/simple;
	bh=uxK6tuwuJNODoSeoVxh/I0TT0BWkiYbdCYE2ZBTQroo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=snxTm47BQPdifX2RZR2x7UhhsqDxBKGr1Q5DNi5SJEYrYmOhbFymp41VSHtd3CpuxUDDFIxCV7O2wuC10mV538PSh7iG+NRnuqFGPvLqHO1laIj71ENCSsPDjeFH/ScTgRv3pmjoTTMeWEFKLt1JjUHMpm/ikTq/VlnxhMOauMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjUQCB9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8708C4CEDD;
	Thu,  6 Feb 2025 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738873844;
	bh=uxK6tuwuJNODoSeoVxh/I0TT0BWkiYbdCYE2ZBTQroo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TjUQCB9NnCMFgjeaZBVJCXZB98Uf0I1RM72A+/SnqQMYXWpRAa5inRhXSSW0agp3H
	 F1ANqLoQVudCIwyiaMbEBQOGRc4cmIMv6lPw4ArLTrzkTYQ9MbH/y7n89ZU8v2VXmL
	 Pbvkna364mmrM3rXnb0nS6CQB2/KkQ5oo6gp3Qv6Ey4M7/lAxc6P75u+06HpXl87G4
	 NAxp3DYdhZBmEaFrXGluSnotg/fyu9gGNflmw54eW1aPdtOiMeDk+JSlRzJBlMiKZu
	 qcTk2+bmeBFZucLWac6bLTEqvcTVkoyVBR0fTzkIaR8/hp+cw+6IDSdL1elbYEvUt1
	 Etpft2PurSpwA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless 1/2] MAINTAINERS: wifi: ath: remove Kalle
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250203180445.1429640-1-kvalo@kernel.org>
References: <20250203180445.1429640-1-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173887384195.28414.6609534484126873119.kvalo@kernel.org>
Date: Thu,  6 Feb 2025 20:30:43 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> I'm stepping down as ath10k, ath11k and ath12k maintainer so remove me from
> MAINTAINERS file and Device Tree bindings. Jeff continues as the maintainer.
> 
> As my quicinc.com email will not work anymore so add an entry to .mailmap file
> to direct the mail to my kernel.org address.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Acked-by: Jeff Johnson <jjohnson@kernel.org>

2 patches applied to wireless.git, thanks.

0db6b7d49b50 MAINTAINERS: wifi: ath: remove Kalle
b76adb9758f8 MAINTAINERS: wifi: remove Kalle

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250203180445.1429640-1-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


