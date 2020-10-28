Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA829D946
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Oct 2020 23:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbgJ1Wue (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgJ1Wud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 18:50:33 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB459C0613CF
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 15:50:32 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id b34so186953uab.8
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X61PD0Eqa415e78dHBCu8gVP7gz9DiO/HA7a3ClV984=;
        b=NEOWjCOdoW+dKxV90REiSNshDKbdF16fZjphJCyW4sXCsrz9B1bTlOsgmoBmn5SiEj
         Ttg/Sbh7iyvA1URHLm7Yhnoeex0MgCqwY9HsUCdVIe+5eud+5/AjV+fgOBuFzWp9p1bY
         GHQw4cFWy+Exvei93CFPwEI3PCFpZ5owzNGTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X61PD0Eqa415e78dHBCu8gVP7gz9DiO/HA7a3ClV984=;
        b=Qpd6gxIiAGfeGlXxCPzAXUd4ybMwUZ4Dy5NMbGPADa5XIG9AWzuR3ODIwqy7IexURT
         a1NN2YGYHhRKz2M1m1smyaQOlizgwhqh2tUDklF/qrGcrTe/OEvwrXWz0HHaWa0rz8Ee
         3lF1F6V08bdLTGXBFTtRwN1aQ9jwT2yegocBfNIMAbgLoly7sGum9lR3j9qYKQGoB6BO
         iHJW82YuM0hCo6X9eQHaFTxjvhOeDroUu7ppNfuPgBK7zYhxyRyYVqJVdrbiOohZllw5
         pe0kzYOi+fSYUBLzvWvJAqnL72CSVz2Ln+JBa6mEaxto0OKjVt7bSZruknhxqwhp2lui
         tYPw==
X-Gm-Message-State: AOAM531xDxmQWTky6heVYT2tb/NlnV2fgFcBmgJCsmYcX8DOWIbmE/Lh
        9JQkf5XrTXAyOMXRasaky/BaeY9kIxv97A==
X-Google-Smtp-Source: ABdhPJxGxQSEn8SQjM0HuecOSyMpAvpnifyJbmjnLACgFXIZEHcLEpwsgdfl7eWXebKD++kRah8R/A==
X-Received: by 2002:a9f:2067:: with SMTP id 94mr728595uam.141.1603910701429;
        Wed, 28 Oct 2020 11:45:01 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id u133sm29212vku.4.2020.10.28.11.45.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 11:45:00 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id h5so123436vsp.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 11:45:00 -0700 (PDT)
X-Received: by 2002:a67:e3b9:: with SMTP id j25mr594499vsm.37.1603910699981;
 Wed, 28 Oct 2020 11:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Oct 2020 11:44:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Message-ID: <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service available event
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Wed, Oct 28, 2020 at 10:01 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> The wmi service available event has been
> extended to contain extra 128 bit for new services
> to be indicated by firmware.
>
> Currently the presence of any optional TLVs in
> the wmi service available event leads to a parsing
> error with the below error message:
> ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71
>
> The wmi service available event parsing should
> not return error for the newly added optional TLV.
> Fix this parsing for service available event message.
>
> Tested-on: WCN3990 hw1.0 SNOC
>
> Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT support")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
> Changes from v1:
> - Access service_map_ext only if this TLV was sent in service
>   available event.
> ---
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
>  drivers/net/wireless/ath/ath10k/wmi.c     | 5 +++--
>  drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index 932266d..7b58341 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -1401,13 +1401,15 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
>
>         switch (tag) {
>         case WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT:
> +               arg->service_map_ext_valid = true;
>                 arg->service_map_ext_len = *(__le32 *)ptr;
>                 arg->service_map_ext = ptr + sizeof(__le32);
>                 return 0;
>         default:
>                 break;
>         }
> -       return -EPROTO;
> +
> +       return 0;

I notice your v2 now returns 0 for _all_ unknown tags.  v1 just had a
special case for "WMI_TLV_TAG_FIRST_ARRAY_ENUM".  I don't have enough
experience with this driver to know which is better, but this change
wasn't mentioned in the changes from v1.  I guess you had a change of
heart and decided this way was better?


>  }
>
>  static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 1fa7107..2e4b561 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
>                             ret);
>         }
>
> -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> -                              __le32_to_cpu(arg.service_map_ext_len));
> +       if (arg.service_map_ext_valid)
> +               ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> +                                      __le32_to_cpu(arg.service_map_ext_len));

Your new patch still requires the caller to init the
"service_map_ext_valid" to false before calling, but I guess there's
not a whole lot more we can do because we might be parsing more than
one tag.  It does seem nice that at least we now have a validity bit
instead of just relying on a non-zero length to be valid.

It might be nice to have a comment saying that it's up to us to init
"arg.service_map_ext_valid" to false before calling
ath10k_wmi_pull_svc_avail(), but I won't insist.  Maybe that's obvious
to everyone but me...


-Doug
