Return-Path: <linux-wireless+bounces-12800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB7D975D34
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 00:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449461F22913
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 22:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0641B5801;
	Wed, 11 Sep 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMkk8RCf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0C524D7;
	Wed, 11 Sep 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093796; cv=none; b=baiQ3yvMY7zJTfk++Zt8w5v1cBldcOPdM8oxdvYyPbl8V7vdtTqIaEpDI//kseqiTL0rW1ZMsqNybnz0eKKgPHWkoKVUmZDSd7GcJE8EekQuK6LO7iWOhiH3yfeUVwrbN7vgg99C0NHNLtLNNtfH9NRc1YJNN8BH7CuFBqR02mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093796; c=relaxed/simple;
	bh=+t4gE1MEvz4FV50ss0nopF9qH1yH8IqfKkUVSuZ4q8M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PZC50PDFpzG33ZUg/mr9imOx2Kn7J8qkAPL9dnLNKgs2kiZZQLH4h01lVu3ehtE/m1HXcKvirnRW2GUCLNI/VPXP1Cf6ybKLPG15IsDleWlmlPuMTkOB5xlB5TvNdRg+srXbIIGmkZkTczSXikXYbrsHsbd/Liv7WBunVbWB834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMkk8RCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7997BC4CEC0;
	Wed, 11 Sep 2024 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093796;
	bh=+t4gE1MEvz4FV50ss0nopF9qH1yH8IqfKkUVSuZ4q8M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JMkk8RCfMrgIz4Ma8VhiCmTK7GP9utOXWsYld4waoagDHGVXJUQkH7cvsvscetJfY
	 gxAcItOVPKWZhpZTPC8gdQO+PVePdHZn6LElGeEoxYSzFJ8FiLN1McmnbRaRt3E+P5
	 AeCYaSSoHK5h4DJPOZ9HODat6NUAa0Gp9tK6mOd1YoxlmVkX8InMK8w1sCslosGDvl
	 W09qmsg7GxlV//1B+SoZ3Mj8dh+mbQRyEOu67Nqm19bunTvtenfGUEmxcZXr0k7vrB
	 59smdklMqKK2kDsQKyj8iq+K3XFlkY6I7QaKtUOhaj/asCfR/+anWf1t5C3Lr1GADI
	 ySOhqCba/88YQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-09-11
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org>
Date: Thu, 12 Sep 2024 01:29:53 +0300
In-Reply-To: <20240911134521.7f510329@kernel.org> (Jakub Kicinski's message of
	"Wed, 11 Sep 2024 13:45:21 -0700")
Message-ID: <87ikv1bz8e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Sep 2024 08:41:47 +0000 (UTC) Kalle Valo wrote:
>> here's a pull request to net-next tree, more info below. Please let me know if
>> there are any problems.
>
> For a follow up, clang W=1 says:
>
> ../drivers/net/wireless/realtek/rtw89/coex.c:6323:23: warning:
> variable 'cnt_2g' set but not used [-Wunused-but-set-variable]
>  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
>       |                              ^
> ../drivers/net/wireless/realtek/rtw89/coex.c:6323:35: warning:
> variable 'cnt_5g' set but not used [-Wunused-but-set-variable]
>  6323 |         u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
>       |                                          ^
> 2 warnings generated.
> ../drivers/staging/rtl8712/rtl8712_recv.c:139:6: warning: variable
> 'drvinfo_sz' set but not used [-Wunused-but-set-variable]
>   139 |         u16 drvinfo_sz;
>       |             ^
> 1 warning generated.
> ../drivers/staging/rtl8723bs/core/rtw_efuse.c:285:6: warning: variable
> 'efuseValue' set but not used [-Wunused-but-set-variable]
>   285 |         u32 efuseValue;
>       |             ^
> 1 warning generated.
> ../drivers/staging/rtl8723bs/core/rtw_recv.c:2030:7: warning: variable
> 'cnt' set but not used [-Wunused-but-set-variable]
>  2030 |                 int cnt = 0;
>       |                     ^
> 1 warning generated.
> ../drivers/staging/rtl8723bs/core/rtw_pwrctrl.c:288:6: warning:
> variable 'poll_cnt' set but not used [-Wunused-but-set-variable]
>   288 |                 u8 poll_cnt = 0;
>       |                    ^

What's the deadline for these? Do you need the fixes tomorrow or can it
wait a week or two?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

