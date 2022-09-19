Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6485BC5FD
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiISKFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiISKFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897846377
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1374860E9C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B286DC433C1;
        Mon, 19 Sep 2022 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581907;
        bh=XW2+rNHLJKOVwRf6XYOYhkp0IcjxtjbuPyao5JENrbw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kYI2M6tozgNB1vlS6cnG3E86AGqMbHT4doOoGPGHqwpmxBMpmrebj27m7PNcJ/0UP
         y7QA9Ypee5oYcts6MDuc7AvRIFxcoRkgMG08H4GZ2K4V6MzaortLc2ZE9xzYjcIF5R
         E8jpIlvaDZnj9bhI2XV1Kws8OFaIEzWTmhX8WIkWvFMz2JD4cAyIaS70LKgK0BihUi
         9VQRS7cvhpiroQYUS2TkSEjwmgrlKiXwlwFBawjXQc8NsotLoWlkf1RGW2nQw0bKvv
         Hun/NwLBKyOUAFf2Y9ZiaKQ58tx/yGyyZqO8ZI1oagaVRM72dB/U/xYY3OfHImj4WB
         RN6kgH3CcOcAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: initialize DMA of CMAC
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220916033811.13862-2-pkshih@realtek.com>
References: <20220916033811.13862-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358190495.24821.12146938591350200016.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:05:06 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852C needs this to change CMAC dma to full mode to keep receiving
> packets after RX full event being resolved.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

a0d99ebb3ecd wifi: rtw89: initialize DMA of CMAC
c060dc51cc15 wifi: rtw89: mac: set NAV upper to 25ms
1b32e34536d5 wifi: rtw89: pci: update LTR settings
a63ae6736d92 wifi: rtw89: reset halt registers before turn on wifi CPU
eae672f38604 wifi: rtw89: free unused skb to prevent memory leak
812825c2b204 wifi: rtw89: fix rx filter after scan
43aeb945eb03 wifi: rtw89: 8852c: add multi-port ID to TX descriptor

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220916033811.13862-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

