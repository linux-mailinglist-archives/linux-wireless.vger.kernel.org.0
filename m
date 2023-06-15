Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73261730EAE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 07:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjFOFaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 01:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbjFOFaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 01:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C287126A9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 22:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23924625FC
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 05:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A3EBC433C8;
        Thu, 15 Jun 2023 05:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686807021;
        bh=TRU0Pgf4i4y0K3jEes+szDbDQ9RTMGOkDVYP6BIn3p0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PmwnlzTTgQ5rSWL0/RDJFZmOLpN7vR80qUCqgWEJ4M/Gk0gZyDtRokM9nsd4D5no5
         NkISgSE/k6sq2yaRKX7+ODWCIH7Xzpjv4pcyJClnrtmtV5cTIUWseRL66sOd/ueyJf
         HmiJtT/ruNbmBjLf+vkOVKjjNmkuAvy+a87z4XkzPKgDBOMz+6b14diYGnojbswBDo
         WW1YDW3CK6ws/B7WRbL5XrAMTLjVfQgc6kwD1AUQuUQwpTT9Dvqi8RovZZMs/DnHOW
         4CjOE9NGgwofYA7fxzAcFYedktiKc11iyr+wowPbS++mh5tYz8G0eO9csSlBYS8xFh
         XjDs0unTa55JA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DBDAC3274B;
        Thu, 15 Jun 2023 05:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-06-14
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168680702131.31702.14877751927236768045.git-patchwork-notify@kernel.org>
Date:   Thu, 15 Jun 2023 05:30:21 +0000
References: <20230614075502.11765-1-johannes@sipsolutions.net>
In-Reply-To: <20230614075502.11765-1-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jun 2023 09:55:01 +0200 you wrote:
> Hi,
> 
> I know it's getting late in the game, but there were still
> a number of locking related fixes and some other things
> coming in recently, so here they are.
> 
> Please pull and let me know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-06-14
    https://git.kernel.org/netdev/net/c/37cec6ed8dc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


