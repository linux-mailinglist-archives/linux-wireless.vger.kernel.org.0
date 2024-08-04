Return-Path: <linux-wireless+bounces-10895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02590946DD5
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 11:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D651F214CA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F1208A7;
	Sun,  4 Aug 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPhlIJGU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6038A29
	for <linux-wireless@vger.kernel.org>; Sun,  4 Aug 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762703; cv=none; b=hLZs3mAahaNRJuYJ1y8qLLaP4/TyFYLI4nKUSYnUqxqwfzuyZLzjYIu1JOw0k0yT4BTLW61y5fhnclGw2Nmfr0cTsD55Wn1UaKmNlvkjQgHxfCVN901B3BVDpO9JoMQNL3DirU6Gz0Nc8AwQmmHnW/yHY+FwjQLPloyQ9ChIPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762703; c=relaxed/simple;
	bh=XrpMO4XUrsrM0391xiDW/krBRIJgiGKTR9D0OQ1Qkzs=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=DXcjtOknrkxfhhd1UWuhXfIq5h85DALqxxbFrIXSU0WsuzahUICZWrkiSMBxrI7wkobc+kK9WFHQzlPH58dAGS9ma9e29NbrPFW5aLaT+hpjmRc43I0ZoDfGKqmLpFo9gm41Kzl4B/FKiLgay1hhFqN897hEl/WyffrpHNy5VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPhlIJGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD56C4AF0C;
	Sun,  4 Aug 2024 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722762703;
	bh=XrpMO4XUrsrM0391xiDW/krBRIJgiGKTR9D0OQ1Qkzs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=cPhlIJGUQh8RAnujXOhh0bpuik1Aq3HHdIRV0NQEsPSaD+yAVC6bwmBQFxIKoUbDQ
	 8mEHmvd7+f5f5k+Zi2FZMiLSZtvS1QkU1uMxhPd6TjBAPy3eyOhPeCnBJbby/hEq8h
	 gXuJNmQqTJCH2kVx9bczj3i9Pok2eC+j7I1SjBZZWugMNurjfXYnkJbDfmgoZVdLsC
	 kbB4z2V17uZoCCQeg6ySvlC9/QPoCVO31GKGQugxUbuogay457H8ka2mFFWljrJ8U6
	 NN42Y6VX0Jg0yUPotE85JLmrqzPT28zTd0Pwlw2IMCkJ87vw9thUuhgy+EyVB53TnD
	 jyRiAlVSssjtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmsmac: clean up unnecessary current_ampdu_cnt
 and
 related checks
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240801101531.6626-1-d.kandybka@gmail.com>
References: <20240801101531.6626-1-d.kandybka@gmail.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org,
 Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276270047.2804131.2096284597730216752.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 09:11:41 +0000 (UTC)

Dmitry Kandybka <d.kandybka@gmail.com> wrote:

> In 'brcms_c_ffpld_check_txfunfl()', 'current_ampdu_cnt' is hardcoded to
> zero, so 'txunfl_ratio' is always zero as well and some dead code can be
> removed. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

420a549395c2 wifi: brcmsmac: clean up unnecessary current_ampdu_cnt and related checks

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240801101531.6626-1-d.kandybka@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


