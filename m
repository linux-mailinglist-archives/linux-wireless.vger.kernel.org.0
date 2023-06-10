Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0554372A973
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjFJGmF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjFJGmD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 02:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F553A8D
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 23:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F251160A71
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 06:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE62C4339B;
        Sat, 10 Jun 2023 06:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686379321;
        bh=dC/XB8adrx7TRfUdGJs0rfRjPM1LJL5QJ2tlffYmoE4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m0IfRvHBX4CjugTn7M566hPP8sDNVnr4vECYlyiHoCKgWnMK8rDoofdc5Uu0A3QD0
         W3wrCS2EpRZK3yOT/XRzKYftw6hRcoWLoEWOIIj74PnQa/TvntbMb2XVueTa9LwilM
         V7H7kTWv2j6udP/NiQwAPZoGeYp1QINvJA8LFph8MSM8xZJnJJM6xhuhygVJAAZAs5
         mahljWfVu5j7fEo0aXyHmzjzpTrB4GPMzZl9y61iY5NnSf+bgsOOhZronQTep517uN
         TJMG79c+fwPutIGa9w8Kjp56esExie2FhRmNs5G/0fDbUsmgqomFHvEbNciSqvPEHp
         ExBEnujaCfgMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3748BE1CF31;
        Sat, 10 Jun 2023 06:42:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-06-09
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168637932120.22916.1742203530299730550.git-patchwork-notify@kernel.org>
Date:   Sat, 10 Jun 2023 06:42:01 +0000
References: <87bkhohkbg.fsf@kernel.org>
In-Reply-To: <87bkhohkbg.fsf@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
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

On Fri, 09 Jun 2023 15:49:39 +0300 you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Note: git request-pull got the diffstat wrong, most likely it got
> confused due to our merge from the wireless tree. I fixed it manually by
> adding the output from git diff. Everything looks to be ok but I
> recommend double checking anyway.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-06-09
    https://git.kernel.org/netdev/net-next/c/cde11936cffb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


