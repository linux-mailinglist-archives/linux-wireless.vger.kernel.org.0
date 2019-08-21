Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9401A980C1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfHUQzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 12:55:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40125 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfHUQzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 12:55:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id e27so2812284ljb.7
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fC+xVlvgXST1/NQH//ytY3s0lRg4O2zmw3CO7A9igoE=;
        b=PFdpxL5seBUCI3yKCgNoc+5iwrFx1oO7MixJbwzFHyRUUiafibbcrl1sIveU2Bd+5o
         ySd/Keng9axup1SAclUnwknR8hhFRzuYR/2qZ2/e/atDI4co98OKbSV2ND/YtKqDqs9w
         1Kr24gxT44zDWYxM3y15P1y4xwb1RnW00j5Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fC+xVlvgXST1/NQH//ytY3s0lRg4O2zmw3CO7A9igoE=;
        b=kZ7vlMvmQNzVplUcv94rftoZ5VWInIuKFX00dmisNU2bPBPXOKH9k3njcFlgM/YEuq
         C3/lPGh82W3JJduk4a4YhVS00+vPj6rf2pTYsBHMzbU+evFyFK9O0vCyCpCoxFBW8rTI
         lRX5ltBRymuujWS0JP/Enzjf8IT5nX4X8Nh5iQwPLAW/+jp3l3kcrmYO9HQ2vWm7j03f
         yJwZwBFD5uo9LSX/u89B/pp841I2gjA5bGJJs7tnPi8WbVTd/OHYAJbtIe98Ifnj5Xxs
         6rPgQZnLM4kiT8ghh/sjaNKtAAHj5R8b/c7/F4bgshmuapdYq7yFZv0lUouYlAeRlDUh
         rfNQ==
X-Gm-Message-State: APjAAAXyDRQ8LROoegaafrUhxGP52LHDnFoMIKuqB31r3N66OYrxJ+Lg
        qzD8WG/YnPk8aCF6e+n44yheU7SMwGU=
X-Google-Smtp-Source: APXvYqy+k/8F02SCapMNP5sxZC9mujseTq0n986XCR16pGototvdyV3/VQ3KmdZDMF+ZJsPRryuThQ==
X-Received: by 2002:a2e:9597:: with SMTP id w23mr18798306ljh.147.1566406510636;
        Wed, 21 Aug 2019 09:55:10 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j4sm3407801ljg.23.2019.08.21.09.55.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:55:10 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h15so2785772ljg.10
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 09:55:09 -0700 (PDT)
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr17998911ljl.18.1566406509095;
 Wed, 21 Aug 2019 09:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAAooHFeLWrY_wmCp-HWqygh8gnKsfpoPCky7SykOBKZgXkb8OQ@mail.gmail.com>
 <20190403210200.GA93453@google.com> <211816ff03cf188d834a21b1fbc98b4f8c5b81f4.camel@sipsolutions.net>
 <CA+ASDXOyXb0dPGOrjQR7C-b6dyftiZhkta3cwG28B9sC5wxHxQ@mail.gmail.com>
 <7687225C-D965-479E-BAE8-769B0AEADD76@holtmann.org> <CA+ASDXNC0hwFzSTvZmUq-B7r_H+pZ3N=p_kjfMqKb1gftsmDKw@mail.gmail.com>
 <7CCE8D56-9E1A-4E04-9C28-E384C1B2E2EA@holtmann.org>
In-Reply-To: <7CCE8D56-9E1A-4E04-9C28-E384C1B2E2EA@holtmann.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 21 Aug 2019 09:54:57 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPhX3Yet=dJn8Pet_inP1uyueFZqBmuNXvmTrjv1r497g@mail.gmail.com>
Message-ID: <CA+ASDXPhX3Yet=dJn8Pet_inP1uyueFZqBmuNXvmTrjv1r497g@mail.gmail.com>
Subject: Re: Flag for detecting 802.11r Fast BSS Transition support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Matthew Wang <matthewmwang@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kirtika Ruchandani <kirtika@google.com>,
        Jouni Malinen <j@w1.fi>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Aug 17, 2019 at 6:40 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> And if you have a distribution or an OEM that cares, then that is what is going to happen.

I can see where you might not be particularly sympathetic to this
concern, but where I re-started this thread, I added in Jouni, due to
his mention of:

"There are such drivers [supporting FT] especially in number of
Android devices and I'd
rather not break those use cases.." [1]

That doesn't exactly sound like a case where he's willing to break
compatibility with older kernels in new wpa_supplicant. But maybe I
shouldn't put words in his mouth. (On the other hand, Android systems
are likely to not ever get either kernel *or* wpa_supplicant version
upgrades, so maybe it's not really a problem at all!)

Anyway, I'll just cook a patch, and then figure out whether/how I can
teach wpa_supplicant to respect it. (Or, continue forking
wpa_supplicant as we have been wont to do...)

Brian

[1] http://lists.infradead.org/pipermail/hostap/2019-April/039951.html
