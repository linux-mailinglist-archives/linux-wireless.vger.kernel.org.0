Return-Path: <linux-wireless+bounces-10119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213792B4F6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E0D1C21A32
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABAA155C94;
	Tue,  9 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV9QVwCk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCFA155C80;
	Tue,  9 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520180; cv=none; b=KpvKDmUk2HTck/7TNMApKPozrSJxQKQNAHUMyw9iKLnt4umEsbeJJ0Wh6gGzZp8KlPSLzGKtEeB38Q1d1VOr4a1PG68JxbCx3g8VFCBmThhM7wMQrfrI8UoxIMVeDKeQ+gFbAK/SPfr2rdAi36RvRujVYDix6s42fqaB1AWxftw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520180; c=relaxed/simple;
	bh=/PVmPIsGBGrZp4RSoHSYEKDJGsU66qaGHvdqjJIjRJY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=q61O+1cABnZtzyLmAjA5IaGBhnOr+UmRP6ElCzX9JK/OQX2Wfzw3WQ3YVh4nmQowUTlGYpX9uZcw7xFkUnzT5pqAyTJQgAdaYvm+qiyWO3J1bR0LqGmVBLCcQGYtQmoCJLrKAxd6cdlPmXBFmojHMMRr7vDrb45ygnoRlCFA0SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV9QVwCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE75CC3277B;
	Tue,  9 Jul 2024 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720520180;
	bh=/PVmPIsGBGrZp4RSoHSYEKDJGsU66qaGHvdqjJIjRJY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BV9QVwCkwWgk70CLWKBw8egRielZVtjd+JhMDus1DMS1y5ZYZp8W4KGrI1nDW9KAD
	 qKFmGdKc9FGoRyg9FdLDj70YST2BnsnOo4zr8PNVEhbkP78hIZx2IidQNpyaPklHUT
	 zrddeYM7HFWxPF2fWjDmC7rCiMBIcFh3awKqsUajWo2CnQ2VuO91yeMoVft7jG36Wf
	 UzVDD45icoKi7AMlZM3+VLft0IzgDz9uEjj8S+JW61fbqZ5lcvep0Mxl7LIuI4TUIj
	 obtSE/dhxok+zlBdjluxHUphsVkTO6xTUI8CsUPBwMtRno99exzUf95sUOGLfRQAKF
	 3hHuag7NwcrXw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: ipw2x00: Use kzalloc() instead of kmalloc()/memset()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240704090622.2260102-1-nichen@iscas.ac.cn>
References: <20240704090622.2260102-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: stas.yakovlev@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172052017694.761847.14633030657681388408.kvalo@kernel.org>
Date: Tue,  9 Jul 2024 10:16:18 +0000 (UTC)

Chen Ni <nichen@iscas.ac.cn> wrote:

> Replace kmalloc() + memset() to kzalloc() for
> better code readability and simplicity.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Patch applied to wireless-next.git, thanks.

3588e6438a1c wifi: ipw2x00: Use kzalloc() instead of kmalloc()/memset()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240704090622.2260102-1-nichen@iscas.ac.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


