Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1A51651A
	for <lists+linux-wireless@lfdr.de>; Sun,  1 May 2022 18:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348921AbiEAQRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 May 2022 12:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiEAQR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 May 2022 12:17:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4543ED8
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 09:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0C97B80E31
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 16:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889B6C385A9;
        Sun,  1 May 2022 16:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651421639;
        bh=GA8Lp/tn+ZL4nYiSG3RT3H6A4sJmAS2nG7HXFmxueXU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j7WBWDldBiVIgljOMuvA3Sfh1FHHxvIsDM0BZ5Jo6LhQsRU20RxS+doJdZDEL6vLW
         Bxuu5s4zv++vCBTWrKtmA6rnsZecnHJyOhrB0PEjEQJn0Ipk4+GI38vKPc08zLfXpi
         oAdNZ7HDyNdOldte1YIXyFbzVJaJ1o9p9S5L+bIo8LakjshQf1Qp5DEX/5GVZvpNek
         vjVvAuzFdXFiV1RYuEIEISsUi9kDHO6ux2gfPZOm2FwBK4dTy/TmT0RV5tBAVLGo8n
         5O0X023Tx38+H+60k81JSpimJfbixzfKGiGDoIbdkiz2EnUeQ40rZaD8r653acsMQy
         GA9ZLDGOJuAcQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtw88: add HT MPDU density value for each chip
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220428020521.8015-1-pkshih@realtek.com>
References: <20220428020521.8015-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <gary.chang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165142163487.16129.3204776725447781174.kvalo@kernel.org>
Date:   Sun,  1 May 2022 16:13:58 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Each chip have best ampdu density value, the correct setting can improve
> throughput performance.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

1d6d131d5049 rtw88: add HT MPDU density value for each chip
02ee806843bd rtw88: fix not disabling beacon filter after disconnection
5b3fd8fd7ceb rtw88: fix hw scan may cause disconnect issue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220428020521.8015-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

