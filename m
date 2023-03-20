Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921C66C0A42
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 06:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCTFy0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 01:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCTFyY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 01:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C521ADDD
        for <linux-wireless@vger.kernel.org>; Sun, 19 Mar 2023 22:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8065461212
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 05:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF70BC433D2;
        Mon, 20 Mar 2023 05:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679291661;
        bh=xOQdLP9/pB3ExDzPZPmbiomJdM2sezX2mffmVb69n3I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KImZFpBZp0jAgEFlZdHRfzeaPJDXByuUTsxPVhVwv0Vjd+UzYN7Urfy0R6+cJXtNR
         PElYDnasu/F4FhxOV/g+hXf0ImGjunrjpaWx0z4ItRcA6K3al7t8c7+sG5LFHfdowM
         wLx0p85LPAK2mFSjamX3W3Ev/6foQC5RILsoVEKZfkOD/tKZykLC5+v7H48WRZGepV
         iUsdVFkTUjVGyGDgp1egyc4ufGAQjPtD3qNGUQm0BgZZyE8z1Qi0734R69ci/+X+7b
         Q0zgSmHh2wQUp/EyrJBQWiTDsii3RfD2PGQNQNyZPQP5JAnpxY6OVMnRG6LBzf/fHQ
         3KcDeau07mF9Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: RTL8192EU always needs full init
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com>
References: <4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167929165640.28804.12432448813334695079.kvalo@kernel.org>
Date:   Mon, 20 Mar 2023 05:54:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Always run the entire init sequence (rtl8xxxu_init_device()) for
> RTL8192EU. It's what the vendor driver does too.
> 
> This fixes a bug where the device is unable to connect after
> rebooting:
> 
> wlp3s0f3u2: send auth to ... (try 1/3)
> wlp3s0f3u2: send auth to ... (try 2/3)
> wlp3s0f3u2: send auth to ... (try 3/3)
> wlp3s0f3u2: authentication with ... timed out
> 
> Rebooting leaves the device powered on (partially? at least the
> firmware is still running), but not really in a working state.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Jes Sorensen <jes@trained-monkey.org>

Patch applied to wireless-next.git, thanks.

d46e04ccd404 wifi: rtl8xxxu: RTL8192EU always needs full init

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4eb111a9-d4c4-37d0-b376-4e202de7153c@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

