Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884F22AA774
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 19:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgKGSm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 13:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGSm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 13:42:56 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E6C0613D3
        for <linux-wireless@vger.kernel.org>; Sat,  7 Nov 2020 10:42:55 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so4297030wme.3
        for <linux-wireless@vger.kernel.org>; Sat, 07 Nov 2020 10:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yxqmyl67WCvQeMIwKoccf4bZzL/NHq26s0+nbTo7KwE=;
        b=yHaxWk7OZ/8bNPjGJtgE12wRzGMSUpP0LHHMJmBlM3pINildvwfUf7zKM44Z0+ayxi
         dYm8U/8Uyn7ZBWJwEZn8LMkK5hmV/VijiEm5y8jq+c+rw/9mBjsB/U3dp30Flk4YTmhd
         ipj6dPYOMauRXQDPmJ5H9EzlsM1MGxk+6v1Oi1CH/DHrMtCAn8O76sRZ57dmk2cX1lPt
         gp4hjGVSTNzWejVHXlX/TS6s+k4lu9asrLktFIGPh3Dh0iQ57Ct1YSlNklIiszx71bM0
         qyCf22qXMDQiNeax1Ez3sSoLRGVZ3+0uSTcgCk5WuoIP5M4LJrvpu39FPLB5IQSo0gYr
         TNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yxqmyl67WCvQeMIwKoccf4bZzL/NHq26s0+nbTo7KwE=;
        b=JIVh0+hzkPyJBgI3hFB7qNjIptrkTKdtVmOOJAypDL2/CClkY9H6Ni+SlT28Np/JNI
         cWi08zglS56HQEhf1L9KLcO4QT+92ET5jyhEv/nW2zkfgYh8QO7r9a3qqTt2LjIixMR+
         /o9EQtpgrtMsBUJLKSc9b6v1ZqaIu6815D/rIF0Nb1IJAAc0OIkAEiG7LHSvvn7h56ao
         YvOcar7JQngZ400DXUm0+TpXtId2rvaImAvdY270MOhTgUOdPsKmNqVBKVRJdBqZuZAR
         CbVYepQA+wNbmBBwVFR/0hAG0/nFS2pSFszyeCdCLRD/wQ9U5MmG+ra32uweRCfmHXMo
         Sv/Q==
X-Gm-Message-State: AOAM531lAdTW7BcoSDHaIzGgw7Eo4VO8dOGtKa1YGrfjYYMaGoGz1aYi
        MrY+B50yUrmQ4AJrrdnQMZaa+Q==
X-Google-Smtp-Source: ABdhPJyTo90E+wkDFc5CnRqPxWZxg0Iab+ECawWBxFPgKSL2swBaR69JoZ5rex4sqhxialZ9QevG6Q==
X-Received: by 2002:a7b:c846:: with SMTP id c6mr5626026wml.143.1604774574501;
        Sat, 07 Nov 2020 10:42:54 -0800 (PST)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id e6sm7093053wrs.7.2020.11.07.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 10:42:53 -0800 (PST)
Date:   Sat, 7 Nov 2020 18:42:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Subject: Re: [PATCH 41/41] realtek: rtw88: pci: Add prototypes for .probe,
 .remove and .shutdown
Message-ID: <20201107184252.GT2063125@dell>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
 <20201102112410.1049272-42-lee.jones@linaro.org>
 <CA+ASDXOobW1_qL5SCGS86aoGvhKDMoBzjxbAwn+QjHfkqZhukw@mail.gmail.com>
 <20201103084453.GJ4488@dell>
 <87y2jd5dyl.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2jd5dyl.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 07 Nov 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Mon, 02 Nov 2020, Brian Norris wrote:
> >
> >> On Mon, Nov 2, 2020 at 3:25 AM Lee Jones <lee.jones@linaro.org> wrote:
> >> > --- a/drivers/net/wireless/realtek/rtw88/pci.h
> >> > +++ b/drivers/net/wireless/realtek/rtw88/pci.h
> >> > @@ -212,6 +212,10 @@ struct rtw_pci {
> >> >         void __iomem *mmap;
> >> >  };
> >> >
> >> > +int rtw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
> >> > +void rtw_pci_remove(struct pci_dev *pdev);
> >> > +void rtw_pci_shutdown(struct pci_dev *pdev);
> >> > +
> >> >
> >> 
> >> These definitions are already in 4 other header files:
> >> 
> >> drivers/net/wireless/realtek/rtw88/rtw8723de.h
> >> drivers/net/wireless/realtek/rtw88/rtw8821ce.h
> >> drivers/net/wireless/realtek/rtw88/rtw8822be.h
> >> drivers/net/wireless/realtek/rtw88/rtw8822ce.h
> >> 
> >> Seems like you should be moving them, not just adding yet another duplicate.
> >
> > I followed the current convention.
> >
> > Happy to optimise if that's what is required.
> 
> I agree with Brian, these and rtw_pm_ops should be moved to pci.h to
> avoid code duplication.

Will do, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
