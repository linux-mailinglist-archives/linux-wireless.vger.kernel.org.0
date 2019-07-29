Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9E7931E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfG2SdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 14:33:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34109 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbfG2SdY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 14:33:24 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so122301035iot.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HRnp79yAtAg76/OwzoPEHCvyCywF4oF1vK2g2G4jaNI=;
        b=k7ZATTLAH+b6XBKHtNiuFPa6LQNWwJQCzRLIRSp9lG1+kn+ztmPA2XaZrXKZZ6o8B3
         Ldtwx05sr6X7J4OJ9mEZaKvoqIl/LS7tgNHUEOpTt5C+CX+NLJ4VGVEWurZSKzTsbpK7
         sUQlXZB92WtuB/MTlCdvnilaLXYvCnPPHwtoOKl0zf/1zqI74BWJNN3PsMOMtCa3u306
         if4ND4wzW04JQW8O9TU7DUSVGGbWm6jhfkLJvaEU54kxHbs2eIh3rSHkusSsvY97y0VW
         /SVteiMb3Q6oCbLur060Hhm22lPxJWxy4g4wlTb5pFCg6PthtC5TsA0o6ZRseaZFWfZg
         9Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HRnp79yAtAg76/OwzoPEHCvyCywF4oF1vK2g2G4jaNI=;
        b=GrpjZG0wPqliwep37kzLv85TjgxOfJFhAV3gbcE+pXeg8DJ9OCrPVxhPG/rGIMMFhZ
         FFbSFsDJMxSCGMQnydUB7Jrw+5XYH3eFjsF4ZkJfta2Cw3WbqXLa7ONfYe9b0syeAiDf
         M07djy803czHuZRtDSPzwnI0uMJa0ulX8c+tZXMvQPwKDFh6QUB56mw7u+BJkWNkOg8m
         ertveQEjTTRri0NHAUdP08vIDSGDsbMakKDxNlRosGKtv7O3VtTnZnvSyq1HT9OokAZf
         be6xHzp3yJ9FhdVKmttuCDmmuDw8DTqo2+3v0rQ8dbyd/w5uui+n7xDUpx/qeV/96eCf
         aDIQ==
X-Gm-Message-State: APjAAAW2AjnnyZI39JbV8XXQCXM8/w8eau3SF0z8z3D6o5HERh4kTSd6
        UI51jbFaQg4Jn53QF0veGissyU+3ACRxLKXvAcqRCzCmxts=
X-Google-Smtp-Source: APXvYqw0JXiOorlyjlQu65hWB+RhtYAV8dJLFI9foNFmSGLh4zO7C1V/yJyP4dJmsej7MeJQa676AkJSIotP1H85aec=
X-Received: by 2002:a02:4005:: with SMTP id n5mr56558858jaa.73.1564425202708;
 Mon, 29 Jul 2019 11:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANoib0Hn9uNnk5vpjEJUiGriD5rHuDc7xxLFj3r8ij6ALSxcag@mail.gmail.com>
 <CANoib0Et3gLu2gGYeWracV4v7tgWj8qhtO7w_c8TSJ+CE-gjMg@mail.gmail.com> <20190729183009.GD21772@ubuntu-xps13>
In-Reply-To: <20190729183009.GD21772@ubuntu-xps13>
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Mon, 29 Jul 2019 21:33:11 +0300
Message-ID: <CANoib0EiYnacGB6Ok4Df0=hwGCR5bOL4c84HqvL4VMtXnM8e1g@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Russia (RU) on 5GHz
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not easy to find and understand these Russian regulatory docs.
There is also another link with the master doc with both attachments.
http://rfs-rf.ru/grfc/norm_doc/detail/?ID=3D41839

I'll make a patch.

=D0=BF=D0=BD, 29 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 21:30, Seth Forshe=
e <seth.forshee@canonical.com>:
>
> On Mon, Jul 29, 2019 at 09:05:06PM +0300, Dmitry Tunin wrote:
> > I made an error while editing. The correct section is
> >
> > country RU:
> > (2402 - 2482 @ 40), (20)
> > (5170 - 5350 @ 160), (23), NO-OUTDOOR
> > (5650 - 5850 @ 160), (23), NO-OUTDOOR
> > # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_=
22042015.pdf
> > (57000 - 66000 @ 2160), (40), NO-OUTDOOR
>
> Thanks. I haven't had time to look over the document to verify your
> proposed changes, but I would encourage you to go ahead and send a
> patch. I will try to look this over soon.
>
> Thanks,
> Seth
>
> >
> > =D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 00:53, Dmitry =
Tunin <hanipouspilot@gmail.com>:
> > >
> > > The db entry looks like this now
> > >
> > > country RU: DFS-ETSI
> > > (2402 - 2482 @ 40), (20)
> > > (5170 - 5250 @ 80), (20), AUTO-BW
> > > (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> > > (5650 - 5730 @ 80), (30), DFS
> > > (5735 - 5835 @ 80), (30)
> > > # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=9612=
9_22042015.pdf
> > > (57000 - 66000 @ 2160), (40)
> > >
> > >
> > > This doesn't look correct. The regulation document is here
> > > http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gk=
rch-_-16_36_03.pdf
> > >
> > > According to the regulation document issued Feb 29 2016, there
> > > frequencies should look like this:
> > >
> > > country RU:
> > > (2402 - 2482 @ 40), (20)
> > > (5170 - 5330 @ 160), (23), NO-OUTDOOR
> > > (5650 - 5835 @ 160), (23), NO-OUTDOOR
> > > # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=9612=
9_22042015.pdf
> > > (57000 - 66000 @ 2160), (40), NO-OUTDOOR
> > >
> > > Note that there was never a DFS requirement in Russia, but always was
> > > NO-OUTDOOR on 5GHz.
> > > Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> > > Also Russia has never been regulated by ETSI.
> > >
> > > If this looks good, I can send a patch if needed.
