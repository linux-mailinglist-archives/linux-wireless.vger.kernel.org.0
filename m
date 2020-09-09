Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC59C263291
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 18:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbgIIQqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgIIQHz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 12:07:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52861C061359
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 07:09:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so3075078wrn.13
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ter5AfOY2E1RDONvLeBXz6x4fUeWe9Kc3HHNzul5bk8=;
        b=YV1NeRmTp37R+lxUDlQ6oEVRzHIrek9DOtxL3TNxiM7VbxP6nsdhK6s4vqOEoH33fC
         xsO6OmuyMFFgmnfl+XxVrAfXAzLe+IFgK0p4/kg7JmfYvALK8WpGbH8KosPvIhg8XDQW
         yNzgZr5FaIFNM7oy1vkcv8A+XNcsU5ywSxPajmrP9sHC4+4MeioU4DSlvKb98X5EkvFH
         O75XGzexPNsk7HdUjDpbt4qIooRPUKzq/37vk70Jl51MImDg/1n9SSYlBgd6fGlYTEfw
         MDxkgqT3ZL1bhPgNz4X4C5CxLNh+n2Fg0lHgZkiDxEJXcCSzhO+hnyPZde/Ouzs4iw5p
         VMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ter5AfOY2E1RDONvLeBXz6x4fUeWe9Kc3HHNzul5bk8=;
        b=sn2cQcbGMD3SUNDXn0e3N1BaeVmj5IW4vbK7DyoN++cqnkuZQd4UYirNlNK85oMTqS
         7B1Oss5EnFT8Em2NybJoUtmyIKXeasZlGdZKLOItLw+pX8vNpVBZ0qG1YQ/PxsF8GKls
         Ri2wAnCMaQv/SfGX2oyKrLmDUfi07zTsdvtdUpaOAkEDS78qAVAFPdllQXk3uOg2ySs6
         PzsHNtctgQEgElg7MWGeZadYWt3SmhCP+YEqeXlpk8SQuNuzfV4GmJqoWmlBOzpZOq1r
         G9XxO1Hh9TZrk8aVmsb6R1kPstFQrPcIimRPYNPj0N+QBYo/bYmePsH+h4SmDjx69l0g
         kS6w==
X-Gm-Message-State: AOAM530nigtryqrT6YyO8FNmIoUbWy35eXCn0wr5nKdq6lFH80+L8mUm
        u06m1TUX8uZ2He1WFe5RRMnbXaN/YIWhVg==
X-Google-Smtp-Source: ABdhPJx6wPxsnMeU9CNheSznCqJi+ogrvxzJEeNBu841OVhO9Vn/XOqld9CVJ3PE2vXtOHmDOgd6zA==
X-Received: by 2002:adf:f207:: with SMTP id p7mr4552409wro.152.1599660542806;
        Wed, 09 Sep 2020 07:09:02 -0700 (PDT)
Received: from dell ([91.110.221.208])
        by smtp.gmail.com with ESMTPSA id v128sm4127268wme.2.2020.09.09.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:09:01 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:08:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:pending 90/109]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning:
 variable 'scb_ampdu' set but not used
Message-ID: <20200909140859.GC218742@dell>
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

This is already fixed in your tree.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
