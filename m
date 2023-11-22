Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48877F4998
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjKVPCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 10:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjKVPCo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 10:02:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24B19D
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 07:02:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B083C433CB;
        Wed, 22 Nov 2023 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700665360;
        bh=xWXFnQCVaUKviWVPS8uh+T0RISysTFHCzWBP1f/x/V4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kJlUETFpGjyViEyQtz0FVV+pfBiJJUMAOcHqV8TLAIrCeKKgdK201H/GVNTeoKg9H
         7SecfujVr5yV9ChfwUW1OQ4+ehOxK2l5weq3OHNnQ7b5KcmVlAo23qadkV674fVqlA
         thhIgm89wq+SMVncw943OXIhO8nFRZgbzWvMBxJu2MIiV6bWlPoYjl9VHtjVTCipSe
         DH1nHIGNbNAsUzHQp5ilNJudz5JCTzhCjUmfvXfKW5+yqghK9L46ohiSY+hx5J/EKx
         mF8KwxsYEy7UkqsscvFuV6GSn67HYPFUJ2YlJ3hIzKLF0GDbAm52jhcKXMyAKxS2VT
         kcgWd+XQgnR5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wifi: rtlwifi: simplify rtl_action_proc() and
 rtl_tx_agg_start()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231113144734.197359-2-dmantipov@yandex.ru>
References: <20231113144734.197359-2-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066535717.4178710.17154753836548581473.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:02:39 +0000 (UTC)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'drv_priv' is an in-place member allocated at the end of
> 'struct ieee80211_sta', it can't be NULL and so relevant checks
> in 'rtl_action_proc()' and 'rtl_tx_agg_start()' may be dropped.
> Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

2c4e9acbe3a5 wifi: rtlwifi: simplify rtl_action_proc() and rtl_tx_agg_start()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231113144734.197359-2-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

