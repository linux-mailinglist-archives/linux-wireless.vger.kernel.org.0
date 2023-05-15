Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3077B702663
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 09:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbjEOHuj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238839AbjEOHuh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 03:50:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB81199F
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 00:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B6861FA2
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 07:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85900C433A4;
        Mon, 15 May 2023 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684137025;
        bh=WPkossC5wCRbrnRCBcADhhmyj2KDsombbtJfKgYZl8A=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HjzxpCGz+Acela76tqnVmbBKETgX9yK4lu1FpvpY4698y6tdrSEH27dsidhwp5/tG
         /6BovS1FpoAD3FLrDKW342NnC2ue9+cXi/7zzWtSn5+L9ic1RLG0rpRtPVHPjw1+Ps
         nV10BsO/QlOXMgiPt+h+Pv9wZzKRIaoWQ/9uHHRE6fS+Zy+Vkfl74q8zSUHReLvfLm
         8ddGZJwjXdJOcn+kGSaHexDdYBXRBDaz5PCIMpno9HjDYMS3uWnbF5HPQDxAOT+eNC
         NpjoXWGeAkTYFDA4l6Zi+D/LdzdAZhTZRLitaorX7ofn31xvagHNIB2YEy/nij1M6Q
         fAISdzh7j0vIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54E7DE5421B;
        Mon, 15 May 2023 07:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-05-12
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168413702534.26935.6972873267729953061.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 07:50:25 +0000
References: <20230512102647.8C727C433EF@smtp.kernel.org>
In-Reply-To: <20230512102647.8C727C433EF@smtp.kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
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

This pull request was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 May 2023 10:26:47 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-05-12
    https://git.kernel.org/netdev/net-next/c/6d4ff8aed3b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


