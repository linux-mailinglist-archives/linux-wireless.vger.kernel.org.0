Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2458F418D2E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 02:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhI0ABs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Sep 2021 20:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhI0ABr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Sep 2021 20:01:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9BCC061570
        for <linux-wireless@vger.kernel.org>; Sun, 26 Sep 2021 17:00:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y35so10550139ede.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Sep 2021 17:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6WCOnuO9EnGFHUidx151/8oXjVQxPrxhqPSBcjejQQk=;
        b=WZbTDzHgzZ3dEp5zORx1u4+VvGtPA0ne60cJMI4klZJPopWDN/lV2GVZW+wxcRrv/A
         7Jeozw732pfUj3ispsPI2TAvX8w67/vvzkU+Z+wik9wh7hDgAmCuFHMxbqtBe/bW+Gng
         HklKpez+3ofvay/b6pNb5y8SniHoRQKWCOewbdSIB26lxwlHsucd/4XI/vapwSqHcpll
         leWji+CGQqvSXLhApxPH80kClnjEeGlP0jcYg1ctO/9tGJhzy3SWFMh3WUpspB1XkLKf
         lCREXX5J8AlBAjF39uTRu3jL0ogXXWARgpid417gEb7nkfV6CGei6jOR9RLJW/+Y/YmP
         XDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=6WCOnuO9EnGFHUidx151/8oXjVQxPrxhqPSBcjejQQk=;
        b=DpI4z27pMsOSuRYsc6z4T6p7Z7w52zp4kR+Rts6i3BeveRr84gItsVGH5qkWaKud6+
         jswJv7QJ4LsqIp0ZEECw+mh8O7tyuyuHVuXsaXNBAblkLtpbooajl+gUrMuLxnu61Yn+
         k3e6gE8+KEf3BO1UrRhpCIbmbU1zFSnGwuJ/Ybl0YTxKvBsKKUascIDnI2jz79EGlSq8
         l/stN155cIlOMSaKuotTn4AbBa1hjoQiLJzHEkk4gkIwj+NY5ZbGR5KDCvMtYnPbuQm2
         Wq2hwFW5rvD0LqDGgCaIs2xRIOJEcveMGQk9qL6byACGV6enSvHZlG4c5wsISlvKsAOw
         xCWQ==
X-Gm-Message-State: AOAM533rcOZbpkby1S9Pl5qHX/W9HHal/E2TbyLqv1/T+mbfGwUPdCRx
        GqZyNwe3QK8gYvINBuOmM+sCaelI6FjvWH4LasM=
X-Google-Smtp-Source: ABdhPJwKw536FO/1pioSUgnKllPrOyZkj+tX2oXgLbnmToybJredZWf4eVs8Qr8CUP8z3MGpDdVjKqJGAdFr6Y/N4o0=
X-Received: by 2002:a17:906:1ec9:: with SMTP id m9mr23881111ejj.115.1632700809222;
 Sun, 26 Sep 2021 17:00:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: martinafrancis022@gmail.com
Sender: nora38588@gmail.com
Received: by 2002:a05:6400:5b95:0:0:0:0 with HTTP; Sun, 26 Sep 2021 17:00:08
 -0700 (PDT)
From:   Martina Francis <martinafrancis655@gmail.com>
Date:   Sun, 26 Sep 2021 17:00:08 -0700
X-Google-Sender-Auth: xoKdvKN9nt_ohVBXfnDz0SL-2xw
Message-ID: <CANa4+1=aeQSy9c=gMMdJAWt8f3q9DJ2n=RPNj0=bp1xmKCOK4g@mail.gmail.com>
Subject: =?UTF-8?B?RG9icsO9IGRlxYggbW9qYSBkcmFow6E=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--=20
Dobr=C3=BD de=C5=88 moja drah=C3=A1
Ako sa m=C3=A1=C5=A1 a tvoja rodina?
Som pani Martina Francis, chor=C3=A1 vdova p=C3=AD=C5=A1=C3=BAca z nemocni=
=C4=8Dn=C3=A9ho l=C3=B4=C5=BEka bez
die=C5=A5a=C5=A5a. Kontaktujem v=C3=A1s, aby ste poznali moju t=C3=BA=C5=BE=
bu darova=C5=A5 sumu (2
700 000,00 MILI=C3=93N USD), ktor=C3=BA som zdedil po svojom zosnulom man=
=C5=BEelovi
na charitu, v s=C3=BA=C4=8Dasnosti je fond st=C3=A1le v banke. Ned=C3=A1vno=
 mi m=C3=B4j lek=C3=A1r
povedal, =C5=BEe m=C3=A1m v=C3=A1=C5=BEne rakovinov=C3=A9 ochorenie a m=C3=
=B4j =C5=BEivot u=C5=BE nie je
zaru=C4=8Den=C3=BD, a preto som sa rozhodol.

Chcem, aby ste tento fond vyu=C5=BEili na chudobn=C3=BDch =C4=BEud=C3=AD, t=
=C3=BDran=C3=A9 deti,
menej privilegovan=C3=BDch, cirkvi, sirotince a trpiace vdovy v
spolo=C4=8Dnosti.

Kontaktujte ma ihne=C4=8F po pre=C4=8D=C3=ADtan=C3=AD tejto spr=C3=A1vy a z=
=C3=ADskajte =C4=8Fal=C5=A1ie
podrobnosti o tejto humanit=C3=A1rnej agende.

Boh v=C3=A1m =C5=BEehnaj, k=C3=BDm =C4=8Dak=C3=A1m na va=C5=A1u odpove=C4=
=8F.

Va=C5=A1a sestra.
Pani Martina Francis.
