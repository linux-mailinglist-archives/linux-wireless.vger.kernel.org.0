Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC5949FB52
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbiA1OHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 09:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbiA1OHQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 09:07:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A3C061714
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 06:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70E4DB825AC
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 14:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CC8C340E0;
        Fri, 28 Jan 2022 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378833;
        bh=iTx44YywEliBZo6Poi8GGJmYALujgboJLbX5CQsNvq8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fF6G5Sg1jtLIvAsXBxCUcfPgVAGVzXPmvaOUgylPFX3KXqCbjnctQ3RMp4MxpVt/H
         wALln2c9kVn8B1PDayQN1/XJ8ifOIx7IzEUP3IBxFt6OkquXhY7mrWlNxydOH3t5ps
         s1U8AdWbHARLeWQDNWpRGjVvXRilV0+BElGjWxQEKLw2G4zGdOyxrbE9CU+eJaP4Bt
         U0M4VMXAp+mQ4xIgnSscqThFEtRvpZacdwRGLads56LKFxscvHJloI7RB7U73DlYUX
         mju6USZGzU443yRlX8cIRJtzT3tlkELIEJe6vW0xDRJbRxa5NJ1DTCxGZROfvxecLA
         Kw5vfD0Xb07lw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220118154514.3245524-1-phil@raspberrypi.com>
References: <20220118154514.3245524-1-phil@raspberrypi.com>
To:     Phil Elwell <phil@raspberrypi.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164337882901.4682.2390001655219643717.kvalo@kernel.org>
Date:   Fri, 28 Jan 2022 14:07:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Phil Elwell <phil@raspberrypi.com> wrote:

> The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
> by a check to the validity of the fwctx->req->board_type pointer. This
> results in a crash in strlcat when, for example, the WLAN chip is found
> in a USB dongle.
> 
> Prevent the crash by adding the necessary check.
> 
> See: https://github.com/raspberrypi/linux/issues/4833
> 
> Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>

Patch applied to wireless.git, thanks.

665408f4c3a5 brcmfmac: firmware: Fix crash in brcm_alt_fw_path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220118154514.3245524-1-phil@raspberrypi.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

