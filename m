Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E367C255560
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH1Hew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 03:34:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54757 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgH1Hev (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 03:34:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598600090; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DvcLlzFzBXdpu93/yJjS9qpHa7iY327N+XsGJqJmemg=; b=ak0VFvuuf/UXZioxsTXJ3Xn5Mh5f29z/xRFvCpRrHe9kpXmldVbUtFNenmBMutntd7+VWj8u
 Hf/B5yPml698OGZW0spegyGWjuqH1PW2bx3jTntwq2xoXEjIy7QG+n7PK7eDiC00HUzibW/x
 XkVYuln2GnP99rdUjbLJKUiZIGE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f48b39812acec35e2d82c69 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 07:34:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4379FC43387; Fri, 28 Aug 2020 07:34:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20602C433C6;
        Fri, 28 Aug 2020 07:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20602C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:master 53/53] drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1181:33: warning: cast between incompatible function types from 'void tasklet_struct to 'void unsigned int)'
References: <202008280240.Op3fNc1d%lkp@intel.com>
        <CAOMdWS+yS6sL19R5RECWyruMMNM2Fgm8M3Gc3FP0kU6SdPO1og@mail.gmail.com>
Date:   Fri, 28 Aug 2020 10:34:42 +0300
In-Reply-To: <CAOMdWS+yS6sL19R5RECWyruMMNM2Fgm8M3Gc3FP0kU6SdPO1og@mail.gmail.com>
        (Allen's message of "Fri, 28 Aug 2020 12:56:53 +0530")
Message-ID: <877dtjkyul.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

Allen <allen.lkml@gmail.com> writes:

>> tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git
>> master
>> head:   26721b02466e396efaca6807b52916478c4f9197
>> commit: 26721b02466e396efaca6807b52916478c4f9197 [53/53] zd1211rw:
>> convert tasklets to use new tasklet_setup() API
>> config: arm-randconfig-r012-20200827 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 26721b02466e396efaca6807b52916478c4f9197
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>
>  I have it fixed for this as well as patch 52(realtek) Shall I send out V2.

The patch is already applied to wireless-drivers-next and cannot be
changed. Please send a followup patch which fixes the warning.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
