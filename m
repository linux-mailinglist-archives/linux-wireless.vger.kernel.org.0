Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C54774FDBA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jul 2023 05:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGLDaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 23:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGLDaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 23:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFEE5F
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 20:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10913616CD
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jul 2023 03:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C669C433CB;
        Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689132621;
        bh=zlSkikX5NiioS0jVtW/FGuDJx6biQlxFFJAyRE8c1q8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hUpTCzTyyEqgP+hMVFbDJjhN9+xuEY0YZXDoNw+jMUBvTpDqMkoDPw9F+hEN/to71
         a0/bIn5FIR2RlxAQTC4gU5UylWCub7Gxx7Nj0Yjam280J4WDgJMoFUJZcrk0LafAye
         vK0a4CZKdRxUE0qEG6rC85frbbW0yM/3Zz3pp9Oo68IC1XPoAbD9Aa+Z/+e0Kitcvj
         BAng+Z15VTScyU1alnUPgvgL7NAh4/6MCqkOcNPPBAkIYO/yiXS6q4HAFViqzRkYmN
         KhWpDy5tFJOFAbxtnR6Wsm8YxK15rdhZ/wmRUyk9YjSzxj3XG3m49jN5f1RfFofsOo
         kIDRQoDNqRTZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 500A3E49BBF;
        Wed, 12 Jul 2023 03:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: iwlwifi: remove 'use_tfh' config to fix crash
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168913262132.27250.2841776474706788914.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 03:30:21 +0000
References: <20230710145038.84186-2-johannes@sipsolutions.net>
In-Reply-To: <20230710145038.84186-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        johannes.berg@intel.com, xry111@xry111.site,
        pinkflames.linux@gmail.com, jeff.chua.linux@gmail.com,
        rui.zhang@intel.com
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

On Mon, 10 Jul 2023 16:50:39 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is equivalent to 'gen2', and it was always confusing to have
> two identical config entries. The split config patch actually had
> been originally developed after removing 'use_tfh" and didn't add
> the use_tfh in the new configs as they'd later been copied to the
> new files. Thus the easiest way to fix the init crash here now is
> to just remove use_tfh (which is erroneously unset in most of the
> configs now) and use 'gen2' in the code instead.
> 
> [...]

Here is the summary with links:
  - [net] wifi: iwlwifi: remove 'use_tfh' config to fix crash
    https://git.kernel.org/netdev/net/c/12a89f017709

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


