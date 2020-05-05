Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087101C601F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEESbW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 14:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEESbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 14:31:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCCC061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 11:31:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so3897544wrm.13
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=havhuAu7xznQ0MuR1bzbfKCs7K2MdrTertMDkyH7tfY=;
        b=FfQ366NL1oalpQ62x0lekBgIFkA/wxnns/r1ujkHVEVZoC5xy4IaY/vgyexgyRfMAk
         rD42IepcjxIdKn5gOe92DgatCoZjnblhvDrgHrau5umekelSqtIJJAV3/pDSE974T2aY
         x3KikGrF5WFmFwTdHP7KKwH2VaPhtRZYX4Sqt3zDrB5XJdDPKiGNTmlH35Yiyp9Km5VQ
         G+GFej0QzqIPFK+HjfxXyCvR9k/0ejBgbXdAvut4VC+wf0+uJNvyh6nJgALp1jyWhMGa
         zRuFNjLj0nzHuxnQW0qA7wBTQutkschunrCUa3ONYTeMur9ypy7euwh1JHRK4nR8AtHh
         3/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=havhuAu7xznQ0MuR1bzbfKCs7K2MdrTertMDkyH7tfY=;
        b=aud+mI3+EiaG/p27ifxeAselairOgPWkM4lkSo1gEFnnmfSZSjQFN+FbUVDWvBLcH0
         BS9AVZk4wOkHEFl6yz1jPD6asnVekPDqDkJjGcfV8MwcjpEP5umZrwLEuitXVpZ4V/Ad
         XaEUaNib9ixnLnVDSORUyxsH58C3AsSdiGbm1jvzROjOy6H8Py4RtSI0Os2J+kOMDIsz
         zDX8Vt3VwddCDRjGCbioWZa5+2Gdd4lUKSNsMgGzJK2NDStYnN2iMAUTaxp2cQM+cPiC
         Uqyz5XkEoDBcZG2FCWrU+ghCjEOzDnwIarDfzny+hz2iOCxM6u9lyV8MA28kuEZnmjUH
         xy/Q==
X-Gm-Message-State: AGi0PuY9XtcJv/T3dZO9mgH2RlwB039FHFcwhfL6DNNz2oCcipbZbaHn
        gcO2dGvHn3tBk0aigGmtR8Q=
X-Google-Smtp-Source: APiQypLru5/bCUzwwo150/X+5AO63IsgIXCX07L0YmPRgDCKzCQEnjwMfMbpF+oI0+puOK+pgFW8Ww==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr4909729wrn.86.1588703480623;
        Tue, 05 May 2020 11:31:20 -0700 (PDT)
Received: from debian64.daheim ([91.13.113.85])
        by smtp.gmail.com with ESMTPSA id i17sm5287617wml.23.2020.05.05.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 11:31:11 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.93)
        (envelope-from <chunkeey@gmail.com>)
        id 1jW2LN-0008W4-O8; Tue, 05 May 2020 20:31:01 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Frank =?ISO-8859-1?Q?Sch=E4fer?= <fschaefer.oss@googlemail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] carl9170: remove P2P_GO support
Date:   Tue, 05 May 2020 20:31:01 +0200
Message-ID: <27876964.GhbJDmQBxd@debian64>
In-Reply-To: <87368ej1aj.fsf@tynnyri.adurom.net>
References: <20200425092811.9494-1-chunkeey@gmail.com> <5ebf8e6d-d34b-aa92-d166-d8a5ca0b2c18@googlemail.com> <87368ej1aj.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

On Tuesday, 5 May 2020 09:20:20 CEST Kalle Valo wrote:
> Frank Sch=E4fer <fschaefer.oss@googlemail.com> writes:
> >
> > Am 25.04.20 um 11:28 schrieb Christian Lamparter:
> >> This patch follows up on a bug-report by Frank Sch=E4fer that
> >> discovered P2P GO wasn't working with wpa_supplicant.
> >> This patch removes part of the broken P2P GO support but
> >> keeps the vif switchover code in place.
> >
> > Hmm... no way to fix it ?
> > P2P-GO seems to work fine with p2p_no_group_iface=3D1, so do you really
> > think it's a good idea / required to remove the whole thing ?
> >
> >> Cc: <stable@vger.kernel.org>
> >
> > Are you sure about that ?
> > People might be using it...
>=20
> Christian, what should I do? Take the patch or drop it?

Well, the way I see it: AR9170's silicon die has been cast before
P2P was a thing. And while it was nice back in '10 then to had have
something to test ath9k with, by todays standards the lack of features
like separate TSF sync and the cacheless BA makes it so that it's holding
back the performance and connection quality of all the clients which are
connected to it.

So, I think we'll just kicking down the can on that and I'm sorry that
I gave the people  the wrong impression. There are much better chips now
that came with P2P in mind.=20

So: please take the patch.

Cheers
Christian



