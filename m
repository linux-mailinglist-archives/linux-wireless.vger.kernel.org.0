Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E767D5C52
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjJXUU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbjJXUU1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 16:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496A10D0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 13:20:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EBDEC433C9;
        Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698178824;
        bh=VkJ+mJU6Y+Tg2FljsDTVDaVBWuCONGhE9eSL5JORb/E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e73w4vOafUwVhrLApRp+pfRMunaNNQK8igGWPJT154Cv0ER8yZHp3x8HqhkJTmUy1
         0LyEApjvdRLPt7Jgh2Op5wxfvHZ5HnplwOZBhO0Hhm4tmtERPKMKajskqxd/buWsrG
         AN0FXZZTATtWpnWL63G/4puL44ftDS+/iRRsFRK8bSlPgxVHMqy0drPoo8KBQnTxS6
         4rruAlfq5mtxY7VIYzVt0xAy0Rf7dJI+eGxuXxHnX+2tlmgqR8s96cn/sEyrpXf/Fn
         oo6a3EHOewN96dqlSh9meZfba+RkQN9geLBKLI/i4kn9JclyCgkfw9UrtVgiEn/9dx
         f4DoOSQGC19aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 541FFE4CC1C;
        Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-10-24
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 20:20:24 +0000
References: <20231024103540.19198-2-johannes@sipsolutions.net>
In-Reply-To: <20231024103540.19198-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 12:35:41 +0200 you wrote:
> Hi,
> 
> We have a couple of last-minute fixes for some issues.
> 
> Note that this introduces a merge conflict with -next,
> which Stephen reported and (correctly) resolved here:
> https://lore.kernel.org/linux-wireless/20231024112424.7de86457@canb.auug.org.au/
> Basically just context - use the ieee80211_is_protected_dual_of_public_action()
> check from this pull request, and the return code
> RX_DROP_U_UNPROT_UNICAST_PUB_ACTION from -next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-10-24
    https://git.kernel.org/netdev/net/c/00d67093e4f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


