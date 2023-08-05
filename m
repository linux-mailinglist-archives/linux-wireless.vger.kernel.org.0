Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D873F770E94
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Aug 2023 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjHEHxi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Aug 2023 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEHxg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Aug 2023 03:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09A1FE1
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 00:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3003460B84
        for <linux-wireless@vger.kernel.org>; Sat,  5 Aug 2023 07:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E3C433C8;
        Sat,  5 Aug 2023 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691222014;
        bh=PC4Ds+J+Yy1q1eDBiTjeR+7fVZu+dB4pJP5K8KhcD5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3XT0SKMsPKL14Fz+XIRl9a7t3Iqnhp/UEgS79yXdF+v/b80tcgdOjuNPlX7yYGUA
         t01YUkjylxIm2EHaEjLtT0SbVpknlEmgyGIfNKLHV4HPjC3eTCIdvvnbtisX2/Kxyc
         S87yn/rAMBvjy17oG7jJy6UwZ4z0fyvcHGy0J7oaU1PD/Vp4jamVsI6KK7/FmLA1qb
         PDcYYlJev86p+lOFqF/xHAi9SNO42aUcH9xQa+VCuf28C/Dkv8PoMPHDNWrHDmMkq3
         Tey2R1Uum3GyG4CRWD5Wqpanq3c+UhGeohYHkZHfFt61q2ejVqln6qkVyMF0FT9G+S
         Hx/sliQYgvJGQ==
Date:   Sat, 5 Aug 2023 09:53:30 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZM3/+pY9Fovc5AC9@vergenet.net>
References: <20230804133617.43564-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804133617.43564-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 04, 2023 at 09:36:17PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: fix comment
> ---
>  include/net/iw_handler.h | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> index d2ea5863eedc..b2cf243ebe44 100644
> --- a/include/net/iw_handler.h
> +++ b/include/net/iw_handler.h
> @@ -426,17 +426,10 @@ struct iw_public_data {
>  
>  /**************************** PROTOTYPES ****************************/
>  /*
> - * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
> - * Those may be called only within the kernel.
> + * Functions part of the Wireless Extensions (defined in net/wireless/wext-core.c).

Can I confirm that the wireless.c -> wext-core.c change is intentional?
It doesn't seem strictly related to the patch description.

> + * Those may be called by driver modules.
>   */
>  
> -/* First : function strictly used inside the kernel */
> -
> -/* Handle /proc/net/wireless, called in net/code/dev.c */
> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
> -
> -/* Second : functions that may be called by driver modules */
> -
>  /* Send a single event to user space */
>  void wireless_send_event(struct net_device *dev, unsigned int cmd,
>  			 union iwreq_data *wrqu, const char *extra);
> -- 
> 2.34.1
> 
