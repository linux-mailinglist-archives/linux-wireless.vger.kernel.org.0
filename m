Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABC738ED8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFUSbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 14:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjFUSbd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 14:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF18519C
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 11:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 481E661689
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 18:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD3CC433C8;
        Wed, 21 Jun 2023 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687372290;
        bh=26DsCrIvi2n7+WNnF3Wmc/ljoQ46A1T8FWgd3kvsX60=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UfGPv6Sso9/4S5ejhNR3THgt9u8wECiZrIfxEQXXbTVNKNDd+6/wl1xb199sRpJgp
         zg4tQnp/iLYeaAOlP31DQWRgSwwiUf8CjZerTdiK5fsLBSngA+Lrv9wU38ev76W/Cd
         RfYS9X7JCR5ZOAdOJPEti0o+LoqPvFthzqor03YduBH2G48/a6+l69JmrS2Hu4lsla
         Ki71h9i3+VKxJLIKsIqEJVU23RtPfVMsJsDWr/9v3qzjahoMicgsTfP3WEt5mH6Lhd
         QA48OYfMUiOrSAYIVPzQYltgAICUC0d1p1WX79mQWZoUMY1rp5JApslljltg5doxdo
         g1zWkBujLE30w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v3] wifi: rtlwifi: simplify LED management
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230614061832.40882-1-dmantipov@yandex.ru>
References: <20230614061832.40882-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <168737228474.1194246.13140069499978583848.kvalo@kernel.org>
Date:   Wed, 21 Jun 2023 18:31:29 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Introduce 'rtl_init_sw_leds()' to replace per-chip LED
> initialization code (and so drop 'struct rtl_led' as no
> longer used), drop 'init_sw_leds' and 'deinit_sw_leds'
> fields from 'struct rtl_hal_ops', adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

084f1f552f8d wifi: rtlwifi: simplify LED management
5f743f576d3f wifi: rtlwifi: cleanup USB interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230614061832.40882-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

