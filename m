Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A5788432
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbjHYKAk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 06:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbjHYKAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 06:00:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924351FD3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 03:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27D286682A
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 10:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0C7C433C7;
        Fri, 25 Aug 2023 10:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957616;
        bh=2TPvHErBBJf2ETUp1CSsZPeKEtt6Kzh4mkHR0jdmdto=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Shtwz9dCSiiEG3Jxm683ESFo+c3FyJ/jWmloEQMLD3+mQzzQRU3Vs/95TgggYr2V/
         CIQmDRGYkkMoT60tmdO7H2bElYijr6LI11321Jg3Cyq/grlH4rzX3Q5DDG3wVeoi/v
         F7lqWN2aipkMn3hjyNsIu6dmjOXTMCWM6nEbfEm5rCYTQASK9Xs0FiefGZww2lbDg0
         65mCH1cFXowWi6S46yJFjt4zf9bJ+tdU2kWF2YPt3jEhCktaSoaFCbAiuSG2HROM+6
         cpycjOmfJkud6OfnT2rgZ/Nw2FLAC0peUvKPijZ6qJxuSmmQzgIFKiibHJQD1Dt2qf
         48rqDBAHbj8UQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: mac: add mac_gen_def::band1_offset to
 map
 MAC band1 register address
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230822125822.23817-2-pkshih@realtek.com>
References: <20230822125822.23817-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295761385.1850672.17252642534706657907.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 10:00:15 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> There are two copies of MAC hardware called band0 and band1. Basically,
> the only difference between them is base address, so we can share functions
> with a 'band' (or 'mac_idx') argument.
> 
> The offset of base address of WiFi 6 and 7 are 0x2000 and 0x4000
> respectively, so add band1_offset field to new introduced struct
> mac_gen_def to possibly reuse functions.
> 
> Using below spatch script to convert callers:
> 
>   @@
>   expression reg, band;
>   @@
>   - rtw89_mac_reg_by_idx(reg, band)
>   + rtw89_mac_reg_by_idx(rtwdev, reg, band)
> 
>   @@
>   expression reg, port, band;
>   @@
>   - rtw89_mac_reg_by_port(reg, port, band)
>   + rtw89_mac_reg_by_port(rtwdev, reg, port, band)
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

c220d08e1f98 wifi: rtw89: mac: add mac_gen_def::band1_offset to map MAC band1 register address
60168f6c50ed wifi: rtw89: mac: generalize code to indirectly access WiFi internal memory
3a7e4f56eb18 wifi: rtw89: mac: define internal memory address for WiFi 7 chip
9d87e7dc930e wifi: rtw89: mac: define register address of rx_filter to generalize code
1165f5719229 wifi: rtw89: phy: add phy_gen_def::cr_base to support WiFi 7 chips
058b20748197 wifi: rtw89: phy: modify register setting of ENV_MNTR, PHYSTS and DIG

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230822125822.23817-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

