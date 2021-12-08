Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59FA46DB0E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 19:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhLHScB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 13:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhLHSbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 13:31:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD15C061746
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 10:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1FE1B8206E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Dec 2021 18:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C3C00446;
        Wed,  8 Dec 2021 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988096;
        bh=T2i8+MDbSMW+B2st11/o0NzEQRy1AJc6L42OpfkbdcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Hq4nvJWaM1v/xRl8U6ZZeRydlieh5Bv7Cw1j7OHejL2y2FIf7YM1xY3n+YAkOtZdv
         nrnPzoscKxA8/AS8811VSltM1G+xfQt+OpMQKIokhaOUZ93bENmmcEiZvhNdtAwgVl
         cf1pnd81WmzcxBrgsjTIMqzBLRQQBFxE7mr2XyNQTDyhGko20MVYRHXWDKXVKkG6x/
         6or5VYTrPrVZS92T97y/dv0x8PWoGUhciK9v5ciMK/E+rJSykJtTNsTnhslYgEtNvp
         hiHefeS22WaQzXtezZUGPDZGRBf0h/za1WJB8KYBYepjqWiJDLKaLdE10fJH6nrCOo
         Hls++mPIGIQ7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: add debugfs to fix tx rate
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211129020506.6273-1-pkshih@realtek.com>
References: <20211129020506.6273-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163898809407.25635.14509606887935515571.kvalo@kernel.org>
Date:   Wed,  8 Dec 2021 18:28:15 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> It is useful to fix the bit rate of TX packets. For example, if
> someone is measuring the TX power, or debugging with the issues
> of the TX throughput on the field.
> 
> To set the value of fixed rate, one should input corresponding
> desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
> Set a value larger than DESC_RATE_MAX will disable fix rate, so
> the rate adaptive mechanism can resume to work.
> 
> Example,
>   To fix rate at MCS 1:
>   echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
>   To not to fix rate:
>   echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
>   To know which rate was fixed at:
>   cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

1379e62026ab rtw88: add debugfs to fix tx rate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211129020506.6273-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

