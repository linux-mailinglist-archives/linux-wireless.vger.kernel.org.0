Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC33B88BD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2019 02:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394527AbfITAwo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 20:52:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42381 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393910AbfITAwl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 20:52:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so5485116qkl.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiu7m8DUVWZxCoLUBSCJNA90YeclA/xM3wyYeZQULiE=;
        b=oeFGdk6HEZzwtPUIq/2Gsk2c4kXst0Qsqf7PRP+6xzgYwwVjM7riJud/oeBQFSGlFD
         iglEdfBLfUJ+90FLZSap4PHamyFAMKRZcRmNEngShJXeoFBzy3YrcA7wv7aJbeNK2IgH
         9XU1Gt+hPw8ktpTaBqac/bO4BhkLmZLFJnKhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiu7m8DUVWZxCoLUBSCJNA90YeclA/xM3wyYeZQULiE=;
        b=D871Dtf3TFcF2a413N0tbeICFbzLva64rQ+Oedzbx9dy5pDoAzFhP3sY0HjgfGkXPW
         vajHezrP2vpQ6gr6KC3NMA6eeAteETGZch1AVzZv7DB8dG7B6e5D9i2+49bUZDRX3lLe
         mo7xMBqXJTLLmrpxlVaSIWorVbiMJtnsBSNiwajsIt4Diw51jPssrzZr6xYSdf3x6/uJ
         1mGx8pH8lgdoxsZFRoYvcWE6Sc+f/r8/76y1hjLKQ2+8xaIdehHzAan6HdD5imNQS2Q1
         brhSnVyTA/9XroER0UePqyvoKXF3WDxQfBrcnHgicxFMjdv+Ogj62fw/l9TgVLuW0tWg
         l8ZQ==
X-Gm-Message-State: APjAAAWgW/nzJSVAupGmDuiIZACd4W7xaSLXJMM41bSsXs7Fko5uWEOD
        tsnrdFFyhgQ/oGVV1TDJRYWuzBqq9aEJ3A==
X-Google-Smtp-Source: APXvYqw3qHuwmGJKEw3fF0Es8C0vstz6YGE/XkovyWvZmU46eP6oziri4UOdn9fr2TKA+BUNvWLf7g==
X-Received: by 2002:a37:6dc7:: with SMTP id i190mr736012qkc.12.1568940759658;
        Thu, 19 Sep 2019 17:52:39 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id p7sm248654qkc.21.2019.09.19.17.52.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 17:52:38 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id w2so5523189qkf.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2019 17:52:38 -0700 (PDT)
X-Received: by 2002:a37:a00d:: with SMTP id j13mr732778qke.2.1568940757739;
 Thu, 19 Sep 2019 17:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <1534402113-14337-1-git-send-email-wgong@codeaurora.org>
 <20181114225910.GA220599@google.com> <CA+ASDXMh7vdfkA5jtJqWEU-g-4Ta5Xvy046zujyASZcESCGhAQ@mail.gmail.com>
 <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87woe5aehr.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 19 Sep 2019 17:52:26 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPaw0womrCF98zzUinMTYSxeanK0Rc-0kn56TBEWJ__5w@mail.gmail.com>
Message-ID: <CA+ASDXPaw0womrCF98zzUinMTYSxeanK0Rc-0kn56TBEWJ__5w@mail.gmail.com>
Subject: Re: [PATCH v3] ath10k: support NET_DETECT WoWLAN feature
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(I realize I replied to the v3, not the v4 which was merged.)

On Wed, Sep 18, 2019 at 7:03 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > Since Wen has once again suggested I use this patch in other forums,
> > I'll ping here to note:
> >
> > On Wed, Nov 14, 2018 at 2:59 PM Brian Norris <briannorris@chromium.org> wrote:
> >> You've introduced a regression in 4.20-rc1:
> >
> > This regression still survives in the latest tree. Is it fair to just
> > submit a revert?
>
> Your description about the problem from an earlier email:
>
>   "It seems like youre enabling SCHED_SCAN support? But you're not
>    adding the NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR feature flag.
>    So it puts us in a tough place on using randomization -- we either
>    can't trust the FEATURE flags, or else we can't use both SCHED_SCAN
>    and scan randomization."

Yeah, maybe I shouldn't have trimmed that context :)

> So essentially the problem is that with firmwares supporting both
> WMI_SERVICE_NLO and WMI_SERVICE_SPOOF_MAC_SUPPORT ath10k enables
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR, but
> NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR is not enabled which is
> inconsistent from user space point of view. Is my understanding correct?

Yes, that sounds about right.

> Wen, can you enable NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR? Does firmware
> support that?

I feel like I've asked him that privately, but asking here might not hurt :D

> If that's not possible, one workaround might to be to not enable
> NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR if firmware supports
> WMI_SERVICE_NLO, but of course that would suck big time.

Yeah, that would be strictly worse than the current situation I think.
SCAN_RANDOM_MAC_ADDRESS is a product requirement for us. At least
right now, it's possible I could teach a user space to just ignore
SCHED_SCAN if it doesn't support the appropriate randomization
features. (I don't want to have to do that, but at least it's
possible.)

Brian

> Here's the full context in case someone is interested:
>
> https://patchwork.kernel.org/patch/10567005/
