Return-Path: <linux-wireless+bounces-15454-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B79D109B
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 13:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611171F216E9
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2024 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B9190665;
	Mon, 18 Nov 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNwePXgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85760190468
	for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933333; cv=none; b=YsdLoKR3RyXc7okpem+fFOw6i9IxIUUCGuFaklfyUr0yQi65ORyvUeSAbe/Y0Z8d+S1k/jgb2S699LrC64GSpLqd7rbGgvnZPypG/pxKF2U1sdEKLgGUCSbr5YeIDDeu5rIAT0vry/4I6Si5F037JgEutK1GxE6S9CzfpeuVUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933333; c=relaxed/simple;
	bh=P6mdJh4zkXbKuNOOp32KS2lBDEq75cG3byTW544Vjs4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=uFQZ6xxxac02LnLaYU9IKCWnDPNQ254p/yNKXpJXDktZuX7JPhkn7bPrL/AlZkWoNbpafzQ6JFAOYxqz8d6gVBlQgJ+FlBHkitRGpFOiYnuTl0vBuZKCowGzcTHXzbbi1hpNmX5uDcvfGgquE+Gk+PmBHX41Ump+N5Blkkmru/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNwePXgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F40C4CECC;
	Mon, 18 Nov 2024 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731933333;
	bh=P6mdJh4zkXbKuNOOp32KS2lBDEq75cG3byTW544Vjs4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aNwePXgNN+O49vTLif+5LYTMml80JnzyYBiP0yUZsqH8IdGjtguoh57AHA1kCKUgF
	 eMdboZszAF3AxRd01vrBP//phphfSw3soCBVDsOOVqqgnkmxyYDxxJr5nQCPe7iqIK
	 2r5HIdhXxCjE8Ylt3djKl3orck6Sf4+9cxV9iLTfebal/0nrwyLM8NR1pU9LBDPqrO
	 jjPbB6tsiBJIxtZWTi3sU35rG0uK5Ubaq8vy8H1l2FB6xmXyLT58+2pWmonL7N4KNn
	 t6kEeM4Zas524l723b6NC7TY3mSke7kQApWruvAvi/LDzzrjXPgvIDOD/NXVkVJ8/9
	 +WOcmdsc2z9Vg==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>,  <kevin_yang@realtek.com>
Subject: Re: [PATCH v2 1/6] wifi: rtw89: 8922a: configure AP_LINK_PS if FW
 supports
References: <20241118040255.40854-1-pkshih@realtek.com>
	<20241118040255.40854-2-pkshih@realtek.com>
Date: Mon, 18 Nov 2024 14:35:30 +0200
In-Reply-To: <20241118040255.40854-2-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Mon, 18 Nov 2024 12:02:50 +0800")
Message-ID: <87ikskvhwt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
>
> After FW v0.35.46.0, for AP mode, RTL8922A FW supports a new FW feature,
> called NOTIFY_AP_INFO, to notify driver information related to AP mode.
> And, one function of it is to monitor PS states of remote stations. Once
> one of them changes, FW will send a C2H event to tell driver. With this
> FW feature, we can declare AP_LINK_PS.
>
> For now, driver still needs to determine if a frame is ps-poll or U-APSD
> trigger. So, add the corresponding RX handling in driver, which activates
> only when at least one AP is running.
>
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +// CLASS 36 - SoftAP

In wireless we prefer '/* */'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

