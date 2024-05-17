Return-Path: <linux-wireless+bounces-7786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6C8C88B0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 16:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8603CB22C6B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125778C60;
	Fri, 17 May 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3JDhPhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7C78B4C;
	Fri, 17 May 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957611; cv=none; b=WnQc4BxqyChzBPvWZGrClOvG5XDRRexClaO7Hi2QKkN5+GsY5G49W1CsKvom3UwLhILHdWCr+M6MPDZdLnkgZFSuwxyqmyjRxaN/fG+1UFhJ5kvycUJo0Gb6hMiPmAUiU2R8h/SIerZnU8tRk+YdZ+7ucgRLys9S/czsyf21yqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957611; c=relaxed/simple;
	bh=FRUm+nnGWwhaBntVRjYzavVZzyBg9okBfCuWgG8mdmU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=GjMk5yQ3LXz9ZGz2mDN4lC5EFvTuvLc3qhBSJa0ga2xrw2e1i//pAjQf/0Q0TzRpwdxYX8g8uXC0mnvOdzMU++RsYGUVSf6+0DfAfsniDWM/PP+VfIZAoO3OPsWygfozcgJvqegcQfCrwMIwdSdBSGWDdOTGDlieZ3jf0TL9adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3JDhPhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D863C4AF07;
	Fri, 17 May 2024 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715957610;
	bh=FRUm+nnGWwhaBntVRjYzavVZzyBg9okBfCuWgG8mdmU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=e3JDhPhgctSs7rzeTm0fZ3m8cwveFPez3JSxQJJFoQXScGVfhzdI0cW3p/gEPAFx9
	 iDjy79SK0HKIpd5eUTAP/DD++j1c0jI0SikVH4bVKJt1mm9/iSb80ZBAWlzVMg6mNX
	 iZixPOpUFEEDZnoZ9sMkYFIYMw+CMcwEaTVsn09+mEjMm4TukNGca4C/nZDmYW0Hzm
	 FsWMj74RIJ9fNxRHEDAGRyZKZY+ImtX5HdHVlcxFUtMXDYArbpsySJ50S9u0ghQGlz
	 o2NKmAhSDPIA6mkcjudOTZly3EcF5tdiyOozUtR9nuFpJj4adEH9Hqwrmd1ZSzXbPg
	 +d0q+WofhB1JA==
From: Kalle Valo <kvalo@kernel.org>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: miriam.rachel.korenblit@intel.com,  rafael.j.wysocki@intel.com,
  daniel.lezcano@linaro.org,  johannes.berg@intel.com,
  dmantipov@yandex.ru,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: adding check if the thermal firmware is running
References: <20240517141655.2797-1-trintaeoitogc@gmail.com>
Date: Fri, 17 May 2024 17:53:26 +0300
In-Reply-To: <20240517141655.2797-1-trintaeoitogc@gmail.com> (Guilherme
	Giacomo Simoes's message of "Fri, 17 May 2024 11:16:50 -0300")
Message-ID: <87r0e0fq1l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> writes:

> In the dmesg is showing the message "failed to read out thermal zone"
> as if the temperature read is failed by don't find the thermal zone.
>
> After researching and debugging, I see that this specific error is
> occurrenced because the thermal try read the temperature when is started,
> but the firmware is not running yet.
>
> For more legibiliti i change the tt.c for return EAGAIN when this was occurrence.
> After this change, in my computer I compile and install kernel in /boot
> and in my dmesg the message "failed to read out thermal zone" is not show
> any more.
>
> I would like to thanks for Rafael Wysocki <refael.j.wysocki@intel.com> for
> your suggestions in mu first patch that results in this another patch.
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Please read the wiki link below how to submit wireless patches. For
example, the title is wrong and you haven't signed the patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

