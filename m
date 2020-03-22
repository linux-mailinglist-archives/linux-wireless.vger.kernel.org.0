Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4439018E8B1
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Mar 2020 13:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgCVM0t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Mar 2020 08:26:49 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:41674 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCVM0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Mar 2020 08:26:42 -0400
Received: by mail-il1-f178.google.com with SMTP id l14so10457730ilj.8
        for <linux-wireless@vger.kernel.org>; Sun, 22 Mar 2020 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=e0BbbFBjNaqWJAORJJW2eiwBf9ukrNp83gXIJkh+fsI=;
        b=AfnNyxd4kMYhiM3PLI84DsiTJTbx+iHb43d9RoNPT1egZwTsxTPDKJxuWBsk3j8+Vc
         k14RQ5f/Q7Z5SGOS20rG3fleibNbRtMKVqJ2wnmGaEW5BYE8rDxXnRrx9kcys5f9xlka
         5QMSYPLfBXjzPgPSm0sz5c7lW0gwxWuKo6ZpJ1JqfUlrPMyhBQ8uC6nrBouyESiYa2YF
         /zohsBR6qRDcJWIlGNBuo4U0/DpCLGqPKnJSraIxNGbqg3usF63mhcXZ5tYlBO3AUMN0
         7wY0aYYKh5vL3kCqi20tGyPldeB0bIEFBN6kdh41RFtLI4TnflFygLawxSlkhQhgQ2UO
         gAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=e0BbbFBjNaqWJAORJJW2eiwBf9ukrNp83gXIJkh+fsI=;
        b=SC5Wt+075AipqRDD56H8lCloRh2saIF6vCbH0Rn0Gnp1Qpc3L2E6/IK3u2DHeAQMeR
         dVG7y0Ab0Db/P4NZhy7i5pIuHdv6U9Wogt08Q2wuVzGZgn3oHGKSaD6WKg8+RHZXS/yg
         71Wh1qY2X2XiBOqXxec1sgSOz6rCk5JuHeG+SKOStKH4yrlBlNH4yJbMmpyU2etpB6mk
         pAs8oIWTbTWjDTHyQO3zM9pXgRcR82hiFhtrJLHzlqxUwWUV/RLHuxNNzWVOh3CZ1oRK
         f1utd1DLJdNbjelD/Js2mZpKRu5moXEfPo6NwesI9+DXN1sVsh9LlP0b693cQPClV1jC
         lNzg==
X-Gm-Message-State: ANhLgQ0V6XCSK6crpgsAwhRc5/kh5SmrgDkwv0EYZOyx/rs10PYj6fAA
        A6F0I8FKSmsqgiQ9yjb2RiF+Qpa+oagZtXhsKGo=
X-Google-Smtp-Source: ADFU+vtsoseSwGrqA/UVOcLQwGDSMZZApfoJL9GDohKy3gLmr/3/MOFtajjEU6e8thsLjGUW546IAQyj4WpwmgLABIg=
X-Received: by 2002:a92:ce51:: with SMTP id a17mr1033538ilr.263.1584880002161;
 Sun, 22 Mar 2020 05:26:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:8742:0:0:0:0:0 with HTTP; Sun, 22 Mar 2020 05:26:41
 -0700 (PDT)
In-Reply-To: <CAOzgRdZ9jzhg5a5T89WVWFan=KOfxuff7qxnX9mXXv5cc-nznQ@mail.gmail.com>
References: <CAOzgRdZ9jzhg5a5T89WVWFan=KOfxuff7qxnX9mXXv5cc-nznQ@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sun, 22 Mar 2020 20:26:41 +0800
Message-ID: <CAOzgRdYsL6=DWxrs1KE2ktnRv36Bt_SkmZZHRoJ=TqTCqr4PTA@mail.gmail.com>
Subject: Re: brcmfmac43430a0-sdio wifi speed only 30Mbps under 40Mhz
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

linux kernel 5.6 rc6

[13726.460088] usbcore: deregistering interface driver brcmfmac
[13730.674252] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[13730.677765] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[13730.682114] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[13730.687617] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[13730.916588] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430a0-sdio for chip BCM43430/0
[13730.916906] usbcore: registered new interface driver brcmfmac
[13731.024690] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430a0-sdio for chip BCM43430/0
[13731.024825] brcmfmac: brcmf_c_process_clm_blob: no clm_blob
available (err=-2), device may have limited channels available
[13731.026035] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/0
wl0: May 29 2017 00:03:43 version 7.13.53.9 (r664949) FWID 01-130000
