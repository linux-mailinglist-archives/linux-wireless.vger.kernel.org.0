Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265AB5BC5F5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiISKDQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiISKDP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:03:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E122BE4
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:03:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C706960E9C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC8C433C1;
        Mon, 19 Sep 2022 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581794;
        bh=B5DBsYkA9IZWFZVfUGTWSixVbC677dvx8vB8TOb5Gxs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EG7D5bA4fn2fPGTW9l/4goR98hNilj2BmdYt8MNcX+qLlJpWwIsnu72YWizJap5Vh
         mpG/eUTX8F2EIslEFdUjXaXe9PP5q9kS0HRrAChWBlyZOuPFsPt2mWcowh1bnQq71S
         ISROf6v0EdUEa+ZE4pEbNPF5KmyZMYYbOiqP7tZNJRE1S2bMX1nlIAfhhVRijU+Gow
         KEP/of8HLYpV8CF68ECopl65DHNYl2atXitC2ec/mo3bI960j7oSazYIQHSTWeg3fw
         GhHIZ3gMsPwbmKtQN6CZxjU260+XWd+w4HqnQ4B7zrMFWc6ctoNz4J1UDIVsqlk+Ac
         FYMlE7RFx2nFQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: 8852c: L1 DMA reset has offloaded to FW
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220912071706.13619-2-pkshih@realtek.com>
References: <20220912071706.13619-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358179110.24821.8200442716191856684.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:03:13 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> For 8852C, rtw89_pci_lv1rst_stop_dma() and rtw89_pci_lv1rst_start_dma()
> are offloaded to FW L1 reset flow. So, driver no longer needs to do them.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

6ff178792907 wifi: rtw89: 8852c: L1 DMA reset has offloaded to FW
52f127054bf0 wifi: rtw89: correct enable functions of HCI/PCI DMA
5280e4813a3d wifi: rtw89: pci: concentrate control function of TX DMA channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220912071706.13619-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

