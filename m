Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38805EEDC5
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiI2GTD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI2GTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 02:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40145125797
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 23:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B226202A
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 06:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2083BC433D6;
        Thu, 29 Sep 2022 06:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664432340;
        bh=7si2vUvV+3L0HnzlDpO8+QGdNK3RsMLy1qQ96vGfYFs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Fd7D8CZF7TNiEs7CZCK0R3oizuIfcDe22tewMqo1Q/t0izzC8nBal7lDsLiJq/VS9
         B5EscoIx1sAedOUi37yWqbdoYNyLGCozXQSKqzQT9MqaRNGbRvH+8E/4Pg39EnwqUj
         of8/o7BeVh9orVjSv/c8wKe6bc8e+6BfeAgbvsieYjit/oVI5uTzgGA88pObRahJlO
         IP2h/gVKxSpV8OknyMXe0cagj8ip9tcAD2Tih3O8INXu6wfEdTSq6yp24E/x7ismLf
         VopuQLP0VBvmggat/ZbKwmGjhDSrKs7mD1VdHtkI6tcg4Y4AmfMHFDTKVM/DEYvKHt
         uTetnuVaUvOGQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] wifi: rtl8xxxu: gen2: Enable 40 MHz channel width
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com>
References: <3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166443233534.2816.7028370887036604875.kvalo@kernel.org>
Date:   Thu, 29 Sep 2022 06:18:58 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> The module parameter ht40_2g was supposed to enable 40 MHz operation,
> but it didn't.
> 
> Tell the firmware about the channel width when updating the rate mask.
> This makes it work with my gen 2 chip RTL8188FU.
> 
> I'm not sure if anything needs to be done for the gen 1 chips, if 40
> MHz channel width already works or not. They update the rate mask with
> a different structure which doesn't have a field for the channel width.
> 
> Also set the channel width correctly for sta_statistics.
> 
> Fixes: f653e69009c6 ("rtl8xxxu: Implement basic 8723b specific update_rate_mask() function")
> Fixes: bd917b3d28c9 ("rtl8xxxu: fill up txrate info for gen1 chips")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Jes Sorensen <jes@trained-monkey.org>

3 patches applied to wireless-next.git, thanks.

a8b5aef2cca1 wifi: rtl8xxxu: gen2: Enable 40 MHz channel width
5574d3290449 wifi: rtl8xxxu: Fix AIFS written to REG_EDCA_*_PARAM
2fc6de5c6924 wifi: rtl8xxxu: Improve rtl8xxxu_queue_select

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3a950997-7580-8a6b-97a0-e0a81a135456@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

