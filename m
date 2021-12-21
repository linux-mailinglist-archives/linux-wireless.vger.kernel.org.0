Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CD47C673
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbhLUSW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 13:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbhLUSWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 13:22:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78C2C061746
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 10:22:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78DA36172E
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 18:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E54C36AE9;
        Tue, 21 Dec 2021 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640110973;
        bh=cIhZPKjYKDXS3bMxhXjOcwTd5YMKGiJgPKcNTPB2VzQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=muVdS2f671W/IoVgbgGIaJFy2UzoD4lPZEGkg3F5L8yjgaJ5MRIzxfO0VO6Lw0Xmr
         fkhENyR7MxQY5ALMS3usP5l14Y+as76HuEUlZOIK1nd13CgUX743Qqr0rHZsgK3OcI
         DCDEw5ULGmOztidSsp45+L08BI4NKu35sOOC+kVcxWIvZetp9bACFzq3h9pCk89NWx
         Tcl7y0BbEbKI+TWIq6PfQ7/DYrRSJUg/bAsDgl0gM84ltrADW7XPSQHs2UhxeShb0y
         rxcc5aUbDmCg5pasEUV1pzl9r+2R1JNjYP+3mefQqP6uesuuvUR/hk5gKsNGrN9JjG
         YaH3ZgJggPfcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: support SAR via kernel common API
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211220093656.65312-1-pkshih@realtek.com>
References: <20211220093656.65312-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164011097096.31508.14987641590578596100.kvalo@kernel.org>
Date:   Tue, 21 Dec 2021 18:22:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Register cfg80211_sar_capa with type NL80211_SAR_TYPE_POWER and four
> frequency ranges for configurations in unit of 0.25 dBm. And handle
> callback set_sar_specs.
> 
> Originally, TX power has three main parameters, i.e. power base,
> power by rate, and power limit. The formula can be simply considered
> as TX power = power base + min(power by rate, power limit). With the
> support of SAR which can be treated as another power limit, there is
> one more parameter for TX power. And the formula will evolve into
> TX power = power base + min(power by rate, power limit, power sar).
> 
> Besides, debugfs tx_pwr_tbl is also refined to show SAR information.
> The following is an example for the difference.
> Before supporting SAR,
> -----------------------------------
> ...
> path rate       pwr       base      (byr  lmt ) rem
>    A  CCK_1M     66(0x42)   78  -12 (  12  -12)    0
>    A  CCK_2M     66(0x42)   78  -12 (   8  -12)    0
> ...
> -----------------------------------
> After supporting SAR and making some configurations,
> -----------------------------------
> ...
> path rate       pwr       base      (byr  lmt  sar ) rem
>    A  CCK_1M     62(0x3e)   78  -16 (  12  -12  -16)    0
>    A  CCK_2M     62(0x3e)   78  -16 (   8  -12  -16)    0
> ...
> -----------------------------------
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

8704d0befb59 rtw88: support SAR via kernel common API

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211220093656.65312-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

