Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2E76F169
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHCSFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjHCSEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 14:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FA4EC1
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 11:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FF661E4A
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 18:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A72CC433C7;
        Thu,  3 Aug 2023 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085790;
        bh=VrjKRx+oWp5ae5K/8G0kK9vqZU2UuHSN2r5BpFukw+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRdu56irx6tj4e1Mt6Yl3O+Efl7BEJqpB7L+M4U/gXlJxGkCS18Y7jIV+cL57E4we
         SujUzYcOtZsYUL051sAyHV5s9dTn6t/wjfHaQ9YfoXrZvfabmyR0Bfe7gCNyCQC/Rx
         InzhpZrGGLa6tiX3A6SSzeNwhmi4IKRRUFGBqslG87I43WDJebBPPSPZTHj0wZlxi8
         IwC9MwsyhBtUn1FTgPmFLJ3U7vJPoNwwCQ2TkUH41yennKINTm3ty1sgnqFTlUigPt
         xt46UwxRtxAe0KkE/VZjdcEZkglwscJ62qNyw1ZAsLJltAVOTOyPB1j6RFx4kQvnuC
         ZZkoDrWKZYu2w==
Date:   Thu, 3 Aug 2023 20:03:06 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZMvr2lNVTPLqs8Nq@kernel.org>
References: <20230803134248.42652-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134248.42652-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 03, 2023 at 09:42:48PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/iw_handler.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> index d2ea5863eedc..99f46f521aa7 100644
> --- a/include/net/iw_handler.h
> +++ b/include/net/iw_handler.h
> @@ -432,9 +432,6 @@ struct iw_public_data {
>  
>  /* First : function strictly used inside the kernel */
>  

Hi Yue Haibing,

I think you can remove the comment above and blank line below it too.

> -/* Handle /proc/net/wireless, called in net/code/dev.c */
> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
> -
>  /* Second : functions that may be called by driver modules */

And work this into the comment above the to be deleted 'First :' comment.
Something like this:

/*
 * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
 * These may be called by driver modules.
 */ 

>  
>  /* Send a single event to user space */
> -- 
> 2.34.1
> 
> 
