Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E222B8901
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 01:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKSAVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 19:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKSAVK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 19:21:10 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6912C0613D6
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 16:21:10 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id l12so3749341ilo.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Nov 2020 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AssRh8wltYpwnLIMHdRyWzG/VTXz5aIhKwDWHkLnZe0=;
        b=IpsYh07mMmjA204ym64OUXzgMOlRPRhH3k+4dYGh3nSVLwQ0/nn/hEHoF0MhhaB7M/
         b1Qm5ZlMCrCmrO0jPj1LL0eEJeH1IKLTWpaG7ksbq/JQccqDUdYelGgtmTtMreYcBrWj
         YNj3uyt4gsk96kVYdcvufDbgqwZ6Gj4kU9ubw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AssRh8wltYpwnLIMHdRyWzG/VTXz5aIhKwDWHkLnZe0=;
        b=couV9fhYUvb9w0WMVW6QKOYnCCDfPko2xW4Dr1PXma6Pm+s7eqN7W8ZIng4Pljmtr0
         QG/XuUcco0335Sd/HN1+hAB+oCR569qIDYloIBH/q6B4F752jrLyUA6RaAiEgEqBkh5i
         NjhvjRszCsByi65Zz9Gzb48UYk1cr80VjvJLZHaNp5esIXPtoKTj2rtLecnAGHc8R20v
         FR9s/PbQH39OS2c0pMsInBvrEQHeZe4uABwA8/mfLxvHuT9sx4F46h2CIQ2WbK+7txwE
         MSnON8Zz/ah4inCxAoW4aABsziEme9uu6aaydajLBY6mc4Jq5XSUvBshNZETYmRcVLph
         D4VA==
X-Gm-Message-State: AOAM53081nwC47/gg2avuMaDUk2zpUgD26QHDCYXbKMPrj6OWoLsUjUv
        3qljpFKZud8U74Mv34WtfHpBmjKGDiI0s6vu2DTgdA==
X-Google-Smtp-Source: ABdhPJxf09B2xNeOqcg4M0cq77Grb3qdYe0wDLINSjLt2SvyZGjxeV3KWQsJHhFUeRqvakZ4c8efyZaemXiSiQS4O7k=
X-Received: by 2002:a92:c8c4:: with SMTP id c4mr19341540ilq.161.1605745270268;
 Wed, 18 Nov 2020 16:21:10 -0800 (PST)
MIME-Version: 1.0
References: <1605501291-23040-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1605501291-23040-1-git-send-email-pillair@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Wed, 18 Nov 2020 16:20:58 -0800
Message-ID: <CACTWRwvG=BqKAeJm18jAtMuah-=NyRPzAJMv-930eQtp+PBArw@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: Fix the parsing error in service available event
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

The patch LGTM there is small nit, though.
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5751,8 +5751,13 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
>                             ret);
>         }
>
> -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> -                              __le32_to_cpu(arg.service_map_ext_len));
> +       /*
> +        * Initialization of "arg.service_map_ext_valid" to ZERO is necessary
> +        * for the below logic to work.
> +        */

Nit: The comment will throw a checkpatch warning.  "networking block
comments don't use an empty /* line, use /* Comment..."

-Abhishek
