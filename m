Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDAC583B46
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiG1Jdk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiG1Jdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672CD61D97
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C1D60CA4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96037C433D6;
        Thu, 28 Jul 2022 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000817;
        bh=a6hcMWwzqQGy+v7SIblZVXv11DEwTLHOubU9AWfz+LQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=sRRkV0XW2pxP4i7pzkRhrpueHOLRRxNX/8tLSSM6ZEKPlMXjweFC8VKzzOtQweZIU
         iW6S9IGDdx7UjJWO3e+B/lhIo8lV86ADIT7dZ8wXwQzaMQ9mLmfj1rN2UnCas153Ck
         s8DiVjf3nkjxtR1GNrOz//mxbSPa0WFQ2QVsA/vcjGscpo5g64a76DGWNrct6ZxARD
         Re/5gsco3PzokJhA1nO4JsYN+8mcS+KXc1klVeuFcU19gj3N+Cgi4f16E1VnK84nlT
         IWHk02azaQGsv5VWtPpare8k44n5IRSJahzk03cDtXncIV/ljGp5Im9MX3Rd06u+Y5
         Je3fOYW5oTpcA==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/7] brcmfmac: support devices from multiple vendors
References: <CAJ65rDxwRshw4Qwte9bU4K+xifcS0Yo7TjCKJ2aNPg4wBLeg5w@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:33:32 +0300
In-Reply-To: <CAJ65rDxwRshw4Qwte9bU4K+xifcS0Yo7TjCKJ2aNPg4wBLeg5w@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:23 -0400")
Message-ID: <87wnbxoa37.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

aspriel@gmail.com writes:

> The bcm43xx family of wifi chipsets found its way to different
> groups inside and outside Broadcom. For the fullmac devices this
> means that in those difference groups firmware is being developed
> and the firmware api is bound to diverge. This series introduces
> a design change to accomodate supporting multiple firmware api's.
> The vender-specific support can be compiled in brcmfmac or
> built as a separate module. Currently the vendor-specific support
> does not have any real effect. At the momemt looking into SAE support
> which appear to be different for Cypress devices so that might be a
> first use-case. Meanwhile wanted to put this series out there and
> get feedback on it. Some ideas were taken from iwlwifi which does
> similar things for iwlmvm, iwldvm, etc.
>
> The patches apply to the main branch of the wireless-next repository.
>
> Arend van Spriel (7):
>   brcmfmac: add function to unbind device to bus layer api
>   brcmfmac: add firmware vendor info in driver data
>   brcmfmac: add support for vendor-specific firmware api
>   brcmfmac: add support for Cypress firmware api
>   brcmfmac: add support Broadcom BCA firmware api
>   brcmfmac: add vendor name in revinfo debugfs file
>   brcmfmac: introduce BRCMFMAC exported symbols namespace

I think there's something wrong in mail formatting, tried to apply just
for a test and it failed:

error: git diff header lacks filename information when removing 1 leading pathname component (line 7)
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: brcmfmac: add function to unbind device to bus layer api
Patch failed at 0001 brcmfmac: add function to unbind device to bus layer api

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
