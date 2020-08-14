Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F87244CC4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgHNQhD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgHNQhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 12:37:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF0C061384
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 09:37:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so8430554wme.4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Aug 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=94xphIsJGhPowpoY48RBThw20r0QnhFcY0RxwYnSUxE=;
        b=rZxG6g7i2t7ZyPQH9ddRiiqgEUlrl1us85HkTolZef9PkcJ+vXPHdQdAbGmN+HDvM8
         XIAA+sY2nuMt2YFYdoyaKe1PnCA79G0wCya2n02BwUSRV1nBMgi2I0DSwNR84avsue4/
         wsgvZtYAwY/Gqu45ewvrfV+1Wd97y19Fze5JXzxxpKQeYV7l/XGIwdMbnG6VMYY7gqJd
         gS0Luw6N6QtvqmNyoxCLPIYmwMFaN3szIY5nSszR/QE/FDrLeF1EGcIHybAmNGOiepIY
         UDXopiEYjEfHgTSTK7n8J5yHE29xE8QLBDosrjimTi6QsPsoPa3UzxkHQMxFCEjrSEV8
         tr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=94xphIsJGhPowpoY48RBThw20r0QnhFcY0RxwYnSUxE=;
        b=NYLhjPCtjtILTKyRKBpw1Ms1AddEs2eTTIpKzTnvXlzADfpON9xcRDtUwoVyUXLGoI
         o5EDWp5zbWXHpi1SGJY7hIbALPo9hPBdf7V8jKPhOuTzcnJ1Rrmy74jvtrE4r8/jerYA
         0SmE48nn9UZGahrRY4c5SCGMGPmD2LFIAJjEthMLgshepZzKwt3OrlvePDh2palJtPEN
         AqFq+4x6n/eciQ2g0nMonZhNO2zXG0bpxS23zGTD58nBKg6jPXF4XurBhv65Tjv+6ceX
         tJwucyQ24DYgd2zGxK/xRX+DmunON2JbFRAT6lhgEeCv61l10YfOlvw8AXj8VIECq2n/
         +W1A==
X-Gm-Message-State: AOAM530mTC9kCMSn+3yHrvbX99C9oHFJI11GExBRL9zBjpU78jfl9552
        Hfgw9iaLwxI+stQMXpg9PActpA==
X-Google-Smtp-Source: ABdhPJxRz3mfR2pumE3rZxAsXJD1/Q56aR5OA66D2mmZLO5u8H0oQFcSdXmrbiyEBBP667ke8NFu+g==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr3127126wmk.159.1597423017663;
        Fri, 14 Aug 2020 09:36:57 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id n24sm15304070wmi.36.2020.08.14.09.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:36:56 -0700 (PDT)
Date:   Fri, 14 Aug 2020 17:36:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Artur Dubrovsky <dubrovsky.mail@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Michael Buesch <m@bues.ch>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, b43-dev@lists.infradead.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Martin Langer <martin-langer@gmx.de>,
        van Dyk <kugelfang@gentoo.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 26/30] net: wireless: broadcom: b43: phy_common: Demote
 non-conformant kerneldoc header
Message-ID: <20200814163654.GM4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-27-lee.jones@linaro.org>
 <CAJrvBf00yQQ7F1p1utBuq1oWc2RwnqXijBjaJ+FuxG0mS0TvOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJrvBf00yQQ7F1p1utBuq1oWc2RwnqXijBjaJ+FuxG0mS0TvOA@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 14 Aug 2020, Artur Dubrovsky wrote:

> remove me from mailing list

I guess you have to remove yourself:

http://lists.infradead.org/mailman/listinfo/b43-dev

> пт, 14 авг. 2020 г. в 14:43, Lee Jones <lee.jones@linaro.org>:
> 
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/net/wireless/broadcom/b43/phy_common.c:467: warning: Function
> > parameter or member 'work' not described in 'b43_phy_txpower_adjust_work'
> >
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> > Cc: Martin Langer <martin-langer@gmx.de>
> > Cc: Stefano Brivio <stefano.brivio@polimi.it>
> > Cc: Michael Buesch <m@bues.ch>
> > Cc: van Dyk <kugelfang@gentoo.org>
> > Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: b43-dev@lists.infradead.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/net/wireless/broadcom/b43/phy_common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

[...]

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
