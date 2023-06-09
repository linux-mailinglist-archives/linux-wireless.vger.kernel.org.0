Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F8729A04
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjFIMae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbjFIMaR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 08:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055D3AA4
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 05:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6174C65713
        for <linux-wireless@vger.kernel.org>; Fri,  9 Jun 2023 12:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2611C433EF;
        Fri,  9 Jun 2023 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686313695;
        bh=xmQbsGpjE1ohlx+uMchWdzhzKFcj0m+A3jS6YKTfnMc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FL6vxUbsONT2hmbK18cIHVPbawKYk8VAgSBj7WFBSxWl84GGO7zXCfzioco6I1PZJ
         MN/Z6rw9uCQXfMbp1nk7tfPcNnZalT0T6gChLEBvoUlSJYyavNR6wGHxYXnuARdVit
         AoMqqTiNPeI1MVVqEdP3a6VW6h/TT2lYUjp9MnHwoeJYAF+0NmOlBwSAz0NE6z827c
         pK7zCS6feJV+Q4YfAtvrbXXTa+XfO98X7EdtRWZfcQpliA46HtsM4t5Gt8eh+xXFtj
         T0m7H+YgSqvAUt3opAf31cVx8jyPV0GIlCjjxvMAJhbPo3lbLDZJMNGYD4VwWTHPoL
         PtmdyD9WbIHaQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/4] ath10k: Drop cleaning of driver data from
 probe
 error path and remove
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230601082556.2738446-2-u.kleine-koenig@pengutronix.de>
References: <20230601082556.2738446-2-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168631369188.10496.13768584046079083634.kvalo@kernel.org>
Date:   Fri,  9 Jun 2023 12:28:13 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Uwe Kleine-König  <u.kleine-koenig@pengutronix.de> wrote:

> The driver core cares for resetting driver data if probe fails and after
> remove. So drop the explicit and duplicate cleanup in the driver's
> functions.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

ec3b1ce2ca34 wifi: ath10k: Drop cleaning of driver data from probe error path and remove
fad5ac80dfa5 wifi: ath10k: Drop checks that are always false
d457bff27633 wifi: ath10k: Convert to platform remove callback returning void
6358b1037157 wifi: atk10k: Don't opencode ath10k_pci_priv() in ath10k_ahb_priv()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230601082556.2738446-2-u.kleine-koenig@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

