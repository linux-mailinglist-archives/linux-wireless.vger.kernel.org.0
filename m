Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34A27A8313
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 15:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjITNRK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjITNRI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 09:17:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EA1A9
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 06:17:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5092C433CA;
        Wed, 20 Sep 2023 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695215821;
        bh=aokdul/EDn4ykOaB3uYcrsOCpdNgFA8ymZpAAnb64FU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BMmrF6sTWe3QQf4tn79LDmTXyoBnxzq1G0wFjipzhbVmAtUxAUoj4Iv6m9Jrflj0C
         LVujNCJfOfhvxjJ5rWANq1pTq+5jOm+T4VB8Vttzr9GBZBNH0yyLyWpqWh6rEnuqHR
         KL+bVbOdQYKEsmFDdfa4lqhbIQvZENRexAS5yXd1QhIy9w0tVmUzBQHSLH+1VErcjW
         3ySgN8AfjwhW3Fn56qeRcJ1lBOEDQJStaziib15/9JDeVeSCq2m6AMdW4RXJTn2+WC
         2Dg5EpLZbz1yA4m+83HmqKIVoBgx9aVy92wx+cWvnadzCSnZ2fPilGQ5gvr7t+l3Mf
         bSdd13prGCsVA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath9k: fix clang-specific fortify warnings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230829093856.234584-1-dmantipov@yandex.ru>
References: <20230829093856.234584-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169521581913.1118199.501040563383368808.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 13:17:00 +0000 (UTC)
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
> In file included from drivers/net/wireless/ath/ath9k/debug.c:17:
> In file included from ./include/linux/slab.h:16:
> In file included from ./include/linux/gfp.h:7:
> In file included from ./include/linux/mmzone.h:8:
> In file included from ./include/linux/spinlock.h:56:
> In file included from ./include/linux/preempt.h:79:
> In file included from ./arch/x86/include/asm/preempt.h:9:
> In file included from ./include/linux/thread_info.h:60:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> In file included from ./arch/x86/include/asm/cpufeature.h:5:
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
> In file included from drivers/net/wireless/ath/ath9k/htc_drv_debug.c:17:
> In file included from drivers/net/wireless/ath/ath9k/htc.h:20:
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
> The compiler actually complains on 'ath9k_get_et_strings()' and
> 'ath9k_htc_get_et_strings()' due to the same reason: fortification logic
> inteprets call to 'memcpy()' as an attempt to copy the whole array from
> it's first member and so issues an overread warning. These warnings may
> be silenced by passing an address of the whole array and not the first
> member to 'memcpy()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

95f97fe0ac97 wifi: ath9k: fix clang-specific fortify warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230829093856.234584-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

