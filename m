Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EFB290B81
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392435AbgJPSmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392382AbgJPSmt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 14:42:49 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E28C061755
        for <linux-wireless@vger.kernel.org>; Fri, 16 Oct 2020 11:42:49 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t25so4535536ejd.13
        for <linux-wireless@vger.kernel.org>; Fri, 16 Oct 2020 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E+EDySNme8N7wmZpM5UzKvyBZmTM68pr/yEgEi74hnQ=;
        b=ubNCGrXPEz6AxZXwbVIwA9q9DZSLfCv0Fvlgftyelhg7OxsJIAskE+pscapVBanVoR
         XCz2gI4X6crEYmxyBHV3xGQ+77KZGl91eWSQbDF7vk45uzdVvIJAOyFjCxP8DFlTXT2H
         43FvTt5Vd8af6yRaRB3M1wzAoXH+colPnDztLE2ciWF5MjH2EO7Z1w0JgtHasT44X4Dj
         gUM3hMwcOzKzxRR8neQth8dgiSYBb4grZtgJdwAC4rH1ztKy2bj/EZBs2k/r/LAH7eU8
         3CKltdzoYjnirjWlQ218Re0i6zM44OxqPGrmWndEhZ9ZVLOx+vRHxQbu7Kpd21ZsU46Y
         haWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E+EDySNme8N7wmZpM5UzKvyBZmTM68pr/yEgEi74hnQ=;
        b=kzPMt8+GliH4I1XxZUOsqT+IuoyDqJ0uj9MHxUtfH/sxwXf5iOeCXAqWGvH5ISUk1c
         6nl7CF/X8lsVNE5AuxU0eqTKvi3+kx4asalgyGdN5FqGjgY+lkIXbMWL6A6Mn8C0rlvr
         9Wqn3IqfzXs+zaPzVGj6n/JL1Oy2bfdlMC5W50m4ipZnS92b+OrA9MViKKcBY+2qNzjS
         EvzuFNNkp0l3AgndlM7AKG9K1GaRuTQu0UmfOWGwqWihkl5AUHvVtFhl2QSLLS+mJRpv
         bCn4DZnqbe8SOmElM0gDjZH9jEdO4m774kcd/ip5DSb6xZ1kxcBWpvdiNkLJTnMbbFI8
         RZUA==
X-Gm-Message-State: AOAM531PxXFhkJzZ1af731eIIjwDW0kR95b6vpTs2lG1NOJjx3l+slo8
        uirex8lMTFSnYprfPvKv1VA8nuLUBsR1iAPksD4lTnQaFY0Grw==
X-Google-Smtp-Source: ABdhPJys3ceDg07NazW87B7h61dBHgBdyZKShVCoTqFtBHgmP9YIIbLpAEgxnyt1+7VfQGr9Q2QyLE+TY5DXp4jD0dU=
X-Received: by 2002:a17:906:f201:: with SMTP id gt1mr4890619ejb.229.1602873767976;
 Fri, 16 Oct 2020 11:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com> <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
In-Reply-To: <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
From:   David Rubio <david.alejandro.rubio@gmail.com>
Date:   Fri, 16 Oct 2020 15:42:37 -0300
Message-ID: <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82@r=
ealtek.com/

I tested that patch. Works fine for me for wifi, but I can't test BT
to be sure it works 100%. Most people will be fine with just wifi
though, I guess, considering the objections were mostly about BT (I
understood -from the objection- that connecting to a AP when having a
BT device paired breaks?)

Thanks for making me aware of it!
- Kodehawa

El lun., 12 oct. 2020 a las 23:37, Larry Finger
(<Larry.Finger@lwfinger.net>) escribi=C3=B3:
>
> On 10/12/20 9:11 PM, Andy Huang wrote:
> > The support for RFE type 2 of 8821ce, the patches are ready, but we nee=
d to do some verifications. After the verification it will be upload.
> >
> > Tzu-En
> >
> > -----Original Message-----
> > From: Brian Norris <briannorris@chromium.org>
> > Sent: Tuesday, October 13, 2020 2:13 AM
> > To: David Rubio <david.alejandro.rubio@gmail.com>
> > Cc: linux-wireless <linux-wireless@vger.kernel.org>; Yan-Hsuan Chuang <=
tony0620emma@gmail.com>; Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
> >
> > On Sun, Oct 11, 2020 at 9:13 AM David Rubio <david.alejandro.rubio@gmai=
l.com> wrote:
> >> Oct 11 12:20:39 youmu kernel: rtw_8821ce 0000:02:00.0: rfe 2 isn't
> >> supported
> >
> > I'm not sure anything changed since the last time this came up:
> >
> > https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb82=
@realtek.com/
> >
> > I think this needs somebody from Realtek to look, or else ignore the ob=
jections and merge the sub-optimal (trivial) patch. I'm not sure of the ram=
ifications of doing the latter.
> >
>
> Once the patches are uploaded, I will merge them with rtw88 at GitHub.
>
> Larry
>
