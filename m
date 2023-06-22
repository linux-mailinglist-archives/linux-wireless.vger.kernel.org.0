Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A873971D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFVGAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 02:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjFVGAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 02:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB070EA
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 23:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2B461766
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 06:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C98C433C9;
        Thu, 22 Jun 2023 06:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687413620;
        bh=4ycCoCeRkBDkknDeFkT/nYWCaO7H6Sz2TzFIfeHuK3M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gxuptOm/nFfVaeXfI1SjIsEKs0J/oMTi9Y93dKZaPfCh2UMPi9Q339x04N+hBZyA0
         fgmFuIIHYNC+SlJLm5D7b5+qtG7mL/+fUtfnm3fiu35kN8U1B4+1jSFvr2C69lyXQl
         B6jZeN7LOOeOdt2xd/+wJbaTWlF+88kafrsKw2CxfE2oZl4hcJZrv5tCqhljo3ylME
         DIIibALaYeo+QGALwjrCS+ws/B4JoJBPZWV/TAkHoXfJa0UmTx+EIfiskxoLStghKc
         ZbUKhDJM6nIRkHYX2aNA7wngN3Rsz8ZcHvql4mGM7gA37ffLwKkWDweQ4WikbN5lAN
         oxCc9Z6eB6VnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C431E2A034;
        Thu, 22 Jun 2023 06:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: mac80211: report all unusable beacon frames
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168741362050.8755.11408593794457778367.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 06:00:20 +0000
References: <20230621120543.412920-2-johannes@sipsolutions.net>
In-Reply-To: <20230621120543.412920-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        benjamin.berg@intel.com
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

On Wed, 21 Jun 2023 14:05:44 +0200 you wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Properly check for RX_DROP_UNUSABLE now that the new drop reason
> infrastructure is used. Without this change, the comparison will always
> be false as a more specific reason is given in the lower bits of result.
> 
> Fixes: baa951a1c177 ("mac80211: use the new drop reasons infrastructure")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] wifi: mac80211: report all unusable beacon frames
    https://git.kernel.org/netdev/net/c/7f4e09700bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


