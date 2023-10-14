Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7B7C930B
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 08:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJNGmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 02:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjJNGmv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 02:42:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B96CC
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 23:42:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8489C433C9;
        Sat, 14 Oct 2023 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697265768;
        bh=MMfMP+AV0fs7x6j1MdNRQHMkQFw8hnCDkZXwx7QIKtg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=smKl4tw0LFpPtFh7cImZU92E7rqev0KAxAd9bDFXeq9eyf3X6r/cQNeBXXeXq4kRf
         GUPoEiWLkNKLtRi6Tfgel/OJJAGiERdkxMB1YfovmF+GoUFclJTAVHXYpCZq2yNc+8
         mSAlwPFJp4O9DQbtX6w+4EtZWvqgKJ2GgcWD4I+vpXjDnqe+AbZIVYau1ZIEWuxian
         f2MQpSGW7UrqJTgCG4Jf13bs68IaYpv7deu769EZzSviW7Mul7I0Syg/1HoA+qs2tZ
         DuJ9MIQCXgC/cRe/83AvKHdiKRI75MLoj+F8MfHGUDtLkcPAYKQ7h7BePbcuNNR59g
         lIGCrMhhnyDeg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wifi: rtlwifi: simplify TX command fill callbacks
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011154442.52457-2-dmantipov@yandex.ru>
References: <20231011154442.52457-2-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169726576572.3637479.6255382503730514780.kvalo@kernel.org>
Date:   Sat, 14 Oct 2023 06:42:47 +0000 (UTC)
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

> Since 'rtlpriv->cfg->ops->fill_tx_cmddesc()' is always called
> with 'firstseg' and 'lastseg' set to 1 (and the latter is
> never actually used), all of the relevant chip-specific
> routines may be simplified. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

461908825205 wifi: rtlwifi: simplify TX command fill callbacks

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011154442.52457-2-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

