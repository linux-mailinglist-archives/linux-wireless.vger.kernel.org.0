Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCF56B8093
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 19:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCMSao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 14:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCMSaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3768316F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 11:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80DDD6144F
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 18:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C7EC433D2;
        Mon, 13 Mar 2023 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678732140;
        bh=KDQ88u+goxlApfNXunHcZS4KKdnQNzBLDOl5twt2rdE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WigvBTkkFSGefA8mS7GEN/M03ll/ZRujAICxeK9QF+ZOBmoxhe0nFBcyXxKxNg0fT
         URC0QXtoipXplmqouAX2qjSV7WR9hx16XlLAG8fFbzwA64KVARkcmmhZvwIZhcglpj
         7+x0n+K2QgEEUyOIHqmbPbgsj8DWTduO2VcgqtD6tZeFFIpHWDOVfL5lOAB60qnxkz
         KCk09nIBPrLTIoBPYnkYoR2smFqup/xF2ee2UpA6AE5cAm5vsBsySBCkWkIjLatNz1
         cA81cbEaztgHbiDiIlk/5Wk5jvtsXJTHPpQSoTK994ZmB3jNCjpxkKyqbIJrW/A/Zw
         gxGCWZtdFCcZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath10k: read qcom,coexist-support as a u32
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <CA+RD57MwUfAzF2u31Ews4uT0+A6uhjwwd40O=9uyZihap4nxdA@mail.gmail.com>
References: <CA+RD57MwUfAzF2u31Ews4uT0+A6uhjwwd40O=9uyZihap4nxdA@mail.gmail.com>
To:     Vincent Tremblay <vincent@vtremblay.dev>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vincent Tremblay <vincent@vtremblay.dev>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167873213607.17591.12426656381855505512.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 18:28:59 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vincent Tremblay <vincent@vtremblay.dev> wrote:

> Read qcom,coexist-support as a u32 instead of a u8
> 
> When we set the property to <1> in the DT (as specified in the doc),
> "of_property_read_u8" read 0 instead of 1. This is because of the data format.
> 
> By default <1> is written with 32 bits.
> The problem is that the driver is trying to read a u8.
> 
> The difference can be visualized using hexdump in a running device:
> Default 32 bits output:
> =======================
> 0000000 0000 0100
> 0000004
> 
> 8 bits output:
> ==============
> 0000000 0001
> 0000001
> 
> By changing "of_property_read_u8" by "of_property_read_u32", the driver
> is aligned with the documentation and is able to read the value without
> modifying the DT.
> 
> The other solution would be to force the value in the DT to be saved as
> an 8 bits value (qcom,coexist-support = /bits/ 8 <1>),
> which is against the doc and less intuitive.
> 
> Validation:
> ===========
> The patch was tested on a real device and we can see in the debug logs
> that the feature is properly initialized:
> 
> [  109.102097] ath10k_ahb a000000.wifi: boot coex_support 1 coex_gpio_pin 52
> 
> Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>

Fails to apply:

error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/CA+RD57MwUfAzF2u31Ews4uT0+A6uhjwwd40O=9uyZihap4nxdA@mail.gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

