Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3233D2543FE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgH0KqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:46:17 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42301 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgH0KqI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:46:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598525168; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=/djNcFo+TzE4bc98l9f056AzR9LQN0CbdceKx4XXNI8=; b=X9L2sVTc0BNuPxYB/aZc76Wmuz+JKTQXPQYjK8cXWoVhPi5JxJnvojU+KKzgSb5cqSncwHUz
 F7ApBvK68YTxPbsQRUkZC/a6Ud8s910AmfroLrU8tNOhGjumBuucomk2VY16r6iuS5s39z0f
 rXKp2ZPWRDshcnVt+x/uH4VqSOA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f478edf1d69e438cb2cd215 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:45:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95D0BC4339C; Thu, 27 Aug 2020 10:45:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83216C433C6;
        Thu, 27 Aug 2020 10:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83216C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Tzu-En Huang <tehuang@realtek.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type qualifiers ignored on function return type
References: <202008271827.tuwLEqMO%lkp@intel.com>
Date:   Thu, 27 Aug 2020 13:45:46 +0300
In-Reply-To: <202008271827.tuwLEqMO%lkp@intel.com> (kernel test robot's
        message of "Thu, 27 Aug 2020 18:36:30 +0800")
Message-ID: <87imd4bc4l.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> Hi Tzu-En,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   15bc20c6af4ceee97a1f90b43c0e386643c071b4
> commit: f745eb9ca5bf823bc5c0f82a434cefb41c57844e rtw88: 8821c: Add 8821CE to Kconfig and Makefile
> date:   6 weeks ago
> config: arm-randconfig-r012-20200827 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f745eb9ca5bf823bc5c0f82a434cefb41c57844e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>       71 | static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
>          |        ^~~~~

Tony, please check this.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
