Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B869F1BE7A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEMUPR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 16:15:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfEMUPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 16:15:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so16655049wrs.11
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 13:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WseHiS737oljtnoWHZSGwODZuVgoSFVRNVAi+JX4ZKo=;
        b=LJuQoAeG9sNoH/rt3nDFVsTOoqMD2S/rAlTereAb9m5ZdXNBxki+1340Ey0bpj6Q08
         T8gXC2cO2bKz1OygbTDe5CF7xxiEAqNvRFM8+/JMrFmGtU0bwztoydMt+0jFmLLrEyRF
         70VSlNeCGzzVGG5ltH5xbQ4uLjD0SleKxDVx8qpCVArxhz9VfIjA5UFhsjjybWDZkVxi
         uV1TKARmgNbDusa2QRQBFyZN62vvKj9Fq+s3hjncJOJIDz8AY5uLEBNcMVoZSNi8SUBv
         KRDyiRjhdl/B2PTLSYhiJx+kM8bXDLLj0sf4YSDruj0I8xXbsADPGJYE3Kd3S7qqG3/X
         IoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WseHiS737oljtnoWHZSGwODZuVgoSFVRNVAi+JX4ZKo=;
        b=KKqfILNLGFC+A6kNiZsTDE+MIcIIw9xncron+fnT1USadGdjE+ThLZh7SVdCceQvqW
         GvBIBkrMjhYjRqIj13YZZzIQmJF8vLcHgWfAjeETSgqd4ZLfOlxWAkpfGVKhq32OxQ5h
         ZZ9CaT4AYCvYryeFk2OOEzqDTFCrylBLWzfjb3TxZR03qJ65k6gnSiIh05Q6Kj+1/X6m
         jYDW/FQUOAcSM8j6bp4j8VGqfW4ewQvOFy/k6YaYgjNKaKKYAPU6NqKsV2mt3+HnmHCl
         mUh89OdXA6CBehMdRqSTw0cQ5xmhPGzPhQlpmXgxjIrIpJIEvP/8jCH1aZxIocuX6g8L
         0zlw==
X-Gm-Message-State: APjAAAU+1tEd8PoVURUDZGSuq//JQbRb0nVzlv6hP3tu71Bvtn/PhAR9
        QEdaMSp5ffGdjbF1+Ji4viJl2epkz2LEfHCdg1g=
X-Google-Smtp-Source: APXvYqyJ3LBZ1Vw7Zu4BUBw+/9RMxuP8SjrM9N+MIHZuAlAgWc9U5uueDq7nfKIHhqBwMRWboqaP+x1l+vloSFw6QGI=
X-Received: by 2002:adf:9e46:: with SMTP id v6mr7193558wre.141.1557778515522;
 Mon, 13 May 2019 13:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
In-Reply-To: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 22:15:02 +0200
Message-ID: <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        robert.dolca@intel.com, oleg.zhurakivskyy@intel.com,
        clement.perrochaud@effinnov.com, charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 5, 2018 at 8:38 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi,
>
> the discussion reference is on github [1].
>
> I acquired a Lenovo x280 with a NFC chip. It is unclear what chip is it
> really, it is called NXP NPC300 which could be a PN7xxx chip range.
>
> A hacked version of an old deprecated out-of-tree module made the PN5xxx
> to work with my laptop but I suspect it brought some subtle instability
> on my system.
>
> Now it would be nice to have this correctly supported upstream.
>
> I dumped the ACPI DSDT table and got the id NXP1001. This one is not
> listed in the match table of the nxp-nci driver.
>
>  - is the driver missing for the so called NXP NPC300 ?
>  - should the NXP1001 matching string to be added to nxp-nci?
>  - is my firmware sending me garbage ?
>
> Thanks in advance for any input
>

[ CC Andy ]

Hi Daniel,

I was able to get a NXP NPC300 NFC device run on Lenovo ThinkPad T470.

Look at the patchset "[PATCH v2 00/12] NFC: nxp-nci: clean up and
support new ID".
I have tested on top of Linux v5.1.1.

Here I have set...

scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C -e
PINCTRL_SUNRISEPOINT

Please give this a try and report.

For details see the below references.

Thanks.

Regards,
- Sedat -

[1] https://patchwork.kernel.org/project/linux-wireless/list/?submitter=33142
[2] https://marc.info/?t=155740978400003&r=1&w=2
[3] https://marc.info/?t=155774435600001&r=1&w=2
