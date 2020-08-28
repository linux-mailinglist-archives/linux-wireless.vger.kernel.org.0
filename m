Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B55255431
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 08:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgH1GEY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 02:04:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64291 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1GEY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 02:04:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598594663; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=PzasY8aBi8ICt0gY/gfh81GdbIsnm4LD6K/tXeMd5+Y=; b=wdMuhnM/g+an6y35ZXd8a99AYYBYxJp1rxAtECO3uf7mo58As2PX21Ecusw6KjoOgKg/3Kmp
 Y2pFiI4z6ot58TNV7MPOx23FNZEHlpVHAs7HIAEwtRsN7zRI8pSJg6XuesvWwRjufzh768sa
 7sSO6IzLnVORdytRUPkWFheQwu8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f489ddf630b177c47f19937 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 06:02:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2357BC433CB; Fri, 28 Aug 2020 06:02:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 754EEC433CA;
        Fri, 28 Aug 2020 06:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 754EEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kevin Yang <kevin_yang@realtek.com>,
        "kbuild-all\@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous prototype for 'rtw_pci_probe'
References: <202007251817.x5EF2Aoc%lkp@intel.com>
        <87eensbc31.fsf@codeaurora.org>
        <a3a708a0d8094b7895065d17e5396b82@realtek.com>
Date:   Fri, 28 Aug 2020 09:01:44 +0300
In-Reply-To: <a3a708a0d8094b7895065d17e5396b82@realtek.com> (Tony Chuang's
        message of "Fri, 28 Aug 2020 02:25:46 +0000")
Message-ID: <87pn7b9ulz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> + linux-wireless
>> 
>> kernel test robot <lkp@intel.com> writes:
>> 
>> > Hi Zong-Zhe,
>> >
>> > FYI, the error/warning still remains.
>> >
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
>> > head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
>> > commit: 72f256c2b948622cc45ff8bc0456dd6039d8fe36 rtw88: extract:
>> > export symbols about pci interface
>> > date:   10 weeks ago
>> > config: arc-randconfig-r026-20200725 (attached as .config)
>> > compiler: arc-elf-gcc (GCC) 9.3.0
>> > reproduce (this is a W=1 build):
>> >         wget
>> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> > -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         git checkout 72f256c2b948622cc45ff8bc0456dd6039d8fe36
>> >         # save the attached .config to linux build tree
>> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0
>> make.cross ARCH=arc
>> >
>> > If you fix the issue, kindly add following tag as appropriate
>> > Reported-by: kernel test robot <lkp@intel.com>
>> >
>> > All warnings (new ones prefixed by >>):
>> >
>> >>> drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no
>> >>> previous prototype for 'rtw_pci_probe' [-Wmissing-prototypes]
>> >     1477 | int rtw_pci_probe(struct pci_dev *pdev,
>> >          |     ^~~~~~~~~~~~~
>> >>> drivers/net/wireless/realtek/rtw88/pci.c:1557:6: warning: no
>> >>> previous prototype for 'rtw_pci_remove' [-Wmissing-prototypes]
>> >     1557 | void rtw_pci_remove(struct pci_dev *pdev)
>> >          |      ^~~~~~~~~~~~~~
>> >>> drivers/net/wireless/realtek/rtw88/pci.c:1579:6: warning: no
>> >>> previous prototype for 'rtw_pci_shutdown' [-Wmissing-prototypes]
>> >     1579 | void rtw_pci_shutdown(struct pci_dev *pdev)
>> >          |      ^~~~~~~~~~~~~~~~
>> 
>> Tony, these are older warnings but please also check these.
>> 
>
> I think this warning can be ignored, as the commit was going to export
> pci symbols for the follow-up patches to use, such as:
>
> f56f08636dda rtw88: extract: make 8723d an individual kernel module
> 416e87fcc780 rtw88: extract: make 8822b an individual kernel module
> ba0fbe236fb8 rtw88: extract: make 8822c an individual kernel module
>
> And these patches were submitted and applied together.

Good, thanks for checking.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
