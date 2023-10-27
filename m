Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A147D8EF9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 08:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjJ0Gy1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 02:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0Gy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 02:54:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B905116
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 23:54:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE2C433C9;
        Fri, 27 Oct 2023 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698389664;
        bh=MJUVkF4OAlCGNmh87SHpXmYBoNo0A1s3AB3gwSpYAS8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kuDqTc+sySNlKVLzuzFg+2zpfeAkRGAY+cdUM/V2ZL7eM1MQiFH8fCQRFelxXwWji
         cLrB7hvsyG74UpQ+Az2cLEWU2JmRCRC0wFE1BlFczVGMtTi7yFkfSu+JBA139LoM+q
         3DeToMCbb4S5bFSXficAYGfqJb+G/6svBk/oNqxbAO/PxxKcNbfNsoAStNuMvdeZ3S
         a+L/SuC1h6iprB+MNv3IV5YVW8MlFqAUa5uCW+gCJuwr6hBNwE5rUTI6AVYdZA8oB3
         M1fvkRLpCE7Swhmjc75pT8KTjZE8Zh5hwIoEaZedxgFoZA81DJA812/cUC4Eo/ZAA1
         aavx67n7PzuhQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in
 kuba@'s modules
References: <20231026190101.1413939-1-kuba@kernel.org>
        <20231026190101.1413939-2-kuba@kernel.org>
Date:   Fri, 27 Oct 2023 09:54:21 +0300
In-Reply-To: <20231026190101.1413939-2-kuba@kernel.org> (Jakub Kicinski's
        message of "Thu, 26 Oct 2023 12:00:58 -0700")
Message-ID: <87fs1wd082.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Fill it in for the modules I maintain.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: linux-wireless@vger.kernel.org
> ---
>  drivers/net/netdevsim/netdev.c              | 1 +
>  drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
>  2 files changed, 2 insertions(+)

For wireless:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
