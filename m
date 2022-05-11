Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9934522B9F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 May 2022 07:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiEKF0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 May 2022 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiEKFZ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 May 2022 01:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852FE1A3B7
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 22:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41492B81F91
        for <linux-wireless@vger.kernel.org>; Wed, 11 May 2022 05:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED0AC385A7;
        Wed, 11 May 2022 05:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652246752;
        bh=gC3c7/72gSD23000zt4DumcmgANP3BkO24ezczgHrHY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fWKALXjbUugAdNdlRKKRyMRwQH32vhdMZ5wJHaq7eyePsDI3fXxt9CHzCGg2z+and
         97gEFJrGGFvf2wpBm+jZGgm/wJuDR1q0iY+sRgJVz6qr9S4/IY8VHy3sBtZwIlw9IP
         Fmcq+vTzJ0CCd8jMcZH/5N9FV8f9pvVhW1cs9EehkoGo/8/xCKD2kqL1VUY0f4Py1N
         ZG/+Mrkgt9+bxaXcBlOX0lgYhTB4xQYlq/0sDwBo/X+inTgIkvw0TZ6KchszapW9Z7
         6qQrCTb90kIZpxuddtgOky4sDr+MQ/C+QJaUvZvaOkxcdMKTcsNWfJxFX6j+EV5cVU
         7sVWk2lENuIOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wilc1000: increase firmware version array size
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220504161924.2146601-1-ajay.kathat@microchip.com>
References: <20220504161924.2146601-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165224674638.19198.14202355050293707012.kvalo@kernel.org>
Date:   Wed, 11 May 2022 05:25:50 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Increase firmware version array size to hold complete version information.
> The firmware commit id(Build:) information is also part of the firmware
> version string.
> 
> Firmware version format:
> WILC_WIFI_FW_REL_XX_XX Build: XXXXX
> 
> e.g.
> WILC_WIFI_FW_REL_15_6 Build: 12804
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

5 patches applied to wireless-next.git, thanks.

4ee8a915730f wilc1000: increase firmware version array size
72ebd6751f9e wilc1000: use fixed function base register value to access SDIO_FBR_ENABLE_CSA
868f0e28290c wilc1000: fix crash observed in AP mode with cfg80211_register_netdevice()
819b161b9487 wilc1000: use 'u64' datatype for cookie variable
62296b3e19dd wilc1000: add valid vmm_entry check before fetching from TX queue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220504161924.2146601-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

