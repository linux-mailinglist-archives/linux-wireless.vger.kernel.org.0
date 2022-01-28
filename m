Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1649FD2D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 16:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiA1PzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 10:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiA1PzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 10:55:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A359C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 07:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A833B80D30
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 15:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422D8C340E0;
        Fri, 28 Jan 2022 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385315;
        bh=otQjcyi3RDhTait56NDK5grzYEqPeRoJRP464R2NrLY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DFt4au/ZOQlo8AFrr5cB/fze7Ik7b9OlbyQIwB9kUPa31jA22Yzg+7mUMeHI62pww
         joc5sQoLHGLdkijt1tLaMgjuWbyjGCUnffv/J71LcDqIyoBsg+6IUWgOGKTVyj4Xht
         XzjYjijfQBygn149RCOhHFvwOoW2pCoi+kWB3hU31kuPnKyHyHokUwrR6HceJuyjlf
         oyyjoMgeZcgJwM6ZkztEXdpBco0NfjxSwuxYYe4wZUAaF1StSz306vU4AeokArC8Xd
         K7kwHElHnj+ljmf8CSdTyNey8P25gSof/f5gc2QD/VRKe80/qpnmLjGnvJmxjRl9DR
         aVW/gOiqSCNjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: extract modules by chipset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211221025828.25092-1-pkshih@realtek.com>
References: <20211221025828.25092-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164338531025.19531.12488012409376026093.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 15:55:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We are planning to support more chipsets, e.g. 8852C. Before that, we
> consider architecutre to handle multiple kinds of chipsets. Obviosuly,
> based on original design, rtw89_core module will have large size even
> if there is only one chipset under running. It is because all chipset
> related things are put in rtw89_core now. To reduce such overhead, we
> extract modules of rtw89 and adjust dependencies between modules.
> 
> The following assumes that 8852AE, 8852AU, and 8852CE are all supported,
> we describe the difference before and after extraction.
> 
> [Before extraction]
>                                              -------------
>        |------------------------------------ | rtw89_usb |
>        V                                     -------------
> ---------------------------------------      -------------
> | rtw89_core (including 8852A, 8852C) | <--- | rtw89_pci |
> ---------------------------------------      -------------
> The data of 8852A and 8852C are built in rtw89_core.
> And rtw89_pci is the entry of 8852AE and 8852CE.
> And rtw89_usb is the entry of 8852AU.
> 
> [After extraction]
>                     -------------           ----------------
>        |----------- | rtw89_usb | <-------- | rtw89_8852au |
>        |            -------------           ----------------
>        V            ---------------                |
> --------------      |             | <---------------
> | rtw89_core | <--- | rtw89_8852a |
> --------------      |             | <---------------
>    ^   ^            ---------------                |
>    |   |            -------------           ----------------
>    |   |            |           | <-------- | rtw89_8852ae |
>    |   |----------- | rtw89_pci |           ----------------
>    |                |           | <-----------------
>    |                -------------                  |
>    |                ---------------         ----------------
>    |--------------- | rtw89_8852c | <------ | rtw89_8852ce |
>                     ---------------         ----------------
> The data of 8852A/8852C is extracted to rtw89_8852a/rtw89_8852c.
> And rtw89_pci/rtw89_usb handles only common flow of pci/usb bus.
> Finally, 8852AE, 8852AU, and 8852CE have individual entry modules,
> i.e. rtw89_8852ae, rtw89_8852au, and rtw89_8852ce correspondingly.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

861e58c8fc6b rtw89: extract modules by chipset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211221025828.25092-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

