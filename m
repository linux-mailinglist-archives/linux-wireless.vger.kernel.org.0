Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEC7D11D8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377610AbjJTOvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377648AbjJTOuu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 10:50:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57541713
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 07:50:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEDFC433C7;
        Fri, 20 Oct 2023 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697813442;
        bh=oocXcBg6ft4CUNhyxIfcVWaOKp9E5tvsg7MLSUkoIy4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hM+6X9+cAci1YHsjKD+2gkYeHWpsoOQ9yb5HL8emXy625rGAD8EdneJmqIoH9X6LZ
         +V7tguyLFxSrBTD8t6RHIWR5erv/lNiLSm1OwJg3RZ/OGJGUFDaRrqeRrpwlVapv95
         CufFx3Q+d2sT1/+Jyv6QHlQaxDD5CrSBxKonv1ogU500E0UaTf0QolhvhErRE0Zqou
         fE6KAl9W4WYahYIG0+r/w5ZY0DIjDNq9TlaxCxuc+ScR1KbE4ZJIomMVPa6iBR8c40
         i7py9v5nyLK1P661bUvJzcvCkZf0esOiXXWnnpopwApLRnt4M2mv0QRXiIdtCuzYy/
         g4Ou1tBH1jhmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ipw2x00: fix -Wformat-truncation warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017165215.143992-1-dmantipov@yandex.ru>
References: <20231017165215.143992-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169781343894.352343.15503426978176886839.kvalo@kernel.org>
Date:   Fri, 20 Oct 2023 14:50:40 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Fix the following warnings observed with GCC 13.2 and -Wformat-truncation:
> 
> drivers/net/wireless/intel/ipw2x00/ipw2100.c: In function ‘ipw_ethtool_get_drvinfo’:
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:63: warning: ‘%s’ directive output
> may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
>  5905 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
>       |                                                               ^~
>  5906 |                  fw_ver, priv->eeprom_version, ucode_ver);
>       |                  ~~~~~~
> drivers/net/wireless/intel/ipw2x00/ipw2100.c:5905:9: note: ‘snprintf’ output between
> 4 and 140 bytes into a destination of size 32
>  5905 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  5906 |                  fw_ver, priv->eeprom_version, ucode_ver);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> For ipw2100, 'ipw2100_get_fwversion()' says that the firmware version
> is no longer than 14 bytes, and 'ipw2100_get_ucodeversion()' uses "%08X"
> so 10 bytes should be enough.
> 
> drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function ‘ipw_ethtool_get_drvinfo’:
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:63: warning: ‘%s’ directive output
> may be truncated writing up to 63 bytes into a region of size 32 [-Wformat-truncation=]
> 10392 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
>       |                                                               ^~
> 10393 |                  vers, date);
>       |                  ~~~~
> drivers/net/wireless/intel/ipw2x00/ipw2200.c:10392:9: note: ‘snprintf’ output between
> 4 and 98 bytes into a destination of size 32
> 10392 |         snprintf(info->fw_version, sizeof(info->fw_version), "%s (%s)",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 10393 |                  vers, date);
>       |                  ~~~~~~~~~~~
> 
> For ipw2200, I assume that the firmware version is no longer than 14
> bytes as well, and, according to ipw2100.h, firmware date is in
> 'mmm dd yyyy' format so 12 bytes should be enough.
> 
> Suggested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I tried to fix this a bit differently:

https://patchwork.kernel.org/project/linux-wireless/patch/20231012135854.3473332-2-kvalo@kernel.org/

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017165215.143992-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

