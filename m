Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3082725E6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIUNlN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:41:13 -0400
Received: from z5.mailgun.us ([104.130.96.5]:61387 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNlN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:41:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600695672; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Q15TmuQD/7KexWdY/DpjpcldPd1zK/OY8kY2yhintLs=; b=jt8xopV1uWazhoAwN3gVJ/QkYBxxh6Onj6oEqXPVRxHTYuLv7l6VAQS0ZbFpxF+bCCZWcUau
 Ipr3gF3Rw0RyhhXXsBezCAB7MsQhXvJ9AvXutF/OBhntIaich/YOIePmsk6ExImF3RljFDmZ
 SOKL+yopUYcDL3lOOG/50tb/bTI=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f68ad622131f7663a9febdc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:40:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF9DBC433C8; Mon, 21 Sep 2020 13:40:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 578B3C433F1;
        Mon, 21 Sep 2020 13:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 578B3C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kbuild-all@lists.01.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>
Subject: Re: [PATCH v3] ath11k: cold boot calibration support
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
        <202009160303.xwD2GbBx%lkp@intel.com>
Date:   Mon, 21 Sep 2020 16:40:46 +0300
In-Reply-To: <202009160303.xwD2GbBx%lkp@intel.com> (kernel test robot's
        message of "Wed, 16 Sep 2020 03:51:16 +0800")
Message-ID: <87v9g7459d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ath6kl/ath-next]
> [also build test ERROR on next-20200915]
> [cannot apply to v5.9-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:
> https://github.com/0day-ci/linux/commits/Sowmiya-Sree-Elavalagan/ath11k-cold-boot-calibration-support/20200915-180324
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> ERROR: modpost: "fw_arg3" [drivers/mtd/parsers/bcm63xxpart.ko] undefined!
>>> ERROR: modpost: "ath11k_cold_boot_cal"
> [drivers/net/wireless/ath/ath11k/ath11k_ahb.ko] undefined!

For some reason I don't see the kbuild bot report above in patchwork:

https://patchwork.kernel.org/patch/11775953/

This time the message ids seem to be ok:

Message-Id: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
[...]
In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>

If anyone has ideas why patchwork doesn't see the report, please let me
know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
