Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6921A967
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGIUzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jul 2020 16:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgGIUzo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jul 2020 16:55:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF4C08C5CE;
        Thu,  9 Jul 2020 13:55:44 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a30so1651879ybj.5;
        Thu, 09 Jul 2020 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5wGJa6N/+T5/MzYdjosGhTKMgj9m+3bHMSgEwljc8Rk=;
        b=Z1N86Mqka14S26ELiAI4BuZzgmYDzknCuJQWjwOWYVCjkk8t/jrgqH5rkWHUwOeXli
         KlVD1mMM37eBSbaeMkRdcf5+uDjdaufNYvPHtq+VjiaZ/oF9Ytd7hZsTXKNv1FApicBw
         DFQ319kl3jx7WVrJuL2URL8K4SfZdFhSfOOaLQciXNzdX076LqpW2DbIE4KDQGuBLCgw
         8jhzzyCz+6tOnV94BAa0QSGJT5W/t/absEJXDVB18sDr1dxpgzAZSzQxzgDMdZ22L7EY
         S4NcAmpJ+9HJ0v6S7vxDiPIZCyWGIOSmp2zcOOq2B4tFHWHBNt1Z4TbU2xiC7Rv9Y2SL
         PlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5wGJa6N/+T5/MzYdjosGhTKMgj9m+3bHMSgEwljc8Rk=;
        b=jBN8+Kmdnh0XqtW1yulMSW8lyP/Vw9y79lBTMqnkYeHTnwhuBFmvVNCYAh0rVZOvvl
         TAI+3ULj/fitiXWGPYjlj8sdG07dBEzzQtPf5O1Hswu1xMvBPaPXccEQlDtsWj0PU1VQ
         QfCTMj1ugPUhvIaL7yPwHuDpyOdTo3GQhYdioLNbLVlvDuX+QAsrs3Ut7ugkTBoyIBFr
         fbh7rd8R5Yr0ATk+LOFF2wgrY996kSyMtl+l3sXe2Avl3qdEyhoGvs/dChto6zK21tVV
         jW8grQN6dND580CHg8XlZVMDsjB9peQtx7yZa4oM7fZ69jnt+JdffkR5PH8OY6Pj91wq
         EnNg==
X-Gm-Message-State: AOAM531lESymEcQ7gt/DPNzc1v5NCPt4oBBOD/T7+pwEcny3d8LXfFGr
        WPcoIzuPn3vK1cTbNCYQDa4zWyfbcaHDJDCsElRFOG8D
X-Google-Smtp-Source: ABdhPJz5+s4dpQoauaXI9ppAsXQEah3rB6Qc4dSTEMcRzeJXxIURkyQaYIEwWl2/bYiroqPs15DdP6TeNuktNBcRASc=
X-Received: by 2002:a25:6e0b:: with SMTP id j11mr11534162ybc.455.1594328143651;
 Thu, 09 Jul 2020 13:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200709062747.23948-1-grandmaster@al2klimov.de>
In-Reply-To: <20200709062747.23948-1-grandmaster@al2klimov.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 9 Jul 2020 22:55:31 +0200
Message-ID: <CACna6ryNBH7ZSie985YV9zXaEa_XmTXX2S2XH5LC8WfMZNFuAg@mail.gmail.com>
Subject: Re: [PATCH] SONICS SILICON BACKPLANE DRIVER (SSB): Replace HTTP links
 with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 9 Jul 2020 at 08:30, Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

I'm not sure how important that change is. You need to adjust your
PATCH subject though, see how older commits look like:
git log drivers/ssb/

--=20
Rafa=C5=82
