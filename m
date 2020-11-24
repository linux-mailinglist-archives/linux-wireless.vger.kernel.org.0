Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B651C2C20F8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 10:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKXJQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 04:16:04 -0500
Received: from z5.mailgun.us ([104.130.96.5]:41240 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgKXJQE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 04:16:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606209364; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=iCuOj6Xap6XRJQpMNchRLq7lVvkf6SE0kgafKp9gt48=;
 b=khZQVHgmEMqboJkyN5VRjGmTU9Btzt9iVyZNRTZXQBY6OSdVDyvPBiM8YH8ZMMNvl2Qu+pjj
 gHNSmc3aj0zKjGVzMLHDjsiia0Pz0F+KWStDC+zquryVsn/a6m5nYQsYF2P5Wt8QKnErp679
 TLJ+0zXiT34N3/zkfglqQDL3qXA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fbccf470c9500dc7ba265c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 09:15:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5C4A4C43460; Tue, 24 Nov 2020 09:15:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88BBEC433ED;
        Tue, 24 Nov 2020 09:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88BBEC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: 8723d: add cck pd seetings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201109090123.9254-1-pkshih@realtek.com>
References: <20201109090123.9254-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124091551.5C4A4C43460@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 09:15:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> CCK PD can reduce the number of false alarm of the CCK rates.
> It dynamically adjusts the power threshold and CS ratio.
> The values are compared to the values of the previous level, if
> the level is changed, set new values of power threshold and CS
> ratio.
> 
> Implement rtw_chip_ops::cck_pd_set() for 8723d.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

8f0cb24ceefe rtw88: 8723d: add cck pd seetings
760bb2abfef2 rtw88: add CCK_PD debug log

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201109090123.9254-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

