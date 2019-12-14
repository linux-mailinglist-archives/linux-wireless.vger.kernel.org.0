Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1911F2B9
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2019 17:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNQBt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Dec 2019 11:01:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45194 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfLNQBt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Dec 2019 11:01:49 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3055608otp.12
        for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2019 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5n26h5aUGynjAqQqkXs+oOQEbeY7Busq7aVKwZv934=;
        b=ODeXure6jQF/dq3PW1o9+jB3aEO0KJwMWTteksoKCh0yRp8GbygEpVabOYcB+IUfhG
         14lox5LNc8rvyY+84+Ca/HuKoMmghzfqai+GI5ouKEp5dWTKeLSW5EctgTdiGss1JBNh
         Ak7CaWvDcuoNrVcMIt1XT1wvrhVguQUSErevTkoWudsxSC/m5kTHa3P3hLDfAImr/9Yk
         D8V18JwqAxXFCm3qr4eLwiSaFhbJL7hy5oYhtbOT4TnkAehE5TqP8iJKJWQYet4U7g4K
         U9417WAZstehJf5N7r6TUzb5xZDUn0HpfHHbXPxxvQWTCTsvbPZcufkSEkzARLP+YkEY
         Iy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5n26h5aUGynjAqQqkXs+oOQEbeY7Busq7aVKwZv934=;
        b=ejyyVBE71JQ20PnkGASHZz5dbrpLF4p6Q1c556Sls+pR/2dsSuuzwal6E7j91nj9h7
         fCv+WGxi4sXtQSjhEsjKmq6QdgPAug4SX56c+LWBnVYrIKLg8ryzNWo2t6uVsJ/Ao7tq
         nMu5OUx6/7Ajca+rzRkhEos3FuVEFFevBG6lOyB7MflLUno3p+Ncp3sXKW/cr1APHM3S
         RFhHnjP3UUUAKnynfnHVYEqne5B/ITQT7cHz07v2nMl2t7YjFvyRbeLkXejHPEvIhDWL
         OPpKG+HX2xyp7XPR14AzGBh6Q1yVco/aoSJtBTTwOXUpNuHaII8L+LybU8sq60An0I+6
         35jA==
X-Gm-Message-State: APjAAAW4mEp91oqlkqyUfDVsTTpuZKBUHtTvfGO8rbmPZUQ3IARGEz5Z
        qIL7fkEPKrLecmqL8K86WihBEvXvubNlKPZPf0A=
X-Google-Smtp-Source: APXvYqz+H/j/TFBlFdrIIgynXYxj+oOM32TkJIpVcK9KgF3QxZVmQoV31wWAW+azEY9okJhHTF2/7JXaOXxRQchrkH4=
X-Received: by 2002:a9d:6b03:: with SMTP id g3mr1132014otp.200.1576339308565;
 Sat, 14 Dec 2019 08:01:48 -0800 (PST)
MIME-Version: 1.0
References: <0101016eaadee57a-54500c6d-4751-423f-8bab-5acd8fad2175-000000@us-west-2.amazonses.com>
 <0101016eb61d9520-b0306a23-c9b9-4b57-b708-9f80ac47eef1-000000@us-west-2.amazonses.com>
 <CAMrEMU-VOYeHO2F5AjyWJLqgEVq5HOUHZkMJqGio1qovFPo8ug@mail.gmail.com> <b5404ac0-1be1-229f-a9e3-8033cdf7eea9@candelatech.com>
In-Reply-To: <b5404ac0-1be1-229f-a9e3-8033cdf7eea9@candelatech.com>
From:   Justin Capella <justincapella@gmail.com>
Date:   Sat, 14 Dec 2019 08:01:33 -0800
Message-ID: <CAMrEMU_2D9KzPudqVEMv-JS73JZD=hrmtf4drk41Hd1zOqS2dw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
To:     Ben Greear <greearb@candelatech.com>,
        Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If you have time to spare I'd be interested in hearing a little more
about your stances on this... I'm trying to learn more about this
stuff and not at all qualified to say one way or the other if it is a
good idea, but my intuition is this is going to lead to inconsistent
state/behaviors. I have been wondering if maybe this change may be
related to some of the fw crash reports coming in--- perhaps marking
the station as authorized before the fw is fully started and/or the
device is present

On Mon, Dec 2, 2019 at 10:17 AM Ben Greear <greearb@candelatech.com> wrote:
>
> On 12/1/19 8:45 PM, Justin Capella wrote:
> > Are there security concerns here? Was the peer known to be authorized
> > beforehand? Would it be better to just trash the peer in the event of
> > a fw crash?
>
> I think you should completely re-associate the peer(s) when firmware
> crashes.  The driver does not cache all possible changes, so it cannot
> exactly rebuild the config to the previous state.
>
> Thanks,
> Ben
>
> >
> > On Thu, Nov 28, 2019 at 11:46 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >>> After the firmware crashes ath10k recovers via ieee80211_reconfig(),
> >>> which eventually leads to firmware configuration and including the
> >>> encryption keys. However, because there is no new auth/assoc and
> >>> 4-way-handshake, and firmware set the authorize flag after
> >>> 4-way-handshake, so the authorize flag in firmware is not set in
> >>> firmware without 4-way-handshake. This will lead to a failure of data
> >>> transmission after recovery done when using encrypted connections like
> >>> WPA-PSK. Set authorize flag after installing keys to firmware will fix
> >>> the issue.
> >>>
> >>> This was noticed by testing firmware crashing using simulate_fw_crash
> >>> debugfs file.
> >>>
> >>> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> >>>
> >>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> >>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >>
> >> Patch applied to ath-next branch of ath.git, thanks.
> >>
> >> 382e51c139ef ath10k: set WMI_PEER_AUTHORIZE after a firmware crash
> >>
> >> --
> >> https://patchwork.kernel.org/patch/11263357/
> >>
> >> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> >>
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
