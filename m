Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB4B5ED2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfIRIOv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Sep 2019 04:14:51 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:34625 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfIRIOu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Sep 2019 04:14:50 -0400
Received: by mail-io1-f41.google.com with SMTP id q1so14170463ion.1
        for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2019 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYcG2UqlY+/lq1FpcHC7dW6S5qd/4aCFZqrP7J5My6g=;
        b=DrJl0qwbelNUkg+1UxCiZ87mYpYku2cDebagLMTo0F2eK0qmP4JZhI8Gs5+hnMlfGE
         m4h8jRWCuUCEqByRUAAdxZXx8f5ZabtrKfNU+V1wfzH/r0VnorIdjQJkwRcJSHRETB1p
         jTLgj1OqUW4zWR8rK05kkpFAGRNmhox9JoYYZn/tPP/Lqej3EFe9l00bgyYL9JZe/iUc
         xFKhKsoaX1D9shCWXRXOMs1S9H3kd4hWY4UYKQWQ9QTbTV33yImqMorIXgWseoQ+SIjO
         bw46vJpkTkzIaX1JccCxobauNMc8cdvXCp1cqdmyf2hs1QS+L1GuSMa0miBuGgMNTOdn
         1YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYcG2UqlY+/lq1FpcHC7dW6S5qd/4aCFZqrP7J5My6g=;
        b=q4Ssm2s9tm9uJ8tbiGMLsH4uu7V3wqPeEpNGqqAYf2EioD1JBOtP4gWA9brrzeOeiE
         aqOjgpZrFiS49s5scOK22NDFDAiZU37RMoYirAkvvaET+abAkXD9tU6LIn5phLj1IAxl
         CWL9Rw1ckJrd+I+uhG6GRTGnjA7jciLQp9INxkABI91qGPrD7eL9F6U2za1qzKJkxMJS
         eDQtsHNb2CswB+IRt8dZEV9j9y0clM4o4CLW+oxMZ9Z1kD0pulylm5RRYxwgdinKoNPP
         xIDJ7mCRoaTtDqhuJHyMoOePH5srNNP5G09NOOJ/LmPjOIVDpa5OqK+1nBkwHKxCwn/E
         oeiQ==
X-Gm-Message-State: APjAAAVfBcrTyyIcU4IlHDeFwM8PpuNyz9XP0+hLFcFH1eI70GwvPmab
        0Xw+ToRnd/7tCkbMGnRlZswvA++U5aeu7WyHmTM=
X-Google-Smtp-Source: APXvYqyokcdwcep/L054Oo34lDepqdh2H8WaYSiOPZDqkCXd4x47hPTmLQdNvKru5XhnASQGHHcLsC+jJU7vPk8Tjdc=
X-Received: by 2002:a6b:ca47:: with SMTP id a68mr3811211iog.110.1568794489857;
 Wed, 18 Sep 2019 01:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKzd-8jgQWTO2w589gMVJm3CaU-15wUER+fsqpYJJSeZL4RPg@mail.gmail.com>
 <CALLGbRKUZmZzBh9=YpJ+r_ts8aY+HXy159oviihSgqMEofOCRQ@mail.gmail.com>
 <CAKKzd-8aRFtdkK+E4-sXBid9jP_sAr0bGbdLYJ=sjb4iCsTAcw@mail.gmail.com>
 <7158fc76fe5ec091633b36b3218a8586960c19e2.camel@redhat.com> <CAKKzd-9zK0ZKWksyp7S+myGrtbc3s4npEhy02SS-wfLCS0tKSw@mail.gmail.com>
In-Reply-To: <CAKKzd-9zK0ZKWksyp7S+myGrtbc3s4npEhy02SS-wfLCS0tKSw@mail.gmail.com>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Wed, 18 Sep 2019 13:44:38 +0530
Message-ID: <CABPxzYJ1YCwdVqba74aptV3KCwCDFT_UP8TCh6C30-gu=CRKNQ@mail.gmail.com>
Subject: Re: Linux wireless times out at Google Starbucks location
To:     David Ho <davidkwho@gmail.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 18, 2019 at 6:22 AM David Ho <davidkwho@gmail.com> wrote:
>
> On Tue, Sep 17, 2019 at 2:01 PM Dan Williams <dcbw@redhat.com> wrote:
> >
> > If you're able to get the wpa_supplicant logs, that would be useful as
> > well.
> >
>
> I captured 2 minutes of log in /var/log/syslog, based on my crude
> judgment of where the connection request began.
>
> I appreciate if someone can update me on this issue; I hope my effort
> is not going to waste (I'm just an ML researcher trying to make Ubuntu
> work at my favorite coffee shop =)
Is this a new issue probably after some update? The only thing we can
see from the
kernel logs are that Auth/Assoc are getting timed-out, no info as to why?

You can probably try disabling the powersave using below command or
using `iw` utils.
sudo sed -i "s/wifi.powersave = 3/wifi.powersave = 2/g"
/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
