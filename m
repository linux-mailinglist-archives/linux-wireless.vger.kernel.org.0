Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40905258AE2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIAJAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 05:00:03 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:22142 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgIAJAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 05:00:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598950801; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4DK14o9noka5wywopVp1iEBBGogp5WRRjJHw7n8UNIQ=;
 b=wExV/7KBgpOJdc+OfZSmgXwR37I3IbT3nUBymuUl1nuWIM3RIeKssT5lo0X/al0ugSS4d9Vy
 Py5pVpFq1Ix4Dkjh4qK2FWhszVvMjJrJXDyjnyzvvf4byViRhvTO03G7Yxs/jkoUu952HEAU
 kdVJt5hChicFCwvnjEntG4zqVA8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f4e0d91698ee477d17c03db (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 09:00:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36CF3C43391; Tue,  1 Sep 2020 09:00:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4137DC433C6;
        Tue,  1 Sep 2020 08:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4137DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtlwifi: fix build warning
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200831043659.281712-1-allen.lkml@gmail.com>
References: <20200831043659.281712-1-allen.lkml@gmail.com>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     pkshih@realtek.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        kernel test robot <lkp@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200901090001.36CF3C43391@smtp.codeaurora.org>
Date:   Tue,  1 Sep 2020 09:00:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allen Pais <allen.lkml@gmail.com> wrote:

> Tasklet conversion patch introduced a build
> warning in _rtl_usb_init_rx, this patch fixes the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: d3ccc14dfe95 ("rtlwifi/rtw88: convert tasklets to use new tasklet_setup() API")
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

6b8c7574a5f8 rtlwifi: fix build warning

-- 
https://patchwork.kernel.org/patch/11745471/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

