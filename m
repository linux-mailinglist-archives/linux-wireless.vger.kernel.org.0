Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7D782DA6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 17:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjHUP61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 11:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjHUP60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 11:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9BF3
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 08:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA0C6166F
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 15:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471CC433C8;
        Mon, 21 Aug 2023 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692633503;
        bh=hZGA7coURT2zJlb9FTBYhe4HrnSqNuyUcEefgPH/t7s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=cQrxUEv4VqSpLt7F2OqMcrHn6leqEpbtR4j+Vs06emSwYbIf+yOChgyU2sR4VN+49
         2eBB6exOvXxQFtE+O0qBPn/osQEW416lB5fg5TEXY6zq+n6G37NXGOq+zKDRB5vUGH
         yLOqK1xDRsYSrOUraL0RRtTSjNSKJe0rNivGoavoI1SIj0auRB6FRxkAAUTRPNmIxA
         et5XtxKFZDQaESaTb/qDtbET5o2sTJtkftcOtz0MJpB9gpqXqSUsn/38CHU/ERmi/f
         KNtf00CZnL17aycXsxV/KT4q/2JLSbWJQ6sVGIDog9BvQO0vLxGucUGu+NC7JT0xGv
         nVaRK0HEfbJ6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: mwifiex: cleanup adapter data
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230814142101.60308-1-dmantipov@yandex.ru>
References: <20230814142101.60308-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263350110.572263.6168753009808843179.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 15:58:22 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove unused and set but unused 'dfs_workqueue', 'dfs_work', and
> 'scan_channels' members of 'struct mwifiex_adapter', adjust users.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Brian Norris <briannorris@chromium.org>

2 patches applied to wireless-next.git, thanks.

0e6ccd25e0d0 wifi: mwifiex: cleanup adapter data
ab55a976095e wifi: mwifiex: fix comment typos in SDIO module

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230814142101.60308-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

