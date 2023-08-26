Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD1789320
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Aug 2023 03:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjHZBlD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 21:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjHZBkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 21:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E11FCB
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 18:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C2A62862
        for <linux-wireless@vger.kernel.org>; Sat, 26 Aug 2023 01:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F8FC433C7;
        Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693014038;
        bh=2j3P+TA8tkmXSr1KmRkRIyjL6HkmIgt6Wch8RsHB7OY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=R4Ruz/os+Tfg+EwnSLkmOK9S8sr+sVPQDQV1z25TKnaHIxTnfrYuviY+H8z7wsLbx
         AdAqMIKtwLciC9xiu5K7FSyejPmIJEndEIDFwg9X11yEonxSLuEwU49uLnSg+nt6I7
         M5B3CshsjoWyPS3U68jPl9JRf492YG3T1RDg6w1e5BVzaWf4untjxXnZhp86vfAysJ
         ZZXk50DAAWPvBerl43WHCG2oSj0kbQsFnGRmP7u43H9vCvG/msyuBAfngkvkc9czHl
         dp1XrCTnGgiWtQsvseXEdtEL3cvrzo85z5PcJu1LAyGtCznwYQFj8f/UUTHckmbJJ2
         D8I4bqfR8jI2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65022C595C5;
        Sat, 26 Aug 2023 01:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-08-25
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169301403841.445.5608322427600137990.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Aug 2023 01:40:38 +0000
References: <20230825132230.A0833C433C8@smtp.kernel.org>
In-Reply-To: <20230825132230.A0833C433C8@smtp.kernel.org>
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

On Fri, 25 Aug 2023 13:22:30 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-08-25
    https://git.kernel.org/netdev/net-next/c/1fa6ffad1275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


