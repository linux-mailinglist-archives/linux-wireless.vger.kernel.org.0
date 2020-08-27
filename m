Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF732543FF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgH0Kqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:46:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42301 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgH0Kqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:46:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598525206; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Qf3xBPF40hi1nSraA0pGIa1xT4mCmEErajbyvZnQnHY=; b=rnIw5+yeGaki5Oxo655P6yiikzd2es9NjaIfkFPHOMghYZHi4lnm/E8Go0sSAz/qZCODVZAO
 v0RPzmQ9Cy1ptsQdQlT/uMKMhfAlrl5iJhFttW0JOusXd2Qzuh1qJfd2YPxeNHrNwPrsZS9N
 wrAAM4dwNYLejpPg1+SKtlXbIqE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f478f166ad591ec08e96c2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:46:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 686C7C433C6; Thu, 27 Aug 2020 10:46:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1957EC433CA;
        Thu, 27 Aug 2020 10:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1957EC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Zong-Zhe Yang <kevin_yang@realtek.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous prototype for 'rtw_pci_probe'
References: <202007251817.x5EF2Aoc%lkp@intel.com>
Date:   Thu, 27 Aug 2020 13:46:42 +0300
In-Reply-To: <202007251817.x5EF2Aoc%lkp@intel.com> (kernel test robot's
        message of "Sat, 25 Jul 2020 18:41:21 +0800")
Message-ID: <87eensbc31.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> Hi Zong-Zhe,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
> commit: 72f256c2b948622cc45ff8bc0456dd6039d8fe36 rtw88: extract:
> export symbols about pci interface
> date:   10 weeks ago
> config: arc-randconfig-r026-20200725 (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 72f256c2b948622cc45ff8bc0456dd6039d8fe36
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no
>>> previous prototype for 'rtw_pci_probe' [-Wmissing-prototypes]
>     1477 | int rtw_pci_probe(struct pci_dev *pdev,
>          |     ^~~~~~~~~~~~~
>>> drivers/net/wireless/realtek/rtw88/pci.c:1557:6: warning: no
>>> previous prototype for 'rtw_pci_remove' [-Wmissing-prototypes]
>     1557 | void rtw_pci_remove(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~
>>> drivers/net/wireless/realtek/rtw88/pci.c:1579:6: warning: no
>>> previous prototype for 'rtw_pci_shutdown' [-Wmissing-prototypes]
>     1579 | void rtw_pci_shutdown(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~~~

Tony, these are older warnings but please also check these.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
