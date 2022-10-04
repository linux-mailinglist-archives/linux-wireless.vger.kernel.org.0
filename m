Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCB5F3D9B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJDIDI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJDIDE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:03:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647902E9EF
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:03:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014FF61299
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A935AC433D6;
        Tue,  4 Oct 2022 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664870582;
        bh=o/gBkNFPDo3ejS5QDvhywkiUY+V5lKC+k9ZgEx3sC4k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XFcBZE39pPBz+f4Y0Szt2ZfdN0chJEjrUUOLBMqXQkIgUAa9OtEJIamjvfCLJ4W/L
         SNA7Ts+VMR2XPTTmI7KdVt2OdJBQkl01g/vSrrry14tEJu9sFNZamkJk9joB7uMDuw
         qDOJ7MwGuPre2suLJaytNHCQ+fEFnKQu8VIBxwtZtnOiugUWtKZ4AQsucaf/hV71s0
         gOGtN77j5EaKL8D2BEymdim+2ZdIzxm7x8/JxW7+15fuD0olDC16BN/7NSTbjdyZcT
         vw2F41C1J7MwxVrjnNAfiiWcNEIjCyMQYB3mFXhr4/6HZOALUbez75OiJ/S3cZK57Q
         5WgVNCpkMsh/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wifi: rtw89: 8852b: add BB and RF tables (1 of 2)
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220928084336.34981-2-pkshih@realtek.com>
References: <20220928084336.34981-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487057950.9318.10838959869577046193.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:03:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> These tables contain BB and RF parameters that driver will load them into
> registers. It also contains TX power according to country, band, rate and
> so on. Increasing thermal can cause TX power degraded, so power tracking
> tables are defined to compensate TX power.
> 
> Internal version of these tables:
>  - HALRF_029_00_014 (R32)
>  - HALBB_027_046_05
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

c8b5fc2e1d2f wifi: rtw89: 8852b: add BB and RF tables (1 of 2)
3e65a0ae142a wifi: rtw89: 8852b: add BB and RF tables (2 of 2)
2b379eb443e2 wifi: rtw89: 8852b: add tables for RFK
9b43bd1ac0a8 wifi: rtw89: phy: make generic txpwr setting functions
b90216164587 wifi: rtw89: debug: txpwr_table considers sign
08484e1f6e6f wifi: rtw89: 8852b: add chip_ops::set_txpwr
132dc4fe5b58 wifi: rtw89: 8852b: add chip_ops to read efuse
134cf7c01517 wifi: rtw89: 8852b: add chip_ops to read phy cap
9695dc2e4be9 wifi: rtw89: 8852be: add 8852BE PCI entry

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220928084336.34981-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

