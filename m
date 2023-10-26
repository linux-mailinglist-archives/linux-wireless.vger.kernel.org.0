Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E87D8C45
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 01:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjJZXk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 19:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 19:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DC187
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 16:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58319C433C7;
        Thu, 26 Oct 2023 23:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698363625;
        bh=R7x6CkCU+Tbnkm7sX4xnBQ7U4p7knsBu7uuqxvZJsSo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KHR1PD8mVM1nA5oCzyfDv/d5Irs2veNWT/mRkMUVIDHaCU9tiUj9rVfgwqibJVOBF
         J/Lm1NEVetb+OgBH15KipKsg164TMUFS4SV7NDHYjKu2/S/mNFJweJIY493aEytZVO
         /t77s7hZXkB5e+YZ0wSERJiV69Wavbbb6bNEN7m5TFbL4xv+96BNJcSkdg/nxrvT88
         xm9NMH/UMYO+Ryw5fldold57TPyJGx7ojxdjGbzjLYh9yjj2ytSJM6nee41Uzjv36H
         1S7QCBi6su26aD7KWxT7D773Wfvdl1nvu36Sox8W021+hkreTWLSmOcEObTwKUTUNa
         uy2L1dQvctZ3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3485FC41620;
        Thu, 26 Oct 2023 23:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169836362519.18504.11964226514290552580.git-patchwork-notify@kernel.org>
Date:   Thu, 26 Oct 2023 23:40:25 +0000
References: <20231025162204.132528-1-kuba@kernel.org>
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
        dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, vinicius.gomes@intel.com,
        johannes@sipsolutions.net, razor@blackwall.org, idosch@nvidia.com,
        linux-wireless@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 09:22:04 -0700 you wrote:
> struct nla_policy is usually constant itself, but unless
> we make the ranges inside constant we won't be able to
> make range structs const. The ranges are not modified
> by the core.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] netlink: make range pointers in policies const
    https://git.kernel.org/netdev/net-next/c/ea23fbd2a8f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


