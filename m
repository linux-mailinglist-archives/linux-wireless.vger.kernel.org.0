Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3277E5CEC
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjKHSK7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHSK6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:10:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D11FEE
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:10:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A780EC433C7;
        Wed,  8 Nov 2023 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467056;
        bh=0tQ4isPBw1F+eysYAGhZfmmWgKHgLU7wVsDFcxe/8As=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=eYU+lonnMbR4RdKWSJYI/eYfYxXXWghuGAZyx66AV8O/yil9+JbCUB0ACRH1+rMY5
         PrvJGyetoZF10LCFfXIYYqRr79TMBF0IdnXxlNafYB3sZXnrGeQqeDYbFLrWX9MQ85
         hOrY8pm9dTXBOEmqARwDGrVUW1OZ0mNP7KKYRLMI4a8yCpSnlGZUmGsaRcanNNsfL5
         RGPCd/f0qLzuBHActlVEpwYkWoWgHXYTsTUB+kFVgdszGJsqyAyjDmLvrQBrzFgsUd
         3nodfSaLO/xBN36LCLmzk4dOk9ixXt+i+vzIEmFmNMMSlUD2w6HeOmwIpjBVuauIv5
         68G20BOuo5Wzg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: pci: add PCI generation information to
 pci_info for each chip
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231101072149.21997-2-pkshih@realtek.com>
References: <20231101072149.21997-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946705347.2821494.11093924787860890785.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:10:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> In order to reuse PCI initial and configuration flows, add struct
> rtw89_pci_gen_def to abstract the differences between WiFi 6/7 generations.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

07fabde630a6 wifi: rtw89: pci: add PCI generation information to pci_info for each chip
bfdcfee3659c wifi: rtw89: pci: use gen_def pointer to configure mac_{pre,post}_init and clear PCI ring index
2daafe9a0cb6 wifi: rtw89: pci: implement PCI mac_pre_init for WiFi 7 chips
e24ae0f07625 wifi: rtw89: pci: add LTR v2 for WiFi 7 chip
5cb0d6b878c3 wifi: rtw89: pci: implement PCI mac_post_init for WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231101072149.21997-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

