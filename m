Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959C697D02
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 16:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfHUObA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 10:31:00 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44633 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfHUObA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 10:31:00 -0400
Received: by mail-pg1-f181.google.com with SMTP id i18so1406269pgl.11
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0VnRFh7HJ8ewHwMiT+1D9/Ktnse6AXEoOJSlUdW0veI=;
        b=kQcx7ZJmtRk9bMYoYOagPayWGFtKyM0G5HkDOOukJZ+b7j3FsaVfOXL6b8PNpUh7jI
         ABJjkKRvEb21W5JtCDxe9E5lxCaJToE7WRg9qiJgkRgUXi0s7+EA5gCYk40Xut8I7q+t
         jiYMNv0PmjocNHG/QXtKAfSoLkATGb2eu2/XzZeJDsDXXnRHbnv0p298CNICthIxcsCk
         11QLVYFjH8GAqiggO3syxGTIOCU0q6ZjTlKlgHcBdkhJD8TnB4ggqsBh4qIOazOrHbor
         haWZlLdo/Vs59k6Wo0V8vTChr6N/2Kv3vo6YJfZgLqbrp8awqC/IJkv1oIrFoI2LREZe
         dN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0VnRFh7HJ8ewHwMiT+1D9/Ktnse6AXEoOJSlUdW0veI=;
        b=bfPTwt+ql+dPbYA0ftKdZAh3yi7PTrHryhQaQyBvLCbPNRBGJ+CyfFmzynxtgzKB+n
         J9xrJzX+LHC4hx6lNNCQWfOLoBodmcNYxrDsB4eFWn3l4y1Yl20uW76aNXAMTRFVrYDo
         xoIb76uelzkj6avkJh8saVydG4sa1u8z/5nCGsGMMpSP/C8oX63AknsDN21nARC0c//Z
         sC14+93yKvEaDaUt/IuQHSXQ/N5vf2cZlwK3Z22CdBfPAcbE48WE/PMQ0M266xbNRcht
         r8PtzNDXWNclM044SLfh2KNkBJOY7rO2KeFvNmirdCLxrP3DeUp12ta8mLsWDa8mddVM
         j5aQ==
X-Gm-Message-State: APjAAAUW3laTk38+IDO4cCuGqaJJA0ZSmbT3uNBQiOep4tDAila70PGg
        /9kGfmkKK+6Ewb1WyobW8NSp9v6+3lhUh1KYs0g=
X-Google-Smtp-Source: APXvYqxfdN9KnslwMQmwEyeO3ZHHxfysMHlWvVDig6QSddCdvWDJh0sBvHuf4UcoUt5mRrwp4zKlDQEyMGH5xUPjrS0=
X-Received: by 2002:a17:90a:b393:: with SMTP id e19mr300903pjr.118.1566397859730;
 Wed, 21 Aug 2019 07:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAG6aBkWDyGDtWX7X0t-FjynkYxpdhpZsAv4Ysw3dKf+iEu+mig@mail.gmail.com>
 <941b807b02962fadaf738942baf1621738872723.camel@intel.com>
In-Reply-To: <941b807b02962fadaf738942baf1621738872723.camel@intel.com>
From:   Nigel Sollars <nsollars@gmail.com>
Date:   Wed, 21 Aug 2019 10:30:50 -0400
Message-ID: <CAG6aBkW09YFz4asHZkhWBUenBiT3dgb7iGXBCq8KkCM09QXjLg@mail.gmail.com>
Subject: Re: [linuxwifi] Intel Centrino Ultimate N 6300 regression
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for the feedback I will look into this and report my findings,
to answer your question, yes I can build a kernel to do this testing.

I will also update my Redhat Bug Ticket with this information also

Regards
Nigel Sollars

On Wed, Aug 21, 2019 at 2:08 AM Luciano Coelho <luciano.coelho@intel.com> w=
rote:
>
> Hi Nigel,
>
> Unfortunately we don't actively support these old devices anymore, though=
 we try to help as much as we can.
>
> This error is -EINVAL, which means that the driver is not recognizing a p=
arameter passed to it. It's hard to tell exactly what is causing that witho=
ut further investigation. Are you able to compile the kernel and do some te=
sts? One way you could do it is to replace the -EINVAL with a line number, =
so we can try to see where the invalid parameter error is coming from. Doin=
g something like this: http://pastebin.coelho.fi/03fa29d951db5405.txt
>
> Then the returned error should correspond to a line number on the driver.
>
> Another thing you could try is to bisect the kernel between the last know=
n good version and the one that fails. To do that you should try to find a =
newer kernel than 4.15 that works, preferrably as close to 5.1 as possible.
>
> HTH.
>
> --
> Cheers,
> Luca.
>
>
> On Thu, 2019-08-08 at 10:42 -0400, Nigel Sollars wrote:
>
> Hi,
>
> So I have been trying to reach out in aim to get this driver fixed as its=
 regressed now to a total non working state.
>
> The card can see access points, but thats about as good as it gets as try=
ing to connect to any networks ( either 2.4 ot 5 Ghz ) results in the follo=
wing,
>
>   wlp3s0: CTRL-EVENT-SCAN-FAILED ret=3D-22 retry=3D1
>
> ( alot of these ) which then resets connection status with a failed timeo=
ut.
>
> I am currently running FedoraCore 30 with the 5.2.5-200 kernel updated fr=
om 5.1.x yesterday. The firmware loaded is,
>
> loaded firmware version 9.221.4.1 build 25532 op_mode iwldvm
>
> Now with all that said, using a Linux Mint live boot from a usb device ye=
ilds the card working fine at both 2.4 and 5ghz speeds, it connects within =
seconds. The kernal in this live boot is 4.15.x and uses the same firmware =
build as my FC install.
>
> I did see strange behavior with this card from around 4.18 to 20, thinkin=
g the card might have developed a fault and obtained a new one. This proved=
 that this was not the case as I get the exact same behavior from both card=
s.
>
> Hope this information is helpful to solve quickly, please reach out for m=
ore information if required
>
> Thanks
> Nige
>


--=20
=E2=80=9CScience is a differential equation. Religion is a boundary conditi=
on.=E2=80=9D

                           Alan Turing
