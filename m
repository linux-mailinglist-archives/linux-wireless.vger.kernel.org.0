Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71EBAD9AD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 15:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbfIINHF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 09:07:05 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39932 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfIINHF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 09:07:05 -0400
Received: by mail-yw1-f65.google.com with SMTP id n11so4733183ywn.6
        for <linux-wireless@vger.kernel.org>; Mon, 09 Sep 2019 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HrzW3VB/q2r1Q6KPFAz7jaBapkI4V54IDpJ0PkrkRQs=;
        b=sDldOrX8wbMtITxBeCIBxjU4E2OteFV3Xl27joGMILvVgCuebTqQkR5y531a2l2eB6
         KCIXxi4mmXdHhB6chky4ZMUweggrKVOfBmai51+ATwlIIA8AUrt8cGL/6XkV3ZyHzu01
         ZHFUgUOaNkA0LZ8K1GPgpn/9yC/1pDCqpj6YPjjJhouI4+CPcyZVe8l7w1MvO6zxTj5X
         KRuqMlKDkVqLRQPDGp+BcFHW4+plZ/kNdLE4SjpTbrqiXrhZKlDEX0J51QA2Z3C+goxW
         Do+Ngn2B6A/9qN62dS6pFoo4ftjKk/IpOJrjsm9QtYLaSpBTby1duJ1Ce3y4/jZM3BoD
         DZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HrzW3VB/q2r1Q6KPFAz7jaBapkI4V54IDpJ0PkrkRQs=;
        b=Ah6wzzoSkQDk9XUZzF3vBs+dcMeQvoRgYigU3ClJ8pybMfiCLghNGktVEQpWuxO/XI
         dlDwq/fnySNskfDtu5FacTfUVbGDPtiaMlylp3uhWJpm39A68wN0rrA2tW0fvi4P21oq
         ZIHv0JC5b71AoK1tyFzibo3Dcfb3xyESSsJaP48UW1oytNmHIjktS88Lsu62xBH+3Vro
         kaprm+KLife5a+ZaFCLZ1gv5noNRD2dxBmi0odpxF8q2hohJYrTYe/7BkcPn7+tZ6x4M
         j09N39Vg/XfR22rm/e/X3euNEmkojQ4kRO5r0ApxnQFULexw8j5fEsNd3yO/a4uZ4esd
         kxaA==
X-Gm-Message-State: APjAAAXfNLUIg41iWe1hxwuBmUzzXxAduZQoTfUCbyM+9P0AXNVrJV+S
        iJoGe3LR1G7nUApy7iGrhNi9eV0jD1rubc8joxWK7A==
X-Google-Smtp-Source: APXvYqyPzGuU5mhTJLWr7uOfVFt5x7EOiJPZir+0SYxRGpz21vkg0A4tGtUryiNIQmOUqxsPR5WgHElLKQ7rO3x6NZY=
X-Received: by 2002:a81:411:: with SMTP id 17mr16003029ywe.235.1568034424507;
 Mon, 09 Sep 2019 06:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190903042928.18621-1-zajec5@gmail.com> <251e608a-c311-3827-02cd-886c8403f7ec@broadcom.com>
In-Reply-To: <251e608a-c311-3827-02cd-886c8403f7ec@broadcom.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Mon, 9 Sep 2019 15:06:53 +0200
Message-ID: <CACna6rxPTqy2fReSOq2qx-LFJALuSQfbBcqhb48acY7jv4J6zw@mail.gmail.com>
Subject: Re: [PATCH 0/3] brcmfmac: keep wiphy during PCIe driver lifetime
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
        <brcm80211-dev-list.pdl@broadcom.com>," 
        <brcm80211-dev-list@cypress.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 3 Sep 2019 at 20:51, Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 9/3/2019 6:29 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > Driver's main init/attach function brcmf_attach() was handling both:
> > wiphy allocation and driver initialization. It meant getting a new wiph=
y
> > on every init (initial, resume, error recovery).
> >
> > For supplicants/authenticators and Linux users it's move convenient to
> > have the same wiphy over driver's lifetime. It allows e.g. automatic
> > recovery after a firmware crash.
>
> Typo: 'move' should be 'more'.

Well, it's just a cover letter (0/3), that message won't go anywhere
to the git repository.

--=20
Rafa=C5=82
