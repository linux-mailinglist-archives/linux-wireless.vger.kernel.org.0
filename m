Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313505E5B20
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 08:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIVGLD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 02:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVGLC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 02:11:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5F98D39
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 23:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EDB2B81F05
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12696C433C1;
        Thu, 22 Sep 2022 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663827059;
        bh=JyYD3DxiVttU7n/j1nxss5FYVKefECMoPNBaI4MU7/s=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KVj4+4rMVFbhDBQRt+jIDlr041V4fdY6t3olbEbqeopM6UjVaTEdT5hKh4V9pq0GD
         SjNSpQfpi1Zl+SOlSUxTo0Z6yXJHAi3Ex79ceZPtspLENdnO3/lLLSZoSaJnKT2CVs
         OQ9OdEq68GPy6y5udBX7AyjHCvOVj+Yna0E/TqR7GDWVYFGXxu54ul/+bJA27yhbBq
         0rZyuvfmYAfck8HY05w9XjiHGw7QV65i9e+kcafk+ZgPDhiStPTm7KhHWabkOrHFBm
         K2FOwP1j1ghAgCKh4KrG2EVF6QRXIrnJwo67YrPVVDoYx0C6KtNA+6vEXFk+7LzdGv
         +D6UZ+JiFkUcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] brcmfmac: increase default max WOWL patterns to 16
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220914033102.27893-2-ian.lin@infineon.com>
References: <20220914033102.27893-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382705512.9021.1981848395524953230.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 06:10:56 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> wrote:

> From: Ryohei Kondo <ryohei.kondo@cypress.com>
> 
> 4373 has support of 16 WOWL patterns thus increasing the default value
> 
> Signed-off-by: Ryohei Kondo <ryohei.kondo@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

Failed to apply, please rebase on top of latest wireless-next.

Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c'
Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c'
Recorded preimage for 'drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: brcmfmac: Support 89459 pcie
Using index info to reconstruct a base tree...
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
M	drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
M	drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/include/brcm_hw_ids.h
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
Auto-merging drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
CONFLICT (content): Merge conflict in drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
Patch failed at 0001 brcmfmac: Support 89459 pcie

5 patches set to Changes Requested.

12975535 [1/5] brcmfmac: increase default max WOWL patterns to 16
12975536 [2/5] brcmfmac: Support 89459 pcie
12975537 [3/5] brcmfmac: increase dcmd maximum buffer size
12975539 [4/5] brcmfmac: add 54591 PCIE device
12975538 [5/5] brcmfmac: Remove the call to "dtim_assoc" IOVAR

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220914033102.27893-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

