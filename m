Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872627CEF01
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 07:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjJSFaG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 01:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjJSFaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 01:30:05 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9516126
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 22:30:02 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b6f67c708eso369612241.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697693402; x=1698298202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0mvcPvIvt4s7DsmMbiMba2lJ7LM/I/Eni6xaPWBnwg=;
        b=fyH98DIrBmO5ZDaAUVbUO3nepKg84VxRukXgkwH3upZzmTgRAI+nfkI4/wZU+AQz5m
         fLmhgC5lUqHFZqpsMkUTOtIBDpfazTB7uG75IuOllfYyiJYrN6JxvCkiVyEmlyG1BkLy
         PD/UaT1BXnjN1RPcFOT07AD2GljWiWacq4O9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693402; x=1698298202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0mvcPvIvt4s7DsmMbiMba2lJ7LM/I/Eni6xaPWBnwg=;
        b=uFdEZ1gC+dGxOjjewujh88O2tZ8/NEY+B7IATaXVDTK3bAMiSHtmqI+zT8tmGcfiPx
         C69ZTvQwaS8kD30yc1zNbxwUJKzSozlEa5t8FxvFShINDZ7NrQjeONsG+9ziGulyAwu3
         ZjXfpaaWaP00modfQJzIf5htxAl6ZDfYsf4cZpMQ79kpMSQWznNxPkix8DKES/zxmykZ
         vgXhNleCeWv04ahvCtpiUgfr0oE1HMleyzShwkss3tmgDFeXHBihlUkKxMKIAa/DCYj6
         Dd7pl5HWOmE3kpRlRX+JV/QMjsV0jfOTQBcgbOzFQ0fN1rus6c0uMKxpDlhYIinn2dnS
         ub8w==
X-Gm-Message-State: AOJu0Yx7IbQz+Jz4v+isFII1vKqRdcmNvTLObBpsHCyw3u3cNvsIVS5s
        J3BpjKmgDgN5IrooLQ+7uq+myTHLC9eImoOkxwo=
X-Google-Smtp-Source: AGHT+IEEkDzb7D/U1yKCTmLgjtdMAkT4JE/72BxAR6yv2XxWiTwygG4utrN5hEGATrT6E8W+/ziAAQ==
X-Received: by 2002:a67:e14c:0:b0:458:729b:4ebc with SMTP id o12-20020a67e14c000000b00458729b4ebcmr867223vsl.16.1697693401905;
        Wed, 18 Oct 2023 22:30:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n5-20020a6563c5000000b0056b6d1ac949sm2193974pgv.13.2023.10.18.22.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:30:00 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:30:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: wl18xx: replace deprecated strncpy with strscpy
Message-ID: <202310182229.7B4E7394@keescook>
References: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 18, 2023 at 09:18:24PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
> the deliberate comment telling us as much. Furthermore, its only use is
> drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
> NUL-terminated since its used in scnprintf:
> 492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
> which is defined as:
> | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ...
> | #define DRIVER_STATE_PRINT(x, fmt)   \
> | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> | 			  #x " = " fmt "\n", wl->x))
> 
> We can also see that NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> The very fact that a plain-english comment had to be made alongside a
> manual NUL-byte assignment for such a simple purpose shows why strncpy
> is faulty. It has non-obvious behavior that has to be clarified every
> time it is used (and if it isn't then the reader suffers).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, a clear case for strscpy.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
