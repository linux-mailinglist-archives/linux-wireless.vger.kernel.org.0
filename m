Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF661BB5AA
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 07:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD1FFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 01:05:30 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53462 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgD1FF3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 01:05:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588050328; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bzAUHkexuX6w2J/cf0kwzIhpJXIyV+XjlTjNfnbtK9c=; b=ZUHcdxMcvgmJtkaV96gW89F8BJcvZu0s5eg/PQX5fzWR06HI+3IDx0TY91u9rxWxpj5foafy
 JHGvjMDEch4jyy/AP8LynfdVJkBc/jWm5EEGPBFf/p2f2rsS9Qw1jW/OHmkfFzF/6Yiiuc7c
 5TvXicLJUk9WSy2IidZyUq+2+Jg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea7b98f.7f1b77aa9d88-smtp-out-n04;
 Tue, 28 Apr 2020 05:05:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33416C44788; Tue, 28 Apr 2020 05:05:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E49BC433D2;
        Tue, 28 Apr 2020 05:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E49BC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jouni Malinen <jouni@codeaurora.org>, kbuild-all@lists.01.org,
        ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ath9k_htc: Set RX filter based to allow broadcast Action frame RX
References: <20200426084733.7889-2-jouni@codeaurora.org>
        <202004281220.j0LQI20f%lkp@intel.com>
Date:   Tue, 28 Apr 2020 08:05:13 +0300
In-Reply-To: <202004281220.j0LQI20f%lkp@intel.com> (kbuild test robot's
        message of "Tue, 28 Apr 2020 12:35:21 +0800")
Message-ID: <87pnbskxo6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Hi Jouni,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on wireless-drivers-next/master]
> [also build test ERROR on wireless-drivers/master ath6kl/ath-next v5.7-rc3 next-20200424]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Jouni-Malinen/ath9k-Set-RX-filter-based-to-allow-broadcast-Action-frame-RX/20200428-022034
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
> config: nds32-allyesconfig (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=nds32 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/net/wireless/ath/ath9k/htc_drv_txrx.c: In function 'ath9k_htc_calcrxfilter':
>>> drivers/net/wireless/ath/ath9k/htc_drv_txrx.c:897:40: error:
>>> 'FIF_MCAST_ACTION' undeclared (first use in this function)
>      897 |      priv->rxfilter & (FIF_OTHER_BSS | FIF_MCAST_ACTION))
>          |                                        ^~~~~~~~~~~~~~~~

This is expected as the patch depends on a commit in mac80211-next:

873b1cf61105 mac80211: Process multicast RX registration for Action frames

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
