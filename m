Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7837C292085
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Oct 2020 00:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgJRWvz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Oct 2020 18:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRWvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Oct 2020 18:51:55 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C2C061755
        for <linux-wireless@vger.kernel.org>; Sun, 18 Oct 2020 15:51:54 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dn5so8313240edb.10
        for <linux-wireless@vger.kernel.org>; Sun, 18 Oct 2020 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t3ZpM9shERXmWg08MXu80HCVYbgk7EEOL98h1/n7aRQ=;
        b=oPvPgn4YiaZSmaTEH08C3dnrJ6iOUIHtI/KrHCDEQkKG6557BAMyaurOaiEg9zm2zX
         nmCILaz0DkoBk0wpnukidptI+IG4xa3t7HJfktLMpkQW8Xcur5VzVyBgHG7IoAR2YB1p
         Q9FUwBJtwSCi3Zoc16RMHNN+t0hKHVYQjwvHL91ANpYyX0sxjigTnGb6k1yJ0e5AmOC0
         9uik3bBcxGX8iPf/h6kAYX6xtL+AMc9T/Ybt4icqTpBNaTGNVK357F7x5m9Y9U1dfac2
         YYvDe/0da8FgRSP+EbZRRvIRAQbYlj3JURZZBwmzEVzrMMUm9mG8Cxgey/gD6fMeEhiU
         h5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t3ZpM9shERXmWg08MXu80HCVYbgk7EEOL98h1/n7aRQ=;
        b=PbuyY+V4an+LASB/r+g7nRChGLstOWuzaiUjokYH3ej8xeRXYhMWeJ2e4yv70/HHAI
         XYO6TY1NLyemw0+OYAGu5iw6WEkLu2HnkpaVWhPAm+zjTmwAOy1EzRobgEXv/TBVtWyl
         AMGMLeFzoHHtXKk6PVqRHPZTFDny5msCXEy7cADxIaCCMpRmkKXfGnnU4XZxVPXhH5NR
         E1CiioHEtsS1CcZeOjTDoyTqeEnmNufRZL1ipF4t02HbbQFZXI4VGkqEtceR9l0p68lW
         0aGsMIl2hoVOe5sMXe7QyvF8sVc3F2n+gVH+ttuF6nDEh3lWff/lMvMZ7bMDimD1JrTX
         SU/g==
X-Gm-Message-State: AOAM531wypNlZOV+aRmgbBXUYpICz67Lw6XqeT28DHi0LD2z9nXz9GxF
        ZFuMyueaQoVLyjffSzmokFSplWdWU+c42AWbpM4=
X-Google-Smtp-Source: ABdhPJzUM2MmhboocelG+sAzNqsbwx5k9W6ik/Pp6fDlCfW64Nmh5dxzKxKc9ciB/HWzj6l6YiNo6Mw/4QcJ43aTyR4=
X-Received: by 2002:aa7:d30f:: with SMTP id p15mr14910274edq.256.1603061513596;
 Sun, 18 Oct 2020 15:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6ttSmiXPnA9z_31CV2rS=DO0c48jSJGBAkOgWiD-GOG73Ffw@mail.gmail.com>
 <CA+ASDXO75rYv29YvK=0zUkB494DsA_WA+n3UttRiko2awzUkOw@mail.gmail.com>
 <362f154dff1b4d6f88503af813eae406@realtek.com> <1f33cbf8-ccf9-354e-a0ac-0911c6acded1@lwfinger.net>
 <CAO6ttS=ABWLQbgRxfbxsqNwr9bkEDJm6dBbvaZAM94GKYP+txw@mail.gmail.com> <87h7qrq4p5.fsf@tynnyri.adurom.net>
In-Reply-To: <87h7qrq4p5.fsf@tynnyri.adurom.net>
From:   David Rubio <david.alejandro.rubio@gmail.com>
Date:   Sun, 18 Oct 2020 19:51:42 -0300
Message-ID: <CAO6ttSkXSt3UC5P-RDCDUhDC66MRb5UkvCcbT5POzkve9G=GyA@mail.gmail.com>
Subject: Re: rtw88 / rtl_8821ce: rfe 2 is not supported
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
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

There's no possibility of including it on 5.10 changes? Seems like a
trivial patch
Or did the merge window pass already? I'm not aware of it by now.

Thanks though. Very much appreciated.

El dom., 18 oct. 2020 a las 6:11, Kalle Valo (<kvalo@codeaurora.org>) escri=
bi=C3=B3:
>
> David Rubio <david.alejandro.rubio@gmail.com> writes:
>
> >> https://lore.kernel.org/linux-wireless/c0c336d806584361992d4b52665fbb8=
2@realtek.com/
> >
> > I tested that patch. Works fine for me for wifi, but I can't test BT
> > to be sure it works 100%. Most people will be fine with just wifi
> > though, I guess, considering the objections were mostly about BT (I
> > understood -from the objection- that connecting to a AP when having a
> > BT device paired breaks?)
>
> If the patch helps people to get wifi working we should take it, BT coex
> issues can be fixed in followup patches. IIRC there has been multiple
> reports about this so I'm leaning towards taking the patch to v5.11.
>
> I changed the patch to New state and my plan is to take it to
> wireless-drivers-next once the tree opens:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20200805084559.=
30092-1-kai.heng.feng@canonical.com/
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
