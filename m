Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE0770D24
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjHEBkk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 21:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEBkj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 21:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A944EE1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 18:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D8262192
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 01:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B059C433C8;
        Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691199637;
        bh=XCUr0dKLtrl7HBjElkry07NJ5TXTAWpkkaBV01A/jLE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=No7vnOczUirzs8/P4M1lt4AAIktAT+xRVMsgaUhEGSk1qapBf8V3NGo2MfEilYouD
         rDxSSePv+fJiQ9dx6rFtwkM7IT+9ud3Vl6I5AFNy+QBVIXqzDZTi8hJ6YT7GpX9+cT
         +lwfu0aYXuv80pJPDy3z4G+KBGkwR0YnGngoHqaq6Jio5KFnZfl4Wrm5LBnkz5GcUW
         p95ljyvzAh/7jdVEWma9fPJjUjiAF2h0zrMSGJu7tiW4dXNO+3YR57qIs04Fq7Srih
         xssgjl9IRR0AzKccmIUmX8nb8+RD/aufQZjAGE0qISNdou5ZtRknB054OGislZVgNE
         iT4H77GAvG+2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A345C595C3;
        Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-08-04
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169119963742.24799.10292849293616747808.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Aug 2023 01:40:37 +0000
References: <87msz7j942.fsf@kernel.org>
In-Reply-To: <87msz7j942.fsf@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
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

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Aug 2023 15:16:29 +0300 you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-08-04
    https://git.kernel.org/netdev/net-next/c/81083076a007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


