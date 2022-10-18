Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D2602169
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 04:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJRCtk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Oct 2022 22:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJRCti (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Oct 2022 22:49:38 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF01A22F
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:49:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f193so12169925pgc.0
        for <linux-wireless@vger.kernel.org>; Mon, 17 Oct 2022 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTODrlB+7AJnag9/P4yyzzC7WqRXAUlUkTowiwHkiWM=;
        b=DydS8spoH83GUDzf8tD3YG9MwEPxUB4hyDkgm9z90W16uxzbFNH7mi9OXPLglNkEnr
         mcw3zoEoHoenTDW3VGWj7lo60QmOE7Nu4u6AuASkSTfRYORo9Ch36dMQrlPWPgfBTN/a
         h0QDjb3JMkfYK2VQT7KPhvGy3tLdka75tFTPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTODrlB+7AJnag9/P4yyzzC7WqRXAUlUkTowiwHkiWM=;
        b=PD1qPF0jBtKJ23yGfHUz61voksQ7Xw4NrYT6umrtjH0xoocPDqKmXUAed9d91FDvlW
         pbFiUvtGw5m3hHQgCkNrms+nBEfn2oKHVRLhIXPgtGPj3dpATH0KHe68ohCXth6k0aEA
         eY/wHwNt3rRGk0klf/8xJ02PxgJm8jz/H3Rz/1JOlNoWyHPOGzmdNbT2m7LoPEaoPrTk
         0WBzMmALgDmS5yYQjQwTdiFpdCp1CbX0yrk1RDkylUHeFRpkzaoh0RiSDmKP8/o860MY
         b0b4kyWFs1nQkX5iock6F5FQehNHOM1Q5S4qSn6qvHlMyuLGUIXFI9m6dufjLSJkJw6L
         9+Sw==
X-Gm-Message-State: ACrzQf3ousY9ZF75SU6R1u9/8eJ3TzmScBav5jGx3nm32HuS9oIyUJ6d
        t6rFesRh05e0IDHyUNyOZ4v5L2T+36RmNA==
X-Google-Smtp-Source: AMsMyM515OHxY++GdMoPEtD7YGrxz70dJ16U7PpqVIiXY2ncUxZpd3i42E2cFMdd4LDmEuWTIlbAjg==
X-Received: by 2002:a63:6c84:0:b0:43c:700f:6218 with SMTP id h126-20020a636c84000000b0043c700f6218mr788153pgc.420.1666061376633;
        Mon, 17 Oct 2022 19:49:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 64-20020a621943000000b005601e974993sm7814654pfz.25.2022.10.17.19.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:49:36 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:49:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5/6][next] zd1201: Avoid clashing function prototypes
Message-ID: <202210171948.E275139C0D@keescook>
References: <cover.1666038048.git.gustavoars@kernel.org>
 <b16526a7a35638224990d265db21c8b450b67545.1666038048.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16526a7a35638224990d265db21c8b450b67545.1666038048.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 17, 2022 at 03:35:57PM -0500, Gustavo A. R. Silva wrote:
> [...]
> @@ -1678,12 +1682,11 @@ static int zd1201_get_maxassoc(struct net_device *dev,
>  }
>  
>  static const iw_handler zd1201_private_handler[] = {
> -	(iw_handler) zd1201_set_hostauth,	/* ZD1201SIWHOSTAUTH */
> -	(iw_handler) zd1201_get_hostauth,	/* ZD1201GIWHOSTAUTH */
> -	(iw_handler) zd1201_auth_sta,		/* ZD1201SIWAUTHSTA */
> -	(iw_handler) NULL,			/* nothing to get */
> -	(iw_handler) zd1201_set_maxassoc,	/* ZD1201SIMAXASSOC */
> -	(iw_handler) zd1201_get_maxassoc,	/* ZD1201GIMAXASSOC */
> +	IW_HANDLER(ZD1201SIWHOSTAUTH, zd1201_set_hostauth),
> +	IW_HANDLER(ZD1201GIWHOSTAUTH, zd1201_get_hostauth),
> +	IW_HANDLER(ZD1201SIWAUTHSTA, zd1201_auth_sta),
> +	IW_HANDLER(ZD1201SIWMAXASSOC, zd1201_set_maxassoc),
> +	IW_HANDLER(ZD1201GIWMAXASSOC, zd1201_get_maxassoc),
>  };

Like with the others, leave these as-is...

-- 
Kees Cook
