Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE6340206
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 10:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCRJ0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhCRJ0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 05:26:35 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E9C06174A;
        Thu, 18 Mar 2021 02:26:35 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e7so1161501vsq.3;
        Thu, 18 Mar 2021 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zo2npcvjAmGdvZUAArXqzA6IXvNRRqR0Tqj2d4B4ucw=;
        b=A9sT6b8T7NlCvCTNZLZO5umXRsldX0zyFWDJBLjfvKRyNmLPObVTTUhSxHJpAN5DHp
         Pnz926cXmO21j8iDXbdb1fX/Ydh/QkUouj6+KMyemTGsQ3CqcG/yl3UwaJlHtIxg1wZs
         zmcrnZ9jLsOLa4bNRQHU3MIp3A+IHhQSkyyTdbvjvOusTbGEEElHoLfHbV3D54OcnGti
         JpRVjPN0vClIo1LuB8ibe3bl/rFEvyenTXihdBBdCPn3DEi/0s0EkjJA8Fg9QbFpEzbb
         1iRWmmjq7agiq/h2qPpz6aX1i8sJnbOxpIOfHQYyoFc+Ot9SQ2VRWUaVGZXvy3Zwmgbc
         1W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zo2npcvjAmGdvZUAArXqzA6IXvNRRqR0Tqj2d4B4ucw=;
        b=n9H2MKUNQMUspvXoMIp92b9Sy/1BHEOUMff2Jy5gYgUXGZbIU+WwNHrNK1+HjQ4q8C
         OWndT2IXv1Lci4Sfy31HKPN7WjhFv2XQiDYSWQQKjfgUSrk0FTEWXIVhOKh8EQvsiarv
         Z1tc/jNitdNtbuejOme4eaoWsbcUYU41ppBtGdXZnZZmSBWPeSuOEAxNPUldRqFRxDyO
         +7gQZ9xWq8kTsY8K+/vlj5qzGpR7LFISa8J3OXYR23WaWEFoWB/V4zAw1Cb1mYChpjRi
         NzS+5WjRHnKjl0W5BF6B1XOGH0MeJTZkdPTBHuUWcxFBCDxkDJHglMjD/2V5fYRMyyMO
         lbQA==
X-Gm-Message-State: AOAM533MqnCeJ53fqLTkmzhGqxCaPXRS+PaUJ1l8tNow64O4AWvgxNGf
        BI8E1txvqdrvYZyPcung4fQEmnQLD8yrGZwnC7hlZBfNlUXbQw==
X-Google-Smtp-Source: ABdhPJyzK6WobYKX1DPkc7Nx+/l46jjPE0iKCY6ClKvVU/XRv4krc1y0j+MhF9bq4BDvd1HNhXO8/VSVTIywdUtniVQ=
X-Received: by 2002:a67:6f45:: with SMTP id k66mr5674085vsc.51.1616059593923;
 Thu, 18 Mar 2021 02:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <s5ha6r0kgt5.wl-tiwai@suse.de>
In-Reply-To: <s5ha6r0kgt5.wl-tiwai@suse.de>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 18 Mar 2021 11:26:22 +0200
Message-ID: <CANUX_P3Ucp1+L_6U+1VHBb8PKtzfN_62aXc1tRde02oDAfqRUw@mail.gmail.com>
Subject: Re: systemd-rfkill regression on 5.11 and later kernels
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Thu, Mar 18, 2021 at 10:31 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> Hi,
>
> we've received a bug report about rfkill change that was introduced in
> 5.11.  While the systemd-rfkill expects the same size of both read and
> write, the kernel rfkill write cuts off to the old 8 bytes while read
> gives 9 bytes, hence it leads the error:
>   https://github.com/systemd/systemd/issues/18677
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1183147

If you use an old kernel that expects only 8 bytes and you write 9,
then yes, the kernel will read only 8.
If you use a new kernel (5.11) and you send 9 bytes, the kernel will
read all the 9 bytes, so I am not sure I understand the problem here.
If you have a new header file that makes you send 9 bytes, then, in
order to run against an old kernel (which seems to have been the case
with the report in github), then you must be ready to have the kernel
read less than 9 bytes.
What am I missing?

>
> As far as I understand from the log in the commit 14486c82612a, this
> sounds like the intended behavior.  But if this was implemented in
> that way just for the compatibility reason, it actually is worse,
> introducing a regression.
>
> Although this can be addressed easily in the systemd side, the current
> kernel behavior needs reconsideration, IMO.
>
>
> thanks,
>
> Takashi
