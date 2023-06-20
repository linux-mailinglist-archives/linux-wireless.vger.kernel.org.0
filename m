Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F85273717B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFTQ0w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFTQ0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 12:26:50 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D11985
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 09:26:25 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-55e163e93d5so3150222eaf.3
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jun 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687278385; x=1689870385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AF/L5yTpy3GASMY2xxrkK1Ed/a2eXFLzC2S7HBF7534=;
        b=oVhQ0UkmxZZyrKQmcvUD5ToGLp+FJemwQaa7j1M/ul9kM2FDKNHRvAac83NWQp13Uq
         AL+so0QJCyxb/lSono99ixvwrBsH5YHQ/Lq46Aj1j+JbMGTWrQL/DyBPCnfck/FE+CNU
         LhfUoXU2eZ4sPtcqJZypAlDCCi6lz2xKPpBjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278385; x=1689870385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF/L5yTpy3GASMY2xxrkK1Ed/a2eXFLzC2S7HBF7534=;
        b=DzmYifupAL2xK9piR2XFLEzRAOFaYL2FqkreLwnvc+bVZ6h86U+UaCae/jDOXt0P9E
         OscwpoRH+GuhxaizVj9MBy+PrNigt9XNoh8c7oh8V7/lt4fo9PB6LEnUeJ7Kq45R4WBT
         Uzq3v8+788aPv6sKikJTTNLhVejc7hbaXMhiiyTK9qkL8K9IBeOJkPRgayRqJuGCen6a
         hJmmdzFF5nIxZWewxTr+Rpr80Zb8E9SFMwSAByHM95qyohMo1w6Vuk5anK95YPe0+bbX
         jWCozf/R+47UsRI1I/csqwlwQD//6UYf8QQsInvIx8FItomE000BziCUHaakEcrzsVsF
         N4mA==
X-Gm-Message-State: AC+VfDyefg3Ef++AnABDEB2PmFY/tdAh3CmdrC5mbVt5syZVrFWTUKUF
        B6oXI7WE+6IY8qqiPUFEm1Cxsw==
X-Google-Smtp-Source: ACHHUZ672/h85yQRWM2xlwgV9j8ZMZD36kiIaQ0Bsz+twb7ZNfFSJaUTqfj8XfO7PVIsWn6kmDhNrg==
X-Received: by 2002:aca:903:0:b0:39e:a493:65fc with SMTP id 3-20020aca0903000000b0039ea49365fcmr11860962oij.57.1687278385153;
        Tue, 20 Jun 2023 09:26:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:64b6:fe8c:2779:6abf])
        by smtp.gmail.com with ESMTPSA id nt18-20020a17090b249200b0025ec54be16asm7229636pjb.2.2023.06.20.09.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:26:24 -0700 (PDT)
Date:   Tue, 20 Jun 2023 09:26:22 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] wifi: mwifiex: fix fortify warningg
Message-ID: <ZJHTLhQNM4oj40Zn@google.com>
References: <20230620100803.519926-1-dmantipov@yandex.ru>
 <20230620100803.519926-2-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620100803.519926-2-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jun 20, 2023 at 01:07:37PM +0300, Dmitry Antipov wrote:
> When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=y,
> I've noticed the following:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘mwifiex_construct_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:765:3,
>     inlined from ‘mwifiex_send_tdls_action_frame’ at drivers/net/wireless/marvell/mwifiex/tdls.c:856:6:
> ./include/linux/fortify-string.h:529:25: warning: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler actually complains on:
> 
> memmove(pos + ETH_ALEN, &mgmt->u.action.category,
> 	sizeof(mgmt->u.action.u.tdls_discover_resp));
> 
> and it happens because the fortification logic interprets this
> as an attempt to overread 1-byte 'u.action.category' member of
> 'struct ieee80211_mgmt'. To silence this warning, it's enough
> to pass an address of 'u.action' itself instead of an address
> of its first member.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/tdls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
> index 97bb87c3676b..5a2941965757 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -762,7 +762,7 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
>  		mgmt->u.action.u.tdls_discover_resp.capability =
>  							     cpu_to_le16(capab);
>  		/* move back for addr4 */
> -		memmove(pos + ETH_ALEN, &mgmt->u.action.category,
> +		memmove(pos + ETH_ALEN, &mgmt->u.action,
>  			sizeof(mgmt->u.action.u.tdls_discover_resp));

This invocation seems a bit suspect, as it uses a 'sizeof' of a field
that doesn't match the actual pointer (it's off by 1 byte), but that's
not your fault. I suppose it's no wonder we had so many problems with
TDLS support on mwifiex...

Anyway, the refactor looks fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

>  		/* init address 4 */
>  		eth_broadcast_addr(pos);
> -- 
> 2.41.0
> 
