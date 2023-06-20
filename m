Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A43737511
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFTTaX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 15:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFTTaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 15:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0241704
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 12:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E44760F1D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA85C433C8;
        Tue, 20 Jun 2023 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687289421;
        bh=nUeCfLB31CaFoKMGKSp295jPG5fUSMkthOYLw6VgpWM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=p2SQcF1CqcIHip21N+TgePwAwGtzZ2voSD1l5mBmw3WVXnePHOxMqOnA2bSPjrw9B
         MPymQFWZBuUsjymmtI/Ws/ofAiWsk/7emVR4tjW7zevVFRhp1uX0uCAQaN4smqWbJ6
         6g0jiCAC3EMoeCxq4jVq1EEqPTHg/ZKUlUubXdeeKrHxBDHcJx7DDjZFCKFTqrAjmW
         5uDKzh01u5UcQ8nXg5uYG3+PaZpLXaDAlFgn+Zn3xiyJVd5PyBJCWCLrLyvmbLoYbt
         9vshrN0uNXU8pS+EaPgqPeSzOoge0N5SiXoUKjVcf/V527Q68crL24xS4jwrCpJJoz
         svWF+4tDRsRgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA686E301FA;
        Tue, 20 Jun 2023 19:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168728942088.14216.9670142240343267380.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Jun 2023 19:30:20 +0000
References: <20230619150233.461290-2-johannes@sipsolutions.net>
In-Reply-To: <20230619150233.461290-2-johannes@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        mukesh.sisodiya@intel.com
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

On Mon, 19 Jun 2023 17:02:34 +0200 you wrote:
> From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> 
> Add support for AX1690i and AX1690s devices with
> PCIE id 0x7AF0.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]

Here is the summary with links:
  - [net] wifi: iwlwifi: pcie: Handle SO-F device for PCI id 0x7AF0
    https://git.kernel.org/netdev/net/c/4e9f0ec38852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


