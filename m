Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF57258DEF
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgIAMIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 08:08:36 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47999 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727924AbgIAMGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 08:06:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598961965; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LFLJVLiMOd/9uDVWba2LfAHY5K36vSixn2hJZnKHiTY=; b=HnhwerhLN3n0rkCBln0NW7tXYFwrCCDh2PzOjKczE9dFWrbDHxs6iDHIj3GipUjJeZ+r4VKi
 ucBukq23n2f98Qng7wVp+E4pGKUVPCmMaRaVfJ+B2ohDlFHv9j4l9tpUt1RZcD+yd4AwtHrM
 7zYcyv/Ita5yaKbyMk4k2AefVkw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4e392025e1ee7586153557 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 12:05:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94C16C433C6; Tue,  1 Sep 2020 12:05:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A265C433CB;
        Tue,  1 Sep 2020 12:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A265C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org
Subject: Re: [wireless-drivers-next:pending 90/109] drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used
References: <202009011913.HKFaLG2U%lkp@intel.com>
Date:   Tue, 01 Sep 2020 15:05:48 +0300
In-Reply-To: <202009011913.HKFaLG2U%lkp@intel.com> (kernel test robot's
        message of "Tue, 1 Sep 2020 19:54:19 +0800")
Message-ID: <87ft8166sj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
> head:   391ddee90739538e99cb73bd26d7a90452d37f30
> commit: d7f95d9204ca1a73183fde8c5a017f2060763d05 [90/109] brcmsmac: ampdu: Remove a bunch of unused variables
> config: i386-randconfig-r015-20200901 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout d7f95d9204ca1a73183fde8c5a017f2060763d05
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from drivers/net/wireless/broadcom/brcm80211/brcmsmac/rate.h:21,
>                     from drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:18:
>    drivers/net/wireless/broadcom/brcm80211/brcmsmac/d11.h:786:1: warning: alignment 1 of 'struct d11txh' is less than 2 [-Wpacked-not-aligned]
>      786 | } __packed;
>          | ^
>    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In
> function 'brcms_c_ampdu_dotxstatus_complete':
>    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:850:7:
> warning: variable 'update_rate' set but not used
> [-Wunused-but-set-variable]
>      850 |  bool update_rate = true, retry = true;
>          |       ^~~~~~~~~~~
>    drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c: In function 'brcms_c_ampdu_dotxstatus':
>>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/ampdu.c:1027:20: warning: variable 'scb_ampdu' set but not used [-Wunused-but-set-variable]
>     1027 |  struct scb_ampdu *scb_ampdu;
>          |                    ^~~~~~~~~

Lee, please send a followup patch to fix these issues.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
