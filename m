Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA2E1C3AA
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 09:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENHMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 03:12:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42368 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHMS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 03:12:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so17848778wrb.9
        for <linux-wireless@vger.kernel.org>; Tue, 14 May 2019 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=5TBZtrU9B5v1RR9R3L6q6afA0gwCnyufeN3SvVzQC6U=;
        b=SscvLm85rwUhgPIOI+6lXjo/V8Kk8l/aF5XFDdS+S+PFGs1jAUTuzlEbEDG84q1F+5
         1DjU2NkK6gL55w5cYr9eAtQ3Knfy9XHjoTkc29XSE2SdR2CdAQNRxN+tL1S+uz183bBi
         dqxS/f3cJ2JX+hPf3+376olf1Vo6/+vRBF9jkYXdg8Lu4iteDqE3FursycqyDSKq4zyP
         HuMTgTkp3/3IvPXc3tp6eBXMMYFaZYhlaabvFTvrIzYUI5+qdFWw2dWc4ITeEjZe8Tdd
         NuzMNtgWMHIr/AB4yzNNwqQE/vwi7U4v0z0PVdfEA4jqEaakV+nIC4dFJDyKrx+qT5J0
         VNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=5TBZtrU9B5v1RR9R3L6q6afA0gwCnyufeN3SvVzQC6U=;
        b=gN56XfTUDD2Argoi8nevetXV2wJK3+fbbE1BGuT17bXY0uZwxHmWwVVrJV/0a7InDI
         YcYCSFDVFYtweFfPiUEAPS5UBjCN7rToHiKR50XwNRVnN3E2u9ts1gC8drcvvQQAp0Nk
         1linYrSZLK0uDMOjG1Y6aoZdrVDd9StUtRwQBTq4PvHlmArTv4yl3tVU6bGYuEv4nz/G
         UheLS7C8GFXLC5sYx4vwKByZOihJUgaN07tmkDVGtdDp/+rrF4qbtuzlAACMj3Ed70bh
         L8S15SsommXH7i+WipOnlpnk6VCqC3+D759EQXtMbelI2GDakb3D7ZWzX+rG12lq21Ay
         eLqw==
X-Gm-Message-State: APjAAAW4X3jTjOTt2ar/dG70ZTrXcvp5zPaiCB3LjkweHM8coTdgi9CJ
        tnDNQLd9Kmq11oHi/SnCuyNNQI8wmykEnolq3hQ=
X-Google-Smtp-Source: APXvYqzCNWIgXU60uvNcpiMtFkO2Pt7ILXzWpruzNIgkqHknyDSPzew4pknH6+wxdFZCdIqEFn7WvnDbpwj/cZFtYQY=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr8484033wrq.285.1557817936299;
 Tue, 14 May 2019 00:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org> <CA+icZUWLBjTtcFS0Fo8M5gSb90GbEUpetUgwr3fy=NxGAVqCyw@mail.gmail.com>
 <ecfdf017-59b0-dcb8-f684-1e4ba3d82a28@linaro.org>
In-Reply-To: <ecfdf017-59b0-dcb8-f684-1e4ba3d82a28@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 09:12:04 +0200
Message-ID: <CA+icZUV0qVmtz6xXYMM7gxJs21H_sQxYK=EeHeXbv=H6LAXeNw@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        oleg.zhurakivskyy@intel.com, clement.perrochaud@effinnov.com,
        charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 8:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/05/2019 08:52, Sedat Dilek wrote:
>
> [ ... ]
>
> >>> Please give this a try and report.
> >>
> >> My laptop is the first one I have with a NFC reader, so I'm not used to
> >> test this as it was not working yet.
> >>
> >> I booted the machine with a 5.1.1, the series applied on top, and the
> >> config options set as mentioned above.
> >>
> >> The nxp-nci kernel module is loaded and neard is installed.
> >>
> >> I used the sniffing tool with the command libnfc -d nfc0 -n but when
> >> passing my NFC devices on the laptop's NFC mark, nothing happens.
> >>
> >> Is that correct?
> >>
> >
> > Hi Daniel,
> >
> > I am new to the topic Linux NFC.
> >
> > I have installed neard (daemon) v0.16 and neard-tools from Debian/buster AMD64.
> >
> > root@iniza:~# systemctl is-active neard.service
> > active
>
> Same for me
>
> > root@iniza:~# nfctool --list
> > nfc0:
> >           Tags: [ ]
> >           Devices: [ ]
> >           Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
> >           Powered: No
> >           RF Mode: None
> >           lto: 150
> >           rw: 15
> >           miux: 2047
>
> I have:
>
> nfc0:
>           Tags: [ ]
>           Devices: [ ]
>           Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
>           Powered: Yes
>           RF Mode: None
>           lto: 150
>           rw: 15
>           miux: 2047
>
> The powered field is different.
>
> > root@iniza:~# nfctool --poll -d nfc0
>
> > Start polling on nfc0 as initiator
> >
>
> I have:
>
> Protocol error
>
>
> And the dmesg show me the errors related to nci:
>
> [  343.056021] nci: nci_ntf_packet: unknown ntf opcode 0x0
> ...
> [31611.394308] nci: nci_start_poll: failed to set local general bytes
>
>

I cannot say much to this.

For the sake of completeness:
I have the patch "NFC: fix attrs checks in netlink interface" applied.

- Sedat -

[1] https://patchwork.kernel.org/patch/10339089/
