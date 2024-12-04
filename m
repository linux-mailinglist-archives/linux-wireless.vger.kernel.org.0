Return-Path: <linux-wireless+bounces-15870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DA9E30D7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 02:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFF3164A13
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D226134D4;
	Wed,  4 Dec 2024 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ky2dgD8H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9F53BE
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276355; cv=none; b=VwPzrx7NY8WdUohPCX6HKqLS8saGAAFuXbN/W+WQSWXu2R8Wh2Wm3oXSVGJSMsATwBQFpw3lq+2qQaAF2QGBZaHRjhyb9U9FzKswWMAL5Z8DV2UAucYX5lsLuALSuYWBPtVLujGttRJzK03YzcaXla+XCMrZvAW741cwnr+fEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276355; c=relaxed/simple;
	bh=hygQY0yKQ7ebOPH3ZBiF/8PChlQAh2LojF0r9bBmdmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phoo4a1XJiuYez/HYhox8AdR9q2I5+8DvFedyYxrCa8lgGsFS41PnLc1fDIC24iiGBISZ3qaPBurJYFcJ8MeZLWf20Zi6AvAE0FvxsWqGO5wzy4/gPhE0RDPrDN/K1l6i8qfr7vl5ePianEC6QrywWGW6zoAjS1nZZ1Q0Q+fl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ky2dgD8H; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so64908921fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2024 17:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733276349; x=1733881149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5142+FxMWvJf+y1zYJc4iuIT592XegYtM+E1mlyFIrI=;
        b=Ky2dgD8HjVGlwDF0Zc06Q/ffmu/NySVwfIeGn30+2La9WHr85eIvQF1jqy0d/2AtiW
         7jrugJTVl3J9DTnuUAgV1kpWcqQwVkL125Iwh8HFTPB1DjaDUv7wNz+RtXQ5fkjsRgRq
         Pb1TeqaKJ7pnZtOsrz0HNqwFueDQBaT9rVOz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733276349; x=1733881149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5142+FxMWvJf+y1zYJc4iuIT592XegYtM+E1mlyFIrI=;
        b=AUcbU3kKrSliTNYE1aHKPBeafk+hOGOOMAW+X1BIFkGR04AHyuLWssAu9g67Nm3uqg
         U6Afo+nmWuioarDALJyVNi5i+V5GIIPOTzA3yFfdTAV6Ba7zOaPD3zQxQKNjrLbshMKr
         sIjUaHZhnC3p3GcJ/tW/OArTtMLXHtQya6yzn17+7rC58U7Vhs2qUVEKLrOWjGfWE3pI
         wp19lEsiHcfqkHGk0fCPwarCefEmflCIUv2/yhPpSXqfKmKy2z+Rv5P8RDgCpD4IH4nX
         EkxChEhf3i4gJaPYpyUkiyiPQ/HykDL0qq4j6IsGhQkhfPK2pld02z7whJc14pgHaMlN
         k3Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUTsd5Xg9SAWvKy8dhysdb+MjE9nStUwXINWBi+HiGlYYjv83CFty9ISHxGjDkRt7Naa08losvemra9RrnXnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdGilZRFmALdXS5XUQFZ91S22jtPxVTCHqyuUOph90fiWa454
	XQyVkzQlNWRPVArvOfWP7WZvddeiXRmuDgQs/L2GGVUMaXqtRwmV/HBJjowXBATyWvVf4mOmuPV
	sbg==
X-Gm-Gg: ASbGncuFFTUhaUEKny5RC3KsJaUrDrg43IsSWWTA0JGyE2Bl2IHP7HbgBIY2zlbiHTD
	6kZGDI7EiH/T20YM2Djzl4jHYjyAJ1pGO1SlEfLaAjHwihlCLxOBQEQJ72GnEhU+24gy3vsSvCw
	ZiPlgO2aEB+r+XzY32knL0RApzc9k3TV2W5qUlqeREPV+gybJ/GIZhxRroFayhGlLxNzMMEN90K
	tnFFOXTP7515b32lonWNGO5YoJuEMSUwvqNUXR0O1KIgq/fiG36SclkL+o0NJ8RMKZelxG9yKxP
	sEel5evuzZARig==
X-Google-Smtp-Source: AGHT+IFf6pG9+CkPqoBM0KA3TP62qiaAUiCBYRO30H8hwbLyry8TkQ1m6DfMJxAEKPppu35q8IwyJw==
X-Received: by 2002:a05:651c:2119:b0:2ff:d7cf:ba16 with SMTP id 38308e7fff4ca-30009c6cde7mr28253531fa.31.1733276349015;
        Tue, 03 Dec 2024 17:39:09 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca2907sm18149691fa.110.2024.12.03.17.39.07
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:39:08 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so432855e87.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Dec 2024 17:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpnnPRJkX1LJfx4/xBn6k81LB87SIPo8pwLjzFf5xS4hiEXdAvEQwcpwN/eq2C1XpCORJFiJEE+LA0/sYkMA==@vger.kernel.org
X-Received: by 2002:a05:6512:1256:b0:539:d10b:e38b with SMTP id
 2adb3069b0e04-53e12a2613dmr2674454e87.39.1733276347121; Tue, 03 Dec 2024
 17:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127105709.4014302-1-treapking@chromium.org>
 <CAD=FV=XhDdBJXfC72PZAbgaSpVx4ubtKSRFptock0SMRg=+Miw@mail.gmail.com> <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
In-Reply-To: <CA+ASDXPXiyga6mKLBacupCXa0wsBbXCrmq20RFo7T2eSF8kbzQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 3 Dec 2024 17:38:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
Message-ID: <CAD=FV=XuResyZK1ke1NtaGREfwm_3MB-u5t6vw459kYPt0LZwQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep
 from 10s to 5s
To: Brian Norris <briannorris@chromium.org>
Cc: Pin-yen Lin <treapking@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, David Lin <yu-hao.lin@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 3, 2024 at 3:05=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> Hi,
>
> On Wed, Nov 27, 2024 at 7:44=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> > On Wed, Nov 27, 2024 at 2:58=E2=80=AFAM Pin-yen Lin <treapking@chromium=
.org> wrote:
> > > In commit 52250cbee7f6 ("mwifiex: use timeout variant for
> > > wait_event_interruptible") it was noted that sometimes we seemed
> > > to miss the signal that our host sleep settings took effect. A
> > > 10 second timeout was added to the code to make sure we didn't
> > > hang forever waiting. It appears that this problem still exists
> > > and we hit the timeout sometimes for Chromebooks in the field.
> > >
> > > Recently on ChromeOS we've started setting the DPM watchdog
> > > to trip if full system suspend takes over 10 seconds. Given
> > > the timeout in the original patch, obviously we're hitting
> > > the DPM watchdog before mwifiex gets a chance to timeout.
>
> The Kconfig default is 120 seconds, and it's hidden under
> CONFIG_EXPERT. What makes you think 10 is a good value? (It sounds
> pretty small for triggering panics.) The smallest I can see outside of
> ChromeOS is 12 seconds, although 60 seconds is much more common. I
> also happen to see other WiFi drivers have hit similar problems, but
> they settled on 20 seconds (assuming a 60s timeout on other distros):
> https://lore.kernel.org/linux-wireless/20230329162038.8637-1-kvalo@kernel=
.org/
> https://git.kernel.org/linus/cf5fa3ca0552f1b7ba8490de40700bbfb6979b17
>
> Technically, this Kconfig lets you set a value as small as 1 second. I
> don't think we should work at reducing all timeouts to fit that
> target.
>
> I could maybe approve lowering this one, but I'd also recommend
> reconsidering your timeout value. And more questions below.

That's fair. I guess having a 10 second timeout for full system
suspend didn't seem totally crazy to me. If a system is taking more
than 10 seconds to do a full system suspend then that seems like
something is pretty broken. I guess it's somewhat like the same
argument that the WiFi driver had for picking 10 seconds but applied
to the whole system level, and I guess that's where we get into
trouble. That made me think that even 5 seconds seems a bit long for
any given driver to suspend. ...but yeah, it's squishy.

Maybe the ChromeOS should change to 15 seconds for the DPM Watchdog
timer and that's a better solution and leave the WiFi driver how it
is?

Another thought: I wonder if it's possible to be dynamic and somehow
set the timeout as "max(10, dpm_watchdog_timeout / 2)". Not that I've
checked to see if the mwifiex can actually query the DPM watchdog
timeout... ;-)

...also, it sure seems like if we're going to choose a value so low
that we shouldn't panic. All of our other watchdogs that panic aren't
so short, so probably this one shouldn't be either. Maybe we could
submit a patch to make the DPM watchdog just abort the suspend if
that's not too hard (and if the power people accept it).


> > > While we could increase the DPM watchdog in ChromeOS to avoid
> > > this problem, it's probably better to simply decrease the
> > > timeout. Any time we're waiting several seconds for the
> > > firmware to respond it's likely that the firmware won't ever
> > > respond. With that in mind, decrease the timeout in mwifiex
> > > from 10 seconds to 5 seconds.
> > >
> > > Suggested-by: Doug Anderson <dianders@chromium.org>
> > > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > > ---
> > >
> > >  drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > I believe Brian Norris is still anointed as the personally nominally
> > in charge of mwifiex upstream (get_maintainer labels him as "odd"
> > fixer, which seems awfully judgemental), so he should be CCed on
> > fixes. Added him.
>
> I tend to see mwifiex patches even if I don't get CC'd, but thanks. I
> wonder why get_maintainer(?) picked up Francesco properly but not me.
> *shrug*
>
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drive=
rs/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > index e06a0622973e..f79589cafe57 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
> > > @@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *ada=
pter)
> > >
> > >         if (wait_event_interruptible_timeout(adapter->hs_activate_wai=
t_q,
> > >                                              adapter->hs_activate_wai=
t_q_woken,
> > > -                                            (10 * HZ)) <=3D 0) {
> > > +                                            (5 * HZ)) <=3D 0) {
> >
> > Given that I suggested this fix, it should be no surprise:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > Upon sleeping on the idea, the only slight concern I have here is
> > whether we'll trigger this timeout if we try to suspend while WiFi
> > scanning is in progress. I don't have any actual evidence supporting
> > this concern, but I remember many years ago when I used to deal with
> > the WiFi drivers more often there were cases where suspend could be
> > delayed if it happened while a scan was in progress. Maybe/hopefully
> > that's fixed now, but I figured I'd at least bring it up in case it
> > tickled anything in someone's mind...
>
> Scans should essentially have been canceled by now, but IIUC, the
> driver doesn't really force the card to stop if it's in the middle of
> a scan (I'm not 100% sure if it's possible). So it's possible that
> pending scans could delay this step.
>
> I wonder what the distribution of (successful) timing is today. I'd
> assume this typically take on the order of milliseconds, but do we
> commonly see outliers? What if a system is fully loaded while
> suspending?

I would hope this doesn't affect things from the DPM watchdog, but I
haven't researched. Hopefully the DPM watchdog starts after userspace
is frozen so the system being fully loaded shouldn't matter?

Things I could believe mattering are things like:

* If memory is full and something in the suspend patch allocates a big
chunk of memory then maybe (??) that could slow things down?

* If lots of USB devices are connected that could slow things down.

* If there are a large number of WiFi networks or APs or Bluetooth
devices I could believe that could cause suspend problems.


>  Can you try testing (and gather timing numbers) when
> suspending soon after initiating scans? It's hard to judge what the
> lower limit of this timeout should really be without any numbers, just
> like it's hard to judge whether your 10 second watchdog is reasonable.

Pin-yen: is this something you could gather?


> Also, for the record, since we might have to field regression reports
> for other systems: what hardware (chip variant, FW version) are you
> seeing problems on?

Pin-yen: I'm assuming you'll provide this.

-Doug

