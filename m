Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B125A778
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIBIM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 04:12:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60147 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBIMZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 04:12:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599034344; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nmLDL+thwRQUEO3OyOM6W+uqFyGoNpoiS3s1rgJWm40=; b=Lg/OwuA4ZqBgEUqdPsUkEFg9R+Zljk6q6u1NFTUuL4nz4Xm2JEPWwQvu/smlaQlIcFQX3bfc
 KUizSX5wfWxiXOwJ77MS72ndyZSgUOU8oT65yBCMntF6gkPQMc60XECUoE1pomozJcI4ifPW
 jKLB4US8iICnkAjwT+cDK19ees8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4f53d7be06707b34e3c5de (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 08:12:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B6A4C43391; Wed,  2 Sep 2020 08:12:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4317DC433C6;
        Wed,  2 Sep 2020 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4317DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 129/131] drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:108:18: warning: unused variable 'dot11lcn_gain_tbl_rev1'
References: <202009020057.jxONANsS%lkp@intel.com>
Date:   Wed, 02 Sep 2020 11:12:03 +0300
In-Reply-To: <202009020057.jxONANsS%lkp@intel.com> (kernel test robot's
        message of "Wed, 2 Sep 2020 00:09:08 +0800")
Message-ID: <87364061ik.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> head:   2c92790b12033797474b9ba1b2e56a95360f66cd
> commit: ebcfc66f56a43601eec4a8abab6e82aaeb09dcbf [129/131] brcmsmac: phytbl_lcn: Remove unused array 'dot11lcnphytbl_rx_gain_info_rev1'
> config: arm64-randconfig-r012-20200901 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project c10e63677f5d20f18010f8f68c631ddc97546f7d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         git checkout ebcfc66f56a43601eec4a8abab6e82aaeb09dcbf
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phytbl_lcn.c:108:18: warning: unused variable 'dot11lcn_gain_tbl_rev1' [-Wunused-const-variable]
>    static const u32 dot11lcn_gain_tbl_rev1[] = {
>                     ^
>    1 warning generated.

Lee, please also fix this one.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
