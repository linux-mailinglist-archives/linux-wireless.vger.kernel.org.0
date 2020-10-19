Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3DB292D03
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgJSRnK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Oct 2020 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJSRnJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Oct 2020 13:43:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292AC0613CE
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 10:43:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h24so215756ejg.9
        for <linux-wireless@vger.kernel.org>; Mon, 19 Oct 2020 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EnW/e8O7oznXycAMh0m4dxARC37F0ItzOi3dJezfxIQ=;
        b=M8zERyiapQmIOjOgnIUyocQfERqbfZm9c7zM47AfZs1Lu1Rc/gEPcU85xnFoHIpmbX
         wg93nZrq/EDKr/uVhfmH+2lJMWIs26hjSNA6WaCUgvH91sjubykubed9cZ+jjoY3v+wh
         akKr6rVtHSsbbv8kx1L8e0JtqW5c9Gt0lG24bpq3gwIXcT+RHzZ0gcmiVX+Ma/Ypf1hE
         ZLr7u2frzaqQWIcFOFksUfBs0jIl+BZdQ6InWLCLImilPGUa/+JT2wP1xng9t7B2MO2U
         58WgMKbIya35eLgHGPgLYJ2Xs92EpqOduFLuaEjr6kDtpr3Z+z6TZebsdLxpReOwP+9g
         W8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EnW/e8O7oznXycAMh0m4dxARC37F0ItzOi3dJezfxIQ=;
        b=M++eyCaMs4v7v1mvK/FngJtkYxU1C72Q9phUxG9v++3B+m1p3k0EmJHLFHZA0+uhxr
         1kkK2npcuJec+gBvVCKyT844Krnxhc+XL31QN4QImEyJO2LPVNfc8h17TPZAfDUXsUwd
         LbzcW/QHnOyi0CmNvxFljVwKyQfiLKNWcs/8HEfm1XekhSgFXY8p2KpllweeK+Ha24/L
         kSmLKRlOyfKrZlCbNSe0GrLfxI/nz/7Oy2YWnT3cPXzL30bmCOUfiYEuPdufgzYhcakE
         pDsppqCmj6hSvIKpZasWazMFExTzyaN3+RY7sMxSuHaDIysvakzakM8MszbgWWsOtdXp
         EBdw==
X-Gm-Message-State: AOAM531ObTQofwX23PRhFsLNJ//mXT/FHoGDZ/jIq3iNEUgQ7+lLl4QK
        iPE4/n3xMyKBL/CRozsqUSSxgGBnVjJIuJmbNWA=
X-Google-Smtp-Source: ABdhPJyaSRUL7pobPHqO3MEmjrrFHXMCkWGI+z4tsb5WeNkAGK44FUS/SjFYRT9AEhsvOV3U0NuL201r/70LFzalyIw=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr951235ejh.383.1603129387750;
 Mon, 19 Oct 2020 10:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com> <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com>
 <87h7qrq4p5.fsf@tynnyri.adurom.net> <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
In-Reply-To: <87bc4553-7f17-0c23-50c8-2b413de9f7b8@lwfinger.net>
From:   David Rubio <david.alejandro.rubio@gmail.com>
Date:   Mon, 19 Oct 2020 14:42:56 -0300
Message-ID: <CAO6ttS=U=UXLEByJVDQgXdBbtgKm=WgGUjOVZCXuOnjyajUTFA@mail.gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Andy Huang <tehuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Makes sense I guess. My room is 7m^2 so can't test beyond that.
Small room issues, or well, not issues, I guess.

- Kodehawa

El lun., 19 oct. 2020 a las 14:10, Larry Finger
(<Larry.Finger@lwfinger.net>) escribi=C3=B3:
>
> On 10/18/20 4:11 AM, Kalle Valo wrote:
> > David Rubio <david.alejandro.rubio@gmail.com> writes:
> >
> >>> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb=
82@realtek.com/
> >>
> >> I tested that patch. Works fine for me for wifi, but I can't test BT
> >> to be sure it works 100%. Most people will be fine with just wifi
> >> though, I guess, considering the objections were mostly about BT (I
> >> understood -from the objection- that connecting to a AP when having a
> >> BT device paired breaks?)
> >
> > If the patch helps people to get wifi working we should take it, BT coe=
x
> > issues can be fixed in followup patches. IIRC there has been multiple
> > reports about this so I'm leaning towards taking the patch to v5.11.
> >
> > I changed the patch to New state and my plan is to take it to
> > wireless-drivers-next once the tree opens:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020080508455=
9.30092-1-kai.heng.feng@canonical.com/
>
> Kalle,
>
> I had generated and applied that trivial patch to my GitHub repo with the=
 rtw88
> drivers a couple of months ago. Yes, it does get the user past the
> initialization check; however, wifi performance is abysmal according the =
the
> users of the repo. It seems that the antenna selection of rfe 2 models af=
fects
> wifi as well as BT. Applying this patch will get wifi running; however, t=
he
> users will need to be within 1 m of the AP for it to work! I do not have =
an
> RTL8821CE chip, thus I have not tested myself.
>
> Larry
>
