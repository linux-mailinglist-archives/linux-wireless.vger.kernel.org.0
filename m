Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8847A767
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 10:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhLTJsQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 04:48:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34028 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhLTJsQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 04:48:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16D2BB80C8D
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 09:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B2CC36AE8;
        Mon, 20 Dec 2021 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639993693;
        bh=EGvXXR0wahhfIVGCNTTyjkHtk1DIxOuQlGKKcFhrGdM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=O1BxTrEVahxTGVfebomk9MdzabMNqqEsqZUK/NmnXppRrlJsN+03zJZzPkygE0JIT
         +le79pgjmJciQN9cZHEAbstrCUIh07nSuxRj3Vluy6H5/4UQ54uH+3e1wRrfVcJJad
         0QST6UM3IFjmfANSpYBv/i6RLykMd9nXbJuKqePbntSqC1uFnVSSFSYt1ytpzl3x3N
         F7hkdw7wOtbyUhS0C8a1bSJ86Tamv/jrSNIjagG8hV1gRk7kjg5jTTfrN2BowMDaO2
         FPjNQfLHwz/iptk01C+P4HGwTEvue9ikK6h6bmx4LEFrT4ejwCPnVdqhnL8XHar0R5
         ZUjqJjjkHVNFw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <kevin_yang@realtek.com>
Subject: Re: [PATCH] rtw88: support SAR via kernel common API
References: <20211220093656.65312-1-pkshih@realtek.com>
Date:   Mon, 20 Dec 2021 11:48:04 +0200
In-Reply-To: <20211220093656.65312-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 20 Dec 2021 17:36:56 +0800")
Message-ID: <875yrjboa3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

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

I switched my email to kvalo@kernel.org and my codeaurora.org address
will stop working soon, please update your address book and scripts.

No need to resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
