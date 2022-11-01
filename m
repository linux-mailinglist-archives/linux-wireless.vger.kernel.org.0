Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800E561483B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKALJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKALJ2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 07:09:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FAE19C35
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 04:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30F3AB81C58
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 11:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E308C433D7;
        Tue,  1 Nov 2022 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667300963;
        bh=CRg23w0o9EwYbGL0iiaaoNzEtRSFnkVV7PX1PjpSmOo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GiqQaB5I2tBz+t5dcjUmJqx62XKwiVpPNEzkcia2I46IWG2zUoc8kbpmCs2FdEZEt
         S+dglmK6gA/KdNfLCzBPYciVS2HvphFtXVSc2ZoAR91eGwwT6fcswk4elvD+iDmR0q
         tjEdm21RSFfWippWkyttntt7BZTyOomZ2/HahKoB2J7oBsSr3mLjelgMQfwjZyp9PA
         6w+6i9lynIZXIt95Y7iGyE7wWWqolELDRxUQFWdF/9G79E99dCdeWNGTUzrISkzMic
         tBBN5FXQc7uOSnzlOuQ0EXNgjqf+xL3MMLJbibsXzXL0tC3pDHw/FqVE2UsjTcehHy
         sHOs5nfedtCOQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166730096092.21401.15624908511546380756.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 11:09:22 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> According to Realtek programmers, "to adjust oscillator to align
> central frequency of connected AP. Then, it can yield better
> performance." From commit fb8517f4fade ("rtw88: 8822c: add CFO
> tracking").
> 
> The RTL8192CU and a version of RTL8723AU apparently don't have the
> ability to adjust the oscillator, so this doesn't apply to them.
> 
> This also doesn't apply to the wifi + bluetooth combo chips (RTL8723AU
> and RTL8723BU) because the CFO tracking should only be done when
> bluetooth is disabled, and determining that looked complicated.
> 
> That leaves only the RTL8192EU and RTL8188FU chips. I tested this with
> the latter.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase on top of latest wireless-next.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtl8xxxu: Fix the CCK RSSI calculation
Patch failed at 0001 wifi: rtl8xxxu: Fix the CCK RSSI calculation

5 patches set to Changes Requested.

13023979 [v3,1/5] wifi: rtl8xxxu: Add central frequency offset tracking
13023981 [v3,2/5] wifi: rtl8xxxu: Fix the CCK RSSI calculation
13023982 [v3,3/5] wifi: rtl8xxxu: Recognise all possible chip cuts
13023983 [v3,4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
13023984 [v3,5/5] wifi: rtl8xxxu: Use dev_info instead of pr_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

