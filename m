Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E796C0A46
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 06:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCTFzA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 01:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCTFy5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 01:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430DD12592
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 22:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A48A561212
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D8DC4339B;
        Mon, 20 Mar 2023 05:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679291695;
        bh=aEXbUrtp24zK/4Zidsa9hu135Qo1z1/vxhtCxbTCKAo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZI475uMHociPI6XN76gwRDj3esvnT7nN0BXY0Jkth7o6FZoRs9RrYdJ3tstsAPG0I
         0cSsAcRK6KCpakdNLeFKEGKl1XsnM8mKudXc0IrnKNltci8BL3DBe7q6cPDU8B50+1
         zF5j3Fz+D4+jAr+30M3SavzZomJsumo15A3J+D9rj+JGs+wvSvA0fh/B6gcVMXjw9B
         1fTH6sofjEjEzNkbyaaLlt0MWsUAnNhscc0fQpF5zXe2vxU1FGReEk8ZR6WpGIRvCT
         lmso0R5uG4ZvuUz3DGOBhSbVP40xt1VzHlkDT3DGshLebzCa+t0jmLnJZb54+zI7KY
         Jq6j7q/lMIX4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: rtl8xxxu: Support new chip RTL8710BU aka
 RTL8188GU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
References: <4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Jiajie Chen <c@jia.je>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167929169189.28804.16177211192382455088.kvalo@kernel.org>
Date:   Mon, 20 Mar 2023 05:54:53 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This chip is found in cheap "free driver" USB adapters from Aliexpress.
> Initially they pretend to be a CD-ROM containing the driver for Windows.
> "Ejecting" switches the device to wifi mode.
> 
> Features: 2.4 GHz, b/g/n mode, 1T1R, 150 Mbps.
> 
> This chip is more unique than other Realtek chips:
> 
> * The registers at addresses 0x0-0xff, which all the other chips use,
>   can't be used here. New registers at 0x8000-0x80ff must be used
>   instead. And it's not a simple matter of adding 0x8000: 0x2
>   (REG_SYS_FUNC) became 0x8004, 0x80 (REG_MCU_FW_DL) became 0x8090,
>   etc.
> 
> * Also there are a few new registers which must be accessed indirectly
>   because their addresses don't fit in 16 bits. No other chips seem to
>   have these.
> 
> * The vendor driver compiles to 8188gu.ko, but the code calls the chip
>   RTL8710B(U) pretty much everywhere, including messages visible to the
>   user.
> 
> Another difference compared to the other chips supported by rtl8xxxu is
> that it has a new PHY status struct, or three of them actually, from
> which we extract the RSSI, among other things. This is not unique,
> though, just new. The chips supported by rtw88 also use it.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

Patch applied to wireless-next.git, thanks.

70664495e3d2 wifi: rtl8xxxu: Support new chip RTL8710BU aka RTL8188GU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4edbe29f-00b9-8eef-9789-20bed0b141e2@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

