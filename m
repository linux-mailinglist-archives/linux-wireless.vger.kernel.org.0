Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847466C86B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 17:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjAPQiv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 11:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjAPQie (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 11:38:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EC33473
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 08:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F37A96105D
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 16:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787ACC433F1;
        Mon, 16 Jan 2023 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673886443;
        bh=NgjsMRDR9SovDZ76J3ZzS1EJpaGAkwNU3nmDTHTZh0o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kFdubSLFaVxqKKYHERA3/IGKRG3GXq+WCmOpMt45WukqbJ8Jn3ChTYO5CAeRBSZmL
         8PGqd7hayzz6aZGj1I2lOlS6GhcaZFpdGyCP1WMoYOlvhiXXI2+kahVAIAhTD/hR4Q
         ipHx9YYRIkIMitn17VZZGfPv4VOdpuOK/ckIElw4cygRGHZcv57EEP5m6Sg6grBrE+
         dZv7IHYvqQWOZlZvsC69gb6S0xm1H/va7y4Uokr3djI7ltZUvF443x5GagNpyema+F
         /yVIofaxkt/lAFQErQHpHeXTkaaAaaYTDivTXDtMnm9Uya8reYlJFNRCz/FqQafe9+
         kUBOALfesNA2w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] wifi: rtl8xxxu: Report the RSSI to the firmware
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
References: <2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167388644061.5321.14472100729676825919.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 16:27:22 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Or in the case of RTL8188EU, report the RSSI to the rate control code.
> 
> The rate control code for RTL8188EU is less likely to switch to a lower
> rate when the RSSI is high. The firmware-based rate control in the other
> chips probably works the same way.
> 
> This affects all the chips, but it was only tested with RTL8188EU,
> RTL8188FU, and RTL8192EU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

3922dc9fbdb8 wifi: rtl8xxxu: Report the RSSI to the firmware
2a86aa9a1892 wifi: rtl8xxxu: Use a longer retry limit of 48

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/2aab4f3f-e914-4fe1-f29a-deac91774d05@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

