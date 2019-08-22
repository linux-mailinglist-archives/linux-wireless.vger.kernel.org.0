Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D86CE98861
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 02:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfHVAM3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 20:12:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHVAM3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 20:12:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id i30so2563745pfk.9
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2019 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6UuQhybGgQQ+P9pqAynxoQ8MH5bUciUE9dwDKfGeyXo=;
        b=iyRN3S781Q+O0kziS7GRthe/SdlqXB2sHHBzWKmI/SSCNCCQV6E4s/1n2jkpfQYlSE
         2rLyyibeHh92BiAL7WIcde+WIZBwhr6Xs6n6zgzuGsXiQHxUkE2/4aTN163NSRu6jjZQ
         G6DEFYGSG0aGRP7LHTrEIsOwOHNr5ChFRz48n1HFce5vikexUELs4xs3RXCSN5+4Xlc2
         Qy42NegRbYYh2UT9t0Pj6aPr3RXkALDxx4FEniRf5szzk7zdAUlFzaGer8rw9q7iCypS
         EpE/1jSsOvcJxfx31OtJS1nCkvdKTjzE1foif5Lq/px64XMbB6m5SJovmK806CmMJp+V
         YlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6UuQhybGgQQ+P9pqAynxoQ8MH5bUciUE9dwDKfGeyXo=;
        b=J9Gu2z/ehRU66jeFR4Vi1snMNE1Eo4Rg83fZXwfeR/FGaXoypFa9d86kBE5q/021FO
         UO7Dq/rI/N9M4Gr3ep9zEWkBy0H3IWg9IlFO3COEy1e8LYet2PH0Bbc2hu8dCkX72gpY
         5KHBG/97PfVcz+f23C0gIfx4sntShEHhHtPx6kk0HSoEDplsjJMe0XQlQy+GDuiaWVxV
         adfc8I3sy+rpwFvs37CNkCETXlp6U7sYKTUTf/K9B0SVGasNlVZeIv7yYn4y6n0hMzIx
         ON+a7nRpa6KvZ9+xBur7mIWJeaLs1yi5vvZJOMP4NejyYqxXw5lW74wk0nYVO8WjrLvk
         AYgg==
X-Gm-Message-State: APjAAAVPqRcnSC30EmI0DIF44GNVfRKXkLKRsWqKouPy+BGJVuFPD5Eo
        4+sG20ycif7Ek13HdpyBWCPSsb3z+qIB61krTWXA6+a0
X-Google-Smtp-Source: APXvYqwOgzSTPDe1iIO8604wLx5LXr52H3U1zSNcOwmlVYYACImOquhl1HBU62WfTAYnoHj5ROOitByMJjdU4o715Lc=
X-Received: by 2002:a17:90a:2767:: with SMTP id o94mr2517860pje.25.1566432748005;
 Wed, 21 Aug 2019 17:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAG6aBkWDyGDtWX7X0t-FjynkYxpdhpZsAv4Ysw3dKf+iEu+mig@mail.gmail.com>
 <941b807b02962fadaf738942baf1621738872723.camel@intel.com>
 <CAG6aBkW09YFz4asHZkhWBUenBiT3dgb7iGXBCq8KkCM09QXjLg@mail.gmail.com> <4e63174a-34cc-cebf-4eb9-205f0d237574@wetzel-home.de>
In-Reply-To: <4e63174a-34cc-cebf-4eb9-205f0d237574@wetzel-home.de>
From:   Nigel Sollars <nsollars@gmail.com>
Date:   Wed, 21 Aug 2019 20:12:16 -0400
Message-ID: <CAG6aBkV_6_ipe3AXJkknidLP+8_40kObfBE5Tfz4vS=2-GGZww@mail.gmail.com>
Subject: Re: [linuxwifi] Intel Centrino Ultimate N 6300 regression
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     Luciano Coelho <luciano.coelho@intel.com>, linuxwifi@intel.com,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Interesting to be sure,  so here are the versions of kernel and wpa_supplic=
ant,

5.2.9-200.fc30.x86_64
wpa_supplicant-2.8-2.fc30.x86_64


On Wed, Aug 21, 2019 at 5:45 PM Alexander Wetzel
<alexander@wetzel-home.de> wrote:
>
> >> So I have been trying to reach out in aim to get this driver fixed as =
its regressed now to a total non working state.
> >>
> >> The card can see access points, but thats about as good as it gets as =
trying to connect to any networks ( either 2.4 ot 5 Ghz ) results in the fo=
llowing,
> >>
> >>    wlp3s0: CTRL-EVENT-SCAN-FAILED ret=3D-22 retry=3D1
> >>
> >> ( alot of these ) which then resets connection status with a failed ti=
meout.
> >>
> >> I am currently running FedoraCore 30 with the 5.2.5-200 kernel updated=
 from 5.1.x yesterday. The firmware loaded is,
> >>
> >> loaded firmware version 9.221.4.1 build 25532 op_mode iwldvm
> >>
> >> Now with all that said, using a Linux Mint live boot from a usb device=
 yeilds the card working fine at both 2.4 and 5ghz speeds, it connects with=
in seconds. The kernal in this live boot is 4.15.x and uses the same firmwa=
re build as my FC install.
>
> I'm also using a "Intel Corporation Centrino Ultimate-N 6300 (rev 3e)"
> card and it's working perfectly with 5.3.0-rc4-wt here.
> (And with most wireless-testing kernels for the last years, too..)
>
> Now there was one noteworthy bug in the last year we handled on the
> mailing list:
> https://lore.kernel.org/linux-wireless/87k1rk1af5.fsf@kamboji.qca.qualcom=
m.com/
>
> But then this was a null pointer and does not match to what you observe.
> (And that really should be fixed in any 5.2 kernel...)
>
> I'm using a Gentoo ~amd64 system and wpa_supplicant more or less
> tracking git upstream and the wireless-testing kernels with the same
> firmware as you.
>
> So whatever it is, it's not affecting me. I would suggest to try a
> vanilla 5.2 kernel and maybe also an updated wpa_supplicant version next.=
..
>
> Alexander



--=20
=E2=80=9CScience is a differential equation. Religion is a boundary conditi=
on.=E2=80=9D

                           Alan Turing
