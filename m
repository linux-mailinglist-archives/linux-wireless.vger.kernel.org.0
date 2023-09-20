Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16167A7A3C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjITLQe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjITLQd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 07:16:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F752C9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 04:16:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F84C433C8;
        Wed, 20 Sep 2023 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208587;
        bh=swL+k+GVh0Gmc144V31CDhUbwzkBhnwhy9eGhMUPeL0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uw+1Wiajs6JKJeP9yqX7v7feqTvtYqpnhfBD5h6xu4lBEQ2B1Pg1T+waTmyt27DEn
         nV8mO3Oib84t4asNvgdF2vovcP+Swn3CoU3YcIe4UpE96Dq3VYKFtb9MHDnj2b8r0f
         jFBgP/n/bRHECsP62JC6aZXRZdfTfCYRRXN2OqhdoELIIgt33hTHhE7i/oJNbtMiuF
         rcdA5lGZWw0Vl4D3YtmH27g44iwR70nVxtKmr5XLFQF3s0Xt7Gznusx9eugLPvzq8R
         pt/OaCt+QtZceijltP/RHPTM488zuaLn3BUwBNaoicZ24qxi6r3TpLACB/nMMAyYnl
         eKlrzcZkoWNDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for
 debugfs_create_file()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919050651.962694-1-ruanjinjie@huawei.com>
References: <20230919050651.962694-1-ruanjinjie@huawei.com>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169520858429.991705.11262505938866457143.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 11:16:26 +0000 (UTC)
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

> Since debugfs_create_file() return ERR_PTR and never return NULL, so use
> IS_ERR() to check it instead of checking NULL.
> 
> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

74f7957c9b1b wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919050651.962694-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

