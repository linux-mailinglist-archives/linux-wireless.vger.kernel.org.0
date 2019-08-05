Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB9B825AF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfHETki (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 15:40:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETki (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 15:40:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so7346153wmd.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Aug 2019 12:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Wh68yPt+IQj+lLhA+0LBEh0DgFqyBXSzdTmMU5WM+DA=;
        b=EBUhF4oqXDInC/4YE0VTgmrP0drpFvRtAuSC6MUIi4YpN7EdiLueTbgLGUSMSYtFo7
         LJcc355Kle6J/1j3vmYAC2nk0eB1V5Wacc/saMfv9GRXuruSXssl8mstLpQRSn/DWlhD
         3hiZj3xHY23AJWQDCljmsIwrdDPGDgJqOa0l9UcHzRY5Pi4Mi6JTrsjI+lA6kFFQQce/
         P6jJOoNPay1HyRLFG0rBAARpYS2i7AeYXyIO2PI3h1tR0x5/F/8BNV5qKt4JwG65guf2
         UTKjXTmme8ZuwmlG/xsg4h9xmstUBZZg/P+1dWkpf0I12S4AmmW/Tyh2ioLdjNDZX+4a
         4QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Wh68yPt+IQj+lLhA+0LBEh0DgFqyBXSzdTmMU5WM+DA=;
        b=g14XonrTehkEJ+IkqBoP/Oz+HylmkqzpJiQPqbpVx9iclgOckEx2ctwqq3NENuhPfx
         2+nFGXzYs/tQvQk2B5zEvhBkGHlNlXp0QxntU6rgOaouV/q3TuJi8rq8liwfUPnTAjYJ
         GJveR/k9NzwflHU204dGQ1YG4UCGKpM3w953Jgl80nsppMdxVUuxeYmQVGw8UqWtcInM
         W0IYFQvxMzHYMWRx15csNZyrRaFKBNfeRy6NeTUogZEESXKL2EsSzaVhy/URqYFL4xpr
         so8YU5Gajp86fk2kD/iIacD3c5sxxiQde5FZ2r8Qq3wiHnS4c1XfuzwgdWoVt6vMLkDD
         gXrw==
X-Gm-Message-State: APjAAAWRv6OkN6gb2h9zwNgWzUbLE6XHwS9l1wQmAAHAMaUW9tm/3x1Z
        Xo1YJT9RZBcoCWj880v+s991UtxPdJIT1MsS0ao=
X-Google-Smtp-Source: APXvYqwkcw7UsqlP4Oea3mY4hew9pW5IetOrTlFz4xXYS/fMFW0vwxmKXJts0KBM3CO5TF03cN0K33ivFuZeLTVr72E=
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr28793wmb.150.1565034035841;
 Mon, 05 Aug 2019 12:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com>
 <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org> <CA+icZUXDLQKyTH-_pPi7A2=Bu5ratwab930Fcecrdr4NtMnFcw@mail.gmail.com>
 <27f2ce02-8deb-384f-af10-7737b703770a@linaro.org> <CA+icZUVaBdswfmRfbRtdVJY8ymeDOwDSFEf7G6jneqEmpW84bg@mail.gmail.com>
 <525160f3-a76c-4b45-2e05-c27aaabbf74d@linaro.org>
In-Reply-To: <525160f3-a76c-4b45-2e05-c27aaabbf74d@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Aug 2019 21:40:24 +0200
Message-ID: <CA+icZUXfx2N_EOJG73bas78ernDeHfiByeiH1yOCb-HmgEnO-g@mail.gmail.com>
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

v4 of the patchset was included in net-next Git.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
