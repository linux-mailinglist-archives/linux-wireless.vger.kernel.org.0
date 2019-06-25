Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB655AED
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 00:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFYWRl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 18:17:41 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38992 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYWRl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 18:17:41 -0400
Received: by mail-ot1-f44.google.com with SMTP id r21so474070otq.6
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AF196hceNf7CY1d67HXzx+j6m4a8u836Up0Con2Mtgg=;
        b=mXoo/k8xGUBWrcvVtmNwN1YpSTbVG7duJNe5J4rfA4+EtB/+jf5HotJxxqrzv3h5D7
         nnhot0UoGpr1py3bfnbsMaevjbqyP7cm1RvOpF75CB+8bLx7tG4rBmMEMlrLGxKB4TWg
         h0Som2l5qqmeKkI88+SzD5fs0/VEmc+FtXkttHs8doQhyxegIPWnougt+YOsFk4iyVQV
         KE1CYx5j2wNe02H5g1FDPjmB8h4fBn/cGm2dKT7/RLgaYSo56kBsBzxScwhrCVBynYFz
         XZjs8GS43Zuuqc5ncK7xMmAt7ZUtrMwyLss/sAhI/KzKjFMHvWQ6Fro6U8u+nUdndOvi
         jPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AF196hceNf7CY1d67HXzx+j6m4a8u836Up0Con2Mtgg=;
        b=sLAfX2bi+JK34PbMZUFrf3ZzYrkRlrL7VB3gawjUKNq7QbmhDcGLL3LewfSauo/rms
         Yb92ChLJQOxdA7QSiTtrPgbRoQu90cwKshPab58MDjWV+24H/eC9dqH9cUY06gIj/7OP
         zZzc+Km3/5R8HCtCLbuO0orSB1W11dnfaLMJnOIiEq0fB0jp/386lQA2sGisdcIxITdM
         YWGiu0+RGUUU+gTOgng8bx6DhhU2D8fIL/OuztpHHx/neIGGogqMTuConuWmk/prgYml
         2vPTT/dCluMy3MHoJz3njbOjwh/lWOn9/VI/tUGwjSrxSgfFTcKKsyfOY3uP0hzkPcCH
         hfeA==
X-Gm-Message-State: APjAAAWbQ8qu6pY33GJdUpe9ElloBwmexeI6wXzMd5bKyRE6Ce/KMdPK
        iWvF0Uxp7aUxX1X0bFtRoSOHMf5XDkEUU/dP404vquHg
X-Google-Smtp-Source: APXvYqx+b06s/K54z0SHPZDTD6QqcimXCmbLzDsaqBC7R1WFZIUwGyRsBoPERKiGE5fmxLw00i+migVqjMhrLleMo2I=
X-Received: by 2002:a9d:61d8:: with SMTP id h24mr552387otk.53.1561501060434;
 Tue, 25 Jun 2019 15:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <2455026.F8Aexx8IWb@zadesk> <CAPuHQ=Ffq_Gw_KbyjpzR07MWz=+LxmGVEP2-Tn5zDxrUEuxrZQ@mail.gmail.com>
 <CAPuHQ=GLgDFQZDhGv34S4yhOXTQL7AkKOywSqqtyPD8Lv6cCPw@mail.gmail.com> <2221997.PNfK1iNeOp@zadesk>
In-Reply-To: <2221997.PNfK1iNeOp@zadesk>
From:   b.K.il.h.u+tigbuh@gmail.com
Date:   Wed, 26 Jun 2019 00:17:28 +0200
Message-ID: <CAPuHQ=FiVABk2U+L_XXwKe7NH0NpCf7gz0O_XY6xrC3MSDm3Nw@mail.gmail.com>
Subject: Re: iwlwifi module crash
To:     Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
Cc:     Emmanuel Grumbach <egrumbach@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maybe we don't have the same issue, but today this one solved it for
me: `rmmod iwlmvm; rmmod iwlwifi; modprobe iwlwifi`. Well, kind of. It
couldn't really connect to any network afterwards, but after another
such dance it was finally back to normal.

The device disappears from iwconfig for me when this happens, so it is
easy to detect and correct with few lines of shell. It can also be
gone from lspci as well. Another alternative would be to set up a
syslog-ng program destination triggered by a patterndb sample matching
the noted failures among the kernel messages.

If it gets stuck without a visible sign, you could watch Inactive time
and tx failures in `iw dev wlan0 station dump` increase sharply in
case of issues. If you need a bit more reliability, it is easy to ping
the AP or gateway every second and refresh the connection in case of
too many consecutive missing replies.

On Mon, Jun 24, 2019 at 11:36 PM Balakrishnan Balasubramanian
<linux-wireless-list@balki.me> wrote:
>
> Thanks for the tip. In my system the path to remove was below:
>
> /sys/devices/pci0000:00/0000:00:1c.2/0000:02:00.0/remove
> Also symlinked here:
> /sys/module/iwlwifi/drivers/pci:iwlwifi/0000:02:00.0/remove
>
> I am now able to restore internet without system restart. Now I need to find a
> way to do this automatically whenever internet goes down.
>
> Thanks,
> Bala
>
> On Sunday, June 23, 2019 5:08:32 AM EDT b.K.il.h.u+tigbuh@gmail.com wrote:
> > devices/ is probably just a symlink. Try to find it manually:
> > find /sys -iname remove
> > lspci
> >
> > The interesting thing is that my iwlwifi card started to do the same
> > thing just recently (some weeks ago). However, I do suspend a lot and
> > it only happens after resuming, but not after every resume (maybe
> > 5-10%). It always came back after restarting except on one day when it
> > needed three restarts, so maybe mine would be more about needing to
> > reseat the card.
> >
> > > On Fri, Jun 14, 2019 at 4:54 AM Balakrishnan Balasubramanian <linux-
> wireless-list@balki.me> wrote:
> > >> The issue occured again today. I tried to restart the module
> > >>
> > >> > echo 1 > /sys/module/iwlwifi/devices/0000\:02\:00.0/remove
> > >>
> > >> There is no folder 'devices'
> > >>
> > >> zadesk% ls /sys/module/iwlwifi
> > >> coresize  drivers  holders  initsize  initstate  notes  parameters
> > >> refcnt
> > >> sections  srcversion  taint  uevent
> > >>
> > >> > echo 1 > /sys/bus/pci/rescan
> > >>
> > >> Attached the error when trying to rescan.
> > >>
> > >> Thanks,
> > >> Bala
>
>
>
>
