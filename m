Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C96761BAA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjGYO3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjGYO2c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 10:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA4210A
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 07:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D60661771
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 14:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848CEC433C8;
        Tue, 25 Jul 2023 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295307;
        bh=JF9ScQlGgL6s4PlAusBKc/b5q948oxgcgh9Me1pjm1M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uBm5OEPh1Aqcgoig6E0jgJkrIPoMQY8jlin+feb8E3Vq4sQ8/R9XmgAPfBMjoZgTB
         UyD8jGfS/g4uJJ4GWdDxvWWkZv1VuuTfjDUBRG9VzBYJU47FCF5JQYhQJmJiehFz9T
         Un+pnOFKPhGn2eQE32HGHDCR/tfSYHfuWAS8ugpMCkTAWU78HYR/27qA70BSQELqMf
         5hbDyjzUfMrLIWtBPKiyHp+S1HVLsPfhpY9xjskOgJKlOTNFKfjFDpynoq9pI6s+cZ
         7Ew2c0o5EbTkvpOFo8uoXH3gspSlCrlL1iDoQyji2Na3+4/8B89HjT6//bkNmAEK8X
         F3qUB3UENbJ6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] [v2] wifi: ath9k: avoid using uninitialized array
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230620080855.396851-1-dmantipov@yandex.ru>
References: <20230620080855.396851-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029530431.3210124.107502189781918259.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:28:26 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'ath_tx_count_frames()', 'ba' array may be used uninitialized, so
> add 'memset()' call similar to one used in 'ath_tx_complete_aggr()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

90f2ba4896e2 wifi: ath9k: avoid using uninitialized array
810e41cebb6c wifi: ath9k: fix fortify warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230620080855.396851-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

