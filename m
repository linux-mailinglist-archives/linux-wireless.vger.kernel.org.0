Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73DD728483
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFHQCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFHQC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F701702
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 09:02:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C52564814
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 16:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1744BC433D2;
        Thu,  8 Jun 2023 16:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240145;
        bh=3wFt8CGVTKC+TV3zZFmR8UtSu/tv1yh19COQfQNVFV4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cv4XJmPuQhkV96OOPDNq0lLupc7lCsqeokuA03XXvMGRry4tK26h71egDKttjmlnL
         DwMaDWPJV/j7vzhRobwpIdZoNkRGJSyuJbyxE2mhAYGWbITyJwaPSCE6wU5E4fNnXz
         Nw0DOhHHAD+hOw6rzL3BtXn+VzlSGfQYay923C8EbCOWpIkHlCviuPpbDbQcGKwro3
         Q2juei7vt2k8ERpdiDLbSAoSA9Y8mLw8pAuiSUse37u3XeBD8E+IPO0hRj/1GdkxoM
         xvOV9mUyFjO5aECHAK0HAYz9tvX7B8Kv5JIX5GThzyPdkbT/YrjW3k60Bi4CuqorrU
         UvwSHk7DprqNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230527222859.273768-1-marex@denx.de>
References: <20230527222859.273768-1-marex@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168624014117.5828.4271353370998823332.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 16:02:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Marek Vasut <marex@denx.de> wrote:

> It makes no sense to set MMC_PM_KEEP_POWER in shutdown. The flag
> indicates to the MMC subsystem to keep the slot powered on during
> suspend, but in shutdown the slot should actually be powered off.
> Drop this call.
> 
> Fixes: 063848c3e155 ("rsi: sdio: Add WOWLAN support for S5 shutdown state")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

e74f562328b0 wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230527222859.273768-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

