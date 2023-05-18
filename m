Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CDA707951
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 06:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjEREu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 00:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEREuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 00:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82870213E
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 21:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CC2464CFF
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 04:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62661C4339B;
        Thu, 18 May 2023 04:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684385423;
        bh=Dx6EnHQo2Yjjh9KrD0mEn6bgue46Bf7wi+SxbOFW2MA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=euBko7G75JYEBaZV4vf7SOQW71XpzQeeJsAa6zH0/QNjVxq4TC1rRUsSX/rT2xPjX
         LFN6MGPeaUxFVViQQSkw9URfE2lBdMr1S++OP5kuk2Es/90oqpl0BzcPuxZguFpY+O
         jx+QjOLFJpyPcU8t3m/4nXsTIu92Ylf6hL9xZXIv3eiG2v+CmC5ihNgYNi1sZ7ahcz
         zbxrkZMyzkAq2CPCpubdQwbJBObOgzfNvHRqCSxruf5Fmx3KLwvQM4ryrd0vnJcOJm
         r/BfU6xMsIiiwkQ9SCqzJNJ9/Nxc0fwyTCJF5lxw+lojC38PgKO0YzWKImFBrYTJQM
         DkgKRV5Klm6Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 386BDC73FE2;
        Thu, 18 May 2023 04:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-05-17
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168438542322.13974.13019571815680311724.git-patchwork-notify@kernel.org>
Date:   Thu, 18 May 2023 04:50:23 +0000
References: <20230517151914.B0AF6C433EF@smtp.kernel.org>
In-Reply-To: <20230517151914.B0AF6C433EF@smtp.kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
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

On Wed, 17 May 2023 15:19:14 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-05-17
    https://git.kernel.org/netdev/net/c/c259ad11698b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


