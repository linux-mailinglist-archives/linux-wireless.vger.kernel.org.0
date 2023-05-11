Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251686FF29B
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbjEKNWk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjEKNWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3172E72E
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 06:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF88D61652
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 13:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F34CC433D2;
        Thu, 11 May 2023 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683811204;
        bh=+PXguMHyEjAIA8CTgKdTp7rt9JR3pTKHwsxE2CBaOKY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZX5189eognoruEEzurlU0KvL1YuOFlkPSMQXHnjuPUfmaq2nnkKFvUWKmNLL+6NY9
         YTOYx2pPLAKqMke156JFY3rfYGTghmtlxKMnD56eSTybg9+ioWXXew/a8VtJ36Rz2P
         i30YOEZLArzU3JSHE+QhR+Egu+sb32abj6RFq1mMQyi2nXCNVCgKE9I2lTxH52Po6i
         X+Besy4TrUERxRRoCa9jUXDTtJAIA3gaQ2e3iRW0STgeWRc8T+Up0/bPl4e14BMZes
         gauAPb5r6c92agvXtkSp9vyekIaLliMstwbvhkxHolwBa+aTWa6/x1yX68uvSlz+5s
         W+o/gBCnJU3BA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: pci: fix interrupt enable mask for HALT
 C2H
 of RTL8851B
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230508084335.42953-2-pkshih@realtek.com>
References: <20230508084335.42953-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168381120166.27145.17125146250902121389.kvalo@kernel.org>
Date:   Thu, 11 May 2023 13:20:03 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> RTL8851B keeps almost the same interrupt flow as RTL8852A and RTL8852B.
> But, it uses a different bitmask for interrupt indicator of FW HALT C2H.
> So, we make a chip judgement in pci when configuring interrupt mask.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

aa70fa4f7dd8 wifi: rtw89: pci: fix interrupt enable mask for HALT C2H of RTL8851B
56617fd02adb wifi: rtw89: ser: L1 add pre-M0 and post-M0 states
8130e94e888b wifi: rtw89: suppress the log for specific SER called CMDPSR_FRZTO

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230508084335.42953-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

