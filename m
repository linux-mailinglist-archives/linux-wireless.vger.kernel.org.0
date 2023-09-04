Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A101791C10
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbjIDRdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjIDRds (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 13:33:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE836DF
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 10:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E3D5B80EAC
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 17:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4187EC433C8;
        Mon,  4 Sep 2023 17:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693848823;
        bh=ubq2fDaxxsaysxRidzVH8ssJXdC2bTABWQDb4vaMkdo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=esd4Zk/TPswPbLDW4mEJ8l1PIjPRI+i2cGUx4e8rUdyThQv/8vKU4MlHQT8YClJUG
         +d0NxL5plqJROOd0xmSSEpRPlSDYgzb7cqU0q0oHnz+361YURDyTkoMyCZk9Fbk+6z
         9uNcBK9UJG9z3fAJP7Gs+KCiRhRrqbTF5la5pjfFOYsRurfhxSQkIvomzH68EQ+Dit
         JQCdomekJOSWSVVnQfMd9Mm7wOd0qEHwQbqy9X2Y8Qiz4ElobRPREUyFoXWcLWQfTm
         S5GDbegbx+04CQCTQSeCEVN8CkvblnNqRBIq7UTMLg7j9LJ5iyIrkfmD2DZWKp7tX9
         5ysr3fWfkX8jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: plfxlc: fix clang-specific fortify warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230829094541.234751-1-dmantipov@yandex.ru>
References: <20230829094541.234751-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Srinivasan Raju <srini.raju@purelifi.com>,
        linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384882020.3484948.9412363192994601836.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:33:42 +0000 (UTC)
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
> In file included from drivers/net/wireless/purelifi/plfxlc/mac.c:6:
> In file included from ./include/linux/netdevice.h:24:
> In file included from ./include/linux/timer.h:6:
> In file included from ./include/linux/ktime.h:24:
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
> The compiler actually complains on 'plfxlc_get_et_strings()' where
> fortification logic inteprets call to 'memcpy()' as an attempt to copy
> the whole 'et_strings' array from its first member and so issues an
> overread warning. This warning may be silenced by passing an address
> of the whole array and not the first member to 'memcpy()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Patch applied to wireless-next.git, thanks.

a763e92c7861 wifi: plfxlc: fix clang-specific fortify warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230829094541.234751-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

