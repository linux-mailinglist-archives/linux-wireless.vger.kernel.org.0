Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1C2AA328
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgKGIDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:03:02 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:54834 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgKGIDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:03:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604736181; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=EfMCA9OH6BbQI6j2BJDOntr303RxmArBCePzx113KpI=;
 b=eeiNcNtIbwPsw5WXh7aHF+rxC4YMCS2drbItTUvdYJCsyE29g55rQRQv2voTMOQtTOtavCIp
 0ngpdTfEHwv0LKKftxOqx9m7U73iK+PQwUz+DuTU6nqAs4Awo6yby+OeI8Vq9ZMQ10Kg0JIG
 Zb787msUwKWN6h5JZTN7LUCHEv0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fa6547d8723a97b706a3f0d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 08:02:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 486CBC433C9; Sat,  7 Nov 2020 08:02:04 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B4D4C433C6;
        Sat,  7 Nov 2020 08:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B4D4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] ath11k: cold boot calibration support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1602862111-14063-1-git-send-email-ssreeela@codeaurora.org>
References: <1602862111-14063-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107080204.486CBC433C9@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 08:02:04 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> cold boot calibration is the process to calibrate all the channels
> during the boot-up to avoid the calibration delay during the
> channel change.
> During the boot-up, firmware started in cold boot calibration mode
> Firmware calibrate all channels and generate CalDb(DDR).
> Subsequent wifi bringup will reuse the same CalDb.
> Firmware is restarted in normal mode to continue the normal operation.
> 
> caldb memory address send to firmware through the QMI message.Firmware
> use this address to store the caldb data and use it until next reboot.
> 
> This will give the improvement during the channel change. But it is
> increasing the boot-up time(up to 15sec depend on number of radios).
> So if the user want to reduce the boot-up time and accepting for channel
> change delay, user can disable this feature using the module param
> cold_boot_cal=0.
> 
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-01162-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

02f9d3c1b918 ath11k: cold boot calibration support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1602862111-14063-1-git-send-email-ssreeela@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

