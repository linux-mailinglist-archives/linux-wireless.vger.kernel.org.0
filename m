Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7710B647217
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 15:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLHOod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 09:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLHOob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 09:44:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D427CC7
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 06:44:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F101961F1E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10093C433D6;
        Thu,  8 Dec 2022 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510670;
        bh=wz4OMOZ53TUtQKOMMm5WyNMjV1pCyGf0ofz8kSlcHPE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=e1pjCgVt2sWTgQ9uRr7ko+XUBinsmTezQpQ58Vf7xFCGxiM2Wnwtzir6Li+hJPdtH
         0LerGsuO7yI0SRp3hx5inT8qOxb8rJSTwlunfvrloeENz5r0e/vVVZP3GU9JIW6Ggb
         rCDU9ftvZxoHDX+jvZXtqDjxiwvDV+DbGKBSbhTz37fQDYvb7kSv6Z5cGvxieagy6n
         HJvxQ3tVwSdsfDGwt99K/YviKuqrR2V/iszanWduVOZ977qYrgEUdMOtDgLjI8qgsf
         jwHQkpP1h46Rm9LGPjF4dFIaGpRClClXmLvvNnmTFlFM9lG4v5FycFLQA1XgGr5ksr
         o6bydwtxchHug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [V2,1/7] wifi: brcmfmac: add function to unbind device to bus
 layer api
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221129135446.151065-2-arend.vanspriel@broadcom.com>
References: <20221129135446.151065-2-arend.vanspriel@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167051066686.9839.5967944624283229773.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 14:44:28 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> Introduce a new bus callback .remove() which will unbind the device
> from the driver. This allows the common driver layer to stop handling
> a device.
> 
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

7 patches applied to wireless-next.git, thanks.

76821aad49ce wifi: brcmfmac: add function to unbind device to bus layer api
da6d9c8ecd00 wifi: brcmfmac: add firmware vendor info in driver info
d6a5c562214f wifi: brcmfmac: add support for vendor-specific firmware api
f74f1ec22dc2 wifi: brcmfmac: add support for Cypress firmware api
b1d94be570c2 wifi: brcmfmac: add support Broadcom BCA firmware api
7205f9f2fc55 wifi: brcmfmac: add vendor name in revinfo debugfs file
8041f2bffbf1 wifi: brcmfmac: introduce BRCMFMAC exported symbols namespace

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221129135446.151065-2-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

