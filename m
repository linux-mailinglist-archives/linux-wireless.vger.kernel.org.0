Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998472DCAE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbjFMIij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbjFMIi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FF1BC5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C88D632AA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8665CC433EF;
        Tue, 13 Jun 2023 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686645497;
        bh=Z34jVPDUGp9AzcvpyTQOGZMjh8Aj8XzFUQ53sc5JuoI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F6j6TPPXx3W0/R+pnlDHWZCPEsaYhAv0HOS3ZJYojHP2FbvIwJOpvb/xKG66hhmsr
         W29h6eQ9UGtBhD/X7K/dFPp4DWkRbxs3RKDWAwwmLp2B7obgm/r2L77JnmHXPLj2iE
         7GK81binLQ3dh5d7TxfWthoFQC0js7rveJ/Io1vNLiNKhWhW681iBbfpiCxRgd52Cr
         NutYCX7Bci/2wxtovDe9Cl8AwHr6eK/24rTVWAjt+hFTm8XJm8OkzVdWqEkyCgHS4a
         SMjj0e9fjooP2CP7YhhTCraijTRT9m2Us+psCQsGoi5g2u94SBgTTTN7l51MA2q6IP
         L67BFKlr4azrQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v3] wifi: rtw89: cleanup private data structures
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230608082457.36020-1-dmantipov@yandex.ru>
References: <20230608082457.36020-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664549483.24637.5306969377701572999.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 08:38:16 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove a bunch of unused (and set but unused) fields
> from 'struct rtw89_btc_wl_nhm', 'struct rtw89_dle_info',
> 'struct rtw89_hal' and 'struct rtw89_env_monitor_info'
> driver-specific data structures, adjust related bits.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to build:

drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c: In function '_iqk_init':
drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:1563:17: error: 'struct rtw89_iqk_info' has no member named 'thermal_rek_en'
 1563 |         iqk_info->thermal_rek_en = false;
      |                 ^~
drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c: In function '_doiqk':
drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c:1592:17: error: 'struct rtw89_iqk_info' has no member named 'kcount'
 1592 |         iqk_info->kcount = 0;
      |                 ^~
make[6]: *** [scripts/Makefile.build:252: drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.o] Error 1
make[6]: *** Waiting for unfinished jobs....
make[5]: *** [scripts/Makefile.build:494: drivers/net/wireless/realtek/rtw89] Error 2
make[4]: *** [scripts/Makefile.build:494: drivers/net/wireless/realtek] Error 2
make[3]: *** [scripts/Makefile.build:494: drivers/net/wireless] Error 2
make[2]: *** [scripts/Makefile.build:494: drivers/net] Error 2
make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
make: *** [Makefile:2026: .] Error 2

2 patches set to Changes Requested.

13271750 [1/2,v3] wifi: rtw89: cleanup private data structures
13271751 [2/2,v3] wifi: rtw89: cleanup rtw89_iqk_info and related code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230608082457.36020-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

