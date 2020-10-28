Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CF29E1F6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 03:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbgJ2CEt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgJ1Vso (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 17:48:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A6C0613CF
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 14:48:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w11so280226pll.8
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 14:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FKhx870r+O+udSKu/8m8SAsZRC12Si58IDOFhUuhu8=;
        b=oFn4hf8+E5lFqfHFsv6RdFf3tapZc5eWM4HJlmFHZVp2oL3NV38xM1HyoimZxyRC8X
         UF+YfdfcSn6kpDtL7ntVwue4XJC8AvtQwEhB25kha9OA9lSXzc8z6yfMPxMZkFTn5M8t
         tgJUP6FYcZ3vF9fAIewsfHMW7qEYaUl1H9QJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FKhx870r+O+udSKu/8m8SAsZRC12Si58IDOFhUuhu8=;
        b=kpn1y6yclul67PL+jReu95Ry/+3MFOWUqj1aGCMLbK7JbF6GZG3ViMbS99+Vpqlrl6
         6lRJ7d7bYikeELNfn+cGqIEvxeuDnnRVbTFSR5Y56WgvrcxfmUK+wZ6l9Ow04V9U0WUF
         EfEggg2hRT0C6pqCRf6Hfg5RytjiE+p3M+hix7J4XAUXFr77fAO7+21zIHiDyfrBn70g
         bL12U9UqlVVstTrS1dtscsBWwR94jhcgxcUEABh27NZ8L3CZXLLKFVejOsdz3HmehJzF
         tlAB0V+SdEMEB4B7EJuNWvDYGX7f/95EbUI1/kjNguC34sF6DRps1UkKb4Qw0VRxOJ6E
         +6Ew==
X-Gm-Message-State: AOAM533fbBtwGh4WYNV2Je2HxBcv4/Ou6lzF8QEfKuKboORdE/YYoQ5O
        8zwo9IXXMeBfAHytgD4D5HxDG98dBaq3JA==
X-Google-Smtp-Source: ABdhPJy4YB45mrOO2Gu51/H+bGiITVYBVOPhLaH2vbXdn7an/B/u+sjHCYNBTJcpEd9UDwlH/BHwdQ==
X-Received: by 2002:a05:6102:3014:: with SMTP id s20mr5561503vsa.16.1603895847596;
        Wed, 28 Oct 2020 07:37:27 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id u185sm593287vke.14.2020.10.28.07.37.26
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id d19so2960795vso.10
        for <linux-wireless@vger.kernel.org>; Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr5590736vsp.34.1603895846114;
 Wed, 28 Oct 2020 07:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1603811067-23058-1-git-send-email-pillair@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Oct 2020 07:37:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
Message-ID: <CAD=FV=XRyeXcE93nZgOy+x5eWcHcKKwbJccuWFkx+cA8tEXwZQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix the parsing error in service available event
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

On Tue, Oct 27, 2020 at 8:20 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
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
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/wmi-tlv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> index 932266d..3b49e29 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
> @@ -1404,9 +1404,12 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
>                 arg->service_map_ext_len = *(__le32 *)ptr;
>                 arg->service_map_ext = ptr + sizeof(__le32);
>                 return 0;
> +       case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
> +               return 0;

This is at least slightly worrying to me.  If I were calling this
function, I'd expect that if I didn't get back an error that at least
"arg->service_map_ext_len" was filled in.  Seems like you should do:

case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
  arg->service_map_ext_len = 0;
  arg->service_map_ext = NULL;
  return 0;

...and maybe add a comment about why you're doing that?

At the moment things are working OK because
ath10k_wmi_event_service_available() happens to init the structure to
0 before calling with:

  struct wmi_svc_avail_ev_arg arg = {};

....but it doesn't seem like a great idea to rely on that.

That all being said, I'm just a drive-by reviewer and if everyone else
likes it the way it is, feel free to ignore my comments.

-Doug
