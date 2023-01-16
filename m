Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9447166C891
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 17:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjAPQkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 11:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAPQj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 11:39:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBFE2C675
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 08:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B8A861084
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115AC433F0;
        Mon, 16 Jan 2023 16:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886505;
        bh=RrBtLL8N3Te7ic8/ZOZkti2PtBP+Owql7UVNdV9ohls=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=m+xrOBJHUkP7P0oKu6w3qLjeDYvV+H56k0km0x44w59fFze1i1bD1l/6dh+ak1vAs
         fbZ9ZoMkhEde54NsMjP8MaGBV9Hy+x6RK8fXqCNfVSR2xTJ0xichNIKxF1ypogV7Hf
         vrFTuAaiyL1/kt+RE7qsRYe7hUdTcgPASvyzeHjxb6q07LMqiORrOXVzN7QLMxrqks
         vHpcPr3Pc1KlN/oqSprM6VdHf8x2UApaxcZdJI/xRv+MfvtT2yp6bSEdEXWpNLocll
         Xd+scW/M958spvlcmtfwvRshhlwIqZxMAQqGCVTSQ7gD2A4gm15bLCY7ibs53D0f8y
         /Xv1ONghklW9A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Print the ROM version too
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
References: <add46396-95af-1164-2033-7d4eb4d0b554@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388650283.5321.307434345917435757.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 16:28:24 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Make rtl8xxxu_print_chipinfo() print the ROM version. This is relevant
> at least for the RTL8723AU and possibly relevant for the RTL8710BU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

aa1a49268951 wifi: rtl8xxxu: Print the ROM version too
de7d0ff301fc wifi: rtl8xxxu: Dump the efuse only for untested devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/add46396-95af-1164-2033-7d4eb4d0b554@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

