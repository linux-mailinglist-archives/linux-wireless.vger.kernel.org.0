Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EAD1D7889
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgERMY6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 08:24:58 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16305 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgERMY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 08:24:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589804697; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=zDfsbimve+95bHN1AMopdOLB7rn7fbjzkFlX7m48gMw=; b=T3kJQjHPeu7C8eOYlE5VOgv3RgqOj+DGJH72f6HpbbMVGpudR5aYbUYm3FPVyJ32Wq74A9sL
 yFg7gL1Oq+Mr6SyeLQPsF1iWi1uHmYdG4V2uNTspFre2PRBandAU3VZnZg2U4FCLpVLZXb8Z
 /PRDY4jvv9DRQZigiYL5LElniO8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ec27e99.7f501e005f10-smtp-out-n03;
 Mon, 18 May 2020 12:24:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1BBCDC43636; Mon, 18 May 2020 12:24:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EC11C433F2;
        Mon, 18 May 2020 12:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EC11C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Tzu-En Huang <tehuang@realtek.com>, kbuild-all@lists.01.org,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [linux-next:master 2957/8703] drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: missing braces around initializer
References: <202005141308.j8dUPd66%lkp@intel.com>
Date:   Mon, 18 May 2020 15:24:52 +0300
In-Reply-To: <202005141308.j8dUPd66%lkp@intel.com> (kbuild test robot's
        message of "Thu, 14 May 2020 13:01:12 +0800")
Message-ID: <87blmljuqz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ linux-wireless

kbuild test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   e098d7762d602be640c53565ceca342f81e55ad2
> commit: 5ad4d8957b69f3ebf95ac02212c388bda75aeb30 [2957/8703] rtw88:
> set power trim according to efuse PG values
> config: i386-randconfig-a002-20200514 (attached as .config)
> compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
> reproduce:
>         git checkout 5ad4d8957b69f3ebf95ac02212c388bda75aeb30
>         # save the attached .config to linux build tree
>         make ARCH=i386 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function 'rtw8822c_power_trim':
>>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
>> missing braces around initializer [-Wmissing-braces]
> s8 bb_gain[2][8] = {0};
> ^
> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
> initialization for 'bb_gain[0]') [-Wmissing-braces]

Tony, please check this and fix it. If it's a false warning please let
us know.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
