Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CF81E0F7C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbgEYN2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbgEYN2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:28:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC46C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:28:12 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 1so9896901vsl.9
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+LsiOwvjl2SpU2qvLXaL5iXkasm+LPHHmTOpB6DmUs=;
        b=U2agXUH+jxBeOk+TChHf9u9B313Dp1m/h3uVwOQQFxcx+2n1gbfdu9Rmw8TxTYF73s
         BS0oXypZZdhR7FhY2l3sbUAH13qeoRu1hXEoBOB3i8CYAxKuLV302JACkX/Hknbvw/+E
         frFfDxLmyoOulcydkVeRlLprk9BfgYTRiKOw/g/yeEFwBu6tSQfUPSavn7FT9eX9izwG
         LZUxsXi95H16I7mP6gqwurs1w2VHGeq59zHNwIxYIsetR+Qgmd293FwD0aw7yfcBQyv+
         CDwF0TC0WeLv4fQRYoQt+t8PmHqA71P8dAnUpNt65l1CQkL7UIhptXf4SHzUwaBRJNgH
         fC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+LsiOwvjl2SpU2qvLXaL5iXkasm+LPHHmTOpB6DmUs=;
        b=pEcRSLqO/9eIiN4g9FUtmaD1R70Pa8fqrsxGiWYA06enXgQZ3e/reaTrDK11kf7SWG
         1TLWKAyaPYozxfmftIEew/J2Sh3rRWTT4hEIXDIwNO05Sy8jz+1kYIjGV8M8jPbwJHjf
         UmLLBSPzv0pb3TYU9w0jZ/C+9rvm3xxv3Ohw8jMV2cm0EOwgsBOG9U7a7+t+2ai/7Hyd
         RSzNuAioG/fAE1LExfs8FV+UzGZqpWu7WTH54NdhKq2MQO6heV2Mz/fvbVHRbKm38L7h
         3I19g1hWJrhxe+R4zYnwRUeMOxN8Cx+LK67a0fUMD2gBanD/1hshWSqQ91+IVPx6DoiY
         TqPw==
X-Gm-Message-State: AOAM532h8sIH7i10099WH3AcIAlI7h+v+siHfFIq5C7tcqr5IZMvrK1s
        vGi7ZJzYPd2g7RS63ypiIFuO5avG2b3xjqhfCg==
X-Google-Smtp-Source: ABdhPJyTE9oTcfKHghGzLSWfubUvewiKfMohma4YUG0g3FGiW7cXbqzp8SB3D4vVh/zH6DqB4uoSxGGjTDvGmmJvy2A=
X-Received: by 2002:a67:f64a:: with SMTP id u10mr18441388vso.202.1590413292010;
 Mon, 25 May 2020 06:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
 <CAGRGNgWuQjQzDS9-cPAx7TnDfEiGnSccw4vqPAE_gWV=QS5JVw@mail.gmail.com>
 <20200524123931.GA915983@wp.pl> <640c254edb9fdaec2fd8987d1f2d345bd1d9276c.camel@sipsolutions.net>
 <20200525093142.GA926004@wp.pl> <9a8da74898b68fb63f65567068de0fcb2b5a57b0.camel@sipsolutions.net>
 <20200525105814.GA926693@wp.pl> <CALjTZvY0qPXxS=VPG3Ma6CCdtWo2g2XC3Cnks6jnNSFzqz-HAQ@mail.gmail.com>
 <CALjTZvbNdQw4uj+n231d9R39F_MNn=nrj9_aL71am4Wy7jnh1A@mail.gmail.com> <9188b9f91d162146a61729b5b4fcc06530674810.camel@sipsolutions.net>
In-Reply-To: <9188b9f91d162146a61729b5b4fcc06530674810.camel@sipsolutions.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 25 May 2020 14:28:01 +0100
Message-ID: <CALjTZvbGQSZ9Jv=6W744FBTKn3AdPDuhdrgvPOsf15rJ+KXyoA@mail.gmail.com>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Stanislaw Gruszka <stf_xl@wp.pl>,
        Julian Calaby <julian.calaby@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 25 May 2020 at 14:14, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Not at this point - but the GTK comes with null STA, so you want
>         (sta && sta->mfp)
>
> instead.

Indeed, that did the trick, thanks. Will send the patch soon.
