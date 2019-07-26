Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB86770FC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfGZSJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 14:09:04 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:35295 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGZSJE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 14:09:04 -0400
Received: by mail-lf1-f47.google.com with SMTP id p197so37641451lfa.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2019 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lo01V+SNW5wwzoAMH9rJf+YJszDrP9Hf0Zya+ZOXPpQ=;
        b=S9ADumrJQOCDrGD6o+MbFt7BJO8+9ZgYbn3Q0aAYkS3KgB32ZoqIw1Q8EbtL7r0WPy
         3YauhgOB+h2lTP9RLG73c7YEtOxqbwTg/C0r6m6BHxG92LXpaRcpBZMnJxHKBQQurV/v
         /KbOrjDv/TQxgEnU2Bm/qX7Ffz6x5Dd+4WfxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lo01V+SNW5wwzoAMH9rJf+YJszDrP9Hf0Zya+ZOXPpQ=;
        b=OZ87/c/poF4ZrJX2gz3ZC1cm4B2mUtYkhucwnKv3qOH+xmYlmDYS59iliuj7g1meaZ
         YO6XKiUo8GmgaN9zmG73VxL1l23RkCrhajma2KxfkH781G4rqQ4S8M7LpW50MQ5sE1Of
         k5YsI+MEOqKo38+KkLiXVpjoinK77aSzaV9gFZFExWAjHdcXAhwIZ9FBLgT2GgGLsj29
         /lR8kOoYj5ZiOShTP0zV4GfMdaTopztldTVeDCk0T2u7BMJLW/bnqqjcQ86i+/25dZ2x
         +Y8TjhGzZwylicBntRZsgCt2NQS/Zilm13RZbDDiokOU30aVP0KUch6w2mo5R4jxzzqI
         6PIA==
X-Gm-Message-State: APjAAAWIVjgM3vOfzX1jkZq178s0PKdvy3xOo3Jy6m/Y100z8XpzVYx4
        /RCOEh7SVyOlhgyyNm5l7+xBfR2ogz8=
X-Google-Smtp-Source: APXvYqxG9LUmfD7czwWxqE+b1Lq9YUT492BhZ4eUR9HE381iReIPIhqWlyaLE9x3HSUZPsnIJjV+DQ==
X-Received: by 2002:ac2:5e82:: with SMTP id b2mr1604811lfq.3.1564164541870;
        Fri, 26 Jul 2019 11:09:01 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n1sm8584916lfk.19.2019.07.26.11.09.00
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:09:00 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id z28so52412355ljn.4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2019 11:09:00 -0700 (PDT)
X-Received: by 2002:a2e:9758:: with SMTP id f24mr50743056ljj.58.1564164540330;
 Fri, 26 Jul 2019 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+K+NcRWLeE3-vah=urveMVxcgXYO0yFHYD=WNeuX_TdZ9+8-A@mail.gmail.com>
 <F7CD281DE3E379468C6D07993EA72F84D1864503@RTITMBSVM04.realtek.com.tw> <CA+K+NcTsxsZ9LGbmSZ55xL-CTxruKta81WbCJXCWQCiMNNz4Qg@mail.gmail.com>
In-Reply-To: <CA+K+NcTsxsZ9LGbmSZ55xL-CTxruKta81WbCJXCWQCiMNNz4Qg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 26 Jul 2019 11:08:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPcnbiZmZLbRS0VXbof5ED+iqtySD+tr+pTszv6Jru4bg@mail.gmail.com>
Message-ID: <CA+ASDXPcnbiZmZLbRS0VXbof5ED+iqtySD+tr+pTszv6Jru4bg@mail.gmail.com>
Subject: Re: [5.2 regression] rtwpci + amd iommu
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?SsOhbiBWZXNlbMO9?= <jano.vesely@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tony,

Can you please submit that patch upstream soon?

Thanks,
Brian

On Tue, Jul 9, 2019 at 11:10 PM J=C3=A1n Vesel=C3=BD <jano.vesely@gmail.com=
> wrote:
...
> feel free to add my tested-by,
...

> On Wed, Jul 10, 2019 at 1:12 AM Tony Chuang <yhchuang@realtek.com> wrote:
...
> > I am not sure if enabling MSI interrupt is going to help.
> > You can try the patch attached, if it works, I will send it to upstream=
.
> > Thanks
> >
> > Yan-Hsuan
