Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED95AAA15
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiIBIck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiIBIc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:32:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA2C121B
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F8C9B82A04
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFAC433D7;
        Fri,  2 Sep 2022 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107540;
        bh=JkMkTlMvt3UooPUpVKxTGmzT0g5QAHq839KUMzQ/dkc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aGnGyPMGqGIVgaUKvh0tlm31yudJbyFpyW82P9ATGTGif7WDFIIb1pINYNbUWUFij
         pwGjWy/nrnGzbOIjnRN1HnZ18XUuBMJCl6JSvuYhYYEMg0xA803sbQbpQO7NS8Y7mH
         drSnONiverblrTLZyQoPVVvXnm3kK2AdsIVNOtjGTMIlNP0tG9/kz05Os09GeN3au3
         S8DzTO7gyjQ8HzgWmhvnIrZcbYNNAumRGSiMUINNLOrfp82QPnyiSSkFBB8Sbg2wJK
         MMTFFwqv9mP5kN7A7ZhzBx2kUqPCQuAhV72+kchuU4HhG5M5swks+y15F214Vswiom
         mE2CFI+yW+LXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] rtw89: 8852c: disable dma during mac init
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220704023453.19935-2-pkshih@realtek.com>
References: <20220704023453.19935-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <leo.li@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210753459.24345.6831667916626644562.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:32:18 +0000 (UTC)
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

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Without this patch, our hardware attempts to perform dma while device
> cpu restarts, and leads to iommu page faults caused by invalid requests.
> Some platforms show warning messages as below:
> rtw89_8852ce 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x000a address=0x10000000004 flags=0x0030]
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

0e91d191cf4b rtw89: 8852c: disable dma during mac init
22e2f847c526 rtw89: 8852a: update HW setting on BB
917606d77910 rtw89: declare support HE HTC always
8676031bae1c rtw89: ser: leave lps with mutex
60b2ede9dd38 rtw89: 8852c: modify PCIE prebkf time
ee5469046474 rtw89: 8852c: adjust mactxen delay of mac/phy interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220704023453.19935-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

