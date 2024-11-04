Return-Path: <linux-wireless+bounces-14854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EF9BAD76
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 08:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2E11C21031
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19918C320;
	Mon,  4 Nov 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHmXTp6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19A189F45;
	Mon,  4 Nov 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706817; cv=none; b=WOcyalc/1NKP5a7tENhxKOgZ8dPs45j0GXiN3Bzoz2m1rIoJF6hpW+lU9WCsGekvpsSFKaX5ThQ2E6RI7nVLDDjoa83TGCxObZhqPwjkl0MofPLZChx6cxYerFp+9e3W5E+jk6APaU+4PMmdGw1pncCPG9jfjFlAtusaNTDC5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706817; c=relaxed/simple;
	bh=waI6P/EUnFraH7IoprJI0ZGKa7BTrqfNGfj2we2HUFA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DRTjcRe5xgV7MMzP1U6YYaXc3AAfkTDFa3odOIsfDC9BCCp7HjBj0L+8RoAj2xa8b9dQgT/me+1Mpc3bpWKyBwNkhPtGpYdRgfl4y1VYmv209Gw9fquv8DCA+XDQIyz6yfiYchJ9gW6PZUMrX3xWSSF1+JZ4BQQdOvL2KXCmnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHmXTp6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC2C4CECE;
	Mon,  4 Nov 2024 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730706814;
	bh=waI6P/EUnFraH7IoprJI0ZGKa7BTrqfNGfj2we2HUFA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DHmXTp6QCMUaZ++yQPmX8Rc7gOtvPGg446ROwzvMdCcn36WU0kWADq4Z+aINIMDDW
	 fpWJapQzcWMvMisL4EN24jD1q32Nf/rU4pVLXgoQyFKh1Cd1QT2DTQcOJ8JjvtxhHc
	 p+rc+3R6lfGUkfkQ3YYflICaGf3Ij78OS6mHHD9aKjEn2PX1bW59YtgiEZruHQSkak
	 BhVu1sx2DvjV0rtRUWpCMyeKOYpuScDE1foavUergQps4hLJAOyPIXOH+nNTryPGUV
	 k/jPC6lxUEblcg8awLOHeWK+3g4OU11C1yrLqp4d+yOxbHLoAR8bYW7+ndNN9xa76x
	 BZ9mhodQYFVNA==
From: Kalle Valo <kvalo@kernel.org>
To: linux@treblig.org
Cc: pkshih@realtek.com,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtlwifi: Remove unused functions
References: <20241103153857.255450-1-linux@treblig.org>
	<20241103153857.255450-2-linux@treblig.org>
Date: Mon, 04 Nov 2024 09:53:30 +0200
In-Reply-To: <20241103153857.255450-2-linux@treblig.org> (linux@treblig.org's
	message of "Sun, 3 Nov 2024 15:38:56 +0000")
Message-ID: <8734k7zb7p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

linux@treblig.org writes:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> exhalbtc_rf_status_notify(), exhalbtc_coex_dm_switch() and
> exhalbtc_antenna_detection() are unused since they were added in 2017's
> commit 7937f02d1953 ("rtlwifi: btcoex: hook external functions for newer
> chips")
>
> Remove them.
>
> This leaves ex_btc8723b1ant_coex_dm_reset() unused.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

'wifi:' missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

