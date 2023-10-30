Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2907DBEBD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJ3RWp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3RWl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:22:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA48E
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:22:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3550C433C9;
        Mon, 30 Oct 2023 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686558;
        bh=q7I+qOPEHdZVE8KeJzEiYinXQQaeltX/0+aK5067TC4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fFEdsCBLUcvsSFJkrhr1GU5BzwyM5jHTgx65yp4NL73untdVlm7Pb/lcSmo4DNOkq
         Tkf/pbU2x5r0gkNFCxnTp6FXzMAQWFsbpqO0hUXFQ2NtR0q9A5PJwmFyTBF5jUyGWr
         i6/BZM0c4uTNUp6vbWADrX3a2smnqHyL67WU90zUf/fj0Yg7jheSYT/VYp/C3Zexn1
         jPic36W9/P7fhIbOKw8pMmVXvigD4WIesm3PU4Hn8GSebIraPbZPboaDHpNU4lFcg5
         zuLWF/Gp6VuRLK2opPORDOvg84VQzdGxmSLb0txLseT2xX/0RoC4/F63xprDxG1ZH7
         re6rDTV6FLL5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: fix timeout calculation in rtw89_roc_end()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231024143137.30393-1-dmantipov@yandex.ru>
References: <20231024143137.30393-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868655567.1993746.15704373038382391241.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:22:37 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'rtw89_core_tx_kick_off_and_wait()' assumes timeout
> (actually RTW89_ROC_TX_TIMEOUT) in milliseconds, I suppose
> that RTW89_ROC_IDLE_TIMEOUT is in milliseconds as well. If
> so, 'msecs_to_jiffies()' should be used in a call to
> 'ieee80211_queue_delayed_work()' from 'rtw89_roc_end()'.
> Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

e416514e309f wifi: rtw89: fix timeout calculation in rtw89_roc_end()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231024143137.30393-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

