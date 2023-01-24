Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBD67A6F8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jan 2023 00:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjAXXkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 18:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAXXkl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 18:40:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFDDEC47;
        Tue, 24 Jan 2023 15:40:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B3A1613F7;
        Tue, 24 Jan 2023 23:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8578DC433EF;
        Tue, 24 Jan 2023 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674603639;
        bh=j8nMb346Q2XEu+B8UmKpDg7d0MtdIuRWSU/yR8zKkks=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l9GiQ+5lWUAsI1uD7ZKPyK9VpiTyd9R33p2+i49ZFSqHTKy0/1x0DvrRzTRVlEW0o
         /KE5YoSRonbCFy4EL8caFH8+J8bolf7tDfYJw8ib6tzhqNoW/xn//IL3+a5OTnh7XN
         XZQYLPtSloF7ID23EG8UGhanl/hRw+buxHE0UO8EX9ds/gn0Gj08hGEBPD56ck9WUG
         JPYqXgi4Z2oWCeCyt28y9eL3SinfTiZ5G0+SDnEGzRJDBw4nPX7GOLMg4pKdDG6p5L
         N96NqUx+EObMnzc89vy34zX79BxU9l6kOhkDZKcsu/6LlLoq0HaIlSdOBq5MGQXj0D
         fZ86exPy+lgTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D348F83ED1;
        Tue, 24 Jan 2023 23:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167460363944.4058.4676712965831302643.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Jan 2023 23:40:39 +0000
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
In-Reply-To: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, robh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Jan 2023 11:47:27 +0100 you wrote:
> Add the missing trigger patterns for Bluetooth and WLAN activity, which
> are already in active use.
> 
> While at it, move the mmc pattern comment where it belongs, and restore
> alphabetical sort order.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
    https://git.kernel.org/bluetooth/bluetooth-next/c/ef017002b93b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


