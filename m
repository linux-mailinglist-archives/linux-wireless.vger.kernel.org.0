Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311837B6B2A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjJCOQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjJCOQ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 10:16:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CA29E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 07:16:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CDCC433C8;
        Tue,  3 Oct 2023 14:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696342614;
        bh=151grJFIi5fsE3npp4Rmsf7qKjqFMhfs8hx9WJKpzuA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=P4a9JIvPb1JycAlIUG3uBwu9Bj5MJH5yAA/KkjO1j8+Rzoc1vyh4To7phK9SUVoSH
         wYh0htUkW4CeHvY7dRVWzzpYiuNqgcvctAM+VoDPxR6ds+I82bJ9idO8UhJNw9GH4/
         BaPWnG2vI16K3rCjywCpMGRZrtx0rUrV7M/z/eILCxCTnrEreiw43f7RPHtHAD8J3X
         UO9J+sgAtKRpNkHGuH0Aqn+es1nlgOFDqca/xUE2g9rnzP81Sb3xo7AhZNcPsD766o
         czpvx21U2LCkHJiScgmr09vgHWSWDbtRxnbeuqapqyCFp1+smSVB03UD2f1BoRQ6YC
         zJdoWs63+MCwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: convert msecs to jiffies where needed
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230626151636.314868-1-dmantipov@yandex.ru>
References: <20230626151636.314868-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634261139.61956.15037887677169461852.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 14:16:53 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'mod_timer()' assumes expire time in jiffies and not milliseconds,
> 'msecs_to_jiffies()' should be used in 'ath10k_pci_rx_post_pipe()' and
> 'ath10k_snoc_rx_post_pipe()'.
> 
> This patch also introduces a minor refactoring and fixes number of loop
> iterations in 'ath10k_pci_rx_post_pipe()' (I assume that the number of
> calls of '__ath10k_pci_rx_post_buf()' should be equal to number of buffers
> returned by '__ath10k_ce_rx_num_free_bufs()' and not plus one).
> 
> Fixes: a6e149a9ff03 ("ath10k: add hif start/stop methods for wcn3990 snoc layer")
> Fixes: 728f95eef523 ("ath10k: rework posting pci rx buffers")
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This is too intrusive patch to take without any testing.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230626151636.314868-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

