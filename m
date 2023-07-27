Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6759765862
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjG0QNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 12:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjG0QND (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 12:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C122730FC
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 09:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F6B661ECA
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 16:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F44C433C8;
        Thu, 27 Jul 2023 16:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474378;
        bh=jTAtuRse9WoT1r13WlIN6o5V4ilv6k2aEiKR7JU7L+Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VWn/wM4Ds25nkp0ZPfuKWD4YiLWPR+n+efF0yFD+H1HSLf6j3svlMZAB7l29IFNAK
         iZslZEQtul1aODgJxK3hxG88SdkqK4Jb1bFnlcgdVQA1gNEZvZ2CDsMGDKF5nCrUB9
         ZQnCeL8bvUO15PKsNhpzsf/KZBCFjhtNzNkQK66tswFzuOo2oSIiwGa9di0hVMvxtb
         Q2vIdvRm5vSqmxTLpjn5I4CAWfXyAZAQQH7Y4EPcJFaEBPDrKxC1AgtVSygT4WWr8A
         fTrSylUv001DvgGZToN0CSTFX/GHCEMs4zWVMN7O6nKDQp3eTZB2T/VRpBvADTjjqr
         Yl9rfq7D3UyqQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wil6210: fix fortify warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230621093711.80118-1-dmantipov@yandex.ru>
References: <20230621093711.80118-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169047437544.3669718.17424986344996292041.kvalo@kernel.org>
Date:   Thu, 27 Jul 2023 16:12:57 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
> I've noticed the following:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘wil_rx_crypto_check_edma’ at drivers/net/wireless/ath/wil6210/txrx_edma.c:566:2:
> ./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> where the compiler complains on:
> 
> const u8 *pn;
> ...
> pn = (u8 *)&st->ext.pn_15_0;
> ...
> memcpy(cc->pn, pn, IEEE80211_GCMP_PN_LEN);
> 
> and:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘wil_rx_crypto_check’ at drivers/net/wireless/ath/wil6210/txrx.c:684:2:
> ./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> where the compiler complains on:
> 
> const u8 *pn = (u8 *)&d->mac.pn_15_0;
> ...
> memcpy(cc->pn, pn, IEEE80211_GCMP_PN_LEN);
> 
> In both cases, the fortification logic interprets 'memcpy()' as 6-byte
> overread of 2-byte field 'pn_15_0' of 'struct wil_rx_status_extension'
> and 'pn_15_0' of 'struct vring_rx_mac', respectively. To silence
> these warnings, last two fields of the aforementioned structures
> are grouped using 'struct_group_attr(pn, __packed' quirk.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1ad8237e9716 wifi: wil6210: fix fortify warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230621093711.80118-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

