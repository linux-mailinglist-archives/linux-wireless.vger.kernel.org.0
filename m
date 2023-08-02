Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BADD76CA94
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 12:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjHBKOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjHBKOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 06:14:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2A211B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 03:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE53618FB
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 10:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A800AC433C7;
        Wed,  2 Aug 2023 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690971272;
        bh=bM2hEaWYm+37HjuzLyv/h4gnb3TgGWMG/3HKOXA2F4Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Bz8NfbDCz9n6ZxsrmbXl1AnSLHDyoDJEnvZzy9NI2bAkNDw12xvMx0807fZfUTsKp
         tI30819KeAsozKOZWvzDyK3GnjVCaSBrmEbEfu3TrgkCLCrdmeTpoiwjtVE9Red3HQ
         rfpzb396FOnKEGMcnOEBGhPScJj47kD5fe0B/jqS1OrJN+3AiDHo9kDKzqz9ohkCZN
         O/4xLKS77/v1m0/b1rJGCrI0uuecfDUKFTPksPgHAdVIWlhtdr2RQS40Yn//7A+qSl
         Tk4SML8KfBNH+7JZ5qXn71VnYF6P5Ov3bEKGxHjKIqdtN9JzukwAtTb0K9yusUxfJA
         5yNRyc0U9b77Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: mwifiex: fix error recovery in PCIE buffer descriptor
 management
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230731074334.56463-1-dmantipov@yandex.ru>
References: <20230731074334.56463-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169097126949.265879.7193434194073843607.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 10:14:31 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Add missing 'kfree_skb()' in 'mwifiex_init_rxq_ring()' and never do
> 'kfree(card->rxbd_ring_vbase)' because this area is DMAed and should
> be released with 'dma_free_coherent()'. The latter is performed in
> 'mwifiex_pcie_delete_rxbd_ring()', which is now called to recover
> from possible errors in 'mwifiex_pcie_create_rxbd_ring()'. Likewise
> for 'mwifiex_pcie_init_evt_ring()', 'kfree(card->evtbd_ring_vbase)'
> 'mwifiex_pcie_delete_evtbd_ring()' and 'mwifiex_pcie_create_rxbd_ring()'.
> 
> Fixes: d930faee141b ("mwifiex: add support for Marvell pcie8766 chipset")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

288c63d5cb46 wifi: mwifiex: fix error recovery in PCIE buffer descriptor management

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230731074334.56463-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

