Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17F268593
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgINHRV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Sep 2020 03:17:21 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30497 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgINHRU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Sep 2020 03:17:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600067838; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=q3NHfVQox0Gssw/guI7kH+XAHIVL6NQIujBdCqW0jbo=; b=MlQ3Z4Q0BLHFsIzyDSeT5ywF7wpKjlJmNZ9TeLsuIBbLzuzFqz1UPFEua3baNKEXq/lD8zyh
 soR4Wl0gfy4ii3xrT1jCOwK7LEHwt/efaQGLsBdZj+wzRuof4VOVF4PLgoOmkBJGiw+rjI2t
 TsCVnIeAoF93lJ08IdWf0v7Tgjk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f5f18fe9bdf68cc039f5276 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Sep 2020 07:17:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E044C433FF; Mon, 14 Sep 2020 07:17:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80081C433CA;
        Mon, 14 Sep 2020 07:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80081C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kevin Yang <kevin_yang@realtek.com>,
        "kbuild-all\@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous prototype for 'rtw_pci_probe'
References: <202009132352.cN4c9rTC%lkp@intel.com>
        <6463246c14a24bc989ea56d9c4443784@realtek.com>
Date:   Mon, 14 Sep 2020 10:17:13 +0300
In-Reply-To: <6463246c14a24bc989ea56d9c4443784@realtek.com> (Tony Chuang's
        message of "Mon, 14 Sep 2020 05:16:59 +0000")
Message-ID: <874ko0rfnq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Chuang <yhchuang@realtek.com> writes:

>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   ef2e9a563b0cd7965e2a1263125dcbb1c86aa6cc
>> commit: ba0fbe236fb8a7b992e82d6eafb03a600f5eba43 rtw88: extract: make
>> 8822c an individual kernel module
>> date:   4 months ago
>> config: i386-randconfig-r034-20200913 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>> reproduce (this is a W=1 build):
>>         git checkout ba0fbe236fb8a7b992e82d6eafb03a600f5eba43
>>         # save the attached .config to linux build tree
>>         make W=1 ARCH=i386
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> 
>> All warnings (new ones prefixed by >>):
>> 
>> >> drivers/net/wireless/realtek/rtw88/pci.c:1477:5: warning: no previous
>> >> prototype for 'rtw_pci_probe' [-Wmissing-prototypes]
>>     1477 | int rtw_pci_probe(struct pci_dev *pdev,
>>          |     ^~~~~~~~~~~~~
>> >> drivers/net/wireless/realtek/rtw88/pci.c:1557:6: warning: no previous
>> >> prototype for 'rtw_pci_remove' [-Wmissing-prototypes]
>>     1557 | void rtw_pci_remove(struct pci_dev *pdev)
>>          |      ^~~~~~~~~~~~~~
>> >> drivers/net/wireless/realtek/rtw88/pci.c:1579:6: warning: no previous
>> >> prototype for 'rtw_pci_shutdown' [-Wmissing-prototypes]
>>     1579 | void rtw_pci_shutdown(struct pci_dev *pdev)
>>          |      ^~~~~~~~~~~~~~~~
>> 

[...]

> Hi Kalle,
>
> The exported function is used by the following patchset.
> So this is a false alarm.

Good, thanks for checking.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
