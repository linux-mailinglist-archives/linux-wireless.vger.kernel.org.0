Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FDD299322
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Oct 2020 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786783AbgJZQ6I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Oct 2020 12:58:08 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46190 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786738AbgJZQ5e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Oct 2020 12:57:34 -0400
Received: by mail-vs1-f65.google.com with SMTP id s6so5110378vss.13
        for <linux-wireless@vger.kernel.org>; Mon, 26 Oct 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U0IxDbw9xkqiRVjMXASTPx8jLKp0WDhukG7QJqTfdjM=;
        b=RfB8rPwjTA8vs3E4K0ZnlkEs3pC7qo0cqceU3vJpfmcdf24Z+E6Jt+ETsXZSJjcxjR
         UR0TOtj/NLEDWilkee0H9Mb787VHCc9Ab+boZIUrhzTLGIzGyCbOF5zjB0vKMlewdEMK
         u0gLdIqrEwDC+kXzOwdV3BKPuCS4qMO2hVNOftHYqDeIBwkkMPVCbg9eSMUl41wBN1Dk
         POy3ShUIQtOQUbcjNwTfQIarlS4x679gUxlein935yq0X22uDWo6f92fGAl0rsyArYwl
         XoeJngjPMZ4l5G0jOkIPxUFFlL0AtqNuzoIsQQFiIa+fkw2k6BZeIDMTDQfHqDIwyVi9
         oHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U0IxDbw9xkqiRVjMXASTPx8jLKp0WDhukG7QJqTfdjM=;
        b=C0/TndPPdNwBKLzbGzdSvL8DEfbZiNIywavo/P8bZUlEVNKMv0fMjWYcDjYRcMiVkm
         uk0kcL+M3ZiPKFHnk0djZLvvDTxkTUq05nqYjjYVAb6udT4yvUNYdyMOSCYg8QIo+ZeK
         wf1Qvx950+CpugbxwOi3gHu6YZIM8PZr54C+KXXxgxeSJpqHCfePoaw4UlrZe2VGmNHA
         bjusEzDuCSVr7ERobf8BsEYgLwEH7/r3JSGv+T/3gBc7E6Bpqt24+CCR8V+96TID7mzD
         n4p15qGMpTQHtxIUcIOBEsSzGYWw4s2GU9XUYMqQiMQeFb15H1YCM0Fxb8KHzqMLaOwJ
         sK+g==
X-Gm-Message-State: AOAM533aJJ2JF+LdrImgiJKIvF4nKUAfOAXs8CWxDeTqBfxUSzt9wkaq
        kUn/ZRrRjwDPDjwoV4VqjrS7n26DWB4=
X-Google-Smtp-Source: ABdhPJx8YHz0RSq3o3jcQ/4VbJWWJgczhACRBWlKSC0YqfnWZm49BhW89eExBw4tsYYQJ6AXZcC41g==
X-Received: by 2002:a67:f919:: with SMTP id t25mr15599754vsq.10.1603731451298;
        Mon, 26 Oct 2020 09:57:31 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id h12sm252623vsg.23.2020.10.26.09.57.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 09:57:30 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id b4so3127410vsd.4
        for <linux-wireless@vger.kernel.org>; Mon, 26 Oct 2020 09:57:29 -0700 (PDT)
X-Received: by 2002:a67:b607:: with SMTP id d7mr19582090vsm.28.1603731449199;
 Mon, 26 Oct 2020 09:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201026150851.528148-1-aleksandrnogikh@gmail.com> <20201026150851.528148-3-aleksandrnogikh@gmail.com>
In-Reply-To: <20201026150851.528148-3-aleksandrnogikh@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 26 Oct 2020 12:56:52 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
Message-ID: <CA+FuTSeR5n4xSpzMxAYX=kyy0aJYz52FVR=EjqK8_-LVqcqpXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: add kcov handle to skb extensions
To:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 26, 2020 at 11:11 AM Aleksandr Nogikh
<aleksandrnogikh@gmail.com> wrote:
>
> From: Aleksandr Nogikh <nogikh@google.com>
>
> Remote KCOV coverage collection enables coverage-guided fuzzing of the
> code that is not reachable during normal system call execution. It is
> especially helpful for fuzzing networking subsystems, where it is
> common to perform packet handling in separate work queues even for the
> packets that originated directly from the user space.
>
> Enable coverage-guided frame injection by adding kcov remote handle to
> skb extensions. Default initialization in __alloc_skb and
> __build_skb_around ensures that no socket buffer that was generated
> during a system call will be missed.
>
> Code that is of interest and that performs packet processing should be
> annotated with kcov_remote_start()/kcov_remote_stop().
>
> An alternative approach is to determine kcov_handle solely on the
> basis of the device/interface that received the specific socket
> buffer. However, in this case it would be impossible to distinguish
> between packets that originated during normal background network
> processes or were intentionally injected from the user space.
>
> Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
> --
> v2 -> v3:
> * Reimplemented this change. Now kcov handle is added to skb
> extensions instead of sk_buff.
> v1 -> v2:
> * Updated the commit message.
> ---
>  include/linux/skbuff.h | 31 +++++++++++++++++++++++++++++++
>  net/core/skbuff.c      | 11 +++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a828cf99c521..b63d90faa8e9 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4150,6 +4150,9 @@ enum skb_ext_id {
>  #endif
>  #if IS_ENABLED(CONFIG_MPTCP)
>         SKB_EXT_MPTCP,
> +#endif
> +#if IS_ENABLED(CONFIG_KCOV)
> +       SKB_EXT_KCOV_HANDLE,
>  #endif
>         SKB_EXT_NUM, /* must be last */
>  };
> @@ -4605,5 +4608,33 @@ static inline void skb_reset_redirect(struct sk_buff *skb)
>  #endif
>  }
>
> +#ifdef CONFIG_KCOV
> +
> +static inline void skb_set_kcov_handle(struct sk_buff *skb, const u64 kcov_handle)
> +{
> +       /* No reason to allocate skb extensions to set kcov_handle if kcov_handle is 0. */

If the handle does not need to be set if zero, why then set it if the
skb has extensions?

> +       if (skb_has_extensions(skb) || kcov_handle) {
> +               u64 *kcov_handle_ptr = skb_ext_add(skb, SKB_EXT_KCOV_HANDLE);

skb_ext_add and skb_ext_find are not defined unless CONFIG_SKB_EXTENSIONS.

Perhaps CONFIG_KCOV should be made to select that?




> +
> +               if (kcov_handle_ptr)
> +                       *kcov_handle_ptr = kcov_handle;
> +       }
> +}
> +
> +static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
> +{
> +       u64 *kcov_handle = skb_ext_find(skb, SKB_EXT_KCOV_HANDLE);
> +
> +       return kcov_handle ? *kcov_handle : 0;
> +}
> +
> +#else
> +
> +static inline void skb_set_kcov_handle(struct sk_buff *skb, const u64 kcov_handle) { }
> +
> +static inline u64 skb_get_kcov_handle(struct sk_buff *skb) { return 0; }
> +
> +#endif /* CONFIG_KCOV */
