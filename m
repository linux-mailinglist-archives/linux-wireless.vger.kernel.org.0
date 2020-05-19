Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D61D9956
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgESOSt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgESOSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 10:18:49 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05771C08C5C0
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 07:18:49 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id b13so3772717uav.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k3+8S4AY2uVpQH+RCiJkWL6MuiFNkRebQcOpXooUIsA=;
        b=meSmS01XIcQsr950zb7oGW9O5o2Lq42OiTTOvhK150a6uS38u10GInz1zWnVm5SVIU
         k0DvjLoX4zzEaU5QePVTNPn2Gto4cHJ8MpCqYIvLSwGeGITHBuR00+RwHfcz3kO77TDb
         Z26konVPsDNnEKjciuY9tm5BhC3p8V3m9O/ybuMHjdQGi5IVy9Cnqd41s0K0H6x+LKC4
         9Y5ibKyHxnn3NGgpxi+vR07tcBUdLrWUJa5jSMWl+wZle6p5884gJJOwXibBepFncs0X
         C8PyDYqtR24NBAF9STLjDaJo4l/6XOePpkDt2KZDgKP7rS1l81nG+NgdyrdXodUAszTO
         wsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k3+8S4AY2uVpQH+RCiJkWL6MuiFNkRebQcOpXooUIsA=;
        b=DwPbVbDtO5KIZ7eEPmutVwb9MHEKiGNHnSbuCPma8pGbVIj/3oCfpF0FhylthnKT4f
         IXNdRB7jMnSC1L0SSukQlUeN3oPpQXa8XUzFm0mHtFd8PI8/hwp2ZsX+vPhv+ak4uV+u
         en9PDuVI1uIs22sNWsRlh5JTgcL15yNbkZwh7lDMtG+7csVp7MTsHvcGG3sIPPwVer6n
         gNCZ5Qy39wdclzIVYBiweier+9g2F/VWfrXzEnLkx0zJvO0HLqdl9dzywIHt0GKn4BfV
         Nqf+7lM5zZ++ToDmdvI/N3Lh7I9S/J1ZM5RWjoBFVWnX/xxhkVlugoJ/NWzE958N824j
         wr2A==
X-Gm-Message-State: AOAM532W0Xv5ixFVmW/IsLl9kxlaSYhxbzwO62WvmtNS4JTt1HXAzXsF
        +AmGVqJSZm6Rfc/dT+05/iRPRx7azrYoo/iMglxyy7uwLmN1
X-Google-Smtp-Source: ABdhPJwT/eeoChjn43sE/ao1TZ/IsnK0ThJEffFuAh/9tn9H3kFTSWY4tH65AalS8HYpIiGtsDZC/qIOpNi1KxCtjgA=
X-Received: by 2002:ab0:268a:: with SMTP id t10mr14988636uao.20.1589897927968;
 Tue, 19 May 2020 07:18:47 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 19 May 2020 15:18:36 +0100
Message-ID: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
Subject: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     b43-dev@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, everyone!

I've been trying to connect to a WPA3 (personal, not enterprise)
network but, as expected, the connection always fails with hardware
encryption (most likely due to mandatory MFP, which the hardware won't
do). What I didn't expect was to have the exact same problem when
using software crypto. I've tried with other devices, and they work
fine. One thing I noticed is this: for example, a Ralink RT2790
device, on another machine, shows the following supported cyphers with
hardware crypto=E2=80=A6

        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CCMP-256 (00-0f-ac:10)
        * GCMP-128 (00-0f-ac:8)
        * GCMP-256 (00-0f-ac:9)

=E2=80=A6 and with software crypto=E2=80=A6

        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CCMP-256 (00-0f-ac:10)
        * GCMP-128 (00-0f-ac:8)
        * GCMP-256 (00-0f-ac:9)
        * CMAC (00-0f-ac:6)
        * CMAC-256 (00-0f-ac:13)
        * GMAC-128 (00-0f-ac:11)
        * GMAC-256 (00-0f-ac:12)

=E2=80=A6 while b43 shows exactly the same in both modes=E2=80=A6

        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CCMP-256 (00-0f-ac:10)
        * GCMP-128 (00-0f-ac:8)
        * GCMP-256 (00-0f-ac:9)

This is a BCM4318 device (PCI ID 14e4:4318), but I don't know if
that's relevant.
Is this behaviour expected?

Thanks in advance,
Rui
