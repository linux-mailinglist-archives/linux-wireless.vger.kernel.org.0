Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588FA5BA96B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Sep 2022 11:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIPJbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Sep 2022 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIPJbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Sep 2022 05:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A51CA6C46
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 02:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E509F62902
        for <linux-wireless@vger.kernel.org>; Fri, 16 Sep 2022 09:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCEDC433D6;
        Fri, 16 Sep 2022 09:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663320666;
        bh=IzOoUg24TN9m11Bj4A89EKxSOI/fHreYBOqcQ26+NpI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SaERNwbmWTRBAJENT2/4FYvsIH6lYJ0YfbyAu/n6kIwzPcFomO+GOnVEudGS4b5nQ
         7lpnuSxsqLRGacdL+OuVRgwP9ZzY3Zrt20VzWLxmG7ho68DkVjZDGG8PhI8/Y64Zom
         afvh5eCpJEVI5386J3Ob2o/V9GFv3ip5co2LDPV7WJR4UobuzkRKsIU04RTgkZ+XTy
         i4nZ4Rv99dyj1au6S+idnNqcB0dhRQiGTVadNMIaow7dCosA/XZMY9lQh/kqKQriL0
         TsVJOY9qI60s9xbUuWoP8Fyb5pbK9e+VGBHhEQf0OEuypVA3cbC37nlce039HriAdv
         iWw7n5A4bVkpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: retrieve MAC address from system firmware
 if
 provided
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220914215408.372520-1-junyuu@chromium.org>
References: <20220914215408.372520-1-junyuu@chromium.org>
To:     Jun Yu <junyuu@chromium.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Jun Yu <junyuu@chromium.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166332065994.16673.5878780244374823378.kvalo@kernel.org>
Date:   Fri, 16 Sep 2022 09:31:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jun Yu <junyuu@chromium.org> wrote:

> Devices may provide their own MAC address via system firmware (e.g.,
> device tree), especially in the case where the device doesn't have a
> useful EEPROM on which to store its MAC address (e.g., for integrated
> ahb WCN6750).
> 
> Use the generic device helper to retrieve the MAC address, and (if
> present) honor it above the MAC address advertised by the card.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Signed-off-by: Jun Yu <junyuu@chromium.org>

Fails to build:

drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_register':
drivers/net/wireless/ath/ath11k/mac.c:8999:9: error: too many arguments to function 'device_get_mac_address'
 8999 |         device_get_mac_address(ab->dev, mac_addr, sizeof(ab->mac_addr));
      |         ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./include/linux/ieee80211.h:20,
                 from ./include/net/mac80211.h:20,
                 from drivers/net/wireless/ath/ath11k/mac.c:7:
./include/linux/etherdevice.h:35:5: note: declared here
   35 | int device_get_mac_address(struct device *dev, char *addr);
      |     ^~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [scripts/Makefile.build:249: drivers/net/wireless/ath/ath11k/mac.o] Error 1
make[4]: *** [scripts/Makefile.build:465: drivers/net/wireless/ath/ath11k] Error 2
make[3]: *** [scripts/Makefile.build:465: drivers/net/wireless/ath] Error 2
make[2]: *** [scripts/Makefile.build:465: drivers/net/wireless] Error 2
make[1]: *** [scripts/Makefile.build:465: drivers/net] Error 2
make: *** [Makefile:1853: drivers] Error 2

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220914215408.372520-1-junyuu@chromium.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

