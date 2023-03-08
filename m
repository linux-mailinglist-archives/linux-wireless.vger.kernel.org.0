Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496506B0C2D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCHPID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 10:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjCHPHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 10:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F8C6E61
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 07:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 325A8B81D2A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 15:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B3C433D2;
        Wed,  8 Mar 2023 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678288052;
        bh=kyk8q1IZwNdU+8DxygP/uvtrA7mwgTjtkQGYi0QKEn4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D4bqwbnZAr0kiEQYrbbktRmTyryAbt8YUKYvdv72k6TlzV89VQGwnSISTFaoj1xl/
         G/l7EOhuQhejXdDFz0FU00kizEifLg01XVQZVNx4KUi0Asl+DPLS5Xmy6SmibKuT2y
         O6UPH8rZUi2GHGdx0hPGh9ygAe7A77EN0qYZJmY1lFTFNIzR3rKPYxqDcss+zuVCNY
         OJsMlOJwhs0QX02pKzx64IRYf8tJX1NoXdgSSUjGD3Wa0/vIQTnIzsxmhE1E2JRVcH
         aEnECU/V2BdgagZb1cvrRwD3BzmzFUj5P+VvEYsLPzfD2YUAjpx2fn3ULsWRAREzCn
         TZWIIQwEoTDmw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] drivers: net: realtek: fix memory leak in rtw_usb_probe
References: <20230308142028.481504-1-dzm91@hust.edu.cn>
Date:   Wed, 08 Mar 2023 17:07:26 +0200
In-Reply-To: <20230308142028.481504-1-dzm91@hust.edu.cn> (Dongliang Mu's
        message of "Wed, 8 Mar 2023 22:20:28 +0800")
Message-ID: <877cvrp9ht.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Dongliang Mu <dzm91@hust.edu.cn> writes:

> drivers/net/wireless/realtek/rtw88/usb.c:876 rtw_usb_probe()
> warn: 'hw' from ieee80211_alloc_hw() not released on lines: 811
>
> Fix this by modifying return to a goto statement.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/net/wireless/realtek/rtw88/usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You forgot to CC linux-wireless and the title should be:

wifi: rtw88: fix memory leak in rtw_usb_probe()

Please fix these and submit v2.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
