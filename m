Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2153E6F8276
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjEEMCU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjEEMCH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 08:02:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D3C1C0E8;
        Fri,  5 May 2023 05:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95E9563D98;
        Fri,  5 May 2023 12:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1538EC4339B;
        Fri,  5 May 2023 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683288111;
        bh=5mLh7jfZI1nfWLVwYkSpPhEzk5XtMGt0LfKmDL5kA/g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=af8ibFnj7doVZmxVcbqEpsn8LJ7lVystx1XcVNeuYnVZxuCGYxCwBesY//RNgy3zo
         IdzABBRLfqbimsQo9mWhsH3FQGscjPnwIWpSi7mDPZsZY+VRj+FVHKq3rk0HDINMsF
         Fyd8sbdAdY3XxGVSBlyZFV5NzCxx5wLDR2w31FPwC2JiD12jHny9+bnI9CZwBgJQjm
         LFlhrPWlKLkWVlUBnG6hKcx2vuEmAtIKNcKjsLzvgzDB2Dr5LhDUtqPOOwiSurzlU5
         B2HnBfmAgpMK6dv3+78BQyT4ZD4A2VHPiRcO+YMz8eAYHnFlb7uUg8IY9E38Syy9pa
         BKiQyKAfhfMcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and
 RTL8851B
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
References: <e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328810808.30117.5754345043778347753.kvalo@kernel.org>
Date:   Fri,  5 May 2023 12:01:49 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@linaro.org> wrote:

> The if statement is reversed so it will not record the chip version.
> This was detected using Smatch:
> 
>     drivers/net/wireless/realtek/rtw89/core.c:3593 rtw89_read_chip_ver()
>     error: uninitialized symbol 'val'.
> 
> Fixes: a6fb2bb84654 ("wifi: rtw89: read version of analog hardware")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9d4f491b860e wifi: rtw89: fix rtw89_read_chip_ver() for RTL8852B and RTL8851B

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e4d912a2-37f8-4068-8861-7b9494ae731b@kili.mountain/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

