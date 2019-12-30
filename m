Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47712D30B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2019 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfL3SCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Dec 2019 13:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3SCP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Dec 2019 13:02:15 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9EB20718;
        Mon, 30 Dec 2019 18:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577728934;
        bh=mmLEN5EVhqLVybqcxDuhfGriciuvTU6AmdSNL96/umg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bc4RjaEDQ1ETswDQYyXiPwv76AKYwd/0t9BG0JWxVixpXvfl41zF0xXKTgUNwatnZ
         4Ehht6ai6mWNwzzvk7vA8L2KLFoZrZ5qF1vKaUzGzu32X22nl3rbzAQgjF5kWonh2j
         cY0epFe+rpWNCBlbvPFab1ZWvffD5T3CrOo10Li4=
Received: by mail-qk1-f181.google.com with SMTP id x1so26747306qkl.12;
        Mon, 30 Dec 2019 10:02:14 -0800 (PST)
X-Gm-Message-State: APjAAAVbBY/EsJUlYQrX+g/i0j4saPAU3AqSG9l0vXC2vKGIxIgbTvPy
        2fgda/WEIBoFcQRRjf3/sExddYS0KMSL8bvhLA==
X-Google-Smtp-Source: APXvYqxnbEUjGyxvCU4ntE7buUgy18mz5Tni7Bm9/X322VaakU+9YenlJraMm5LyISnrzCBgzdGBaqVdjNI50V7PeH4=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr56849186qkd.223.1577728933710;
 Mon, 30 Dec 2019 10:02:13 -0800 (PST)
MIME-Version: 1.0
References: <1576496415-23064-1-git-send-email-tamizhr@codeaurora.org>
 <20191226185132.GA31120@bogus> <62b9e7b140a96401469f7075811d0d67@codeaurora.org>
In-Reply-To: <62b9e7b140a96401469f7075811d0d67@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Dec 2019 11:02:02 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKspnQ50Muw-jeq+uE1+vj5nuzpxmYcOSFwY+n2Gj3tXA@mail.gmail.com>
Message-ID: <CAL_JsqKspnQ50Muw-jeq+uE1+vj5nuzpxmYcOSFwY+n2Gj3tXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ath10k: Add new dt entries to identify
 coex support
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, devicetree@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Dec 29, 2019 at 10:07 PM <tamizhr@codeaurora.org> wrote:
>
> Hi Rob,
>
> Thanks for your review comments.
>
> >> This adds new dt entries qcom,coexist-support and
> >> qcom,coexist-gpio-pin
> >> which will be used by ath10k driver to identify coex support
> >> of a hardware and notify wifi firmware the gpio pin number.
> >> This pin number information is needed for the hardware QCA4019.
> >>
> >> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
> >> ---
> >>  Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt | 6
> >> ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> >> b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> >> index 0171283..a41e936 100644
> >> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> >> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
> >> @@ -87,6 +87,10 @@ Optional properties:
> >>      Definition: Quirk specifying that the firmware expects the 8bit
> >> version
> >>                  of the host capability QMI request
> >>  - qcom,xo-cal-data: xo cal offset to be configured in xo trim
> >> register.
> >> +- qcom,coexist-support : should contain eithr "0" or "1" to indicate

typo

> >> coex
> >> +                     support by the hardware.
> >> +- qcom,coexist-gpio-pin : gpio pin number  information to support
> >> coex
> >> +                      which will be used by wifi firmware.
> >
> > What combinations of these 2 properties are valid?
> >
> > Is qcom,coexist-gpio-pin required for coexist support? If so then it
> > alone should be enough to enable/disable coexist.
> >
> qcom,coexist-gpio-pin is required for QCA4019 devices. And other ath10k
> devices doesn't required that value.
> So only added two fields to enable/disable coexist and another for
> notifying the gpio pin info.

Okay.

'qcom,coexist-support' can be boolean instead. Unless you need it to
override a default setting.

Rob
