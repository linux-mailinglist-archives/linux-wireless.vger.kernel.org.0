Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26B78802F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 08:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjHYGqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjHYGp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 02:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA87CD5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Aug 2023 23:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A81C611AA
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 06:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB353C433C7;
        Fri, 25 Aug 2023 06:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692945955;
        bh=SPf0JlHFP10nE5FSiZFg96WuwINAQod0UmBi7efzerY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uTxmeLSChn4IkIirSHh3Q6sTzi8VS8gOXZZUyaskwOTEoH8iFfA2vxEPfaxLFQGgZ
         1xbTEJrmZpafsz8eb2+iGgt3+NHaXMp7oay+jnuIWMDjws20GmDpGpGLBx/FE6YL37
         JzVE0CiSp/ozf+C0hU9YEY89Iw93QIk2/d4hVEqxJ1x1Kw1/Tzh8cY8cPHxPjYxTAQ
         /PwVra3uSfIdLkNkneo9aLq+TkdLScwefHqJwfnQ+hcmvTle/IKStvdd8R6wGjMcso
         F3C7XFrGqqEAQ1e6Rm1WBmL8Yfg6NT/zzbsuE7w86qA1zt6bAzPQacoYlb1N4Kl7Xb
         nm8RbngXURU9Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: fix typo rtw8822cu_probe
References: <20230825062404.50813-1-pkshih@realtek.com>
Date:   Fri, 25 Aug 2023 09:46:57 +0300
In-Reply-To: <20230825062404.50813-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 25 Aug 2023 14:24:04 +0800")
Message-ID: <87o7ivvcta.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> From: Po-Hao Huang <phhuang@realtek.com>
>
> The probe function of 8822cu is misplaced to 8822bu, so we fix it.
>
> Fixes: 07cef03b8d44 ("wifi: rtw88: Add rtw8822cu chipset support")
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I guess this is just a cosmetic change and does not cause any changes in
functionality? I can add that to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
