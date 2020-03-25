Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35AF9191DD9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 01:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCYAEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 20:04:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46773 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCYAEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 20:04:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id q5so290316lfb.13
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8fbK5Bdp/jF6OWvA5CwZVk1CbwAuqs92/vtugfhmEE=;
        b=gnvAs4rE51QS6c0onBI6Zwh+/HJ2QkXs8xY+l2K73HC3OvVgncKIeWxAP8Uv9KlDhv
         DJzzWeTQ1AvsjK1gdva/Rmb5HgZOZaYMNzz8yGYw9gWSNO/ve/noq7OHFeoae0Gw7DyC
         J0w+rNsIwDkkbIkrGJ2v5afSo4Ezaeim5gYS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8fbK5Bdp/jF6OWvA5CwZVk1CbwAuqs92/vtugfhmEE=;
        b=drekDAfy+fJIsk/8LDiEWJWRMFPb+tkpEmrKnUWaEjltqJICm7M4NUemguULIHvkgQ
         ncazIvDg+f1gIgxMckDr3NXX0wTl9TLx2ZF7BV8rJ9Kz+GFtxok8qWPS2yBEdg5JuZV0
         re8bI8kxCU0PkmYv+QFm8bUXG0qh9EEgfTuDsw6w1rf07zGYQQQvgNw0OfbpPzrtzUrZ
         cJb60E25OJxuVGNlNoFnx5a/vkWhCOt1lKoM0UWk7IMFanLsBySnE35WwwtwH5ku3MGQ
         dpW7kCxpIXkTJKgkVTIElFZHFlK68aonbXlph/utuRytoH9ZIIAT4nbX0AxBdYBc6IZR
         yAgQ==
X-Gm-Message-State: ANhLgQ3BhZIpYm8zD85dPauRvzMobTjXaiSz5+bIOU1CXT4v+2fOZQaX
        oneCBmNUu0ZmWNOkXMnGJlTp99iL7mE=
X-Google-Smtp-Source: ADFU+vtmH9stTMyM7szmIoWagzytYHuw/JgTMKsGsIc4718H9C94oO+QJGSBaun3MBJY0p49FfOT/Q==
X-Received: by 2002:a19:6502:: with SMTP id z2mr359227lfb.47.1585094639564;
        Tue, 24 Mar 2020 17:03:59 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d4sm10603047lfa.75.2020.03.24.17.03.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 17:03:58 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id z23so307807lfh.8
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 17:03:58 -0700 (PDT)
X-Received: by 2002:a05:6512:2023:: with SMTP id s3mr356513lfs.121.1585094638250;
 Tue, 24 Mar 2020 17:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200313065114.23433-1-yhchuang@realtek.com> <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com> <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com> <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com> <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
In-Reply-To: <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 24 Mar 2020 17:03:46 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
Message-ID: <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ To be clear, I haven't asked for this debugfs knob, and as of now,
there is no plan for Chrome OS to use $subject feature. Per some of
Tony's descriptions, I suppose maybe this would be useful for certain
debugging scenarios, but only that -- no intention of wiring this up
"in production." IIUC, he CC'd me only because of the "measuring the
TX power" portion of the commit message. ]

On Fri, Mar 20, 2020 at 6:06 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> Brian can probably comment on this - I think ChromeOS (used to) use(s)
> some kind of fixed rate at the beginning of the connection to force low
> rates? But I also remember this interacting badly with some APs that
> just don't want to enable low rates at all...

Regarding how Chrome OS used NL80211_CMD_SET_TX_BITRATE_MASK: we used
to use this during authentication, association, DHCP, etc., until we
determined the connection was "established" -- the goal was to enforce
low (and ostensibly "more reliable") bitrates initially, so we get the
important stuff done, even in the presence of wacky rate control
algorithms. I understand this was actually added years ago mainly
because ath9k had poor rate control. Notably, this feature applies
(or, is supposed to apply) to both management and data frames.

As Johannes noted, masking off these rates caused problems of its own,
especially when APs (esp., guided by (mis?)guided I.T. admins who
think that low bitrates are evil) removed these low bitrates from
their SupportedRates field. Apparently these APs may start to reject
clients if they don't obey.

Additionally, we found no evidence that forcing low bitrates like this
was substantially helpful for anything other than older ath9k systems.
So longer story shorter, Chrome OS does not use
NL80211_CMD_SET_TX_BITRATE_MASK any more.

One is free to improve/extend the NL80211_CMD_SET_TX_BITRATE_MASK
command if desired, of course, but I think some of the earlier
complaints are valid (and line up with some of the problems I note
above): the use case for $subject does not necessarily involve setting
rates for management frames -- only data. One could always add extra
options to this command to reflect all the different ways this might
get used, but I'm not sure if that's worth it, for a feature that has
no non-debug use case.

One could also argue that, if iwlwifi already has a debugfs knob
(looks like rs_sta_dbgfs_scale_table_write()?), rtw88 should be able
to have one too ;)

Regards,
Brian
