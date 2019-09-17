Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFFB52AA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfIQQNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 12:13:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46889 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfIQQNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 12:13:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id q24so1714762plr.13
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2019 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iv/RJWpHTKw8GkHY3copO+/BqYn19rOzgW2DgV/n0DQ=;
        b=JHdgEkWz0WZ7B57440ViPheeEGL2/GXBvfTsq1KEcppPHoKK3VVIxg1GOV+drrubyJ
         i2dyfiQrUp/QPTkcwxVO0abScGMgT/hcWVzpmGbq6/nQVqi45DrFBOUiTOrbhOFrVdez
         wiU3QDu+Ykegah7bH8kH/H4ORLnWgHqGUyR3f5m9ZP2QAbAstBXm4EGFEXZF8IcPD6PZ
         5nDvfxEO9Q4r5SeMm37O2hJe8jwuTq5L8qM15GXJAz5tCuaiyVrcUxcrCXncO5CAKKzb
         F0s8QrL5hJOyXS172S+/4AuzjGJ/ADubmHQDFkM5g2WbwSSJtoF3oIk3zVyEZEBUvJqk
         N8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iv/RJWpHTKw8GkHY3copO+/BqYn19rOzgW2DgV/n0DQ=;
        b=pu+/En39PiWDqEdevxQ/cb/aZyCJ8tVqN3mVJeEoHowxOcM/N1MUoNkkPJYd1M4Dmx
         AAimMrsY2vUzVa8iUsWO+5BHRA0OiYXlIVfxJCDLFJIT0ReAOo7OQUdZ7B+wkTlF7A3/
         GGSds8aiGjNRr/CM6CSflmsFPHQwYdwCwrqJUbqp9aF/S27fxLgkEOdwQJ1bKp7ivzG3
         HcbEfiZ63WADmjZZwX3ipv6MKt79fBe9ZP/pAEV3hTSJQ06WynoSv9FCQtYKBTktmeND
         mPQ1fDXH+HP3FpyjnQECCpJwtOnw4cVuwXLyOwW6aETBw2MPSpTjxWD8GeFnlevKZXVk
         zjjA==
X-Gm-Message-State: APjAAAV0gVgTJxDma0YGBuI30fPHnAeYg2CyHfrSOqQm6oAwLmaXvOcc
        lGG9+ZOPXqdUeS9o2Q4R9rQUbu7/fGQ=
X-Google-Smtp-Source: APXvYqz+6G+ZtYC9CDDnzzkEtSEZyUDd9XhvOxz8hdFs2IrXO3hFYr4QX2R7oVm/ePjCtw5cho8HOQ==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr4219494pls.165.1568736827056;
        Tue, 17 Sep 2019 09:13:47 -0700 (PDT)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id v68sm4536301pfv.47.2019.09.17.09.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Sep 2019 09:13:46 -0700 (PDT)
Message-ID: <636f968e6b31abf98512c78e0a03d89d6e469e8f.camel@gmail.com>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   James Prestwood <prestwoj@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Tue, 17 Sep 2019 09:11:43 -0700
In-Reply-To: <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
References: <20190904191155.28056-1-prestwoj@gmail.com>
         <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
         <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
         <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
         <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
         <87a7b8lciz.fsf@tynnyri.adurom.net>
         <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
         <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> 
> As you only provided one number it's clear that you are only working
> with one driver. But for us it's not that simple, we have to support
> a
> myriad of different types of hardware and there can be complications
> and
> additions later on, even for simple features. Like the dynamic power
> save support I submitted to mac80211 over 10 years which was supposed
> to
> be simple, and still we talk almost every year how do we get it out
> of
> mac80211 as it makes maintenance difficult.

As Denis said we are happy to test other drivers, granted I do not have
*that* many cards on hand to test. I understand the kernel needs to
support all kinds of hardware, yes, but what is your concern with this
patch specifically? What kinds of issues do you foresee this causing?
Or is it that you simply don't know any you'd like to find out?

Thanks,
James

