Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4155C78FC06
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbjIALBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 07:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjIALBt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 07:01:49 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41E10D5
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 04:01:46 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693566104; bh=1WQne8zuae/eWhLZP5alO9Rk6xUCNACmkxspWqiFgZQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RhNQ8t2Whmybv9Op9unzIp0qzNMKa9ihVDo6T7OSj5zPWmgbGLcIuUoPnHu4J5/De
         n1KxLOo05vDq+tbMQdRdt4b/vN02Bywv7KhtjjgamV9SLl0LUcHcB+ty3VOAd1clwO
         DZktY7ILVJ9Va/wAhLjtW9RuXcxOQZUKlpcJT+MKPeboEH/H+BazEgTFs4wFpoLpXf
         2G9FGIs4hk2UaXlVIqRWKTjmBd4gFLUX+dvXeqsYEpmRASvN4TqjH64yv3W9uJWwxQ
         8puU+2qjZHLk7uByWaSTBPQKCUd4I7IuRSqWaExeKpaWAPYyv3Pt8XKt7XZMY6YCnB
         8EtIoQleOPDeA==
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: fix clang-specific fortify warnings
In-Reply-To: <20230829093856.234584-1-dmantipov@yandex.ru>
References: <20230829093856.234584-1-dmantipov@yandex.ru>
Date:   Fri, 01 Sep 2023 13:01:44 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ledqtaw7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=3Dy, I've
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
> ./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow=
2_field'
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
> ./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow=
2_field'
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

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
