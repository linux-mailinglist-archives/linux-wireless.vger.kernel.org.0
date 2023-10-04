Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688AF7B8AD0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbjJDSkf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjJDSkd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7BAAB
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 11:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A696DC433C9;
        Wed,  4 Oct 2023 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696444829;
        bh=TdNIT7YcFpP38LtyOuUncJP/3YiSnHJ79w9V/RLoX44=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qaF7DrkdMBO/25ufp9V6HQfAvIBjLT//8Xk3cjvQ9fwDBMD5n5YXfcnX16u4XrM7S
         6od4tG1c61ASv+7qQIsGouBru9iZ7VV6GvLzqtFdyGfzQwsCRWudPCYzkpUrOxftqG
         n29m2HBrbTSRQIFRFuB38eLa4IDeLb5nv+kZJA8i+zj+f84MV5tM2dx5qiimVu2vIP
         s2npcA5JDZyeyb/NDGTZofeQ22msoSegOpRveKsY31JOIYTYzNs1BiiBOTClkDwrmI
         MDiCC0+MdlKocKMR26UG9uEXe/SfJKYXBi8dkkqkxn8/qeMZCTzIZG8sTq8PM/vPzp
         3B3hXPIsuFyYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89FC4C395EC;
        Wed,  4 Oct 2023 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-09-27
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169644482956.7260.12644444542884934909.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 18:40:29 +0000
References: <20230927095835.25803-2-johannes@sipsolutions.net>
In-Reply-To: <20230927095835.25803-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 11:58:36 +0200 you wrote:
> Hi,
> 
> Here's a first wireless fixes pull request for the 6.6 cycle.
> There are quite a number of fixes here.
> 
> Note that this has conflicts with wireless-next, which I guess
> then Stephen will report between net and wireless-next after
> this is pulled, rather than between wireless and wireless-next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-09-27
    https://git.kernel.org/netdev/net/c/72897b295999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


