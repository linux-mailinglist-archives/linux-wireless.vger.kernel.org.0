Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3A2725ED
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgIUNmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 09:42:52 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:17105 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUNmw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 09:42:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600695771; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eUv1pj5a339DsJe3O4Y3TdIqMyRlR0R6KpyUa1ZBi4Y=;
 b=EdBIM4Et2jrSnJYHdWurs/Wy76RZO8BF+oTk7epbNDBKLz4xgKRmvO+O6bCSIhrF6ieCn1iA
 dSc7LcW2e9Jbm3qMIr7q7Fg0zVvsVgeKWw0KoQLFGU2AWMBYtwBp0pQ0vDPhu7mAYpTfQ5/X
 V6qbFKFUtergPb9Mc2tOYnZTymk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f68adda7334da8678c691cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Sep 2020 13:42:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09757C433F1; Mon, 21 Sep 2020 13:42:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B27BC433CA;
        Mon, 21 Sep 2020 13:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5B27BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ath11k: cold boot calibration support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
References: <1600163991-2093-1-git-send-email-ssreeela@codeaurora.org>
To:     Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200921134250.09757C433F1@smtp.codeaurora.org>
Date:   Mon, 21 Sep 2020 13:42:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sowmiya Sree Elavalagan <ssreeela@codeaurora.org> wrote:

> From: Govindaraj Saminathan <gsamin@codeaurora.org>
> 
> cold boot calibration is the process to calibrate all the channels
> during the boot-up to avoid the calibration delay during the
> channel change.
> During the boot-up, firmware started with mode “cold_boot_calibration”
> Firmware calibrate all channels and generate CalDb(DDR).
> Subsequent WIFI ON will reuse the same CalDb.
> Firmware restarted with Mission mode to continue the normal operation.
> 
> caldb memory address send to firmware through the QMI message.Firmware
> use this address to store the caldb data and use it until next reboot.
> 
> This will give the improvement during the channel change. But it is
> increasing the boot-up time(up to 15sec depend on number of radios).
> So if the user want to reduce the boot-up time and accepting for channel
> change delay, user can disable this feature using the module param
> cold_boot_cal =0.
> Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
> 
> 
> Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
> Co-developed-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
> Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath11k/ahb.c:573
error: drivers/net/wireless/ath/ath11k/ahb.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11775953/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

