Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FAD7E5CDC
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKHSIU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:08:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845C186
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:08:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF80C433C8;
        Wed,  8 Nov 2023 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699466897;
        bh=2/9otKjW6UkjDbQCjf9BaYmmjJBtqSON1JS/f1/T15U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WpD26rNTH2t1l3m9u/bxntnNc0QLVRLyt9u6gCJYYT4EavCGItL1ApFd7VcEvOmRh
         8mNjLSWuj98Ey195vvtMD695g4yAGuo3Nsrf8Tc9l0XH/zCtIBK6yFJJrvka+gPkUC
         xhKcjxdv4rMI4Vgf+SAE4kOywwOPZI1lmNisX3BHAEFaT/JO28ISP3l0DbWEmDLLFr
         RTizRjZRI83bLNxhgNYs0GFCg2eYZCr1C9JtNANDXpBwIuI1DNEEeLG9WedJS6TaFd
         i9gVMqRcoZTj9xre6VoliXDoZeVbNt4AneeUT9QreRm5gp8QRsbgbM+DJeBocfk6uq
         Q/vd5LAeGA7Cw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: wilc1000: cleanup struct wilc_conn_info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231031171330.70399-1-dmantipov@yandex.ru>
References: <20231031171330.70399-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946689473.2821494.3798870018831794922.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:08:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove set but otherwise unused 'ch' member of 'struct wilc_conn_info'
> and avoid typeless 'void *' pointers in '(*conn_result)()' callback.
> Likewise for 'wilc_parse_join_bss_param()'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

2 patches applied to wireless-next.git, thanks.

4859b08f197b wifi: wilc1000: cleanup struct wilc_conn_info
a2fbf9e1e8ac wifi: wilc1000: simplify wilc_scan()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231031171330.70399-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

