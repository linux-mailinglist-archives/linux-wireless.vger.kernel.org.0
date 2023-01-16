Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B34266BFE1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 14:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjAPNfP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjAPNfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 08:35:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685641EFFA
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 05:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE8E660FB6
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 13:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3E4C433EF;
        Mon, 16 Jan 2023 13:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673876107;
        bh=BIuuPMoedYIsoYZW9vWEyKt3xJdp8SlyDGcZ+sHsQxE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Vm90PMm4eSaiMzU2FRNvVIm9E2AD7rVmZbEgC1zgwTJDENgjY+kwea84PmvwzixJo
         LTVxLzOT3HPZnjBwL4lk4i8EIx9inKqIPsyll88eUfsGd+sRaFGhwFXgNr/MeW+73O
         FFrIEMldnwKkQz6MGQ0/WviidysF8JCMHDHHu7gHxmx+kETT8aeoA0R1g4PIYD6Hvg
         bSPbuuK1dZ0apeYw5+OZaJB5Pp90Hv2Dp4FrsNw8WhjMAl0cQS6r8RdKpxbPfjDQJM
         TCtSbpwgZiWoNyLYf+/4yB7tUGdY65oTI8YNG55WkkmGDp5NccNtrZO2fl/vYipeKX
         HkqHsHr9wmfAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: coex: Remove le32 to CPU translator at
 firmware cycle report
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230103140238.15601-2-pkshih@realtek.com>
References: <20230103140238.15601-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167387610474.32134.14955766480774316300.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 13:35:06 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> There are at least 2 version of cycle report format. If the code keep
> translating the report to local variable, the numbers of variable in
> check btc report function will out of maximum variable numbers. And
> most of these variable are using only one time, it is not necessary
> to store at memory.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

f643d08642b8 wifi: rtw89: coex: Remove le32 to CPU translator at firmware cycle report
fab895b31982 wifi: rtw89: coex: Rename BTC firmware cycle report by feature version
202c3b5c276f wifi: rtw89: coex: Add v4 version firmware cycle report
b02e3f5c344d wifi: rtw89: coex: Change firmware control report to version separate
0c06fd47335a wifi: rtw89: coex: Add v5 firmware control report
891b6a3f9407 wifi: rtw89: coex: only read Bluetooth counter of report version 1 for RTL8852A
3f625adc61a0 wifi: rtw89: coex: Update WiFi role info H2C report

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230103140238.15601-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

