Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13D396CD
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfFGU1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 16:27:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52782 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfFGU1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 16:27:35 -0400
Received: by mail-it1-f193.google.com with SMTP id l21so4664893ita.2
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jun 2019 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEdxKvMI76F7qa+HuVievFWbNtPV7oK8lFzNJOnKdpA=;
        b=wnS/L7yi74saLSqqhBuB9irE7lmR8JegaHod+7lych9m8PE8qXBjAfQjmIvo+biU0I
         g6s00gaPT5ae5hoBLSb8LzR7HFUeGuTy1dzErSFSTeqfXE1yISEe62MzdjQwqBFKZlY5
         KQaMS5XaPiC5dklRZbUMp99psJ3LiEWstu8Cm+ZPSXAcNvVIpZL9XqrHB08SYLvIHgN0
         wbEBYtiHNDhuj/qbci3snRBKpsnj/CIejs/LbKXH3vnsha6vcypq+03an2DhHsmBUmIG
         yDO1l5a3kdOUUhna/GrWH5Iw6y9yg+8rL5e+4/OmDgGI5akcQH8nuIH30UDoYKwbJzab
         XgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEdxKvMI76F7qa+HuVievFWbNtPV7oK8lFzNJOnKdpA=;
        b=SM3AN5pt9/8phj7u9ROmPXdFMXx8LN2cvmEhF6v3C9FwvYO75jtMpHODjKpL3dyvKk
         qQ8ypPe5qi+GXOzFYBi0imgOWrGVX7CXFqUmhcPh+Gc552iHbF/QDzGZQxMdNXkB6quV
         XFRVzDCS+Loi0W2nBguKD12tcglTV4lZaJHQmKr0KXXGEWexiqQHJoB4wqM3MWUJPM84
         oLJ2RFIGXs7W9ZOJ7h1xYZgaz9yxErQ7a/1+aJQnbkm47sey46enqCVw5Due4jlW63DT
         tmIIQ1E9yaVtbnvJTQ36Ko1E0UazOP9j9JO3vpcRxAAlfMtWTYjzomOVIvVPRQMWebMl
         rD4Q==
X-Gm-Message-State: APjAAAVs6K+3vDkpght6YW5iIhbtVYk5gAoPDps/4+TSmo080pDCSW9+
        W8BMiGthBVTtjKbZ08QPSOtzDzC6l5fBu27nKy1Qmw==
X-Google-Smtp-Source: APXvYqzwrEgOeAiGg4ql0plFeCQSsvwUiysIH7xINJ9Wx5BMLLv8UgBybbXrIRxS+W6CmC/ydcK98mcL7/W+xLgbDGc=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr5071003itl.153.1559939254598;
 Fri, 07 Jun 2019 13:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190607144944.13485-1-ard.biesheuvel@linaro.org>
 <20190607175947.GB648@sol.localdomain> <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
In-Reply-To: <97BB95F6-4A4C-4984-9EAB-6069E19B4A4F@holtmann.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 22:27:22 +0200
Message-ID: <CAKv+Gu-ek4nK+cACx5QZTbp=ciQq_Fvtn9y3g-wFWSOabyczZg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] move WEP implementation to skcipher interface
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Johannes Berg <johannes@sipsolutions.net>,
        "open list:NFC SUBSYSTEM" <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 7 Jun 2019 at 22:24, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Eric,
>
> >> One of the issues that I would like to see addressed in the crypto API
> >> is they way the cipher abstraction is used. In general, a cipher shoul=
d
> >> never be used directly, and so it would be much better to clean up the
> >> existing uses of ciphers outside of the crypto subsystem itself, so th=
at
> >> we can make the cipher abstraction part of the internal API, only to
> >> be used by templates or crypto drivers that require them as a callback=
.
> >>
> >> As a first step, this series moves all users of the 'arc4' cipher to
> >> the ecb(arc4) skcipher, which happens to be implemented by the same
> >> driver, and is already a stream cipher, given that ARC4_BLOCK_SIZE
> >> actually evaluates to 1.
> >>
> >> Next step would be to switch the users of the 'des' and 'aes' ciphers
> >> to other interfaces that are more appropriate, either ecb(...) or a
> >> library interface, which may be more appropriate in some cases. In any
> >> case, the end result should be that ciphers are no longer used outside
> >> of crypto/ and drivers/crypto/
> >>
> >> This series is presented as an RFC, since I am mostly interested in
> >> discussing the above, but I prefer to do so in the context of actual
> >> patches rather than an abstract discussion.
> >>
> >> Ard Biesheuvel (3):
> >>  net/mac80211: switch to skcipher interface for arc4
> >>  lib80211/tkip: switch to skcipher interface for arc4
> >>  lib80211/wep: switch to skcipher interface for arc4
> >>
> >
> > The way the crypto API exposes ARC4 is definitely broken.  It treats it=
 as a
> > block cipher (with a block size of 1 byte...), when it's actually a str=
eam
> > cipher.  Also, it violates the API by modifying the key during each enc=
ryption.
> >
> > Since ARC4 is fast in software and is "legacy" crypto that people shoul=
dn't be
> > using, and the users call it on virtual addresses, perhaps we should in=
stead
> > remove it from the crypto API and provide a library function arc4_crypt=
()?  We'd
> > lose support for ARC4 in three hardware drivers, but are there real use=
rs who
> > really are using ARC4 and need those to get acceptable performance?  No=
te that
> > they aren't being used in the cases where the 'cipher' API is currently=
 being
> > used, so it would only be the current 'skcipher' users that might matte=
r.
> >
> > Someone could theoretically be using "ecb(arc4)" via AF_ALG or dm-crypt=
, but it
> > seems unlikely=E2=80=A6
>
> that is not unlikely, we use ecb(arc4) via AF_ALG in iwd. It is what the =
WiFi standard defines to be used.
>

Ah ok, good to know. That does imply that the driver is not entirely
broken, which is good news I suppose.
