Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03787CD14B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 02:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJRAae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRAad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 20:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90241B7
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 17:30:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 373DCC433C7;
        Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697589032;
        bh=soDnUzUKYBogGm2mhVzuR5Tjnbz2TQhgwTDBGtH18WA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lR206GgArxDcl9qRo6OHCY550ounvDFHzexzGKxWM/MoFA0gYsl6rq3sd8JLMi2gx
         rB+82JguvQA0OJLySRnhTstXw0uy3NXYODp9s0PvXRBhql4yew7W5uETu6xIfx1YM3
         CvogE6yVuLx4qLU+yyRTy3CP56+G8LxmeK452zA7oOsbRzbsW+olA57+wqrt6AlsWy
         5OZ9r3B3CCQbtI+cIWHjxjpXISxIVA/dprjath3rYsOIIMglWTugUryLQF8G/w6xN2
         CTdPs55JMAU722n2tCis4hS3qCs+Mw6P1dhpnGOy/36TGIslwXiRoyE9M9E/I/TOTX
         PGJqfF71BWVgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A816E4E9BC;
        Wed, 18 Oct 2023 00:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-10-16
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169758903210.2770.15454538416871688769.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 00:30:32 +0000
References: <20231016143822.880D8C433C8@smtp.kernel.org>
In-Reply-To: <20231016143822.880D8C433C8@smtp.kernel.org>
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

On Mon, 16 Oct 2023 14:38:22 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-10-16
    https://git.kernel.org/netdev/net-next/c/56a7bb12c78f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


