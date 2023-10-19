Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF40B7CED72
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 03:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjJSBU2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 21:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjJSBU1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54185113
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 18:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE3BC433BA;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678425;
        bh=CNs0BKDEjfOa2gcNkk744AMJR6d0l87ZEc8H5ukVQ0U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=O7yRsKdm44uB9FCtS4JFnCgTBJ9fWQKDSpcSlFOE8AMjXmqHambnuwV4AhXKtYtpu
         p+OxYZGIWmMuvVq2V8kFJcaKbSV1z0xsLunTtJFDtzClugIxwNvH+Ck9UeAf380HdZ
         zMQCr/aa51aL3m3owfGbWnuQff4hThHOZM8HP2P5XgYHAZ3V2hxYJgH7N8RQb8AEap
         QNQjRHIUTE35f4S1pIlMMSivS4iuhbKricMFLgW4uTAh3vUcPWx2zS2lb7YWlsaEGv
         fYrFB7Lz9cR+PgFnrgSMIWcw76G7yOx3MbMz7QMOorTkavdv/hX0Tm1aoeGM1Ybyf0
         o+XoaiMLQScqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCC78E00084;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-10-18
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169767842477.18183.16659092882709250447.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 01:20:24 +0000
References: <20231018071041.8175-2-johannes@sipsolutions.net>
In-Reply-To: <20231018071041.8175-2-johannes@sipsolutions.net>
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

On Wed, 18 Oct 2023 09:10:42 +0200 you wrote:
> Hi,
> 
> So we have a couple more fixes, all in the stack this time.
> 
> Unfortunately, one of them is for an issue I noticed during
> the merge between wireless and wireless-next last time, and
> while it was already resolved in wireless-next, the issue
> also existed in wireless; as a result, this causes a merge
> conflict again when merging wireless and wireless-next (or
> obviously net/net-next after pulling this in, etc.). This is
> (pretty easily) resolved by taking the version without the
> lock, as the lock doesn't exist any more in -next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-10-18
    https://git.kernel.org/netdev/net/c/88343fbe5a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


