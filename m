Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051D219E046
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 23:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDCV0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 17:26:18 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41714 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDCV0S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 17:26:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so7448689oia.8
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 14:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73V8whj1Ys9i/Dnj0V8Jrh2GwO6wrXmEkb0pKE5JyMs=;
        b=l/5djvPonFAQB30E50Hdlx/jrPK+3qu4Ge7n1uB9in5Ls7y/cBexvMRRtSMlVfIidu
         s+AbFclh2cza9wbGnyWlJo2wBNiQBFroogGvzzUXpeAzbVpASehqhe6Jl8Am9r1AhRt9
         PERGP185O1TcFtDwA4bEKCNTtDBEHHcc7FDWCJERZVh5wLR/vgzbiDcu9jqQ+1i4VJ/b
         IFuAhLCxW0VWjUjPTL2kWM6uEJc1tLFKOtlBSZI9Vpvf/F9UcwNMH1gB3GWlH4yIZeGF
         1FlJeFj+YXjlO3W4eyEEabCymGsKz7hDVR8vUrmPkrDkme8dkcgAT2a4xUPj77c4XyCl
         zsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73V8whj1Ys9i/Dnj0V8Jrh2GwO6wrXmEkb0pKE5JyMs=;
        b=OoyAcHEDZ0k/m66gthl3IBWgRxcDtZb24i5LF8M7MZO0e7skRbUx4lmY1BmZwgwDNW
         GltuV5LcavE2EsSzB3KzJMU2A2eein41/eElpxuoGN5wDZJetIWnpgT1IZ/YzHJ53pep
         X5lqCM3hhBDJTajSBK8dd+sbW/+3iNLRnRtrWOwuTALlLq+WbAZrM6m8nb0lXCJEPLiH
         P4tMFNcXDWyP3pmBQK6YMjchNBVHScXy9Knvc9J23S/bjHLim2uUomgDlxts2PCL7YHv
         6geHTqtV749Y8uw6TG3ZP8tOSRTp9u0CV2ik0STeie3e+ivnb1JLv7aCQB12iDVA6ZJA
         C+yA==
X-Gm-Message-State: AGi0PubzRsP3Q+u3bzHp1/sjFmWJTtUPkqD/bHFpI+K3/aNt8h+Fipq7
        GwADh65rSASRHQB18YAiwRh/ui6E9Jg6xD3mdVsRBA==
X-Google-Smtp-Source: APiQypL+V5+z+TOXT4U3TX8xXu5CDZNc/Im4pnEsLAvhJj5SwpnidIWj9O05AkU6NempHnNlpbyGF5uExh9KoGRb1Hs=
X-Received: by 2002:a54:4e0e:: with SMTP id a14mr4834592oiy.88.1585949178059;
 Fri, 03 Apr 2020 14:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200403082955.1126339-1-luca@coelho.fi> <iwlwifi.20200403112332.75faaf2137f4.I9e27ccc3ee3c8855fc13682592b571581925dfbd@changeid>
 <CAPuovEJ7b36wEh7=8GQUx8dp_fx2AuQS4ivKb3tuHeP31HwyUQ@mail.gmail.com>
 <08f1736dc95604f2a2fa47c2836251735e89ae99.camel@sipsolutions.net> <b8690095cf1b37b4ffca02f3959ad315b6f629ee.camel@coelho.fi>
In-Reply-To: <b8690095cf1b37b4ffca02f3959ad315b6f629ee.camel@coelho.fi>
From:   Mark Asselstine <asselsm@gmail.com>
Date:   Fri, 3 Apr 2020 17:26:06 -0400
Message-ID: <CAPuovE+Zc_EDPZOZphGZ5vWc5e9gcwq8xWXc8dNCWnpRNHwFfg@mail.gmail.com>
Subject: Re: [PATCH v5.7 7/8] iwlwifi: mvm: fix inactive TID removal return
 value usage
To:     Luca Coelho <luca@coelho.fi>
Cc:     Johannes Berg <johannes@sipsolutions.net>, kvalo@codeaurora.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 3, 2020 at 3:08 PM Luca Coelho <luca@coelho.fi> wrote:
>
> On Fri, 2020-04-03 at 20:58 +0200, Johannes Berg wrote:
> > On Fri, 2020-04-03 at 10:46 -0400, Mark Asselstine wrote:
> > > On Fri, Apr 3, 2020 at 4:31 AM Luca Coelho <luca@coelho.fi> wrote:
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > >
> > > I sent Johannes part of this fix weeks ago and heard nothing back. I
> > > am far from a glory hound but something is wrong with this list if
> > > fixes are sat on for weeks and then the fix shows up with any
> > > acknowledgment lost. At minimum a note saying that a fix existed and
> > > would be merged shortly would have been nice.
> >
> > Uh, sorry. I really didn't have your fix on my radar when developing
> > this, and cannot even remember it now.
> >
> > I guess I could've saved myself some work there ...
>
> This is my fault, sorry.  I've been sitting on patches sent to the list
> for some time now.  I have a big backlog of patches in our internal
> tree to send out and have been prioritizing those before processing
> patches coming from the community.
>
> I'm finally catching up now with fixes for v5.7 (and stable) and I
> promise to do better from now on.
>
> My sincere apologies.

np. More than anything its the duplication of work that sucks. In the
end we all want the same goal, to improve the functionality of the
drivers so let's keep pushing forward with that. Stay safe and have a
good weekend.

Mark


>
> --
> Cheers,
> Luca.
>
