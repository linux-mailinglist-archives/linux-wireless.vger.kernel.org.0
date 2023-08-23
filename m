Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869A8785551
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 12:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjHWKZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjHWKZp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 06:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19767E51
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 03:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B204A62239
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 10:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19245C433C8;
        Wed, 23 Aug 2023 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692786334;
        bh=vwqZ9zKjv6zkK9coGPnf8p57PfSY7qU/AJ2u7uJzmho=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cAghFAvSZoHwI3VoV/YD6r0fge+nwIsofZxMpSeRuy206sThDmYlrRt/RLTmsqcoP
         u7RlUPw1LqWeQpndjDJvF6eYDF0b2e2kaEhA8xMn3yiwkUBlf+E/FYyRlWRjwnkRPQ
         lm8Ef2KhgXDpABJLRGXbshTmRzx+GpJoMIxYGXYQ/xDTKT/xjSPYPDkroO5mKcX6Gm
         646ZE33B9xwsqsel6BHnJoFzh+RQcJP3iRXzIhSeIAxFgzL/QyHPHqPZ4V3yOjgNV2
         iw2OAPaMKLtRsdmLMru6jmqUPL0rjdlKglZRRBKw3y1jC24hskgWJuXYrN+osyEOrU
         eBm2DpRdY2FWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: mwifiex: simplify PCIE DMA mapping management
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230802161049.89326-1-dmantipov@yandex.ru>
References: <20230802161049.89326-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278633096.1133515.976396654998983133.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 10:25:32 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Simplify PCIE DMA mapping management by eliminating extra copies
> of {address, size} pairs to/from temporary data structures. Map
> and unmap operations may use skb fields directly via introduced
> 'MWIFIEX_SKB_DMA_ADDR()' and 'MWIFIEX_SKB_DMA_SIZE()' macros.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I assume these patches are compile tested only so I'm very reluctant
take these.

2 patches set to Changes Requested.

13338499 [1/2] wifi: mwifiex: simplify PCIE DMA mapping management
13338500 [2/2] wifi: mwifiex: avoid indirection in PCIE buffer descriptor management

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230802161049.89326-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

