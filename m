Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8824B281C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350948AbiBKOk2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 09:40:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiBKOk2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 09:40:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D02A197;
        Fri, 11 Feb 2022 06:40:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E33E8B82A77;
        Fri, 11 Feb 2022 14:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B41E2C340EB;
        Fri, 11 Feb 2022 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644590424;
        bh=loi7Ozic4PR5aHPwFtuUrkrmW1tdNmfka4rxI9r9k8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aXF21CNs5/B85ZIo+GIQaZUUOLxmT8tf0dR4wx1MVb34as3KK6HBzG3MZloLdl62P
         46n0sFdR5TvERwu6BSPJjzdKlQHKTeOCGKgwVS80FhS5qwXOIUZ5ckFhQbADNLjNyM
         CMAy/asXZJBJb27FNGR4ejVI3ZDNxQWkOFSUbGQy/I/Uq8ENs4qQvlaEztbj9XwYtK
         1jSV8fCHEQjPs5VAGcme9172xTkcs1UEV1DSDKB61k40/cwRua1C+wIvQgjP1TfRdK
         li4fxd/F03WS4gKpkTwKTOny97LqbpVvZ6402NYh7c/HrDN4Q0uzH51XJaYsbId0JR
         /B6Wv/+Jf1THg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2189E5CF96;
        Fri, 11 Feb 2022 14:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2022-02-11
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164459042465.31178.124419469597096692.git-patchwork-notify@kernel.org>
Date:   Fri, 11 Feb 2022 14:40:24 +0000
References: <20220211094059.52B3BC340E9@smtp.kernel.org>
In-Reply-To: <20220211094059.52B3BC340E9@smtp.kernel.org>
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

This pull request was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Feb 2022 09:40:59 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2022-02-11
    https://git.kernel.org/netdev/net-next/c/b96a79253fff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


