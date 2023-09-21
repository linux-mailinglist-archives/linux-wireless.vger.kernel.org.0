Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81137A9D38
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjIUT3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjIUT30 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67113A9EB
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79344C433CB;
        Thu, 21 Sep 2023 06:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695277756;
        bh=3plL4AVi0KjPMIVHUCes3Gt1Mq6OZUkOOGmfjZhrHko=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XFaoQZiz716ZymLV1KTPBKwxFr674MSZP8PNyq1PK4jMO+ZaaWU4W8dme3x+zKRhF
         0ym1FoL6NupCCN60ZwCiFnvTsbstytH640TNqhZskSDxuaJh6iyhywiCUJuE5QNN0/
         is+sxP1Mm64NsKEq3dtnKO6n97hiTfE+oWXLsbiPzCNHjIN5XSohC5eoetWkVpJ51N
         b0ng1Og/JaFOibpfmlLHm/A1M1dWNsy160JSW+/ASp4Heh3K+hYoQcWtD9J+m/8STm
         1HgOq7o+RSRnQtigOB7W8jlkahFvkdV6VP6ckAIeUULXf74qBy3BHZKUHH84jto3kF
         UHj9rD0q7xRUQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230821115254.167552-1-dmantipov@yandex.ru>
References: <20230821115254.167552-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169527775333.1469888.1103496771734115139.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 06:29:15 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Drop filled with NULL pointers but otherwise unused 'skb_arr'
> array of 'struct mwifiex_sdio_mpa_rx', adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

3ffd23d121de wifi: mwifiex: cleanup struct mwifiex_sdio_mpa_rx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230821115254.167552-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

