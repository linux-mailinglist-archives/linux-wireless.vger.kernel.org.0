Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B58DE218
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 04:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfJUC1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 22:27:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43437 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfJUC1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 22:27:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id a194so7003142qkg.10
        for <linux-wireless@vger.kernel.org>; Sun, 20 Oct 2019 19:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jrxW9Qmajz62yvUJquj+KTYfgTaCJqtVwxFo17SjfJg=;
        b=GdHGOI6FA40Cf/+MypBS3AhVeJaxk7piMbLSXh4snwlYbYQSyU4qdtsk5NWw4Is4MW
         8CEOyhdLdJn1MUYeul4rYdmLKibTOfIZF5eVj45+tBaOQoJ7gKr+9twnE9J0ZylXTLKW
         Oek1sYfiGGf7cKBCKkYsQ2l/1rEJ44mUZi3A8zstu2qW+bf0vpRv5d1byuJG5tPFOJ/F
         PKn/EcFXsFyaUeBczL3W71GZZXnSW+QtvjGYzRHTnWKAhrm6W7y7GAfyhmz5IXICxg6v
         NTy1rCcmjFtdsqV+iqw2s2ysWcElHOwdIOOG2lWrbNPvH8xBNneEGZO5MuurM78HUbOH
         +EwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jrxW9Qmajz62yvUJquj+KTYfgTaCJqtVwxFo17SjfJg=;
        b=d7ih4ywCH6EU4PPsnQtT8ayZDfKwRFw++k9Yw1fdkZykftgZLOptt+n4cbXAaYTEUn
         b+KrWbAG8vGDSV9ArICFY/tF2RYuYXivz9UGAWTM8TmWsXTCwqTH/nHqzK6yYaAmuGqt
         2beyyQH8xVYIahf9u+9pO05sZX178qWbgywgB/1+eV1rK/TTFxLwcz/TMCJJy0PEN8gy
         XZdCE44jSOFDGhuuY8qmCXZVCtstV0X/w7OaGKzzsyjr4xHNBskmGtluSydez8c6o5TH
         0sumjUScE9ewuEbsoXqTym742XeOKPBACHTANCmoVHPIaQTY08d5Bo8uTwrCL9VgIhSa
         UgnA==
X-Gm-Message-State: APjAAAWdk3klRlV6e0HXKrRtlzpk46LcirhCvXr/C0yuhpZXbHXP/5NI
        APiDL+Az+ARGguFb41UiJvvsZiyo5NRMXZewE8ezTQ==
X-Google-Smtp-Source: APXvYqzLwdW3DA3VpPfKWk5UBNKvFyqUgyR2WjiFtRKl7134YMV086Yowi5kRvOGGSPHNujQzRONodo0XwsojYlg7G8=
X-Received: by 2002:a37:5f46:: with SMTP id t67mr19441250qkb.220.1571624819419;
 Sun, 20 Oct 2019 19:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191016015408.11091-1-chiu@endlessm.com> <CAB4CAwen5y7Z4GU7YgpVafyGexxaMDLzrZ949t9p+LiZ9TxAPA@mail.gmail.com>
In-Reply-To: <CAB4CAwen5y7Z4GU7YgpVafyGexxaMDLzrZ949t9p+LiZ9TxAPA@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 21 Oct 2019 10:26:48 +0800
Message-ID: <CAB4CAwcW5JGtZQy+=vugx5rRYMycWoCSSdDc6nwhunqTtqoQaA@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: fix RTL8723BU connection failure issue after
 warm reboot
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 17, 2019 at 10:26 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Oct 16, 2019 at 9:54 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > The RTL8723BU has problems connecting to AP after each warm reboot.
> > Sometimes it returns no scan result, and in most cases, it fails
> > the authentication for unknown reason. However, it works totally
> > fine after cold reboot.
> >
> > Compare the value of register SYS_CR and SYS_CLK_MAC_CLK_ENABLE
> > for cold reboot and warm reboot, the registers imply that the MAC
> > is already powered and thus some procedures are skipped during
> > driver initialization. Double checked the vendor driver, it reads
> > the SYS_CR and SYS_CLK_MAC_CLK_ENABLE also but doesn't skip any
> > during initialization based on them. This commit only tells the
> > RTL8723BU to do full initialization without checking MAC status.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>
>
> Sorry, I forgot to add Jes.
>
> Chris
> > ---
> >
> > Note:
> >   v2: fix typo of commit message
> >
> >

Gentle ping. Cheers.

Chris
