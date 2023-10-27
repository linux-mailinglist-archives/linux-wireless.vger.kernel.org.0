Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF397D8E00
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 07:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjJ0FKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 01:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjJ0FKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 01:10:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6505C1B9
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 22:10:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6EC3C433CD;
        Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698383450;
        bh=TyXcPDcA7TTQbRhs/9lOlcg1EO9AahL5ljNgx/nBR9c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e6OaOrIyiQeYIS2CC12RNOaS5wYkAEw0l9jnf8ZPhZq6cNj38I53cGpPca+Do0tK9
         opMnQ1WbG8/Vcy0IWhRZ8bJpAr0dGLiIB+AG3fUoYwmXlmWEnVuTlGxx6yGhd8/rjN
         glZrvc8UAOKupIletQBrm8BxjMgbimfSY5ApAvp6XGrs907aZgQUcdEqcWmuFrTZGS
         o87t+D1v1fk/xzHAMbNmov1MGq851RLmH3a+7MH0Vt2oTkb01XFmMjebMr+PO7LO6w
         aqq0krkieVqZ+NCRIN/DhWBTF3E00NAwp5RTXSr8DfdCVJMX/95NOkTXD3JP9JydoF
         w3V4fiSLUUexw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93302E11F57;
        Fri, 27 Oct 2023 05:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-10-26
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169838345059.10513.5353747529284282144.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 05:10:50 +0000
References: <20231026090411.B2426C433CB@smtp.kernel.org>
In-Reply-To: <20231026090411.B2426C433CB@smtp.kernel.org>
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

On Thu, 26 Oct 2023 09:04:11 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-10-26
    https://git.kernel.org/netdev/net-next/c/edd68156bccf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


