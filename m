Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C682C613E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgK0I5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 03:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK0I5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 03:57:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BDFC0613D1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 00:57:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id z7so4742066wrn.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 00:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bbiTgqd4ToQeRiBSJMQhq9hcfqtuv/kYGDy+0sCGicc=;
        b=i37faw1KnwmHqwkzSqojJ3kC4DCtvnlWMUsRCXMDUyunnBtJ53klG8G1BIf3NbpUbQ
         vWR2BbA2BbBcsY+jZclvlKUqebnzgXc1tJbhgLp8QQfx5VbACpilcHJbvi/jHa2UiE8p
         oG8sFRTdJ83G6qbc/eAUm/vpcbYpX9e/NldWFXprgAf6Yk3oYP0F0kdfn/PI3lzUDaHm
         XXf5TWutd2uxYhRqbxi4HTYk9ZeEXxVriilgESbVeOwpKt9oJCsxqn6xWEneb2nDl+Am
         jt0zFpys+3V8GgzUwVz5JVuylFwpphqVQ2/rWVmAXyYlT889reszQpn1la+binSX2ZvP
         dm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbiTgqd4ToQeRiBSJMQhq9hcfqtuv/kYGDy+0sCGicc=;
        b=CAZ7bNaucDK5B9TcYqcnOWzgahKj+JDTwFFv/OSF3uFczMT4QkCSYSXUKDiP6kYctj
         U7HcYjRY5Ebk3TDsfvqifa75o3qPPQX7Ug4PFBdey/NdY7l191WoEA5IW8xD1RbAf00U
         jwkrQtFzeZ6xetdZdsSTIFFDkJnXW8ZN4HNBhNXoeNjiQGmCg2Hwpjd7C4CuMgrD4U1q
         pyGovHXKPSv0G1PFN3S0dIIkVDAPZUnT+ptz8BHvAO2DU0xDu2EPWtY4FDazId6AgVY3
         gqs/tzq9zEjYvfhgEg3U6QhK2Pf6RBZDYBlZMqdz9HTg9hs9q9px/MzhNzxKdQeKvsfh
         UWQg==
X-Gm-Message-State: AOAM531LGT/n3HLlZy+qyhJ8kLspllhbezcx7LjAA1A5YzkQrXkrnf1p
        HaM9s5nTLb2GBv/S8VAiPDbf2TInKI4gcGY0
X-Google-Smtp-Source: ABdhPJzeyxK530smdHXIDeAe/99P7Nxy+EnsnNtNS5FLR4s2zGnUtnuNf+d8Sfr6sUd3hf25pHmIdA==
X-Received: by 2002:adf:f651:: with SMTP id x17mr8903334wrp.185.1606467427573;
        Fri, 27 Nov 2020 00:57:07 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id m20sm13876879wrg.79.2020.11.27.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 00:57:06 -0800 (PST)
Date:   Fri, 27 Nov 2020 08:57:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pkshih <pkshih@realtek.com>
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH 17/17] realtek: rtw88: pci: Add prototypes for .probe,
 .remove and .shutdown
Message-ID: <20201127085705.GL2455276@dell>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
 <20201126133152.3211309-18-lee.jones@linaro.org>
 <1606448026.14483.4.camel@realtek.com>
 <20201127073816.GF2455276@dell>
 <1606465839.26661.2.camel@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1606465839.26661.2.camel@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 27 Nov 2020, Pkshih wrote:

> On Fri, 2020-11-27 at 07:38 +0000, Lee Jones wrote:
> > On Fri, 27 Nov 2020, Pkshih wrote:
> > 
> > > 
> > > The subject prefix doesn't need 'realtek:'; use 'rtw88:'.
> > > 
> > > On Thu, 2020-11-26 at 13:31 +0000, Lee Jones wrote:
> > > > Also strip out other duplicates from driver specific headers.
> > > > 
> > > > Ensure 'main.h' is explicitly included in 'pci.h' since the latter
> > > > uses some defines from the former.  It avoids issues like:
> > > > 
> > > >  from drivers/net/wireless/realtek/rtw88/rtw8822be.c:5:
> > > >  drivers/net/wireless/realtek/rtw88/pci.h:209:28: error:
> > > > ‘RTK_MAX_TX_QUEUE_NUM’ undeclared here (not in a function); did you mean
> > > > ‘RTK_MAX_RX_DESC_NUM’?
> > > >  209 | DECLARE_BITMAP(tx_queued, RTK_MAX_TX_QUEUE_NUM);
> > > >  | ^~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > Fixes the following W=1 kernel build warning(s):
> > > > 
> > > >  drivers/net/wireless/realtek/rtw88/pci.c:1488:5: warning: no previous
> > > > prototype for ‘rtw_pci_probe’ [-Wmissing-prototypes]
> > > >  1488 | int rtw_pci_probe(struct pci_dev *pdev,
> > > >  | ^~~~~~~~~~~~~
> > > >  drivers/net/wireless/realtek/rtw88/pci.c:1568:6: warning: no previous
> > > > prototype for ‘rtw_pci_remove’ [-Wmissing-prototypes]
> > > >  1568 | void rtw_pci_remove(struct pci_dev *pdev)
> > > >  | ^~~~~~~~~~~~~~
> > > >  drivers/net/wireless/realtek/rtw88/pci.c:1590:6: warning: no previous
> > > > prototype for ‘rtw_pci_shutdown’ [-Wmissing-prototypes]
> > > >  1590 | void rtw_pci_shutdown(struct pci_dev *pdev)
> > > >  | ^~~~~~~~~~~~~~~~
> > > > 
> > > > Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > > > Cc: Kalle Valo <kvalo@codeaurora.org>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: linux-wireless@vger.kernel.org
> > > > Cc: netdev@vger.kernel.org
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/net/wireless/realtek/rtw88/pci.h       | 8 ++++++++
> > > >  drivers/net/wireless/realtek/rtw88/rtw8723de.c | 1 +
> > > >  drivers/net/wireless/realtek/rtw88/rtw8723de.h | 4 ----
> > > >  drivers/net/wireless/realtek/rtw88/rtw8821ce.c | 1 +
> > > >  drivers/net/wireless/realtek/rtw88/rtw8821ce.h | 4 ----
> > > >  drivers/net/wireless/realtek/rtw88/rtw8822be.c | 1 +
> > > >  drivers/net/wireless/realtek/rtw88/rtw8822be.h | 4 ----
> > > >  drivers/net/wireless/realtek/rtw88/rtw8822ce.c | 1 +
> > > >  drivers/net/wireless/realtek/rtw88/rtw8822ce.h | 4 ----
> > > >  9 files changed, 12 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireless/realtek/rtw88/pci.h
> > > > b/drivers/net/wireless/realtek/rtw88/pci.h
> > > > index ca17aa9cf7dc7..cda56919a5f0f 100644
> > > > --- a/drivers/net/wireless/realtek/rtw88/pci.h
> > > > +++ b/drivers/net/wireless/realtek/rtw88/pci.h
> > > > @@ -5,6 +5,8 @@
> > > >  #ifndef __RTK_PCI_H_
> > > >  #define __RTK_PCI_H_
> > > >  
> > > > +#include "main.h"
> > > > +
> > > 
> > > Please #include "main.h" ahead of "pci.h" in each of rtw8xxxxe.c.
> > 
> > You mean instead of in pci.h?
> > 
> > Surely that's a hack.
> > 
> 
> I mean don't include main.h in pci.h, but include both of them in each
> of rtw8xxxxe.c.
> 
> +#include "main.h"
> +#include "pci.h"

Yes, that's what I thought you meant.  I think that's a hack.

Source files shouldn't rely on the ordering of include files to
resolve dependencies.  In fact, a lot of subsystems require includes to
be in alphabetical order.

If a source or header file references a resource from a specific
header file (for instance here pci.h uses defines from main.h) then it
should explicitly include it.

Can you tell me the technical reason as to why these drivers are
handled differently please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
