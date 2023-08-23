Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8D78567D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHWLKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 07:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjHWLKg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 07:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00BDE7D
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 04:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE6A6523C
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 11:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB5BC433C7;
        Wed, 23 Aug 2023 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692789002;
        bh=BXyEBZOgVdoJO0xJ3BZjL8h4q+R94vXV3td9SjcSCFI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=O0sFH+EESUSmI7A3F7kwZkO3G97GfhKtNkZ3wB7cHy32K0yEvppj2Hl/sLoLfzZYn
         PUBHiPioifbn6yRLAeqYuAItUN0D1kPAXkqNbmIClFxJFCZ1ePz/C8ke9XcRxXJlAo
         KVoHM0GAqn/yfrEgWxG62ibUyoalLxAwvGHCWtezMXhR+xswvxhr1dT2ZnUiSu0o8M
         vc8x+n158sE6mvf4e6tlNz4Ick+A/G4pOFracUkWp4Opmw8XeR2zgcSv97elByMiQp
         C6dlnRwgcL74V1ZMqGYdUwCaoSWSk3i2hVbBzYfmXowyIh5vVLBR6qXGqiua1R72gA
         WTAsLcfwrFeKQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2] wifi: rt2x00: limit MT7620 TX power based on eeprom
 calibration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB03159090ED14044215E59FD6BC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB03159090ED14044215E59FD6BC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278899930.1133515.16332073083038231584.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 11:10:00 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> In the vendor driver, the current channel power is queried from
> EEPROM_TXPOWER_BG1 and EEPROM_TXPOWER_BG2. And then the mixed value
> will be written into the low half-word of the TX_ALC_CFG_0 register.
> The high half-word of the TX_ALC_CFG_0 is a fixed value 0x2f2f.
> 
> We can't get the accurate TX power. Based on my tests and the new
> MediaTek mt76 driver source code, the real TX power is approximately
> equal to channel_power + (max) rate_power. Usually max rate_power is
> the gain of the OFDM 6M rate, which can be readed from the offset
> EEPROM_TXPOWER_BYRATE +1.
> 
> Based on these eeprom values, this patch adds basic TX power control
> for the MT7620 and limits its maximum TX power. This can avoid the
> link speed decrease caused by chip overheating. rt2800_config_alc()
> function has also been renamed to rt2800_config_alc_rt6352() because
> it's only used by RT6352 (MT7620).
> 
> Notice:
> It's still need some work to sync the max channel power to the user
> interface. This part is missing from the rt2x00 driver framework. If
> we set the power exceed the calibration value, it won't take effect.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

821b5192c955 wifi: rt2x00: limit MT7620 TX power based on eeprom calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB03159090ED14044215E59FD6BC10A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

