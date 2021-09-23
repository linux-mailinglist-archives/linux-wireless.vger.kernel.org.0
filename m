Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94F415C1A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhIWKl3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhIWKl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 06:41:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B19C061574
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 03:39:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id me1so4131981pjb.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Sep 2021 03:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0l5Qjk10ns9RTcZCx62S0Ghtn1+O62O0rQJz+8Rhm0I=;
        b=n8Wqw2WAmNvR3Tfi0IN+hvY9FiUzaOcCcnnXcLK89WtSIR7TucrqCxR1kymTRGKzwU
         2lTZq5gtLAKlj0ciNizxwCSSFk5at9MDpjkx7Zix2Wa70HQjvjPKCaiNqDykmbEoH+0V
         IFOyuUukiqSdgrTjdg5IWPbFKSQ9W6cyN4e8+E4K/su0afRI2cG12hJwBSKbkVlH/luA
         xC/qtUiLMECJ+SayzxbbsghqViDuQL2G7P/zthFDVFRmsOBAMDOQXUWKleB7Cgz9AnLm
         OO587hdDoTtG1l4kyieL5kdJFDw37yZx5NO2SV7BHVc7DxaXCx2jf6CJWV259SyveSK6
         WMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0l5Qjk10ns9RTcZCx62S0Ghtn1+O62O0rQJz+8Rhm0I=;
        b=6HQRIGzPwKyXYlD2+NO5NSl5tFKZJa8UrMmrpxiQ+So9cbveuPtLuqN069WG7epl6c
         jvST45UnIZxyC3IxoW0rK1g2kNlB479Qx0Q3X8cshpifPe0tjE6pXiNtB59hQJRvm6Ma
         O/+Wtg3qtfGBeAS6YmcbLvSsD6goDroyjcWwPn3XPdhihOhPT4unrjZc9OBiQTgpcjAk
         3EEfHP2aLB1h+cMuffZySjwav4zBfJMey3G4VMoQhXRbZReC5TgdMhNOehjpneX/1Qit
         SauQS099Xx13iyofROJKhUJ65XRyUFDkHB1MJD0okB7BjaQ+UmFnCjdb9WYzCzl4RQ9r
         ushg==
X-Gm-Message-State: AOAM530AiX7kPTzcKxVaOE2DhDW4mamW9uJgeK948W/BoDGMnak7DM0s
        U7uATLBQ1AQrpASXeTQNduhckbJpkKh/AbfNEXRIwg==
X-Google-Smtp-Source: ABdhPJzkbgNlQdn54hfS6ArGL5SRw53Cv7Fuq/8iSKoYVDZpajH5rCyoTEjEMX9HaJM31dUcaJsRWZRXBwZKT3o3JOw=
X-Received: by 2002:a17:90b:4a88:: with SMTP id lp8mr4495426pjb.159.1632393597263;
 Thu, 23 Sep 2021 03:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <871r5p0x2u.fsf@codeaurora.org> <CAMZdPi8UJLvBFQd8-nf-iHAQh8cEuihq97PUFfZ7Q=rxRQoPsg@mail.gmail.com>
 <20210916111218.GA12918@thinkpad> <CAMZdPi94607mZorp+Zmkw3seWXak6p9Jr05CQ5hhfgKQoG8n7Q@mail.gmail.com>
 <20210916163529.GA9027@thinkpad> <87k0jgxyjp.fsf@codeaurora.org>
 <20210916171927.GB9027@thinkpad> <b7c0906041dcafb43be215bd4f55326a@codeaurora.org>
 <20210923085926.GD6083@thinkpad> <6912b6840858c0554922c01a0f9c47b8@codeaurora.org>
In-Reply-To: <6912b6840858c0554922c01a0f9c47b8@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 23 Sep 2021 12:50:08 +0200
Message-ID: <CAMZdPi-3WOj_TT7diUJJ00RaoHgKw-tu-heQJu6vDUK1yZ4CZg@mail.gmail.com>
Subject: Re: [regression] mhi: ath11k resume fails on some devices
To:     Carl Huang <cjhuang@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        ath11k@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Carl and Kalle,

On Thu, 23 Sept 2021 at 11:26, Carl Huang <cjhuang@codeaurora.org> wrote:
>
> On 2021-09-23 16:59, Manivannan Sadhasivam wrote:
> > On Thu, Sep 23, 2021 at 04:34:43PM +0800, Carl Huang wrote:
> >> On 2021-09-17 01:19, Manivannan Sadhasivam wrote:
> >> > On Thu, Sep 16, 2021 at 07:42:02PM +0300, Kalle Valo wrote:
> >> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> >> > >
> >> > > > On Thu, Sep 16, 2021 at 01:18:22PM +0200, Loic Poulain wrote:
> >> > > >> Le jeu. 16 sept. 2021 =C3=A0 13:12, Manivannan Sadhasivam <
> >> > > >> manivannan.sadhasivam@linaro.org> a =C3=A9crit :
> >> > > >>
> >> > > >
> >> > > > [...]
> >> > > >
> >> > > >> > If things seems to work fine without that patch, then it impl=
ies that
> >> > > >> > setting M0
> >> > > >> > state works during resume. I think we should just revert that=
 patch.
> >> > > >> >
> >> > > >> > Loic, did that patch fix any issue for you or it was a cosmet=
ic fix only?
> >> > > >>
> >> > > >>
> >> > > >> It fixes sdx modem resuming issue, without that we don=E2=80=99=
t know modem needs
> >> > > >> to be reinitialized.
> >> > > >>
> >> > > >
> >> > > > Okay. Then in that case, the recovery mechanism has to be added =
to the ath11k
> >> > > > MHI controller.
> >> > >
> >> > > What does that mean in practise, do you have any pointers or
> >> > > examples? I
> >> > > have no clue what you are proposing :)
> >> > >
> >> >
> >> > Take a look at the mhi_pci_recovery_work() function below:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/bus/mhi/pci_generic.c#n610
> >> >
> >> > You need to implement something similar that basically powers up the=
 MHI
> >> > endpoint (QCA6390) in case pm_resume() fails. At minimum, you need t=
o
> >> > call
> >> > below functions:
> >> >
> >> > # Check if the device is powered on. If yes, then power it down to b=
ring
> >> > it back
> >> > mhi_power_down()
> >> > mhi_unprepare_after_power_down()
> >> >
> >> > # Power up the device
> >> > mhi_prepare_for_power_up()
> >> > mhi_sync_power_up()
> >> >
> >> > This implies that the WLAN device has been powered off during suspen=
d,
> >> > so the
> >> > resume fails and we are bringing the device back to working state.
> >> >
> >> This is fine for platform which doesn't provide power supply during
> >> suspend.
> >> But NUC has power supply in suspend state.
> >
> > If NUC retains power supply during suspend then it should work with
> > that commit.
> > During resume, the device is expected to be in M3 state and that's what
> > the
> > commit verifies.
> >
> > If the device is in a different state, then most likely the device have
> > power
> > cycled.
> >
> But the tricky thing here is that upstream QCA6390 doesn't have recovery
> mechanism to download
> firmware again, so QCA6390 has no way to work after a power cycle.

Maybe a simple quick-fix would be to add a 'force' parameter to the
mhi resume function and discard state testing in case it is forced,
that would allow both ath11k and modem to work for now. Then
investigating what happens on ath11k side.

Thoughts?

Regards,
Loic
