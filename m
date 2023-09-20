Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014AA7A839A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjITNjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjITNjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:39:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05276A9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:39:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888F8C433C7;
        Wed, 20 Sep 2023 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217187;
        bh=OJLOcu7QGnU8Z4qYvqF4xiEoMz9vtjV6liy7IRfGmDs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZfJa2gVUGgLaNGBZzzegn3OPffvT5+6g8QiY7lZq93lwfNhiVzT8LivAgS7CLhqR8
         asHWcVMyZYuBreSbERH+VIpxz14JIU+jA1D/tZWL+kvqfj8uVP/amZXmx3N1uQ+W/8
         TeoxDOjhEXyTydDB8qU8VfkJbh3qGE43f+0X3uxLoTylZ6DhE2IgtdTBHHgn6FTZhk
         ApZsOvz2tQWwsOe4x3JzcAxfbJcnoinRHKMNVWRvTfW1fwJ0ZGbnuuuLF+iypTq/Yz
         Qnrabl6cSc4q9qePC61iZ/u6Vgk4K4Kr2cc1aXN2t7g9lCO2XxEbeangXQdupx95Tc
         pPLdTVnuYHjFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: fix clang-specific fortify warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230829093652.234537-1-dmantipov@yandex.ru>
References: <20230829093652.234537-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521718481.1118199.1680199294713287417.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:39:46 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
> noticed the following (somewhat confusing due to absence of an actual
> source code location):
> 
> In file included from drivers/net/wireless/ath/ath10k/debug.c:8:
> In file included from ./include/linux/module.h:13:
> In file included from ./include/linux/stat.h:19:
> In file included from ./include/linux/time.h:60:
> In file included from ./include/linux/time32.h:13:
> In file included from ./include/linux/timex.h:67:
> In file included from ./arch/x86/include/asm/timex.h:5:
> In file included from ./arch/x86/include/asm/processor.h:23:
> In file included from ./arch/x86/include/asm/msr.h:11:
> In file included from ./arch/x86/include/asm/cpumask.h:5:
> In file included from ./include/linux/cpumask.h:12:
> In file included from ./include/linux/bitmap.h:11:
> In file included from ./include/linux/string.h:254:
> ./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
> declared with 'warning' attribute: detected read beyond size of field (2nd
> parameter); maybe use struct_group()? [-Wattribute-warning]
>                         __read_overflow2_field(q_size_field, size);
> 
> The compiler actually complains on 'ath10k_debug_get_et_strings()' where
> fortification logic inteprets call to 'memcpy()' as an attempt to copy
> the whole 'ath10k_gstrings_stats' array from it's first member and so
> issues an overread warning. This warning may be silenced by passing
> an address of the whole array and not the first member to 'memcpy()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

cb4c132ebfea wifi: ath10k: fix clang-specific fortify warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230829093652.234537-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

