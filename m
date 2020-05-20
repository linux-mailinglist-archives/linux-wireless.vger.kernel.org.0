Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D601DB47B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETNBy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETNBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 09:01:54 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46269C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 06:01:54 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id v26so1769752vsa.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2020 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woAnCIhfYEJLipFe8EyZcfmluPA2MaZuO37zxR3vgb4=;
        b=Kn2sSWppvhHVjhct9KDLJTMw91TD7ZhUf0aMA3bkc7nFiCuylrwPze0UQIIik4DdOJ
         N8ygw4qG37hZ4LHNY8si5tGH3HklqEHflv2DJvrRkKRCdtpNUzBOwiHIIC825z3XC27w
         7xtWGQ+V/TuL/PwTDEN/VYctGxhSFhPcvqHBqAU4cmdRTFHBU9sBFQjDz0+6yPs0WqFT
         PP30AWltwUF1x6fa41Om76QWWKdFgIkXZkLwHczf2i9haOcLXssXGQ6kQQa1ImVx05kB
         wpBaCZOoqNg+rV/uxU6KgDv7gS8RRNmiyFtGsBDzK3C8iOiVnjAAqkUYPoESt2ueMqBK
         ANfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woAnCIhfYEJLipFe8EyZcfmluPA2MaZuO37zxR3vgb4=;
        b=WXstQqiBPMxH5hfxO1rkBvyu6hD5k+A7MvAb5vWXy3gLJdO1PBQDUFDL9Vsc1PEdYl
         Zy+50yDDKEQkXtShrxBvxUg3JvDib0A7IHRhvpBMoylaTp2UiU4RCoxCVSugxl8FX427
         rQfaucTVgpoQqH1yPwld6W11WsdTlkP932CoCGkkRUdEqMXI5ScTk+R7mhjfbJX8DqXY
         5v8d4FDVGtlk0aRCJ2sP7PmsKTzVihAKQJRUiumfXpNuv4VW3YZKp4hmPVf9XzCKb7TR
         z/qYa2M85zAht5kAtacr5DZjqc60n0QpN3L/qxNjHTayT5lZGR1om82Mx9TW66T7Tv6a
         zw5g==
X-Gm-Message-State: AOAM530Wv44V10gN/EgoT0L8i2M1bcPfW/qCHvnX0X5l/HU4jelUr2Ez
        ugmYB2WERC9ZaagSRQbfkjX/3tKuiDBqb+WalCw=
X-Google-Smtp-Source: ABdhPJzM3ZY8vwut7M1/Mc1Vzn+Fk4KTxo0f0WuLZt4UD6+dKcBpOhqFbJjxWDWosv1dzsuk/FboXI+w3tieJ8IjTSg=
X-Received: by 2002:a67:684a:: with SMTP id d71mr2937165vsc.176.1589979711982;
 Wed, 20 May 2020 06:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <9122588d-683a-936e-1305-c34124e6702c@nextfour.com>
 <CANUX_P1q22J6ONRqTCDwwEMtmbGbCmS=C1WK6Zz0OqG_v2qcSA@mail.gmail.com> <f27e0e85-6e45-15bd-1460-4140671ee4cd@nextfour.com>
In-Reply-To: <f27e0e85-6e45-15bd-1460-4140671ee4cd@nextfour.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 20 May 2020 16:01:43 +0300
Message-ID: <CANUX_P3kqY9wMBmAZoKsdzQv0TdW1pY7d=yqp5925Ryhkyq=Xg@mail.gmail.com>
Subject: Re: iwlwifi firmware loading problems, rk3399
To:     =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> > I guess you need to debug your board :)
> > The interrupt is not coming, then.. there isn't much the driver can do.
>
> Well it does get interrupts, but stops getting them during fw loading at
> some point which causes it to fail. I have seen similar posts while
> googling and they are happening on x86/ubuntu and popular platforms. So
> I'm afraid it is something with iwlwifi or its usage of MSIX or such.
> The kernel version is 5.4.

You can try to disable msix.
In iwl_pcie_set_interrupt_capa, just goto enable_msi.
