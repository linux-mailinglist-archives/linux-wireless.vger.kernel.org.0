Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8E45A50FE
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiH2QHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiH2QH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 12:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19B8307A
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 09:07:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B46A611C1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 16:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD1BC433D7;
        Mon, 29 Aug 2022 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789247;
        bh=cQtl4vkF1HqTib/ZbydMsJpq71b45/PK58mjdNjy8lI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qR3uN56Ab8YfI0qaNGcvVUHmLH338JNoBjnxyxAhAxMxkbyl5oA+08kchxAohBwRM
         F7eB8dMChaL46+bZu7fptfCgJlgrqKQj7zeJXxaCrHLy8HQGQoZWZWc5jDRWrPQ4z1
         TtXhCEJD0jidbS4YgxQ/pEazKBu7+ygEOldog/Fx5faZcVVOR450nJmMVCF2673RdV
         uqlpLrrwrR+1tr1h4eNJPxaQUrEmDUaeYIqJY24U9Nbbb2gI32oXdyyvp69C8rxQZk
         ggQmj0gm3o2Q5/aet96RtKMeag5yz+Lzvw3nt7EjKiriUvqj+FUU/utyvHXNhYOEQn
         JlUYz7e8dV/xA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: pci: fix interrupt stuck after leaving low power mode
References: <20220824063312.15784-1-pkshih@realtek.com>
Date:   Mon, 29 Aug 2022 19:07:21 +0300
In-Reply-To: <20220824063312.15784-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Wed, 24 Aug 2022 14:33:11 +0800")
Message-ID: <871qszdoee.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> We turn off interrupt in ISR, and re-enable interrupt in threadfn or
> napi_poll according to the mode it stays. If we are turning off interrupt,
> rtwpci->running flag is unset and interrupt handler stop processing even
> if it was called, so disallow to re-enable interrupt in this situation.
> Or, wifi chip doesn't trigger interrupt events anymore because interrupt
> status (ISR) isn't clear by interrupt handler anymore.
>
> Fixes: c83dcd0508e2 ("rtw89: pci: add a separate interrupt handler for low power mode")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> Hi Kalle,
>
> This patchset contains two patches with fixes tag, but we don't turn on
> lower power mode yet, so this patchset should go to wireless-next tree.

Very good, thanks for letting me know. This kind of info always helps.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
