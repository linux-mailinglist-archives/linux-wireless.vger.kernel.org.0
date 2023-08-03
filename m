Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA6E76F179
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjHCSKj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSKc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 14:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728403A87
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 11:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D965461E63
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41177C433C8;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691086228;
        bh=JQ7oC/6/r2+aJtlBU9MJELICSmE7bgUSZdhahmPBdqI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RV43oF2lW/2NJ3cQXHiQ1qTcOej2LxtDs+5gS7bHrgmBf3pBR+AGHCQsXClrNn9lN
         AEQ/zjx6c0OVxm8BuV33JTse8buxWoOnTcuXHSWmPTkFbOyt9swMo4PsRYEXzB1cFL
         vSc8a0EM/Rd4QDWU991+cI6Sq6HFX7MD2eXsQ/AX8VLIuZ03BYkPQmOSuliCQ1qQJ0
         GSGBT5nwVQwtxWZLidobi2ZQKKVqXJFFwnyp7O1vMS0uRKjvZ3AiSXREOgA9zAk5vw
         FfaBR4+4njA+G2GaWsqcgQA5yKK7sq8jkqEdP+OXVgCHQ5gyiKVNt0CNJ781uCFuTu
         Az57vMrAxmrHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F87EC43168;
        Thu,  3 Aug 2023 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-08-03
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169108622806.23543.11800053914524862324.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Aug 2023 18:10:28 +0000
References: <20230803140058.57476C433C9@smtp.kernel.org>
In-Reply-To: <20230803140058.57476C433C9@smtp.kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
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

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Aug 2023 14:00:58 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-08-03
    https://git.kernel.org/netdev/net/c/0d48a84b31f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


