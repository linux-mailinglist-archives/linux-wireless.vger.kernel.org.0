Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0CB4280D9
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Oct 2021 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJJLjQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Oct 2021 07:39:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58534
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231556AbhJJLjK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Oct 2021 07:39:10 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E437F3F324
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633865830;
        bh=3aL2g6ASYJjmJXLGE2td/GKebrEEfp5cYtOVSOPNOjE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NlvMVZ67a0hPzWrD3G4a8t+GYgWdmcm6d6vb/KpzA0sqzAwaueSz4aW/STTaDizsx
         fKDZjFCsPzI6qTpRKfC9PQsJ2OlP4DjdmZuuv5WddyT2Y65VrMcqebs+81i5QkryMe
         l4MEo3uk0HMvUQFxKTNxZq4nnNuQp0xhdbBqaFdheqLTQA+/cLbHj29GicDdpYowF0
         vqdlivyUYR4cOB0ByUmOAVFTogPwWLjftgHIOns51MaTlF7lMSKAUp/ZkmqihFAZOB
         LR3MqAVZQWvuIiOGXmzkg2BG1fd5cZ93N4caVo7INPdLUPd6y4OWyZcPCeYbQfthUJ
         HkruYINc1vNiQ==
Received: by mail-ed1-f71.google.com with SMTP id 2-20020a508e02000000b003d871759f5dso13240352edw.10
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 04:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aL2g6ASYJjmJXLGE2td/GKebrEEfp5cYtOVSOPNOjE=;
        b=1eFqL2KPoTJLTDod3eMxLLlcgej5ZBriKm3csSGdqMfdRW3g/SJxaS7H4e2gBVCLw3
         yQYOPH8ntzSQtYLXXQ+gUgQ5nzmNjpwWilzPIcdEDzFA4QC+DJ/LZNB7fr5UnOlKWRJd
         oo9KtP4QYSBpF8eWWKP/D0V2cezsvdXL3By1Yqxfay6HIVuC99c9gj9+hhic5Nz9JvFp
         qN9Rf7QSANuEYUDN02VtOX14qGGzZkkgQaIoHwfp8R2wC1BXOO3qJHjQRTc+tZ2875q/
         +M4i/g5s7QPx3QcPcQ0eSPZdVzynZ2uoT46SfO45R3DMAF/4E+XhDp6YAT667euNzpkW
         u76Q==
X-Gm-Message-State: AOAM533hYbITmlHoFPbmaWY5RGiHbM9PMu9DssPR/i1fZH8Ec7+8j4JE
        gsWw0Fh7jk2th1EqaiG0iDghomWGhxNhtOA3PsA71ctfP1x25dggYm3yPpczbzErELdOQM+vAx3
        2jHIHpRvw/I/0zz8Its8/TZ7EuSrgPYzCjku8YU6CsNZsRZ0aQ1fgKNjNcBnx
X-Received: by 2002:a17:906:919:: with SMTP id i25mr17554111ejd.171.1633865830570;
        Sun, 10 Oct 2021 04:37:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmGfXRax8w6ByvvioynebBatQTyi+KnMs4IdARMtMQVkKFfh4370Xu091DRaFkuwupjNT9l7lw+PWQutb8gQQ=
X-Received: by 2002:a17:906:919:: with SMTP id i25mr17554102ejd.171.1633865830425;
 Sun, 10 Oct 2021 04:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211007133021.32704-1-krzysztof.kozlowski@canonical.com>
 <20211008.111646.1874039740182175606.davem@davemloft.net> <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
In-Reply-To: <CA+Eumj5k9K9DUsPifDchNixj0QG5WrTJX+dzADmAgYSFe49+4g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date:   Sun, 10 Oct 2021 13:36:59 +0200
Message-ID: <CA+Eumj65krM_LhEgbBe2hxAZhYZLmuo3zMoVcq6zp9xKa+n_Jg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/7] nfc: minor printk cleanup
To:     David Miller <davem@davemloft.net>
Cc:     k.opasiak@samsung.com, mgreer@animalcreek.com, kuba@kernel.org,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 8 Oct 2021 at 12:18, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On Fri, 8 Oct 2021 at 12:17, David Miller <davem@davemloft.net> wrote:
> >
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Date: Thu,  7 Oct 2021 15:30:14 +0200
> >
> > > Hi,
> > >
> > > This is a rebase and resend of v2. No other changes.
> > >
> > > Changes since v1:
> > > 1. Remove unused variable in pn533 (reported by kbuild).
> >
> > Please CC: netdev for nfc patches otherwise they will not get tracked
> > and applied.
>
> netdev@vger.kernel.org is here. Which address I missed?

The patchset reached patchwork:
https://patchwork.kernel.org/project/netdevbpf/list/?series=559153&state=*
although for some reason it is marked as "changes requested". Are
there any other changes needed except Joe's comment for one patch?

Best regards,
Krzysztof
