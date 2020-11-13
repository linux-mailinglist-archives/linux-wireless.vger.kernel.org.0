Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA71E2B28BA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 23:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKMWpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 17:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMWpw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 17:45:52 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2FFC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 14:45:52 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id s24so11361088ioj.13
        for <linux-wireless@vger.kernel.org>; Fri, 13 Nov 2020 14:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yTLjM8MNxOmmA1Uo6QUNupWMOa9HR4S+JIGXxBqkbs=;
        b=AX5SiQ+o7K61hNMLVUtiFtdpA0IWLMEOGUGYyz+gih9jJEFWqZzEDKZkBu13yeaxZn
         GKViDQ+hj1DfpRatFPWg3lJtkL4zUlopDtk9AReBMc9dUwmIMAH1mjr5Cnfvw/n+PTpM
         wMxu8bjezkyYL6okBVaSYugXOtwEayLrJMCsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yTLjM8MNxOmmA1Uo6QUNupWMOa9HR4S+JIGXxBqkbs=;
        b=gL5ScKwWBswHNn7WnswFPc+WRnc1LiLNLW51oYygSL7PqnrQcbi+Nie7Sgzn26NYPZ
         IvoZTNK9h89+RHFnCxp9O6oObvE+kdNLfAs3rEcL1YyJrIzxp2CRaK09Vjv3NTeLHucc
         gZY9knJ6dyvMTEVwciFYq2rBr3RXc8UNGMwMKvl2ABJLYPRoPWJThT2QlhxJB+MkAeD8
         o3QQqg/CIn3Ttwn6XGBlQe6Eo7C47zlLiEsKM5odwS9NTzDK025JzGnELGIaN3ypocO2
         hM449glHuDmLyJdT7rWH7UGZI0Zb46y8ToCx1CDiXUn/N3xgR5Ag1duTp3iJ4nlvk8th
         g/Kg==
X-Gm-Message-State: AOAM533sw2EUcqO9hjcwgL0nqywSXwq6X/+fjXGKGTwSV1yuAIcTIlQv
        GhSbCxFvGTMdMTjnfGc8YEI3OzRIwwTHASC37EM1Zg==
X-Google-Smtp-Source: ABdhPJzy5LZ4pe9Vm+6b33MKYhuHFGoz9umuFnkQ0Jf01LURlj7LXUmQHfbXFJUzKmMMiCgtH1/7zjd1WkIeeaM8qq0=
X-Received: by 2002:a5e:9e42:: with SMTP id j2mr1489086ioq.87.1605307551834;
 Fri, 13 Nov 2020 14:45:51 -0800 (PST)
MIME-Version: 1.0
References: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V0apTHaemMKvRx1HWLaO9ArC2t4ohfZ7-CthFz2NiA2A@mail.gmail.com> <87wnyzkkum.fsf@codeaurora.org>
In-Reply-To: <87wnyzkkum.fsf@codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Fri, 13 Nov 2020 14:45:41 -0800
Message-ID: <CACTWRwu4XeNhUTsKPa2S1hBJ2tawo4Jx5rVFuht4=Gi1WgOvsw@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: Fix the parsing error in service available event
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi All,

The V2 patch now has good comments and probably spinning off a new V3
might be a good idea. Here are a few comments to the discussion.

In response to Doug's comment
> case WMI_TLV_TAG_FIRST_ARRAY_ENUM:
>   arg->service_map_ext_len = 0;
>   arg->service_map_ext = NULL;
>   return 0;
Since the TLV messages are parsed iteratively for each tag, if
WMI_TLV_TAG_FIRST_ARRAY_ENUM this comes as the last TLV tag then this
might cause the map_len to be zero even if there is a valid tag like
WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT , so having a "valid" flag
seems to be a better and scalable approach.

> > The TLV TAG " WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT" is the first
> > and a mandatory TLV in the service available event. The subsequent
> > TLVs are optional ones and may or may not be present (based on FW
> > versions).
>
> From ath10k point of view never trust what the firmware sends you. Even
> if WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT is a mandatory TLV it
> might be missing for whatever reasons. The same is with buffer lengths
> etc and always confirm what you are receiving from the firmware.
>
Looks like the length for each tag is already being validated in
ath10k_wmi_tlv_iter() and would return error if the length does not
match against the wmi policy., so I think the tlv message validation
is already being done. Kalle, Is the expectation here is to do
anything additional ?

-Abhishek

On Thu, Nov 5, 2020 at 11:25 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> >>  static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
> >> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> >> index 1fa7107..2e4b561 100644
> >> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> >> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> >> @@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
> >>                             ret);
> >>         }
> >>
> >> -       ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> >> -                              __le32_to_cpu(arg.service_map_ext_len));
> >> +       if (arg.service_map_ext_valid)
> >> +               ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
> >> +                                      __le32_to_cpu(arg.service_map_ext_len));
> >
> > Your new patch still requires the caller to init the
> > "service_map_ext_valid" to false before calling, but I guess there's
> > not a whole lot more we can do because we might be parsing more than
> > one tag.  It does seem nice that at least we now have a validity bit
> > instead of just relying on a non-zero length to be valid.
> >
> > It might be nice to have a comment saying that it's up to us to init
> > "arg.service_map_ext_valid" to false before calling
> > ath10k_wmi_pull_svc_avail(), but I won't insist.  Maybe that's obvious
> > to everyone but me...
>
> It's not obvious to me either. Please add that comment.
>
> BTW, for some reason Doug's response didn't get to patchwork:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/1603904469-598-1-git-send-email-pillair@codeaurora.org/
>
> Though I do see it in linux-wireless, so most likely this was a
> temporary glitch in patchwork. But it's just worrisome as nowadays I
> only check the comments in patchwork before I apply the patch.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
