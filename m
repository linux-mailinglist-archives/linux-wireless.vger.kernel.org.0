Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929F247B0D1
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 17:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhLTQCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhLTQCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 11:02:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A5C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 08:02:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB09861216
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 16:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A1C36AE5;
        Mon, 20 Dec 2021 16:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016152;
        bh=jnIQaeVdoh/VDLPenNMIMoSxbIMtiiU/uOm77hJv/Ww=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Kq7VjsabKowIxFHFJRlDB5B2SnLBMo1cioEzWuClUkJQJEFSJwEvcJ6bY4f1YcyPM
         TUcUnj7yq9jgXIKmCB+/YKPPSw+aIdPVcqDCyshN0rEYgnKV6Soow0pnka5lJwK4QO
         WH7NQXHNoZm74fvoqSaiIJy2uhzjeWAEyJa+nbBDb4A/trnWTHbNhrYaVPB5jshpCZ
         ExBFuO6HUHm9flOf+BjYgx0JtlDuOw8Uz+OCdgOldsJmZS7BWN1KUkISd1DChG4Qgw
         iuj/2QBcTitTUQoeqrmmOV1mcVYDCa3/nmhqzJKxkf/aR99JnWKu5HrlINtnob4aqE
         GEoEB821AP2Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: switch to rate table based lookup
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211215215042.637-1-jelonek.jonas@gmail.com>
References: <20211215215042.637-1-jelonek.jonas@gmail.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org, nbd@nbd.name,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164001614889.2023.14570320085741679938.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 16:02:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonas Jelonek <jelonek.jonas@gmail.com> wrote:

> Switching from legacy usage of ieee80211_get_tx_rates() lookup to direct
> rate table lookup in struct ieee80211_sta->rates.
> 
> The current rate control API allows drivers to directly get rates from
> ieee80211_sta->rates. ath5k is currently one of the legacy drivers that
> perform translation/merge with the internal rate table via
> ieee80211_get_tx_rates provided by rate control API.
> For our upcoming changes to rate control API and the implementation of
> transmit power control, this patch changes the behaviour. The call to
> ieee80211_get_tx_rates and subsequent calls are also avoided. ath5k now
> directly reads rates from sta->rates into its internal rate table. Cause
> ath5k does not rely on the rate array in SKB->CB, this is not considered
> anymore except for the first entry (used for probing).
> 
> Tested this on a PCEngines ALIX with CMP9-GP miniPCI wifi card (Atheros
> AR5213A). Generated traffic between AP and multiple STAs before and
> after applying the patch and simultaneously measured throughput and
> captured rc_stats. Comparison resulted in same rate selection and no
> performance loss between both runs.
> 
> Co-developed-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a5d862da9105 ath5k: switch to rate table based lookup

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211215215042.637-1-jelonek.jonas@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

