Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C907F4B86
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 16:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbjKVPtR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 10:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjKVPtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 10:49:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96592
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 07:48:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EB4C433C7;
        Wed, 22 Nov 2023 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668100;
        bh=B32IrzlvQQsEDYIdZY7gHsw4sjzADopajnY2cdHVeqQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SOFh/qHsavwjOnaw0EM5+98RMCxNwOVWyckMK/UlBw2YoALOpKnQ5LtKCqmQDsSDm
         HNIFrs3HgMz66ghcgN/hextlyXr7zw9VhFK0+FXXv6HV1QT5s37JYZO6zdr3sBU6FE
         NOUt6f/PYOuwpBO52zvu0QmOKUyeAaRrm23+Th+4PXAc7JvYo1B2hYwGaIzRZZoe0Q
         8z2N+xuTDoZid1R/kBohuqJi124RJQwuHwb+IGmUPSWEEisgD4gCZyxF5s7TsPzqtS
         qfaEqJGTiAXo4ysHEyL4f/Ps+QXaau/i7auShEvMOiu5eaauecIS7p818E4TETvrLq
         Mb4myZhgwKDig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: acpi: process 6 GHz band policy from DSM
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231114091359.50664-2-pkshih@realtek.com>
References: <20231114091359.50664-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066809796.4178710.8565816952013722617.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:48:19 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Realtek ACPI DSM func 4, RTW89_ACPI_DSM_FUNC_6G_BP,
> accepts a configuration via ACPI buffer as below.
> 
> | index | description   |
> -------------------------
> | [0-2] | signature     |
> | [3]   | reserved      |
> | [4]   | policy mode   |
> | [5]   | country count |
> | [6-]  | country list  |
> 
> Through this function, BIOS can indicate to allow/block
> 6 GHz on some specific countries. Still, driver should
> follow regd first before taking this configuration into
> account.
> 
> Besides, add a bit in debug mask for ACPI.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

665ecff7dd14 wifi: rtw89: acpi: process 6 GHz band policy from DSM
b2774a916ab9 wifi: rtw89: regd: handle policy of 6 GHz according to BIOS
c212abfbd19f wifi: rtw89: regd: update regulatory map to R65-R44

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231114091359.50664-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

