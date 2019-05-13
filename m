Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F81B712
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfEMNdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 09:33:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55791 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbfEMNdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 09:33:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id x64so2669158wmb.5
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LNwFnYc3OiS4RD8IV8zCW5QU7k8ZZnL5AgwEDil8YnU=;
        b=Fq6NXYHOcGGEllYWmz80gGvjm4r0V3zvWdi7/vw3EXJCu13n3I54KpqUTr0VNkExsw
         Cyl/kx5Bijn/mgEaKTHPPSu1Rf5625NUcGaUOWOsilE5FQAvkzzsa5l6KA+6aa/fvLsa
         jDCm1Ds/J0KQO6daAikLKVKihjHuawaPun4l2aHpZy0a6YXgnFSX2E0jMGThEXV/6PXY
         aEV8tc6CZxqTQVqtryoDoe5wGIWpQQfqhUYBkkIHUmzDXpbRvHCty/r3tpKvk4zEcze7
         AuCsmoxaJFGj8owt1rL7xFVtfcKbPA6mWxONvaoDoJZoksJ7qYrSE895d9npOe/ABlbu
         /lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LNwFnYc3OiS4RD8IV8zCW5QU7k8ZZnL5AgwEDil8YnU=;
        b=JH8sGywUISnCE3ak3D37RFb1J7FdQIUYVuK58QPqTA5t6ly0e8Vpr/BPzoeX2rtOvf
         H4vTIZrpmAZ3r00OIUvTnh6kWJW8G/cPgIeLCM9UynxXs+PKxCVuUMIjW3WnmCNTxgaR
         46s9Vtz+UiXMekaAs0REvyVIKSOMYklDMeNc345kT5ZsAlnvoh101R81w5T0+KUdPB7X
         3r6hZRr+W+t8n0mE033QaXwfBC+W/wX8hl2itTvldI5ecJ2pcImFvQq4d3tfLbwmuqQL
         ub1KWuz5SxEdItfoXsNbJ4Y1uzMSH5pBJIPVF47SR75yRGjOfsR8yIsmKm48PjApT6hp
         Oq6w==
X-Gm-Message-State: APjAAAV+pRTNdU/Nl2twAielgNJZg/K35O9Xp+EfnD8OKkhyXLu1oKxh
        OZrUk6TYuKRebSA6D5ViukuEAX17sRf6yRBg7Dmtbyb3Orc=
X-Google-Smtp-Source: APXvYqy54cLvXoMtRWWCle62B31u78Ig2T5okZEODeV/BoukVMGuTqlCHqQLert6e3qnFd+KXh0zAAAOTFOZRMlW4hs=
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr16137716wmh.40.1557754383835;
 Mon, 13 May 2019 06:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <20190513095059.GN9224@smile.fi.intel.com> <CA+icZUWXSup0BfXNZXxcrAAbu-b9KCiBU++OkC+eFqacMrTwRg@mail.gmail.com>
 <20190513105745.GR9224@smile.fi.intel.com> <CA+icZUVDTx_ZUuOgHVDmg5_a4tgrRkPp880+0KPaRJ1d=zF5VQ@mail.gmail.com>
 <20190513124049.GT9224@smile.fi.intel.com>
In-Reply-To: <20190513124049.GT9224@smile.fi.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 15:32:52 +0200
Message-ID: <CA+icZUWU2OQszOYi1Jzp7yW+gB-TmhkBfmqaLAvy3WEOn9Rh8g@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BTW, which Linux Kconfig setting are minimum?

scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C

What about?

scripts/config -m NFC_NCI_SPI -m NFC_NCI_UART -m I2C_GPIO -m SPI_GPIO

Required?
Not needed?

- Sedat -
