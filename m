Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0180269F48C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjBVM3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 07:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjBVM3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 07:29:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A62B633
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 04:29:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FF76137F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AB7C4339B;
        Wed, 22 Feb 2023 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677068973;
        bh=nR5bDnKFdVZSZ4J1IbNRHscEnVPV8AiHET1I3jEmGPc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Pm28zewc/glFV+ZpxMKvixkZoydoyGZVC2cMPSIVEncu6U4hr7kCL9pEwlZrsMsvZ
         afSSfHjU4saEf1Cw7P8dzTY9mDebe9PYa4Wy9pYW2dKSCq/JT3/NYsJ7EA6Vj3DWH8
         w6O2EsRkaFsNplpe+nr9k0OReGEU4h4Ozx6X5HJquqSTcqbKdngcwdolFX6N4NGGR6
         pOHvY+v0YqP7E4m4R4baXom+2OXJAehk1qXm5J9gKWdO80XyDzaAobFHVYXQTgGlNR
         83ydCnAibOBAtqJ2ILdzY3IrIbWOdKO6wyqdxKj5vmX21bXGDAWjuAoGc8/J9PcYVO
         rLCiAz4/z3MDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: 8188e: parse single one element of RA
 report
 for station mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230216004654.4642-1-pkshih@realtek.com>
References: <20230216004654.4642-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Jes.Sorensen@gmail.com>, <rtl8821cerfe2@gmail.com>,
        <error27@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167706896785.20055.7787168018772184989.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 12:29:32 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Intentionally parsing single one element of RA report by breaking loop
> causes a smatch warning:
>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c:1678 rtl8188e_handle_ra_tx_report2() warn:
>   ignoring unreachable code.
> 
> With existing comments, it intends to process single one element for
> station mode, but it will parse more elements in AP mode if it's
> implemented. Implement program logic according to existing comment to avoid
> smatch warning, and also be usable for both AP and stations modes.
> 
> Compile test only.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302142135.LCqUTVGY-lkp@intel.com/
> Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

398eb19415eb wifi: rtl8xxxu: 8188e: parse single one element of RA report for station mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230216004654.4642-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

