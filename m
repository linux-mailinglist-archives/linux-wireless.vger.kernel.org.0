Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B244C73AF00
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jun 2023 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjFWDUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 23:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjFWDUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 23:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2A2130
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 20:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 653626194F
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jun 2023 03:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51C4C433C9;
        Fri, 23 Jun 2023 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687490448;
        bh=DwbACjbiiSYkZEcEzktTKHsfX0I+KAANaVcOSfX8VAk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l/9YC1BPnkMkKsOpWwJUgf4Yqpg3n9FXEpR6nN5fsth7BLkKBXVBoolDYz3Vt7EFe
         eW4MliApAUETHd+dUCNzKW3YMAUdDakCDGi1md94a4c7yIoUm8gWhtRU7rZHBL2SCZ
         jb/0P6X9AXm9UzZGnFzVFCXaKd+Pma+3/B0SnqcEe/YuTruCB35X+Zbh5VGBDWxFRc
         t7YiBhUe6JX71IAVm7HFpXddp3TmUIQvRfjuCEenVxPe8StmqTv+JMbX9krion0yyA
         r/Bohtvzsa4eouHqxqGzgiJkQ3wqHvkQgOERPibhbdtwK7M4EjIhoyCSatfM5SvI/o
         0abMl6IRJZy/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91F31C395D9;
        Fri, 23 Jun 2023 03:20:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-06-22
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168749044858.15040.8646713875880229434.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Jun 2023 03:20:48 +0000
References: <20230622185602.147650-2-johannes@sipsolutions.net>
In-Reply-To: <20230622185602.147650-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
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

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jun 2023 20:56:03 +0200 you wrote:
> Hi,
> 
> Here's another set of updates for -next, almost certainly
> the last as we go off into the vacation period soon. Have
> a great summer, and already thanks for all the help!
> 
> Please pull and let me know if there's any problem. I'll
> likely be around a little bit at times if needed.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-06-22
    https://git.kernel.org/netdev/net-next/c/e6988447c15d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


