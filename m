Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C772847E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFHQCV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFHQCI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2B359A
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 09:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B27D64EC7
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 16:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FC0C433EF;
        Thu,  8 Jun 2023 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240111;
        bh=uxVKn8B7UnQ7DreeWBr1pGGtJNVRbe4Xc8LONzaoKIo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HmC8d/8cWuDnixAGJOBiwaVNqpPdxrnj2y90EpYHdD9J3T1n9znwL8njhjbYfG5K6
         P/b/3utJHAuGyP363I8W6hymnA6B5oypOD4H29DCTtAvrExZcvH1NUhfIpXgqRkTkQ
         s5PVA8Hj33SfKBm53uffoR3sp0SqRBNXQwIUO9l7VzWaoFdSwuvOOUo9hTko1GYP9/
         LoB5/vdyFN9l0L7xXluzMYAL0UUro9wSSeg9LEhaPMrZ0Sk6YaG6hcmeR8UcKfSvn8
         TUt/iifOyBpgGx/HZtLMXJPsaZTpnHUjAHeKhcPMyKxaDB0eBBVzvUzSWQwQ/9Vd7/
         2e/wVIC3KKqXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rsi: Do not configure WoWlan in shutdown hook if
 not
 enabled
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230527222833.273741-1-marex@denx.de>
References: <20230527222833.273741-1-marex@denx.de>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-wireless@vger.kernel.org, Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168624010800.5828.9610241801394227388.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 16:01:49 +0000 (UTC)
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

> In case WoWlan was never configured during the operation of the system,
> the hw->wiphy->wowlan_config will be NULL. rsi_config_wowlan() checks
> whether wowlan_config is non-NULL and if it is not, then WARNs about it.
> The warning is valid, as during normal operation the rsi_config_wowlan()
> should only ever be called with non-NULL wowlan_config. In shutdown this
> rsi_config_wowlan() should only ever be called if WoWlan was configured
> before by the user.
> 
> Add checks for non-NULL wowlan_config into the shutdown hook. While at it,
> check whether the wiphy is also non-NULL before accessing wowlan_config .
> Drop the single-use wowlan_config variable, just inline it into function
> call.
> 
> Fixes: 16bbc3eb8372 ("rsi: fix null pointer dereference during rsi_shutdown()")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

b241e260820b wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230527222833.273741-1-marex@denx.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

