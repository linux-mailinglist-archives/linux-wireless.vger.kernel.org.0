Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72202776C1B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHIWUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Aug 2023 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHIWUX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Aug 2023 18:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB2A8
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 15:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2554362D02
        for <linux-wireless@vger.kernel.org>; Wed,  9 Aug 2023 22:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B20C433C9;
        Wed,  9 Aug 2023 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691619622;
        bh=csBWtvwRbziRdxXRRnz5SOtm+ubyZCH8dAcQRA2YSf4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j3wDx3jIccsCix+gjp9pjIk9/U2nIBAWzHzCiKB0kVlyqf0FQAoTnR2OImegmR1Si
         U1jv312VeTKRkY/kzkeqtbg+UUvKVqMAITQnrGCI76bnbDYCRUT+YzTvZe3nethL0C
         TWSPyNPiiSJtKYvhg6nu7UsLIP5S/f/ituA6QUMSQOAWISV3qSehIb/ej7xnpFd1ic
         5W96T6+4cNnKAfdHcoSyK2j5JwRtfRykVXMSU2MMbq0/VGaYWN+913qkhfpaJTxR8i
         chcFC+yBTu4yCEgNw/Xjw8vUHcnkDtP7klMEZdMSAoiczuPttm769zWItKK8VvHOGg
         6kMzici9/fAYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A744E3308F;
        Wed,  9 Aug 2023 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-08-09
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169161962243.15093.7034192084083040541.git-patchwork-notify@kernel.org>
Date:   Wed, 09 Aug 2023 22:20:22 +0000
References: <20230809124818.167432-2-johannes@sipsolutions.net>
In-Reply-To: <20230809124818.167432-2-johannes@sipsolutions.net>
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

On Wed,  9 Aug 2023 14:48:19 +0200 you wrote:
> Hi,
> 
> So I'm back, and we had a security fix pending for an
> issue reported to security@kernel.org, but Greg hadn't
> gotten around to applying it, so I'm handling it here.
> Also, covering for Kalle, some driver fixes. Since we
> want things routed to the right place I also included
> a couple of maintainer updates, but to be honest now
> I'm starting to have second thoughts about it. Oh well.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-08-09
    https://git.kernel.org/netdev/net/c/15c8795dbff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


