Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985907E15B3
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Nov 2023 19:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKESHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Nov 2023 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKESHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Nov 2023 13:07:43 -0500
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 10:07:39 PST
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF4DB
        for <linux-wireless@vger.kernel.org>; Sun,  5 Nov 2023 10:07:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id DD49A1154C;
        Sun,  5 Nov 2023 18:00:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IeEx67rLXPzY; Sun,  5 Nov 2023 18:00:12 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sun, 05 Nov 2023 20:00:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1699207212; bh=Hrt9zu1vI6KZPtNUSZjVBfmzqB5oWzL9lR5Zvkkq7lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYMpV6SLsa/Ffo/ZFFALCG32+5+CuWuo2imP5qJy/DyKktvjvSBElsh+xBWvwRb4F
         y1hOlf47V2WYuuZNPN3/yvB26a09s52rdYrr34CprcO7mevdWMC6SIG/BMaZ4t2zAt
         k1CROpVlUx2fj7v7hAPuAHlZuBdmSIhhtSoFN8jSKasdQnYT1/V7M3Ebcv63fAo1L5
         c3cK2xrVSAxnhvWfShwHWkBP16cgQQ7QvE1LoP1GuQlHGxiYeUUKqa0hMMePwIKj5L
         FDo8ce3yMQF4aJGjqjt+v8DufA/p7SM7JW5quPbCN1JFTxLM4ixDk+hzeQ7RUy8dfi
         SlLauEKQGGEOw==
Date:   Sun, 5 Nov 2023 20:00:10 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Kavitha Velayutham <k.velayutham@samsung.com>
Cc:     hostap@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] Patch [1/1] Changes for FILS External Authentication
Message-ID: <ZUfYKgsOz+cfM3+C@w1.fi>
References: <CGME20230704061838epcas5p2d56b04612af73c01545bc7acb4400cab@epcas5p2.samsung.com>
 <20230704142019.1020183-1-k.velayutham@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704142019.1020183-1-k.velayutham@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 04, 2023 at 07:50:19PM +0530, Kavitha Velayutham wrote:
> Changes for Authentication to be done in supplicant where sme is in driver
> for FILS Authentication.

> diff --git a/src/drivers/nl80211_copy.h b/src/drivers/nl80211_copy.h
> @@ -1562,6 +1562,8 @@ enum nl80211_commands {
>  
>  	NL80211_CMD_SET_HW_TIMESTAMP,
>  
> +	NL80211_CMD_FILS_ASSOC_REQ_INFO,
> +
>  	/* add new commands above here */
>  
>  	/* used to define NL80211_CMD_MAX below */

This has not been applied into the Linux kernel, so I cannot apply this
into hostap.git either. Please send the hostap.git patch again once the
needed kernel interface changes have been accepted.

-- 
Jouni Malinen                                            PGP id EFC895FA
