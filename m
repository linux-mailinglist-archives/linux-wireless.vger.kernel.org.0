Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4050E46BF0A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhLGPUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 10:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLGPUQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 10:20:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB8C061574
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 07:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 153E1CE1B68
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 15:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E32C341C3;
        Tue,  7 Dec 2021 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890202;
        bh=jiYx5o6IIdoldqcXdrP/KfJy6PT8qz5O7TD1XGGkbzg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UlE6nsN30ID55UaCkw5TQ2CcxUKE3XEnv4yDc/m+40DF73dCIKJ8fLaOkeQXjAgpH
         UilviKcJOOxlFSDmnYNYsfwD4vdoRrxpb1hRdMk2wlYuT70bJ7aEDc29ee/Xk7Iul8
         Q/H7bOEKLKmyUUopYeYKpDgTqG7iHM7gf33/TUj2wJE8Vy1FMk9cjbTIZdA/fgmrhR
         /T/Go6+aELgJRJu7h/cUOfvEGluku517Lt5MaQYEZpUdGDXHZ9n8KVnGeN8hjv3rM4
         /0DQz4meYG57On6e21/T+JazI5c0YzmlA/nUaEP+xrU2qhGyZ2LMuOgM+PjKouRuPe
         cr7EuLcyO1tWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath9k: switch to rate table based lookup
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211128090753.958-1-jelonek.jonas@gmail.com>
References: <20211128090753.958-1-jelonek.jonas@gmail.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org, nbd@nbd.name,
        toke@redhat.com, Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163889019720.23771.16292116056725581861.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 15:16:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> This patch changes mac80211 rate control for the ath9k driver.  The rate lookup
> per packet is changed from legacy usage of ieee80211_get_tx_rates() to the new
> rate table based lookup in struct ieee80211_sta->rates.
> 
> The most recent rate control API, introduced with commit 0d528d85c519
> ("mac80211: improve the rate control API"), allows drivers to directly get
> rates from ieee80211_sta->rates. This is not used by every driver yet, the
> translation/merge is currently performed in ieee80211_get_tx_rates.  This patch
> changes the behaviour and avoids the call to ieee80211_get_tx_rates and
> subsequent calls. ath9k now directly reads rates from sta->rates into its rate
> table. Cause ath9k does not expect rate selection in SKB->CB, the table merge
> does not consider rate array in SKB->CB except for the first entry (used for
> probing).
> 
> Tested with a 8devices Rambutan with QCA9558 SoC by performing two runs, one
> without the patch and one with. Generated traffic between AP and multiple STAs
> in each run, measured throughput and captured rc_stats.  Comparison of both
> runs resulted in same rate selection and no performance loss or other negative
> effects.
> 
> Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

7f3a6f5dd207 ath9k: switch to rate table based lookup

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211128090753.958-1-jelonek.jonas@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

