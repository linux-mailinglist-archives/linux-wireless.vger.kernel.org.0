Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B936D19A1F4
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgCaWa0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 18:30:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41667 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgCaWa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 18:30:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id z23so18772956lfh.8
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2020 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZRTdWRsRy0+yLenav5Vh7mR2qAKlGF4rQtXsANo03w=;
        b=hx40YH0DYtlkaR9hgzdXoWVoHw8Jrp/5M0XYQUpxo2pfOAHGDVMcxIckCmOVreeKvA
         XqTK6r5X+5Um7iKfji+v6rhHc351ilgqDRFTW48oqAcXrh0Nq3cjdTy0Znl8XdkRFWQE
         JVcsw/4efX2jTaW7MeNtciW9tQuAXIlFeOw1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZRTdWRsRy0+yLenav5Vh7mR2qAKlGF4rQtXsANo03w=;
        b=s+jSC37J+MClWdSj2+2tsoalIomZ0+8XJRBh2BEMU8o30en4MhUNj+rpya6wq/UJw2
         HbQrpPiv8y6Z0jJsptvyRtLheeZGxM3RlxyucqQftEIkBwdZNkmo+xcAoWc0/nprQnAq
         WM25c5GCep2pb1GGkg7Y6DXUt7xPlnGswp+/fBoIDuneihpHbNjYvz3R4vfdgqsoNMVQ
         EBrr/pPgwIZkFWwoT8QGHHwdfRBCtX5e8zGDfndRPdZ6EHlQJUSo41HFFrf8IFh7sReD
         raTeOd59se9CAlTVLJks/jDHpaHUX2KipaKxwd9Dq/G7j5THfsu5gh7403KZ47Wz/jFl
         anxw==
X-Gm-Message-State: AGi0Pua5o7IrjqNjDsaDgeNdrYmMdKspS5AbtgRjRNa64JmrCu1ndulc
        VNlU/wxSdzDvsFnPnrSMm6CWLppsAXU=
X-Google-Smtp-Source: APiQypLDnIIrY+uU/VHCjTt19C4H6otmeW1SHqmCUrGC99nMBeJsLynhYZAcTzzFaxsA1mc6ELspqQ==
X-Received: by 2002:ac2:5096:: with SMTP id f22mr13005046lfm.79.1585693824329;
        Tue, 31 Mar 2020 15:30:24 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j125sm167702lfj.38.2020.03.31.15.30.22
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 15:30:22 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t17so23774458ljc.12
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2020 15:30:22 -0700 (PDT)
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr11144383ljp.241.1585693822061;
 Tue, 31 Mar 2020 15:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200327075229.29191-1-yhchuang@realtek.com> <20200327075229.29191-2-yhchuang@realtek.com>
In-Reply-To: <20200327075229.29191-2-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 31 Mar 2020 15:30:10 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP0QMv=P6p-GRd4skhYdReHV=crvRz74HyyMXtSAHrCaQ@mail.gmail.com>
Message-ID: <CA+ASDXP0QMv=P6p-GRd4skhYdReHV=crvRz74HyyMXtSAHrCaQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rtw88: add regulatory process strategy for
 different chipset
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Andy Huang <tehuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 27, 2020 at 12:52 AM <yhchuang@realtek.com> wrote:
> v3 -> v4
>   * squashed with "rtw88: support dynamic user regulatory setting"
>   * modify the commit log
>
> v4 -> v5
>   * no change
>
> v5 -> v6
>   * remove custom world-wide, use stack world-wide
>   * surface error codes
>
> v6 -> v7
>   * restore custom world-wide
>   * modify commit message to be more clear

If it wasn't clear, v7 looks more like v5. I think I had some of my
own misunderstanding of the regulatory core when
reading/reviewing/testing v5, which resulted in ill-conceived changes
in v6. I think I've gotten my head around this, and this looks fine to
me. But that's not saying much, given how confused I was at times.

Reviewed-by: Brian Norris <briannorris@chromium.org>
