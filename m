Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAE17E5CF2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjKHSMI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjKHSMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:12:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09DB1FEB
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:12:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5F0C433C7;
        Wed,  8 Nov 2023 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467124;
        bh=PgrzDEYlueh9xFGD1NeRdSnGnOOq4l6E06v9kSvG+xo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nuZ7LeM7n4uLQYv8rTW1UxhYczU/1rUv03OMExL0b7Alxl1PyEjyz3WlCPTK7uEuA
         qjvLT4QQT8ACBsVkzbfIJqkC3uJl9yZkudknS6kUkOdQf+slbG6CTruZdz7v+yGmrV
         jmAJg7eXhMKaJaYOMoELkwAve2rbXK0iQpov2GGTjXTZd1DF84kaVZjvzlgatwQ3s2
         Z/Gdz4zX94T3fKOu+piZLfknl1RU9SOSPhDh8m28NgurJz8rzZnHRMuc0yunUZ6nh6
         ODX2V3E7Iz7sp7LqWgiQ2DF+4KyrjqfvmwhOv1DByo5PgM1eoZg7ViBQrFV/BewpRK
         jpRKCkdt66ofg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: coex: use struct assignment to replace
 memcpy()
 to append TDMA content
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231102003716.25815-1-pkshih@realtek.com>
References: <20231102003716.25815-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946712218.2821494.17415728678244513492.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:12:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To notify firmware TDMA timeslot assignment, append TDMA parameters when
> sending policy H2C firmware command. However, compiler warns we do memcpy()
> data to val[] field of TLV struct. To avoid this, assign the struct value
> with simple '=' instead. Compile tested only.
> 
> rtw89/coex.c: In function '_append_tdma':
> drivers/net/wireless/realtek/rtw89/coex.c:1585:17:
>  warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>  1585 |                 memcpy(&v3->tdma, &dm->tdma, sizeof(v3->tdma));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/net/wireless/realtek/rtw89/coex.h:8,
>                  from drivers/net/wireless/realtek/rtw89/coex.c:5:
> drivers/net/wireless/realtek/rtw89/core.h:2703:37:
>  note: at offset [5714, 71249] into destination object 'ver' of size 8
>  2703 |         const struct rtw89_btc_ver *ver;
>       |                                     ^~~
> drivers/net/wireless/realtek/rtw89/coex.c:1579:17:
>  warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
>  1579 |                 memcpy(v, &dm->tdma, sizeof(*v));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.h:2703:37:
>  note: at offset [5710, 71245] into destination object 'ver' of size 8
>  2703 |         const struct rtw89_btc_ver *ver;
>       |                                     ^~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310301908.Wrj0diqe-lkp@intel.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

ca76817f4c4b wifi: rtw89: coex: use struct assignment to replace memcpy() to append TDMA content

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231102003716.25815-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

