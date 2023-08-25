Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209778843D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241844AbjHYKDU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbjHYKDK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 06:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FD1BE
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 03:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 009006526E
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 10:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72581C433C7;
        Fri, 25 Aug 2023 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957787;
        bh=4pQarfiFx7znhMKtIq711vYAAdUJ/73tM7x9G3fvlxI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EyAI+fd+t48iIsjWaO28DOe+uxPsgnPqnEMG0jEr/ZfOmTkw1y1wWPBJokNgXHbLB
         H+qHYNKL7DOyKAX7nMGgcU/ZHV021IecI7NDvJuEDplbOp5WGyKVijjr866/xTLA0z
         3uFO/reebwnhYJch3X3WZMUrvFIh/VWJk+pIPwsuVqbEq5A9rO6W20BrxTDCocavYF
         L0bvj9pyl5H2Sl0FguQQmyefif2nfdnLnDLWGK9MLDrCIc2e2CjZTYURP+1pLbYCYm
         R9iPP73g8vrg+yEnyiR6gOb3h/V+S04Npg0B823S3/ecsvpPooh6gZiJsZUxrPu9V1
         7mNRMAMaA3z6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtlwifi: rtl8723: Remove unused function
 rtl8723_cmd_send_packet()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230824062339.1885385-1-ruanjinjie@huawei.com>
References: <20230824062339.1885385-1-ruanjinjie@huawei.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>, <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295778460.1850672.7409992161310164080.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 10:03:06 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The function rtl8723_cmd_send_packet() is not used anywhere, so remove it.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

e8afebbf434b wifi: rtlwifi: rtl8723: Remove unused function rtl8723_cmd_send_packet()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230824062339.1885385-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

