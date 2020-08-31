Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79034257B0F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 10:06:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60543 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgHaOGp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 10:06:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598882804; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=aUp/h/rqOEvFmhaYW8oGpN2c7VScLKQV84XM5ZLvlms=; b=lGJ2/hcXcIo+rhkBdEumMb1XKsKrRSCjr0OMHUoDpHu0+KWGgNI4g9CZ0VuUgq7fj1YHBisE
 pkL1R81g0TayHq/hNZC4GHUDjeRFsuYyvvFwTdR2sQxlMDiIHotDVecWN1KI3LNS335x8wVc
 GEvF7bjB8+0qwST/bAMyqzDupsg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4d03d8d3d3df8c39f80963 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 14:06:16
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 930C8C43391; Mon, 31 Aug 2020 14:06:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9FCDC433CA;
        Mon, 31 Aug 2020 14:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9FCDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     pkshih@realtek.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] wireless: rtlwifi/rtw88: fix build warning
References: <20200831043659.281712-1-allen.lkml@gmail.com>
Date:   Mon, 31 Aug 2020 17:06:12 +0300
In-Reply-To: <20200831043659.281712-1-allen.lkml@gmail.com> (Allen Pais's
        message of "Mon, 31 Aug 2020 10:06:59 +0530")
Message-ID: <87tuwi6hbf.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allen Pais <allen.lkml@gmail.com> writes:

>  Tasklet conversion patch introduced a build
> warning in _rtl_usb_init_rx, this patch fixes the warning.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtlwifi/usb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I'll change the title:

rtlwifi: fix build warning

And add:

Fixes: d3ccc14dfe95 ("rtlwifi/rtw88: convert tasklets to use new tasklet_setup() API")

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
