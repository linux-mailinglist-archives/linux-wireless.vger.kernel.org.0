Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD03E08A1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhHDTTO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbhHDTTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 15:19:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC8C0613D5
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 12:18:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id g30so2011007lfv.4
        for <linux-wireless@vger.kernel.org>; Wed, 04 Aug 2021 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g408wbV5yGX32cnKeHXlj6aUQta/3az557iPBzRYkUU=;
        b=t2Q37nM3UkmBkwsVKp88PTwMW3NekRFObNp5rjb2ZhRxzsKs3fpq7L5AtW9NoA1emk
         RWAiVMX/UnUxzMCWvx/ok11mTgW6bzJegCB8xIcsPZ9ijkp4N5KtDEUr611oz6KfnRkY
         p9c3CUhFM93J/06gagB0MRy1r3OlFYHxczA7tJw2XTj//QYF3iyb4wOIPFlCLVrOpUsl
         5RUaizL1GGVA4uYJifOeznH49wFHt1TL6/sSzoIhmF07+HIbRmgGh2kzOaLUc6urWZ4Q
         lx0ROQquomXC5kX3xxK7IGwrqt87S7YCjjq5UmiXqFfckwmFmJIfLDqBHLgk2Qq0woVY
         jb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g408wbV5yGX32cnKeHXlj6aUQta/3az557iPBzRYkUU=;
        b=Q20kb5gnF2zP2VN4bdCz9GWODSrG5Y973Y7k5wGE9PArzPZzYoOlzJrKxNNLmmjw/+
         awuqNrjqHU8pTc7oAU++CB5j/LGonZI2ASy816cj0GRB7jBRfRKccID2MtHR1HbjavQM
         mXMfyCfPju2xAYblPEfgiw3UTtniRuT4p42HH+rYQShGoDqkgizficswMGw98a0SbhuC
         H8vghcJC2SD9TwUTL+N8fTBEF/M/RQkP5qnf9KyKWCGiumldHKm1BuPOhCPiXQjblfyI
         bQZY9QvfMfHt8UQnUySbQmW3cMkgeSWGTwSTseJPDuhGQd8Wu3Pkewgrh4F0PqI9KLQF
         vR9A==
X-Gm-Message-State: AOAM5329nY36rSoLrOPWgJ5kMCEzZ4PlWgE4vvGuhTR8sTFYCSfBpP7y
        DoPaTGI8LUxQPScg/r0TjlB8TvyQ6Tm29OHXSEIfBQ==
X-Google-Smtp-Source: ABdhPJzmnQ63jtt/5k/SuL/gD5GSqTCSCVZA7z6i6Obv8soG2Cvu/sboUcv0ZzPK+zI+UlxRHEMBfXkqANgsyMgfn2E=
X-Received: by 2002:ac2:5d4a:: with SMTP id w10mr536673lfd.529.1628104733110;
 Wed, 04 Aug 2021 12:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210711231659.255479-1-linus.walleij@linaro.org>
 <fca09928-72a8-a573-a862-7c486a2094d6@gmail.com> <02415358-6635-a974-7682-a721912ca4fc@gmail.com>
 <a2ee7f03-879e-543f-fbaf-06a58e416e9d@broadcom.com> <CACRpkdYSXmPO0zGfFbmg3dHrv30sTzQcaGW-vbVV+L1NNS3MqA@mail.gmail.com>
 <dbdf5491-6365-4804-9719-e60d093a62f4@broadcom.com>
In-Reply-To: <dbdf5491-6365-4804-9719-e60d093a62f4@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Aug 2021 21:18:41 +0200
Message-ID: <CACRpkdbQSt6qmugWMwKgdJ0aa5n7D13vf0dVo00M-GRwGFGa8Q@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: firmware: Allow per-board firmware binaries
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, phone-devel@vger.kernel.org,
        Stefan Hansson <newbyte@disroot.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 4, 2021 at 1:32 PM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:

> Apart from
> the compile date using strings will also give you the firmware compile
> target, ie. 4330*-roml/... Could you share that?

I have this:

BCM4330 devices:
Janice:
*unknown*/sdio-ag-p2p-aoe-pktfilter-keepalive-pno-*unknown* Version:
5.99.7.0 CRC: 76bfb595 Date: Thu 2012-11-15 16:51:35 KST
Codina:
4330b2-roml/sdio-g-p2p-aoe-pktfilter-keepalive-pno-ccx-wepso Version:
5.99.10.0 CRC: 4f7fccf Date: Wed 2012-12-05 01:02:50 PST FWID
01-52653ba9
Gavini:
*unknown*/sdio-g-apsta-idsup-idauth-aoe-pktfilter-keepalive-btamp-p2p-pno-ccx
Version: 5.90.125.169 CRC: 323b9dfb Date: Tue 2012-03-27 16:27:59 KST

BCM4334 devices:
Golden:
4334b1-roml/sdio-ag-p2p-extsup-aoe-pktfilter-keepalive-pno-dmatxrc-rxov-proptxstatus-vsdb-mchan-okc-rcc-fmc-wepso-txpwr-autoabn-sr
Version: 6.10.58.99 CRC: 828f9174 Date: Mon 2013-08-26 02:13:44 PDT
FWID 01-e39d4d77
Skomer:
*unknown*/sdio-g-p2p-extsup-aoe-pktfilter-keepalive-pno-*unknown*-*unknown*-proptxstatus-*unknown*-*unknown*-*unknown*-*unknown*-*unknown*-*unknown*
Version: 6.10.58.45 CRC: 7d0fc51b Date: Wed 2012-11-21 00:22:18 KST
Kyle:
*unknown*/sdio-g-p2p-extsup-aoe-pktfilter-keepalive-pno-*unknown*-*unknown*-proptxstatus-*unknown*-*unknown*-*unknown*-*unknown*-*unknown*-*unknown*
Version: 6.10.58.45 CRC: 7d0fc51b Date: Wed 2012-11-21 00:22:18 KST

> > So I am half-guessing that bcmdhd_sta.bin_b2 is obviously for the
> > ordinary use case, *mfg* is probably for manufacturing, *apsta*
> > for mobile hotspot (access point) and *p2p* for some other cool
>
> Half-guessing seems sufficient ;-) If I recall correctly on Android the
> driver loads different firmware based on what a user selects in the gui.
> Not something we do in upstream linux. p2p is a WFA specification and
> supported in upstream linux cfg80211. Many TV sets support it to show
> content from your portable device.

Aha makes perfect sense!

Yours,
Linus Walleij
