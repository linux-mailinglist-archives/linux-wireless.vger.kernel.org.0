Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0725113066
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 18:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfLDRCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 12:02:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39127 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDRCm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 12:02:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id v93so65599pjb.6
        for <linux-wireless@vger.kernel.org>; Wed, 04 Dec 2019 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eu3IyJHMQvuKhJZsYp2g7JJil3jVEh0AYfjqL0o1IiE=;
        b=QmoH0UexrWMCC1IIRTlz1PwJWQ6h2dxtiUk7KvO3NzCeEmPQZo3S3GKwDDa6xuwAso
         ZamUti0ojZ3jtqWW1PT1k+GCtau2iCzY1JRJUI0N8JxzE1f+lOz6PBNx/rzMdlcinqBu
         1FTP8v36bHZVo/GlZYEGqdFxUWCYxHdxSBbOLJd/LUD/6raGJRBjaqyKOaUD5jl4EJJ/
         LcOJkKnLuCMX9N2XsR2bssttYgqtw8euGbU2mPp3gb7dtbXQoKEwXT2/WxxVMFAVyV+Z
         eipg2msnalCwO17Uhru4JhR0Q+VWryVf0Dh0SAwjZ4ITsQPp8csF1Co1ivCPwxes6CcB
         qn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eu3IyJHMQvuKhJZsYp2g7JJil3jVEh0AYfjqL0o1IiE=;
        b=heJtCO13Q1u4m+pJ2ziQGB6jr8eW3r6N8xl++G9cGy7vcSV4syVM8s4pIP0/6LtGu3
         EFvUNBcZ4Stc6Z1nSqm7Hg4upxVZ+ADwuJWM7A7WfyQtv4Sf3E9ZQENMQkHeXYU5VD5F
         ZSnJfsKSKMejnCLBVlEdPc9LuHWQGP4rr6LJXhBODVwyhHB10Sgz2nthTG8+Fgv7g41J
         vwzaSpcWbJ3A1+Gyqt0efJqP0x1gCaiT+UmWOtA0q/u3fsaBd+qkJKO9PuguelFs+wNN
         9qiMEqOdpwUm/Kx90t9AtQOImsAvwluaY+36xNuCCIzmDzZe0ZWxXzN5d9dQoxHPAmnJ
         xkZA==
X-Gm-Message-State: APjAAAUYmA0Dqi7fL8dEdWumRaqPIp9Jn1cLYgdvwnsPO5YMdx5+/wvh
        cKlZgl+9TgYUhEMJELNxMtf3ieoBcIEE6F2a1lEO+w==
X-Google-Smtp-Source: APXvYqzrNQd3LocGGri7/gY6Hv0QqlU+RA0bb+qoQL4Gk6NCjiROT8Lilv2qq9FysgmHO6jzOSBR6S18uymGHTubEZg=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr4270989pjy.123.1575478961561;
 Wed, 04 Dec 2019 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20191204081307.138765-1-pihsun@chromium.org>
In-Reply-To: <20191204081307.138765-1-pihsun@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Dec 2019 09:02:30 -0800
Message-ID: <CAKwvOdnLxXeGYfEL+fgVts3cW71gMsP42mysQYtKse_STUErzQ@mail.gmail.com>
Subject: Re: [PATCH v2] wireless: Use offsetof instead of custom macro.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 4, 2019 at 12:13 AM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Use offsetof to calculate offset of a field to take advantage of
> compiler built-in version when possible, and avoid UBSAN warning when
> compiling with Clang:
>
> ==================================================================
> UBSAN: Undefined behaviour in net/wireless/wext-core.c:525:14
> member access within null pointer of type 'struct iw_point'
> CPU: 3 PID: 165 Comm: kworker/u16:3 Tainted: G S      W         4.19.23 #43
> Workqueue: cfg80211 __cfg80211_scan_done [cfg80211]
> Call trace:
>  dump_backtrace+0x0/0x194
>  show_stack+0x20/0x2c
>  __dump_stack+0x20/0x28
>  dump_stack+0x70/0x94
>  ubsan_epilogue+0x14/0x44
>  ubsan_type_mismatch_common+0xf4/0xfc
>  __ubsan_handle_type_mismatch_v1+0x34/0x54
>  wireless_send_event+0x3cc/0x470
>  ___cfg80211_scan_done+0x13c/0x220 [cfg80211]
>  __cfg80211_scan_done+0x28/0x34 [cfg80211]
>  process_one_work+0x170/0x35c
>  worker_thread+0x254/0x380
>  kthread+0x13c/0x158
>  ret_from_fork+0x10/0x18
> ===================================================================
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>
> Change since v1:
>  * Add #include <stddef.h>

Thanks for following up on the feedback.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
>  include/uapi/linux/wireless.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> index 86eca3208b6b..a2c006a364e0 100644
> --- a/include/uapi/linux/wireless.h
> +++ b/include/uapi/linux/wireless.h
> @@ -74,6 +74,8 @@
>  #include <linux/socket.h>              /* for "struct sockaddr" et al  */
>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */
>
> +#include <stddef.h>                     /* for offsetof */
> +
>  /***************************** VERSION *****************************/
>  /*
>   * This constant is used to know the availability of the wireless
> @@ -1090,8 +1092,7 @@ struct iw_event {
>  /* iw_point events are special. First, the payload (extra data) come at
>   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
>   * we omit the pointer, so start at an offset. */
> -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> -                         (char *) NULL)
> +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
>  #define IW_EV_POINT_LEN        (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
>                          IW_EV_POINT_OFF)
>
>
> base-commit: c5db92909beddadddb705b92d3388ea50b01e1a2
> --
> 2.24.0.393.g34dc348eaf-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191204081307.138765-1-pihsun%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
