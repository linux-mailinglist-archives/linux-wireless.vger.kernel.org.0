Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97D76A479
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGaXGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 19:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGaXGP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 19:06:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61420FB
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 16:06:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f25d045cso3371444b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 16:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690844774; x=1691449574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jM8pm+E+CXbfooJNhDR8HGuge+AEaE1NLBAsYmmAzr0=;
        b=N1hwJWEiqpsml5Bo2TgnS3AB/U40NkvabYIHbcFb5+A5l3504hshHCBqDFCWQ5JAlV
         +C6LSQyAGjKXpTSgWJU8/HxkWI7bHMv+Pz0BxDwvBYx1NC/VQD/sQgEYUzLKftFhSOA1
         Vp336OUbiXyy1rEw7UNb8Uff2dnhtUwBnM40s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690844774; x=1691449574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM8pm+E+CXbfooJNhDR8HGuge+AEaE1NLBAsYmmAzr0=;
        b=lH+VZ5Ogx+Vpa4n5mh09H1HwvL7fh/O1MlNAiQO2W1vJm1EUvl0YgVW9jx1TmnIzBD
         xZe1HB0ivioMUySuimOanjRSQDEWmuRgs4c+qTeqU1iYnkU+3cl8du7dQiM4VDyORgxW
         vc2jBtC9kkA2zWx2DO2W1uPqncHDpyPcoVNR/L81JBtbC7VKC6pHVgpZlOlrMcBk60iz
         Q/7HxZ/tnUvtQa6FYRveMA61QZoVOicc5KbzruxCGohmVsuYUDDDH5lFX5oQTVSfrZ36
         NNUx+0D0r06s6WeVuLxohaCGPrxVJD2pAGIwRhmlrlQtFlKemDUj6vat86N307pW+ETA
         GmMw==
X-Gm-Message-State: ABy/qLYqs1otZWP5UML9keK0dcHM4CiyRjcFy6YyuvElwvaPpq1y1jD/
        NiCSjcMb0lOE4PBk9nIXeWhjpw==
X-Google-Smtp-Source: APBJJlGjtUSJqd8h+Zb/CE+Xh78UucKPRFisLww89RC6rXJllK8itDyIS7FUg9WY3VrUtNqZvTdvVA==
X-Received: by 2002:a05:6a20:3d1e:b0:13d:17cc:5bca with SMTP id y30-20020a056a203d1e00b0013d17cc5bcamr9836125pzi.18.1690844773849;
        Mon, 31 Jul 2023 16:06:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a656a8d000000b0053051d50a48sm7858683pgu.79.2023.07.31.16.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:06:13 -0700 (PDT)
Date:   Mon, 31 Jul 2023 16:06:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH] wifi: brcmfmac: Fix field-spanning write in
 brcmf_scan_params_v2_to_v1()
Message-ID: <202307311605.706EEC44FD@keescook>
References: <20230729140500.27892-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729140500.27892-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Jul 29, 2023 at 04:05:00PM +0200, Hans de Goede wrote:
> Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
> a backtrace caused by the following field-spanning error:
> 
> memcpy: detected field-spanning write (size 120) of single field
>   "&params_le->channel_list[0]" at
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)
> 
> Fix this by replacing the channel_list[1] declaration at the end of
> the struct with a flexible array declaration.
> 
> Most users of struct brcmf_scan_params_le calculate the size to alloc
> using the size of the non flex-array part of the struct + needed extra
> space, so they do not care about sizeof(struct brcmf_scan_params_le).
> 
> brcmf_notify_escan_complete() however uses the struct on the stack,
> expecting there to be room for at least 1 entry in the channel-list
> to store the special -1 abort channel-id.
> 
> To make this work use an anonymous union with a padding member
> added + the actual channel_list flexible array.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me; it's consistent with how similar 1-element arrays
with sensitive structure sizes have been updated lately. Thanks for
the investigation!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
