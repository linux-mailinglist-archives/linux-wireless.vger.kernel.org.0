Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1883123503
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 19:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfLQSfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 13:35:38 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40668 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQSfi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 13:35:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id e6so2394655qtq.7
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 10:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqR10Ray35SJpBzHXPMJL31vlypWu7cUa6JUcMASLbo=;
        b=hzL+8zVgIFxpFV7m5pnrtTW2SEXZVOzmBS2NwnkjJLvE1sxxWaPl7RipEwinV+Ot2k
         EKOHWxbX24UreWevkU8ihQisTz87NyDKYo1+vqwHoQrNiwdykiSuh9GHgJeUwuve0UnC
         x081/aQodoP8BMXVOQT5gVxtxXvBLHdICxw61xGLH/7B72ciWV7xb01gzD3kihL66Msp
         d6RfbETWNgubg1+3AzUo8scu6qRBpnc5ksoqlQob6gAzcbtZpJ+e7DkmNRtGIE5ndP82
         jzHoHFwfT/L85OzZJgcdADEAOZR/qGb+HAof6sGg3HiNB0Gv9l+mfScko34tfz0D0xXa
         jopw==
X-Gm-Message-State: APjAAAUN0W/9ne2hFWFV8a6NNUk28cdB3zOu7LSmoc6Vbcd0QkvaL9eW
        2nzEX90VdWBIzyb8xmoaQFfLr4M82ZSShkpt3uvWCw==
X-Google-Smtp-Source: APXvYqxBR61uXHQdXc7T+abVhe0nPlueXaWUbDpDPZwZkiwa9C2SYqPpSBYiXoCknsYb3WQlCHaSzQ4e/9WeYLEZIM0=
X-Received: by 2002:ac8:1e8e:: with SMTP id c14mr5506175qtm.330.1576607737384;
 Tue, 17 Dec 2019 10:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com> <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
In-Reply-To: <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
From:   Adrian Chadd <adrian@freebsd.org>
Date:   Tue, 17 Dec 2019 10:35:23 -0800
Message-ID: <CAJ-Vmon5811ktT-+8HcMOAPnOLGzd20rFMxaTucXbEEAz4+q0A@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 17 Dec 2019 at 10:29, Tom Psyborg <pozega.tomislav@gmail.com> wrote:
>
> On 17/12/2019, Ben Greear <greearb@candelatech.com> wrote:
> > On 12/17/19 8:23 AM, Justin Capella wrote:
> >> I believe someone recently submitted a patch that defined noise floors
> >> per band (2/5).
> >
> > I looked at using the real noise floor.  Our radio was reporting a noise
> > floor of around -102,
> > where the hard-coded default is -95.  This of course would make the reported
> > RSSI lower by 7db
> > in that case.  I am not sure that is correct.
> >
>
> Hi
>
> I am getting similar NF values with all my ath10k devices, I thought
> default was changed since ath9k from -95 to -115 just like in the
> vendor driver? There were some discussions about it on mailing list.
> On some channels (5Ghz) the value goes down to about -107, even saw
> -110 once.

IIRC they're /not/ calibrated dBm values. They're just internal noise
floor calibration values derived from the internal ADC reads when you
kick off a NF cal. Then everything is relative to this NF value.

This is one of the many, many reasons things get gunked up when you
start seeing higher noise floor values; since a lot of things
internally are/were related to what the currently calibrated NF value
is, a too-high NF sample value would result in quite exciting things
in the PHY like "this channel never drops below CCA"...




-adrian
