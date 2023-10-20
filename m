Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63B7D11C6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbjJTOpq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Oct 2023 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTOpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Oct 2023 10:45:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066BCF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Oct 2023 07:45:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F63C433C8;
        Fri, 20 Oct 2023 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697813140;
        bh=acLf+2NzwVyM5VvEjG3zF0YK+qyKObTQSHvqW8DXLi8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FJL8v259AXA+TKgmPtKfArUQilQbmbKFk2oSKh3RUsUBNQEe2H3jcawmi56H2VQBP
         Zh/XBSh5vJ5a1G9sYcRe0pLvrsx4K+bN/7j5q3zMalqdS/2GSMVWVBLLiIXXH4VTZX
         OuLSUET62Xrr/F4P0mA/V4zYIejbElRLpPsvc2qBV5esmSSos8kAusRfNBce3/dYzT
         1A2iUmrL7sF46EebE0e57dCA1em2hz6OGh9opqIeRm1JBet02Lpi8zkqHzPmzf0JG9
         c3irOvTKF3+6L7f6quI1KpV3PJ/pYA8EiaJx8UVxj8817IfsxUhEkegxaT6EuJsZdF
         f3tP1GFhitPHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: fix -Wformat-truncation warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231017155201.111950-1-dmantipov@yandex.ru>
References: <20231017155201.111950-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169781313737.352343.12523599682050042172.kvalo@kernel.org>
Date:   Fri, 20 Oct 2023 14:45:39 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Fix the following warning observed with GCC 13.2 and -Wformat-truncation:
> 
> drivers/net/wireless/ath/ath9k/hif_usb.c: In function ‘ath9k_hif_request_firmware’:
> drivers/net/wireless/ath/ath9k/hif_usb.c:1223:42: warning: ‘.0.fw’ directive output
> may be truncated writing 5 bytes into a region of size between 4 and 11 [-Wformat-truncation=]
>  1223 |                          "%s/htc_%s-%d.%s.0.fw", HTC_FW_PATH,
>       |                                          ^~~~~
> drivers/net/wireless/ath/ath9k/hif_usb.c:1222:17: note: ‘snprintf’ output between
> 27 and 34 bytes into a destination of size 32
>  1222 |                 snprintf(hif_dev->fw_name, sizeof(hif_dev->fw_name),
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1223 |                          "%s/htc_%s-%d.%s.0.fw", HTC_FW_PATH,
>       |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1224 |                          chip, MAJOR_VERSION_REQ, index);
> 
> According to the comment in 'ath9k_hif_request_firmware()', 36 bytes should be enough.
> 
> Suggested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

As I didn't get any replies to my RFH I unfortunately already fixed this myself:

https://patchwork.kernel.org/project/linux-wireless/patch/20231012135854.3473332-3-kvalo@kernel.org/

I just used a bigger buffer than you.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231017155201.111950-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

