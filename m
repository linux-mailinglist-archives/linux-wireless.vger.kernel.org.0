Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5C583B90
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiG1J4F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiG1J4E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539336390C;
        Thu, 28 Jul 2022 02:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E417160CD4;
        Thu, 28 Jul 2022 09:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0E3C43470;
        Thu, 28 Jul 2022 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659002162;
        bh=nwp57PiOXE/bBj5SQgoSWUC9ZuA/a8ca1u9c4yEW2zU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fpfnMaVr51ZVOR3XcN61gHVNcfEMHAd4JMy3bayfzLd3MroiuyTXWU6iWZay4+TnN
         /fs48i/OonxxamgVsllBJgHH0e01YJ+1Ld2HxSf3BmXfqeS2W5yjcsWFzqxKyMNZ5g
         K1TNReUIPCtQU4+uykDDasO2DAVBul57/cl9rvm8TIR8s8nNizLFSYbMl6ZJAoRD2/
         jY1FEF0mT61VGarZWvHL5tOJ/ABemlP8tMOCEnCm4YuxjvfekXWJ0NkMnbKX4Besnt
         C7rhpDoLfFhlhph8gjubqwUG+g+bkYq1ZQOI+R4nPnL9NRyq5ltsjFX742ADC58kNa
         HYeJ9B/b40Ajg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmfmac: use strreplace() in brcmf_of_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <YqrhsKcjEA7B2pC4@kili>
References: <YqrhsKcjEA7B2pC4@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Len Baker <len.baker@gmx.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165900215794.25113.6597202255013388708.kvalo@kernel.org>
Date:   Thu, 28 Jul 2022 09:55:59 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The for loop in brcmf_of_probe() would ideally end with something like
> "i <= strlen(board_type)" instead of "i < board_type[i]".  But
> fortunately, the two are equivalent.
> 
> Anyway, it's simpler to use strreplace() instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

bef11f1edc40 wifi: brcmfmac: use strreplace() in brcmf_of_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YqrhsKcjEA7B2pC4@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

