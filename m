Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F33C19205D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 06:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgCYFQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 01:16:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46577 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 01:16:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id v16so1044512ljk.13
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 22:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOtnnGLP8BipaAze8V87q8XeZApQmF75SeBJ0qM73Z0=;
        b=QuhbA6nPAl+qc9oOk4qMaIKsDY4x8GN1kQ++ipsopE5YvFOXAzk+4xsxsHAiJc4l9X
         eTgeIdGIyFtEp2ChzoKHN5Tm431OJTMIWUDvAwCDsbafYqLgfMlaJKrJah4xqn75OrDA
         Cvve/E5+oNOmCG0nPuRAWgopD5Z5yx+AieGVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOtnnGLP8BipaAze8V87q8XeZApQmF75SeBJ0qM73Z0=;
        b=YprjNhPCRcscsEbzyNYUi21MB+KgxuqQG9iIySy1bcI5vjGfxLSOccfAuNjqQ3wG8v
         5W9Ud6L+WvFf305xrv3/PLE9QfstbfxkT6+OFYGqLhdHQIFWSIGcWJltW/gXP1LzOg4p
         7c0XNrFc0OAchbYTqZnIJ3/NL9ka3moUPSchu24x4y1MjpPtsTEovM/utB++7r8js9dA
         a9ASR9ZHx6pSEVPcaoIYQGneJKTLRAiZHnCuB+m7VY0AMkN9FLONE1lwH0o5XMFR4mKC
         iJLW1QxxreI7yAoH49Z3ebbuHmOofwvBc1Op4EXj03bpaUi2I7qP5qMzi1mhbeXUn4NE
         cp5Q==
X-Gm-Message-State: AGi0PuYTMbJtBvmWcibiv4vUTfj5C/to/tMpCZqEAzPYrzQ1ET6abzcR
        APl46nBXgRP13qh+T6OJV+9uCY4qopw=
X-Google-Smtp-Source: ADFU+vuENETqb7D25LiC/JRZ+F7/bwskJsUvWd9CyC+BkTZDv7rUImtImxtos3YL4EBSaBw3/O9qlg==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr376337ljc.203.1585113400482;
        Tue, 24 Mar 2020 22:16:40 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q10sm1357262lfa.29.2020.03.24.22.16.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 22:16:39 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j11so719833lfg.4
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2020 22:16:39 -0700 (PDT)
X-Received: by 2002:a05:6512:203c:: with SMTP id s28mr997374lfs.49.1585113399024;
 Tue, 24 Mar 2020 22:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200313065114.23433-1-yhchuang@realtek.com> <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com> <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com> <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com> <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com> <3894907ca6bf4566b8716731492a869b@realtek.com>
In-Reply-To: <3894907ca6bf4566b8716731492a869b@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 24 Mar 2020 22:16:27 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
Message-ID: <CA+ASDXMi8BqccHdVXVXb0JOj4y0vcFBGdL6BB0YuzB78qzgQuQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: add debugfs to fix tx rate
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 24, 2020 at 7:55 PM Tony Chuang <yhchuang@realtek.com> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> We want to measure the TX power, and the equipment just cannot
> detect the signal on some rates, unless we "fix" the rate exactly.

I think we all understand this now.

> So NL80211_CMD_SET_TX_BITRATE_MASK is not so useful for us
> sometimes.

I'm not sure if you have directly explained why this is the case. See
your comment earlier:

"This command just mask out some of rates that are not allowed."

Sure, but if you mask out all but 1 bitrate...voila! A fixed rate!

And this:

"But actually the firmware has its own rate
adaptive mechanism, so mask out the other rates does not mean the rate
left will be chosen."

That's entirely your fault, not the fault of the API. If your firmware
doesn't listen to your driver, then that's either your firmware or
your driver's fault. If you set a mask that has exactly 1 bitrate in
it... well, that's exactly what you should tell your firmware to do.
Not, "use this 1 bitrate, but try something else if you feel like it."

Now, there are other problems, like the others that Ben mentioned: the
rest of the mac80211 framework doesn't like it too much if you really
disable all but 1 rate (arguably a mac80211 bug -- but not a nl80211
bug); or maybe you want to differentiate management frames and data
frames (and that's not what the current
NL80211_CMD_SET_TX_BITRATE_MASK allows for).

I'm still not (personally) expecting that you *must* do this all via
the existing CMD_SET_TX_BITRATE_MASK, but to satisfy everyone involved
here, you at least need to be clear about why you aren't.

Regards,
Brian
