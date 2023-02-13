Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE3694DDE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBMRY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBMRYz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:24:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2C18B06
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37734CE1C3D
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEDEC433D2;
        Mon, 13 Feb 2023 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676309089;
        bh=S9P4Gtgp6W5UoFpF6vaIy2LgBrPxmW5HsfU12W6COdk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X3XiF22W09Cl7XgpkoVCkegFiATs6wrQywJGdEtH+ntk00zjlMzcgD3hJX4dUXYaM
         A2lO2YDN+bqFhG8c4vs67QX3X2fAQ0Cl3s5Bkt8xKaRzVnyFTTIrhO6Cwx2Edx8KBO
         m80o9TZEB7hqk3g23uTFy2oOK5X9cumRY1FgLMVYhrfm2+4wkXs2HUolLUOY8B6+lC
         AfCCgQGYXjBbPIphGh1SC9PlETpeHk9hgyDvin1Syc3oiYOUV/fey+UBomcRnQ7Fgx
         LfJl875wNz8i2r3Ks/RFXN/8zKYSofjx5PmwCZXf4/3yQTRVvuPDcKIssoMtKa8cuS
         1AVYIMUWl8gSQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: rtl8xxxu: Register the LED and make it blink
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
References: <b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630908718.12830.5018978756931312787.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:24:48 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> If the chip can have an LED, register a struct led_classdev and enable
> hardware-controlled blinking. When the chip is not transmitting or
> receiving anything the LED is off. Otherwise the LED will blink
> faster or slower according to the throughput.
> 
> The LED can be controlled from userspace by writing 0, 1, or 2 to
> /sys/class/leds/rtl8xxxu-usbX-Y/brightness:
> 0 - solid off.
> 1 - solid on.
> 2 - hardware-controlled blinking.
> 
> In this patch none of the chips advertise having an LED. That will be
> added in the next patches.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

3be01622995b wifi: rtl8xxxu: Register the LED and make it blink
873b3811728b wifi: rtl8xxxu: Add LED control code for RTL8188EU
ae0a6df673c2 wifi: rtl8xxxu: Add LED control code for RTL8192EU
2cef0aeebf2c wifi: rtl8xxxu: Add LED control code for RTL8723AU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b8235bca-60c3-d0fe-a958-53c6dd3ba3f6@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

