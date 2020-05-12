Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546DE1CEDD8
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgELHNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELHN3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 03:13:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF3C061A0C
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2020 00:13:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b190so194338pfg.6
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2020 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bvIBWMYCQid6N8zBsdNDHUKkIdOA7VgYY1sntddkviw=;
        b=RecMHZRyHCdIIehdmGYZ/778gSExNRkgZEudpJwN1C+mfKGVLFFO1mZZhQk9OFmJk1
         HBommUjIPK/53oAAkjTFenUB7nhf96GnN3zP42LybhU8ftV3L0q5ZINbqmIeVEC+pAcm
         X6OjehnmLaJEWt1drhbjfWgnMpXV/sEHDTg/vm+GFEx0KO7N0JKRAXtVXkoUJUKAZKqV
         RmfQ8vfP5sM3K+E/C9Lo8R4VAySOMfmM/7LO//N0Qt728VyBtXFCnPtxJM+nygsu9iEx
         TBDzY40+3th71MLXCP1/LuqLz36YKCQbCIckG8yrxCItb1bGgok/0XJydQsnopUsiuqU
         D50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bvIBWMYCQid6N8zBsdNDHUKkIdOA7VgYY1sntddkviw=;
        b=lzHSZWQu9VhmXr9Ky5/cl0l5bIcr4nJljNo8RW8Q0zHxFEOu85jTnsiE6kFusRbkM6
         +dptSdMWCkJdTDmFyMi9fSehnXXA1H8Ja2tlcMRZ4vzcogI5EKwiBcGxXN09ERTC4MaP
         oAGTkq+GJS2bjFNL5n7M++PAWgWBBX9Td5oeasOyg5wFy8R2KT8KcJsA+poQE7iuCfGX
         vjJIqS4r1uOzVDjsmCu7UyVyj6yAEb2YUBZe8kpaiMGmWT4ioWJ/KHmgSqBwv0t8H8xV
         oEnUwsxoSQRKfLtstRV6iHzhxBftw9zvEVwST70m/PN0ucehTe7TM0VjiA7s4Z/m7pey
         M88g==
X-Gm-Message-State: AGi0PuaYr4nbofD5bzv2WXbGZy9NWWHwfBTsMZgE5EOu9xhzWC5sTrmV
        iYq6G8A5DL5wInKbYpOeCfs0st2zaw==
X-Google-Smtp-Source: APiQypLC0LQXEtnFGmt5pQE62v/wKLr3efmkuRyHauqPw2+yqydPoP28ATyNoJQbiYQyPxojJoBjrw==
X-Received: by 2002:aa7:951b:: with SMTP id b27mr19933794pfp.2.1589267608850;
        Tue, 12 May 2020 00:13:28 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id l6sm11069273pfl.128.2020.05.12.00.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 00:13:28 -0700 (PDT)
Date:   Tue, 12 May 2020 12:43:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
Message-ID: <20200512071323.GI4928@Mani-XPS-13-9360>
References: <20200508085850.23363-1-govinds@codeaurora.org>
 <20200508085850.23363-5-govinds@codeaurora.org>
 <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Mon, May 11, 2020 at 09:03:56PM +0300, Kalle Valo wrote:
> + mani
> 
> Govind Singh <govinds@codeaurora.org> writes:
> 
> > MHI is a communication protocol to communicate with external
> > Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses. Even
> > though MHI doesn’t dictate underlying physical layer, protocol and mhi stack
> > is structured for PCIe based devices.
> >
> > Register directly with mhi core layer as a mhi device driver for
> > firmware download.
> >
> > Tested QCA6390 on X86 platform.
> > Tested firmware WLAN.HST.1.0.1.c1-00440-QCAHSTSWPLZ_V2_TO_X86-1.
> >
> > Signed-off-by: Govind Singh <govinds@codeaurora.org>
> 

Ah,finally!

> [...]
> 
> > --- a/drivers/net/wireless/ath/ath11k/Kconfig
> > +++ b/drivers/net/wireless/ath/ath11k/Kconfig
> > @@ -2,7 +2,6 @@
> >  config ATH11K
> >  	tristate "Qualcomm Technologies 802.11ax chipset support"
> >  	depends on MAC80211 && HAS_DMA
> > -	depends on REMOTEPROC
> >  	depends on CRYPTO_MICHAEL_MIC
> >  	depends on ARCH_QCOM || COMPILE_TEST
> >  	select ATH_COMMON
> > @@ -15,13 +14,13 @@ config ATH11K
> >  
> >  config ATH11K_AHB
> >  	tristate "Qualcomm Technologies 802.11ax chipset AHB support"
> > -	depends on ATH11K
> > +	depends on ATH11K && REMOTEPROC
> >  	---help---
> >  	  This module adds support for AHB bus
> >  
> >  config ATH11K_PCI
> >  	tristate "Qualcomm Technologies 802.11ax chipset PCI support"
> > -	depends on ATH11K && PCI
> > +	depends on ATH11K && PCI && MHI_BUS
> >  	---help---
> >  	  This module adds support for PCIE bus
> 
> Currently ATH11K_PCI is not visible if MHI_BUS is disabled, which I'm
> worried will confuse the users. I wonder if we should use 'select
> MHI_BUS' instead? That way ATH11K_PCI would be visible even if MHI_BUS
> is disabled.
> 

Right, this sounds good to me.

> And what about QRTR_MHI? Mani, any suggestions?
> 

Are you asking for Kconfig dependency? If yes, then you need to select it here
also as you can't do much without it.

Btw, I'm not CCed for the patch so I haven't looked at it. But we have made few
changes to the MHI stack which will impact the controller drivers. So I'd
suggest you to rebase MHI controller patch on top of mhi-next [1]. The proposed
changes in MHI will hopefully land in 5.8.

Thanks,
Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-next

> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
