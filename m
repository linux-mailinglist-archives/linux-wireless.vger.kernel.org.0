Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA26260DBA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgIHIjA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 04:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgIHIiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 04:38:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD2C061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 01:38:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so18165416wrp.8
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6zNz0QwCih7zGro4lWxglqIDePFuxgqa1/NNE60CNZY=;
        b=XmZRQ3heP45i7zM+hwnesdNT6VU3WWrdD3YMxKXH3/m83bZUA7YqfG9bmxVY0CqoeF
         2lP206JFfCjWBQewI9fyhHev8dyiaXFhFv36WQ9HQbRt102++7ORlfBX0iFkoFO3sm/j
         isBJiLbnUcnxiS5zcbXzGkeU84qsZgEZxeDYDBqmc7Sn+4Qpq2qeGsJiGYS9nt5VGXxB
         pkuMg1Zezp8kI12Gg7CVhMdne7rstdVC4CrXqVHYNm3qfiLotbV/grMSqhtGI3nSKcEo
         Dnqr1psVeFlgp91E//eJIHfesZaOttn0G3NX/ECRrvVnqjSVCuh/Sd3bKdIqsIstZCmB
         vEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6zNz0QwCih7zGro4lWxglqIDePFuxgqa1/NNE60CNZY=;
        b=L2ZtebOR93plPcJTbxJ7v+ELX3nU4IHfWX7TsKXbyjngwDQdcJR0Yj9VIFcGXZv97P
         DbaXYy0KphQY91ym0sFRFhbtU3xmLBfHRoOGBmzCqKnk63FlCQGhHautmNH0QnkLwihk
         AzBGrl/UAjDbC/+TFMefE+7rqr8uFiaB3w4piaIzCA+hR8Nz39Mn6jwWjZbON9ywLs14
         rMEGQlSiwGE+Ow6ptR3fXgyImKGx3661UNeOWaAejuulfkBOHnpdLdWcQrON7+LCwTq7
         ke5dIwG/FZX6yNkKbWRm6L7iK6i8wtZ1WthWOuaon66bqC3i4t4i3dLFutR4JkeVaDsm
         hFqw==
X-Gm-Message-State: AOAM532E7Xsksa1KS8w8Yt4mxW02tJsFTZJqJjHWN2+yBqcs5KIBw0Iq
        cyU8Paud489IvKOOb7JPIS/E3w==
X-Google-Smtp-Source: ABdhPJxm0FIexFfUE6j+nVi7j6hiF8KvaP+FAVZPANVBvGpAb49Q8qW++nmIoFBaxUtU6C1fqJA1uw==
X-Received: by 2002:a05:6000:36d:: with SMTP id f13mr24783667wrf.425.1599554333288;
        Tue, 08 Sep 2020 01:38:53 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id v2sm32328004wrm.16.2020.09.08.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:38:52 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:38:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:pending 90/109]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning:
 variable 'scb_ampdu' set but not used
Message-ID: <20200908083851.GH4400@dell>
References: <202009011913.HKFaLG2U%lkp@intel.com>
 <87ft8166sj.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ft8166sj.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 01 Sep 2020, Kalle Valo wrote:

> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
> > head:   391ddee90739538e99cb73bd26d7a90452d37f30
> > commit: d7f95d9204ca1a73183fde8c5a017f2060763d05 [90/109] brcmsmac: ampdu: Remove a bunch of unused variables
> > config: i386-randconfig-r015-20200901 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > reproduce (this is a W=1 build):
> >         git checkout d7f95d9204ca1a73183fde8c5a017f2060763d05
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=i386 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    In file included from drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h:21,
> >                     from drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:18:
> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h:786:1: warning: alignment 1 of 'struct d11txh' is less than 2 [-Wpacked-not-aligned]
> >      786 | } __packed;
> >          | ^
> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In
> > function 'brcms_c_ampdu_dotxstatus_complete':
> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:850:7:
> > warning: variable 'update_rate' set but not used
> > [-Wunused-but-set-variable]
> >      850 |  bool update_rate = true, retry = true;
> >          |       ^~~~~~~~~~~
> >    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function 'brcms_c_ampdu_dotxstatus':
> >>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used [-Wunused-but-set-variable]
> >     1027 |  struct scb_ampdu *scb_ampdu;
> >          |                    ^~~~~~~~~
> 
> Lee, please send a followup patch to fix these issues.

Without looking into these (I will), my guess is that they are
knock-on issues from where other unused variables have been removed.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
