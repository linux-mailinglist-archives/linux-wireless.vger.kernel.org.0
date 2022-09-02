Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7F5AAA37
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiIBIhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbiIBIhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:37:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213E6B8E1
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:37:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57AC062118
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400A1C433D6;
        Fri,  2 Sep 2022 08:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107839;
        bh=5yqgdbjf9aE7mVITkXc8sAfHBKmFeI6GXQk9ZU0rGtI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mKJTeWPaiJ3GYgJYSc77rv63oX7I0Aft+ihJG8fySSks5QggdySPMabs+116frS+1
         bHub4digseYxDLU7dLEcntx3dcjma9Ma3yso42c/wTneNLWejRmbW6INt3l+ADfjXr
         S52FjMKk6bigbp0gXxLh2GrVXGZOxjHby+ndb7i9Xk7z/JG8MbrR0YbhDtmLdePv5R
         2HJxb4U6nXaP0kKk6t6cd6lr39JX5g8CBdtrgAG4yuvKztkVMhPwPLHq+YPUz8KVFT
         XnRuW+HOrO0Un05Qt6iPsbpLlClVx+P/KSlJnIkhBg5wZSpNwLQ8DHQuKnJZyXBKmo
         bFdvAgUAttSsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: pci: fix interrupt stuck after leaving
 low
 power mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220824063312.15784-1-pkshih@realtek.com>
References: <20220824063312.15784-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210783724.24345.17742687832155161410.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:37:19 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> We turn off interrupt in ISR, and re-enable interrupt in threadfn or
> napi_poll according to the mode it stays. If we are turning off interrupt,
> rtwpci->running flag is unset and interrupt handler stop processing even
> if it was called, so disallow to re-enable interrupt in this situation.
> Or, wifi chip doesn't trigger interrupt events anymore because interrupt
> status (ISR) isn't clear by interrupt handler anymore.
> 
> Fixes: c83dcd0508e2 ("rtw89: pci: add a separate interrupt handler for low power mode")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

b7e715d3dcd2 wifi: rtw89: pci: fix interrupt stuck after leaving low power mode
4a29213cd775 wifi: rtw89: pci: correct TX resource checking in low power mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220824063312.15784-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

