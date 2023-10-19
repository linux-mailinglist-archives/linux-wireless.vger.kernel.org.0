Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405247CF137
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjJSH1y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:27:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DA124
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:27:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECED3C433C8;
        Thu, 19 Oct 2023 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700471;
        bh=jB+aHzQhq8TME8Rkm+fy2k+Xf3iVbFXsKy4v++brGPg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gigc391Pv7YQ1NXfGAlATcTKqySCFAaBrYc/NsSiKZy9HdUfIwWWLnXhDk7DadYXs
         4ESB23kh8pPUZhV6ruz3fzw7iHf5uYvtR71pqi/9sjUBbHdTivBxUg3UhRlA4RjOiV
         ysm7VjGDJusgmZfy27sx2E8ULLUFxu4MtagIWvZonuhMgkK1xBdVcMlrrY7CHkTIkq
         KivTvpXmmxwFNbAwPbUeEu7dTWwxJDCzWgSQHbHWHCbfeqOhzN0Bp/iacrJfUiTlrX
         riqzgBsPdC8ffU1BPWjteLrZ5n2Arp/3m0k9oD4m4mA94EZVLtY4ayP32nEY20qZXu
         JXBYljcbm0Jcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: rtlwifi: cleanup struct rtl_ps_ctl
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013124534.19714-1-dmantipov@yandex.ru>
References: <20231013124534.19714-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770046900.117236.12867404059386799197.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:27:50 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove set but otherwise unused 'sleep_ms', 'last_action', 'state'
> and 'last_slept' members of 'struct rtl_ps_ctl' (these seems to be
> a leftovers from some older code) and adjust 'rtl_swlps_wq_callback()'
> accordingly. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9a66e73094ad wifi: rtlwifi: cleanup struct rtl_ps_ctl

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013124534.19714-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

