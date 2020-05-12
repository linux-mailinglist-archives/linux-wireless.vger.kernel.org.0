Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DF1CF08B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgELJA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729230AbgELJA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 05:00:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3CAC061A0C
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2020 02:00:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so9079737pjd.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2020 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+JBtyqJwGc7IDncae6fx8HBXnJ71fefyUPrpQJQjDiE=;
        b=NOfRfEXekkWINTo8oieRavHzVZWqUCfOCXccxqG9zLBQ4NJyvLUnGzKH9cyXO8r7UM
         /hKMPzn2B4aDUf46w1fyamIzeqDG8+1BvAxcFkJXmxw9UqJf/Wzl8FcZGHzv4aWy/F/A
         1BSA9NdB/Hc9xUDANiUhf87/8teviQIQEhgSTnzxz93ATTnskaYAm09IgRNjgbeEBBv8
         +40zbuXgEjrPDfVYYfu6AEpjZ6opGkI7q3dvWvceTMWsICmKtKdDOMgNJpugMM/vljk3
         KZQ/8tH1nzXWNqoC2ZcqpRlXSAnDcJh7w33MSwhghZH8a/+TzxiiE1yG77i60AGR4Aag
         whxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+JBtyqJwGc7IDncae6fx8HBXnJ71fefyUPrpQJQjDiE=;
        b=JE1XLkjHRE2SeJp78uDDxA4UMGXWX67x4+PlklqowZud7Pf9RsNGMtFx30gekP6ezT
         X82YWO+7pmzQwyGsKIlnt7zP+Wrt3o4Q4YuzbNpYG23V/ZtbhoJKL9qnwz9A+wKJ9njW
         irAjyW03WYhFalBBdamZYU+Pi3CpSRdw4Vfu/ZjgLQbq/eQ/P9bW8g763J7/Y20z6BQr
         2RGmLlxok+l9ISmuRvzZ86ly//yIsV/J9eNg6t30yEsTakrMAPEKa1Ahy3rQjXKvt48J
         X8HM2FgSkM7Yx7jgaPNAkQhlsHUggTMoYa5T1e5CdSIY3K08m9g/BNMNjfsXqPJSstre
         rsRg==
X-Gm-Message-State: AGi0PuaVYJUCcSguS8Tg2ScAMySWUAIVmIS5yUERetl+fCI5U2YRu9sv
        a/q6Rcyr34K/KIILCOzOlZJe
X-Google-Smtp-Source: APiQypKLJ1S8vNGEt9mqAMykw+g9Fu9HaDQfCLhgxM+rIrqo2y6l0UdU5ACm3X7NB+boT+w75PQPRA==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr17720228plt.96.1589274056878;
        Tue, 12 May 2020 02:00:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id g199sm1695015pfb.95.2020.05.12.02.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 02:00:56 -0700 (PDT)
Date:   Tue, 12 May 2020 14:30:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
Message-ID: <20200512090050.GD5526@Mani-XPS-13-9360>
References: <20200508085850.23363-1-govinds@codeaurora.org>
 <20200508085850.23363-5-govinds@codeaurora.org>
 <87d07a4acz.fsf@kamboji.qca.qualcomm.com>
 <20200512071323.GI4928@Mani-XPS-13-9360>
 <871rnp4lc7.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rnp4lc7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 12, 2020 at 11:19:04AM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:
> 
> > Hi Kalle,
> >
> > On Mon, May 11, 2020 at 09:03:56PM +0300, Kalle Valo wrote:
> >> 
> >> Govind Singh <govinds@codeaurora.org> writes:
> >> 
> >> >  config ATH11K_PCI
> >> >  	tristate "Qualcomm Technologies 802.11ax chipset PCI support"
> >> > -	depends on ATH11K && PCI
> >> > +	depends on ATH11K && PCI && MHI_BUS
> >> >  	---help---
> >> >  	  This module adds support for PCIE bus
> >> 
> >> Currently ATH11K_PCI is not visible if MHI_BUS is disabled, which I'm
> >> worried will confuse the users. I wonder if we should use 'select
> >> MHI_BUS' instead? That way ATH11K_PCI would be visible even if MHI_BUS
> >> is disabled.
> >> 
> >
> > Right, this sounds good to me.
> 
> Good, I added that in the pending branch.
> 
> >> And what about QRTR_MHI? Mani, any suggestions?
> >> 
> >
> > Are you asking for Kconfig dependency? If yes, then you need to select it here
> > also as you can't do much without it.
> 
> Ok, I added QRTR_MHI to Kconfig as well I also had to add "select MHI"
> as othwerwise I would get this warning:
> 
> WARNING: unmet direct dependencies detected for QRTR_MHI
>   Depends on [n]: NET [=y] && QRTR [=n] && MHI_BUS [=m]
>   Selected by [m]:
>   - ATH11K_PCI [=m] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && ATH11K [=m] && PCI [=y]
> 
> So now Kconfig looks like:
> 
> config ATH11K_PCI
> 	tristate "Qualcomm Technologies 802.11ax chipset PCI support (work in-progress)"
> 	depends on ATH11K && PCI
> 	select MHI_BUS
> 	select QRTR
> 	select QRTR_MHI

LGTM. I should have selected MHI_BUS in QRTR_MHI... but that's fine.

> 	---help---
> 	  This module adds support for PCIE bus
> 
> Govind&Mani, please check my changes in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5ebf69d1db8b027671b642e3ba0bec3d7c73acb7
> 
> > Btw, I'm not CCed for the patch so I haven't looked at it.
> 
> This patchset is in my pending branch, link above.
> 
> > But we have made few changes to the MHI stack which will impact the
> > controller drivers.
> 
> Oh, that will create problems. What kind of changes are needed in
> ath11k?
> 

I looked into your patch and the only change needed is below:

```
void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr,
                   u32 val)
{
        writel(val, addr);
}

int mhi_read_reg(struct mhi_controller *mhi_cntrl, void __iomem *addr,
                 u32 *out)
{
       u32 tmp = readl(addr);

       *out = tmp;

       return 0;
}
...
        mhi_ctrl->read_reg = mhi_read_reg;
        mhi_ctrl->write_reg = mhi_write_reg;
```

So we have offloaded the MHI read/write calls to controller drivers as they
are truly physical layer dependent. So the MHI stack just calls the callback
for reading/writing to MHI register space.

> > So I'd suggest you to rebase MHI controller patch on top of mhi-next
> > [1]. The proposed changes in MHI will hopefully land in 5.8.
> 
> I cannot rebase on top mhi-next as my patches go through net-next. One
> option I can think of is that I'll pull (not rebase!) mhi-next to my
> tree, but I would need to check with David Miller first and I'm not sure
> if it's worth the trouble. I think easiest is that we find minimal
> possible changes needed to accommodate the new MHI interface and then
> inform Linus and Stephen when do the merges.
> 

One more option is to create an immutable branch on top of RC like v5.7-rc1
which has the offending patches. Then we can do the pull of this immutable
branch into our respective trees.

Then finally when Linus pulls these two trees, he'll see that these are the
same commits and he should be fine. Only thing we should make sure is to inform
the respective subsystem maintainers to mention this to Linus during pull
request.

For sure the commits will appear in two shortlogs but that won't be an issue.

Let me know what you think.

Thanks,
Mani

> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-next
> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
