Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1254227E775
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgI3LK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3LKV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 07:10:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58375C0613D0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 04:10:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so1330883wrm.2
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mgERC2re+LsQHv7WHehbQUmBGbS8iq333nN2VyixEQ=;
        b=Lef71amHGweagbo5hPClbodyOxYqqm3V53cYc6ws5IcSNCyHr7PnFK7gFhvd9e9vzi
         7tpBe5IwPJ3viwdbl7PQY3ffMe4uAAS99/CpCU9PV7j0kasr8bRQGdndMwgpgseocmWU
         MEX7yRxAF0WjqKbl+FuNs1A6L+JGqOYs2rue+iuOpIGuYHYIidz7810IEbZSPRRcx9no
         oHEcP4Ccwbn4ToFGWvDiIagOwvS1UxSqXBtUJ53Iw/KNAYjv3sugX4CLJv2mikGGyiyc
         3YZBRuxb54ev35XxIcvUwsL3w92YyCrdTqXpA0YReGp0eoHj8UVgVZNsKHedEW8xLRsD
         YHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mgERC2re+LsQHv7WHehbQUmBGbS8iq333nN2VyixEQ=;
        b=eq2pFdkynvufFC1x5z5OLOlIJumAF81cfWvnriU0nkS6zfsBVR2cp1c7nedLCN/v1g
         oJk4PH9DsFIm5/xvomopramY6/eCGUwIl4tCloOQOeBR/DMMIZ7JYXUIZ2jG69qzcC8u
         mG0u+0tQewzFDIZw84VwFSnjdHA/SWFzpXjZOMEI8DzRpyLnYywMknkYsw968q5lj6iI
         VDa8DaZ9wAAZ7BFUOBlWxe/JqdOQ2L4x6/v0qh9tP1egOmpS9Giaf7HWjSX0+916yJyl
         QW995kRQVxrgNyhQYVstv8Y11m1tqXIHemTKeKOi1vp/UVB5eJ1FIXZEyNyPwiyMTns2
         enNg==
X-Gm-Message-State: AOAM5326fENEqs7LgT/5FqTzNYIClkd3lAbGfHa+lYMLev3pd7XXBYBW
        ghpTn1p9vdMNqLc5A4SiYlkEWtp+gFUe5zGa1PV18A==
X-Google-Smtp-Source: ABdhPJxRAYAdDId2wFAHvCCnCfATHqjzpdk/XpVpNAQwQh/eUI2ddso1JTacHLyknbdLNgOUWFmFEXuBxkd0/Q3MKEE=
X-Received: by 2002:adf:e952:: with SMTP id m18mr2478350wrn.171.1601464219892;
 Wed, 30 Sep 2020 04:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <1601058581-19461-1-git-send-email-amit.pundir@linaro.org> <20200929190817.GA968845@bogus>
In-Reply-To: <20200929190817.GA968845@bogus>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 30 Sep 2020 16:39:43 +0530
Message-ID: <CAMi1Hd1NhPipHMWFjGu6MMJDNRNndmvYrEt-5sFowYJPwtJdxw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Introduce a devicetree quirk to skip host cap QMI requests
To:     Rob Herring <robh@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        David S Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        ath10k <ath10k@lists.infradead.org>,
        dt <devicetree@vger.kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 30 Sep 2020 at 00:38, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 25, 2020 at 11:59:41PM +0530, Amit Pundir wrote:
> > There are firmware versions which do not support host capability
> > QMI request. We suspect either the host cap is not implemented or
> > there may be firmware specific issues, but apparently there seem
> > to be a generation of firmware that has this particular behavior.
> >
> > For example, firmware build on Xiaomi Poco F1 (sdm845) phone:
> > "QC_IMAGE_VERSION_STRING=WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1"
> >
> > If we do not skip the host cap QMI request on Poco F1, then we
> > get a QMI_ERR_MALFORMED_MSG_V01 error message in the
> > ath10k_qmi_host_cap_send_sync(). But this error message is not
> > fatal to the firmware nor to the ath10k driver and we can still
> > bring up the WiFi services successfully if we just ignore it.
> >
> > Hence introducing this DeviceTree quirk to skip host capability
> > QMI request for the firmware versions which do not support this
> > feature.
>
> So if you change the WiFi firmware, you may force a DT change too. Those
> are pretty independent things otherwise.

This is a valid concern and I'm not sure about the other devices, but
on PocoF1 I have tried all the three released firmware version updates:

WLAN.HL.2.0.c3-00257-QCAHLSWMTPLZ-1
WLAN.HL.2.0.c3-00445-QCAHLSWMTPLZ-1
WLAN.HL.2.0.c3-00534-QCAHLSWMTPLZ-1

and none of them works without this skip host-cap patch or equivalent
hack. PocoF1 is already 2+ years old device and sadly I do not expect
any major vendor update coming its way.

>
> Why can't you just always ignore this error? If you can't deal with this
> entirely in the driver, then it should be part of the WiFi firmware so
> it's always in sync.

I don't know the technical details of the ath10k/qmi driver, but I'm
OK if we just ignore the return value of
ath10k_qmi_host_cap_send_sync() and move along.

Regards,
Amit Pundir

>
> Rob
