Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9824F2D3BEF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 08:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgLIHFd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 02:05:33 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:37956 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgLIHFd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 02:05:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607497510; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=+86PPT91p2hKaKQv6yeBkRk/kjLBqJBT+A93PHux4wg=;
 b=i/sZASUgDtA2krLkEkh86FurSI20ExBZukdif6/EIqoE0I9aDv4H+7nr+VvVXWXJ4CbT1EBO
 1vp3Bd2r0XAIK8qKMKtofqrYCcee2/mfPfL3FwLeDi2aFcvW+rb2VAacZlqrnk5Plby/fjXY
 BgnmBQ1QSazjc7BEFhwwasj80sg=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fd0771f395c822bfe5672df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 07:05:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7053EC433C6; Wed,  9 Dec 2020 07:05:03 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E4D2C433C6;
        Wed,  9 Dec 2020 07:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E4D2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] ath11k: fix incorrect wmi param for configuring HE
 operation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201020183111.25458-3-pradeepc@codeaurora.org>
References: <20201020183111.25458-3-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201209070503.7053EC433C6@smtp.codeaurora.org>
Date:   Wed,  9 Dec 2020 07:05:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> WMI_VDEV_PARAM_TX_OFDMA_CPLEN has been added with incorrect enum
> value. Fix the enum to represent WMI param for configuring HE
> operation field.
> 
> This is applicable to firmwares under
> https://github.com/kvalo/ath11k-firmware/tree/master/IPQ8074/hw2.0
> https://github.com/kvalo/ath11k-firmware/tree/master/IPQ6018/hw1.0
> https://github.com/kvalo/ath11k-firmware/tree/master/QCN9074/hw1.0
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

3 patches applied to ath-next branch of ath.git, thanks.

f00490432b60 ath11k: fix incorrect wmi param for configuring HE operation
bd88815060d9 ath11k: support TXOP duration based RTS threshold
743b9065fe63 ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201020183111.25458-3-pradeepc@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

