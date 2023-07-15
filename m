Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4E7546A0
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jul 2023 05:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGODuZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jul 2023 23:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGODuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jul 2023 23:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFDE30E3;
        Fri, 14 Jul 2023 20:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0F9561DEF;
        Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AAD0C433C9;
        Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689393022;
        bh=mjhOLI+yCD9rfoSJAQ1b1UeP1kkeR8pIp7XLs7anurs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hqYHDGlIuqx6UIDdefgNxJVFK2OVcg5sTDqrD9CRqRpHncmwTEWXKqaOlVTXZHKOZ
         O/i/TM55YwqHMkx89KmekKuyrO5UNCJbRsTboIcYDQgKvyqAANFJylV2xJt+y6n+uy
         MFcFzQ8w8vPePjo/KAI0DgTCbO72KdRLJEpAucTPj/5REYOOn7vget+t9MJ+inrqLs
         5NHnS8e64q1B0CgZDwpKiW1opfWxSH2fRggIT438XtB5gmn/JLDJDVXaK1LxUkM7Ak
         mmBKc0/4cmdznxjbiGgHpeR6ccYMUqNO5axQyfgPNnWUZsGjiB40wLMnRDTOWlk7di
         Q0iW1e0kz/nTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11A75E49BBF;
        Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/9] net: fix kernel-doc problems in include/net/
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168939302206.24345.17268044128458529302.git-patchwork-notify@kernel.org>
Date:   Sat, 15 Jul 2023 03:50:22 +0000
References: <20230714045127.18752-1-rdunlap@infradead.org>
In-Reply-To: <20230714045127.18752-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        linux-wpan@vger.kernel.org, j.vosburgh@gmail.com,
        andy@greyhouse.net, johannes@sipsolutions.net, mchehab@kernel.org,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, marcel@holtmann.org, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us,
        dave.taht@bufferbloat.net, moshe@mellanox.com,
        jacob.e.keller@intel.com, razor@blackwall.org,
        benjamin.berg@intel.com, jbenc@redhat.com, lesliemonis@gmail.com,
        tahiliani@nitk.edu.in, gautamramk@gmail.com,
        prameela.j04cs@gmail.com, siva.rebbagondla@redpinesignals.com,
        kvalo@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 21:51:18 -0700 you wrote:
> Fix many (but not all) kernel-doc warnings in include/net/.
> 
>  [PATCH v2 net 1/9] net: bonding: remove kernel-doc comment marker
>  [PATCH v2 net 2/9] net: cfg802154: fix kernel-doc notation warnings
>  [PATCH v2 net 3/9] codel: fix kernel-doc notation warnings
>  [PATCH v2 net 4/9] devlink: fix kernel-doc notation warnings
>  [PATCH v2 net 5/9] inet: frags: remove kernel-doc comment marker
>  [PATCH v2 net 6/9] net: llc: fix kernel-doc notation warnings
>  [PATCH v2 net 7/9] net: NSH: fix kernel-doc notation warning
>  [PATCH v2 net 8/9] pie: fix kernel-doc notation warning
>  [PATCH v2 net 9/9] rsi: remove kernel-doc comment marker
> 
> [...]

Here is the summary with links:
  - [v2,net,1/9] net: bonding: remove kernel-doc comment marker
    https://git.kernel.org/netdev/net/c/a66557c79020
  - [v2,net,2/9] net: cfg802154: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/a63e40444e1b
  - [v2,net,3/9] codel: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/cfe57122bba5
  - [v2,net,4/9] devlink: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/839f55c5ebdf
  - [v2,net,5/9] inet: frags: eliminate kernel-doc warning
    https://git.kernel.org/netdev/net/c/d20909a0689f
  - [v2,net,6/9] net: llc: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/201a08830d8c
  - [v2,net,7/9] net: NSH: fix kernel-doc notation warning
    https://git.kernel.org/netdev/net/c/d1533d726aa1
  - [v2,net,8/9] pie: fix kernel-doc notation warning
    https://git.kernel.org/netdev/net/c/d1cca974548d
  - [v2,net,9/9] rsi: remove kernel-doc comment marker
    https://git.kernel.org/netdev/net/c/04be3c95da82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


