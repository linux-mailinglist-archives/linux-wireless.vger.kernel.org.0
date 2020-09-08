Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C437E260D99
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgIHIdG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgIHIdF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 04:33:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B790EC061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 01:33:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so16271656wmk.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JvnEFMaNjXHqhwG8miaL0ooeJ049Cf9xiGq4BaBNqiE=;
        b=ELTt9gTXVB4YV0THUOy4fMOrH1dybwnYx2qbbYlRZo/sgr2T61uPcTvVO9P1FETDKg
         m7aLW8e8gla0quGsB23AC0rq+wjFWy0ZB3J4n1pJdbaJNycnAdC4jf4hqL8Um3p23sjX
         phA5opUYZXLM34rr15w5zFpVmL2O9FKvNVZsXn6jahAxrXZILxHq42L1UZ9zvTE7PbZj
         PNU4/nxo1oqEh6lDHcCqgdyl/xVyv2Wh5vPCkgQ/03rTrkm/yAli74bEHNGamqMsKuK+
         dLL5LvQJTUw33+67bs+rvPNFvjQzV98vG4xmM9jJMDD1jd00hLP+4qNg34cM6pyOfNGB
         3eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JvnEFMaNjXHqhwG8miaL0ooeJ049Cf9xiGq4BaBNqiE=;
        b=r4t5wI8NRXjIB7tzMTzdBIvJMG5P6Y6mT8qLJS4sBIAM+SSTuY4XCPWKZBepW+ambm
         gTLNqcJrrDDohneYyx61FHk7Ul3TdNb+7LEEjih4GbP1Lskt//lceIbFLW0vMakb7C4Q
         qI0UQggpbxfD65/cWqdFinjLPSCXSbw/s1cBqWIAOJNiejOD0FkM0XFeOigDMC7YC1zk
         CnNnPr3zj3BVtGOykZgcYq40ze5tZfjs49WbLn3D7qpG/Fw0lbXdASBvkj8hwaP1TEVJ
         2D/vAhUF99CRNNoftJsz/fJ06n8eGIKwBRmzBHiOTLuCgeaoMRcVyx/LXd5iwfrXYyI0
         rsXQ==
X-Gm-Message-State: AOAM531pefqcEJ/k/Ipr+D+I4c3Kg2I87ggr9hPfEg5ndDuWqLQJxsjF
        izIFY/j+tbYrGhx9r46fC1QrFw==
X-Google-Smtp-Source: ABdhPJw+THwwdYHM/F2Qc+m9za/hnrPz7rDlCI2ZCrqtV1/zKjqvzHvrN2mEY8wmeVOsAB36xu3zLw==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr3121744wmi.37.1599553983045;
        Tue, 08 Sep 2020 01:33:03 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id t6sm7476120wre.30.2020.09.08.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:33:02 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:33:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 127/131]
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:361:25:
 warning: unused variable 'lcnphy_rx_iqcomp_table_rev0'
Message-ID: <20200908083300.GF4400@dell>
References: <202009012305.vGKHlIAu%lkp@intel.com>
 <877dtc61lu.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dtc61lu.fsf@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 02 Sep 2020, Kalle Valo wrote:

> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> > head:   2c92790b12033797474b9ba1b2e56a95360f66cd
> > commit: 38c95e0258a067812311e84d2a170fd56f05431d [127/131] brcmsmac: phy_lcn: Remove a bunch of unused variables
> > config: arm64-randconfig-r012-20200901 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project c10e63677f5d20f18010f8f68c631ddc97546f7d)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         git checkout 38c95e0258a067812311e84d2a170fd56f05431d
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:361:25: warning: unused variable 'lcnphy_rx_iqcomp_table_rev0' [-Wunused-const-variable]
> >    struct lcnphy_rx_iqcomp lcnphy_rx_iqcomp_table_rev0[] = {
> 
> Lee, please send a patch fixing this.

I'm just back from vacation.  Will take a look at these shortly.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
