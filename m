Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23374A8DB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jul 2023 04:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGGCUa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jul 2023 22:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGCU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jul 2023 22:20:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20391BF8;
        Thu,  6 Jul 2023 19:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4556162A;
        Fri,  7 Jul 2023 02:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B6EEC433C8;
        Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696424;
        bh=NMaIG04L/6+E/2sKovqZRj+7rHyfA4XB+GfHgtsEzmM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=azrHxF6Er9dz5uac8BGKksDnLEYAXRN1rbS3CZfh/slM4DqIfuqkZPsGz/jakca6h
         fyj1EzFyhw2LsOEd5sNkGxrN9UnU0b+/zgbgR4ms3fZs+TjlOx78XFZrfhjfuRR8+b
         HVdG9oz/Dy+vMOocfKwfexB/mwnfSch7lRIwypBRXT60XK5uZod3ToOKdFlWe6wWR5
         7XhxjJyKo2teWX6gAptH6I2Hevk8StAp4yvnJYdmc7FI6DwrU/3H3WuPdalSW0CqzH
         QQwtcEJ8MtmkW2SHpi0DZW1zZYwBVgU+n8gqZz0NdgKb3KEHKcPj5qwmC5zOQgylSX
         QRuvwTxabhjMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 679CBC73FEA;
        Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: mt76: mt7921e: fix init command fail with enabled
 device
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168869642442.27656.11954856306543851735.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Jul 2023 02:20:24 +0000
References: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
In-Reply-To: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     nbd@nbd.name, lorenzo@kernel.org, kvalo@kernel.org,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
        quan.zhou@mediatek.com, stable@vger.kernel.org,
        leon.yen@mediatek.com, deren.wu@mediatek.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Jul 2023 23:26:38 +0800 you wrote:
> From: Quan Zhou <quan.zhou@mediatek.com>
> 
> For some cases as below, we may encounter the unpreditable chip stats
> in driver probe()
> * The system reboot flow do not work properly, such as kernel oops while
>   rebooting, and then the driver do not go back to default status at
>   this moment.
> * Similar to the flow above. If the device was enabled in BIOS or UEFI,
>   the system may switch to Linux without driver fully shutdown.
> 
> [...]

Here is the summary with links:
  - [v2] wifi: mt76: mt7921e: fix init command fail with enabled device
    https://git.kernel.org/netdev/net/c/525c469e5de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


