Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1CE16B298
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBXVeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 16:34:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39757 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBXVeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 16:34:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id n30so7119657lfh.6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol9mP/mNc/B093KYQ/yfySi+spT89kwBay5njJjbJBs=;
        b=I6B1JyH1DxItKJyekTpKrtM4jGRiuw7CvR9YkTvluedbOfrU2QhSRstp5mp+Q/Tb1G
         Vzu2y2RvIu4H7BelrmXS/BorpclOYqmkgV2oMClQG0EjhUzdjcmiHvU6kb/jbpCRxh3G
         HsVailsVsCdD8JZpz0aqk0mmW8o06w0uyEG20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol9mP/mNc/B093KYQ/yfySi+spT89kwBay5njJjbJBs=;
        b=qoNp9R3H2SAzoZMvsH7kcv79n4aD5iCL2zHDohuxMvzbvlb3msBmOkFGqlQUgiGYJn
         /iCYrXw3GWhQkiDCIzSlGs0zevJF8n4nQOFBLEAUUh24QdMX0PQKv4EtiQqYPgqXzIC0
         Km40GoqcjrHrNJa4aJhXuIpgBFMy7utM2R8/CXeUB9O9tS4YSHZcnBKmhRNvJ+Q23nit
         rLpzdxcq0SYCtIwbUbUk/HDPa9bdn1rOucwtpO6p9qzILHWtqN3FH1JAMKSmd/JYdfHB
         gpteQrB75Y8FRoM8lmDetRYd85UFfOYxGfR5TDzRoyLUsAZSEUq+kKwc4SZ59OxkbMIq
         bALg==
X-Gm-Message-State: APjAAAVMs+94u8eaoBPoHZPw8EhlIi0REfOAcAiYc8qcGI07IMakVQIc
        bm/l8ExS/G165sUAQJJFZjYfEVcE3BE=
X-Google-Smtp-Source: APXvYqybLZaKqjRDvU3a8ixEOfnd2oaQCWxvAHBCkYyw9jo4EFlvLhZYE7qfgio+pyWZJraQyNZ97Q==
X-Received: by 2002:a19:7b0a:: with SMTP id w10mr28386292lfc.90.1582580047550;
        Mon, 24 Feb 2020 13:34:07 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z22sm6276604lfd.87.2020.02.24.13.34.05
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:34:05 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id h23so11756449ljc.8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Feb 2020 13:34:05 -0800 (PST)
X-Received: by 2002:a2e:8804:: with SMTP id x4mr29228335ljh.187.1582580045467;
 Mon, 24 Feb 2020 13:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20191219085816.20709-1-yhchuang@realtek.com> <20191219085816.20709-7-yhchuang@realtek.com>
 <20200222005242.GA100360@google.com> <d7c4c85ca707118a612a34607b4980b2448f2059.camel@sipsolutions.net>
In-Reply-To: <d7c4c85ca707118a612a34607b4980b2448f2059.camel@sipsolutions.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 24 Feb 2020 13:33:54 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPP31bXpjvYz=hbR_WmwbXb77NRodgSThcxnDgME5vFJg@mail.gmail.com>
Message-ID: <CA+ASDXPP31bXpjvYz=hbR_WmwbXb77NRodgSThcxnDgME5vFJg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] rtw88: Add wowlan pattern match support
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Chris Chiu <chiu@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Mon, Feb 24, 2020 at 1:21 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > This also hints at a deficiency in the wowlan APIs:
[...]
> Yeah, well, we didn't dream up arbitrary restrictions when the API was
> added :-)

Sure, I didn't expect that sort of foresight ;)
I was just highlighting that (if rtw88 can't fix it some other way)
rtw88 may need to extend the current APIs.

> It's maybe a bit harder now to add them, but we can do it in cfg80211,
> and reject it if the conditions are not met, and then older userspace
> will simply not be able to figure out easily why it was rejected, if it
> doesn't understand some new features bits/capability advertisement, I
> guess?

Seems reasonable.

> Ideally, this can just be fixed;

Yes, I'd like to see what Realtek folks have to say.

> if not, IMHO better to add some
> advertisement bits, but if not then we can surely add some kind of
> filter callback that's invoked at config time, rather than only at
> suspend time when it's way too late to do anything about it.

Yeah, I'd have to see what sort of restrictions we're working with --
sufficiently complex rules might not make for good "advertisement"
bits.

Thanks for your thoughts,
Brian
