Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4B732D70
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 12:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344084AbjFPKV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 06:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbjFPKUz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 06:20:55 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2DB3AB7
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 03:20:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 4D40D5ED7A;
        Fri, 16 Jun 2023 13:20:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0KaLKWAW1iE0-TTysXfJ8;
        Fri, 16 Jun 2023 13:20:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686910800;
        bh=hQ4KipRsd6rR4DVab3LV09flp/u0keV1/tknf+o7494=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=F1zNyb/ShXEU0G9BgQ6/2AYnaerBejgEHszI11DXDUCYSUyEkL8aBF00lzgBYKOmh
         U/kcSlR7Jfx6vrza+3TZO8hXARbR8zTY2uD/5DEETjxnvc3t1s2fekP0fOZ67Y37w2
         VUbu8d5MWVOt8GW108i9irXVkcsM7dm/L71X7Cfo=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
Date:   Fri, 16 Jun 2023 13:20:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20230608095051.116702-4-dmantipov@yandex.ru>
 <168664510862.24637.10587241603155144086.kvalo@kernel.org>
 <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru> <87h6rad3fp.fsf@kernel.org>
 <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru> <87cz1vbulk.fsf@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <87cz1vbulk.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/16/23 12:54, Kalle Valo wrote:

> rtl818x is not active. You can actually check that yourself:
> 
> git log drivers/net/wireless/realtek/rtl818x/

Note MAINTAINERS marks drivers/net/wireless/realtek/rtl818x/rtl8180 as
orphaned but drivers/net/wireless/realtek/rtl818x/rtl8187 as maintained.

> I want to also mention that the maintainers are not really enthusiastic
> about random cleanups to random drivers from new contributors, they
> increase our workload and there's always a risk of regressions. I try to
> be nice and take few cleanups now and then, but if there's too much such
> patches I'll start to back off.
> 
> Instead random cleanups I would be very happy to see these issues fixed
> in wireless drivers:
> 
> o removal of strlcpy()
> 
> o fixing sparse warnings (my goal is to have wireless drivers sparse
>    warning free)
> 
> o removal of BUG_ON() (no wireless driver should use BUG_ON() which
>    crashes the whole system)

Got your point, thanks.

Dmitry

