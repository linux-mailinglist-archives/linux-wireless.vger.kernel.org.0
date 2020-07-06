Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE72153CB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGFINZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgGFINZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 04:13:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC7C061794
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 01:13:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v1so20119085vsb.10
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2020 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uU0xlJFFa00TPVnoXEPqSp0oyV50ZErE/QACHMhe2N4=;
        b=wRznHkTxGCiQajCVNy9WSYCnQb05YHLCdtX7y70OCdpBfnc9TEVkeBRekT1E67LAFY
         34RkjoCc4z4mjEkXMPx598LDq1kUDFRvWLNoT9f1nRTpzIZLB0ZyAbY1Kk0vihaQ2UHz
         xBooI6oRjCCHVCocp+YFVVlBmLK5KSyc6ZB98i/zL3BLrvzvr4rA9o64sA2/o6BJnJD2
         pCAP0wAxts2lhzqzswEQLCB0oTnVpiQ87QK8hKNPRDkRgvxFpx5MXrzcZ/nQfoT1jvW3
         ZFGxsS9bpUe6dK1YXXbjgFaYQ+SdOXP/1vEvjebZGI3JaQX3C9tZRPe2XeNYvUTAVgjQ
         Cxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uU0xlJFFa00TPVnoXEPqSp0oyV50ZErE/QACHMhe2N4=;
        b=Bpi6r4IoPSsYJ7LF6cLRY9kA9hs5AGRVZiUDEFcbz04U9/iL/RDUbxMrUo4vvhEMiO
         TksScoZaYbeu+L2IRKNPq6x3XBfsupTNWc9CsVOOuB4It3smrg+atRivO+KJRpJ/H3g0
         s5cMIj69jlGyymgZ7bGAxaBCyKwiQFiCpLNOkur7mh+CuoT3hBuDHhBuk2iTUWFVypQf
         XDV07EdnzrwrSAwLjEzKfUpQDE4uVVASmUC4zhhkJhVoaZE3KvPDxb0LxN6olmnDgzyd
         aqwxMbFCv5jv2/qbMeTfMIgxY3KGNLJOYLJ+M68GF0GbPlN1S6+CUq9YrR4DiVFL6ON5
         bmeg==
X-Gm-Message-State: AOAM5331DwebOGnr5QzULCYfJmO/4CdQOxwuSzyiQO2D3NAgw505oJjl
        MFT7azyTbu79o09jf53tRw5oE96XnaIGN1UIr4SADQ==
X-Google-Smtp-Source: ABdhPJw4Bfj4EQ8COBJIeo7D8VGRYlDADzKZonEBAoQVS2UeZtYYqk8AqEi+blrR221WwLcPoQik/mNFDEOYgtH6ncw=
X-Received: by 2002:a67:ca03:: with SMTP id z3mr27998411vsk.34.1594023203065;
 Mon, 06 Jul 2020 01:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
 <20200629132612.nl6rfpihzlii6ilh@pali> <c23ca5da-b9db-5e98-94e4-edc84ded9611@microchip.com>
 <20200701075515.zypusfh4xazqu2fl@pali>
In-Reply-To: <20200701075515.zypusfh4xazqu2fl@pali>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 10:12:46 +0200
Message-ID: <CAPDyKFpgXa+z_spubHWQ=2wJvJxA8sdJqgZfo0OvR6LSGE7NAQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] wilc1000: move out of staging
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Ajay.Kathat@microchip.com
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        Venkateswara.Kaja@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 1 Jul 2020 at 09:55, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 30 June 2020 03:17:01 Ajay.Kathat@microchip.com wrote:
> > On 29/06/20 6:56 pm, Pali Roh=C3=A1r wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> > >
> > > On Tuesday 23 June 2020 11:00:04 Ajay.Kathat@microchip.com wrote:
> > >> This patch series is to review and move wilc1000 driver out of stagi=
ng.
> > >> Most of the review comments received in [1] & [2] are addressed in t=
he
> > >> latest code.
> > >> Please review and provide your inputs.
> > >
> > > Hello Ajay! Could you please move SDIO vendor/device ID definitions f=
rom
> > > driver code wilc1000/sdio.c to common file include/linux/mmc/sdio_ids=
.h?
> > >
> >
> > Currently, the wilc1000 driver movement changes are present in topic
> > branch and yet to be merged to master branch. Would it be okay to submi=
t
> > the new patch once driver is merged to 'wireless-driver-next' master an=
d
> > branch is pulled into Greg's staging repo.
>
> I think it should be OK. But maybe Ulf as maintainer of mmc subsystem
> could have opinion or react on this.

That should be fine. Just keep me on cc so I can ack it. Potentially
we may get some mergeconflict between the trees, but let's resolve
that if/when that happens.

Kind regards
Uffe
