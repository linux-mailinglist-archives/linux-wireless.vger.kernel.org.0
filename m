Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEAF5E9D8C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiIZJ0Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 05:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbiIZJZl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 05:25:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE410568
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 02:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0480B60B26
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED49C433D6;
        Mon, 26 Sep 2022 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664184284;
        bh=CLZxuY397AvAoXoC/BrmunXg7DevWnLeC/RnDK76lGQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jXbIvU79v0V1tBXblHvmnSTUlOdAWfg7dC25lMJn+73QQOWIvnw9nCG8TC0llP0zi
         lUM6tKxSF8ZV6g2DzDGDxinPEklMKLgpfELMegAJ0mIT5NijFa/6ZjWbzunx+MIiCp
         SE++6+ZmM9u2ZCuLRgBVptT0dLiqpc1Mbj0Eb0K1PxjqXUlC6h9xDau0I3mHr8wTxV
         PStx/F48B+uWK6wORlqbt8Ie9z3JCypBdXJ5pmP3y6ctEccZ/eFpBEGs3V7GmipCmF
         nL+FUX16mBmqS0yw6TMPT+xOWDPv1AxuVf3zdq8xndGNJ8sqiiwIlHJy0sXRtDmpme
         iiOVahg4mfGMA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
Subject: Re: [PATCH 3/4] wifi: rtl8xxxu: Fix AIFS written to REG_EDCA_*_PARAM
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
        <038cc03f-3567-77ba-a7bd-c4930e3b2fad@gmail.com>
Date:   Mon, 26 Sep 2022 12:24:41 +0300
In-Reply-To: <038cc03f-3567-77ba-a7bd-c4930e3b2fad@gmail.com> (Bitterblue
        Smith's message of "Sun, 18 Sep 2022 15:42:25 +0300")
Message-ID: <877d1q7ajq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> ieee80211_tx_queue_params.aifs is not supposed to be written directly
> to the REG_EDCA_*_PARAM registers. Instead process it like the vendor
> drivers do. It's kinda hacky but it works.
>
> This change boosts the download speed and makes it more stable.
>
> Tested with RTL8188FU but all the other supported chips should also
> benefit.
>
> Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[...]

> +static void rtl8xxxu_set_aifs(struct rtl8xxxu_priv *priv, u8 slot_time)
> +{
> +	u32 reg_edca_param[IEEE80211_NUM_ACS] = {
> +		[IEEE80211_AC_VO] = REG_EDCA_VO_PARAM,
> +		[IEEE80211_AC_VI] = REG_EDCA_VI_PARAM,
> +		[IEEE80211_AC_BE] = REG_EDCA_BE_PARAM,
> +		[IEEE80211_AC_BK] = REG_EDCA_BK_PARAM,
> +	};

static const?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
