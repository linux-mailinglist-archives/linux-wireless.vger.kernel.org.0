Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFDB61950F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 12:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiKDLCZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 07:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiKDLBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 07:01:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713C72CDD2
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 04:01:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E59E6213C
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 11:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1151C433B5;
        Fri,  4 Nov 2022 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667559712;
        bh=Go9ZPS1D7b5vhLir1KiMzmsxIwAedkfzRsChBg5iZNA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZgVNuzMQLuGBnqcpBD5xqPYA9VZKD2c287btfU+Ka0IZY4lq/N9nvpbu/37ARrUMt
         P4VfLlmsrPMl7gFsXWQLinyE/nL5XlMtBacd0RJWOaFnp56t/4jUunGU6a5VEit7xh
         ZBAQUr7rKRs3PwbuJxqF/FNh5QngtQmHasb/aej2WbGwTyMikDiCGzYc4xbwaLABDY
         Rrlow2x7Wxi9vt6Tc7HBIWws7HpT2WYYBCKH2ICmkJfpLhWWd2qRDqgbfZo5N7cPgl
         61Ix3k2ZkLskeb/eSZwwl8m2GsxLFh7XgMyLimORjorFyKbhEfKPMOB9CEhb0Mnt5L
         0y8CcVzLjedEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/5] wifi: rtl8xxxu: Add central frequency offset
 tracking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
References: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166755970986.3283.8272687655557599604.kvalo@kernel.org>
Date:   Fri,  4 Nov 2022 11:01:51 +0000 (UTC)
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

5 patches applied to wireless-next.git, thanks.

57b328bc7996 wifi: rtl8xxxu: Add central frequency offset tracking
2ad2a813b803 wifi: rtl8xxxu: Fix the CCK RSSI calculation
7b0ac469e331 wifi: rtl8xxxu: Recognise all possible chip cuts
e952deaa95ba wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
bd954a7e4aa0 wifi: rtl8xxxu: Use dev_* instead of pr_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

