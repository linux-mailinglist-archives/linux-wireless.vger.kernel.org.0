Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5893E15904B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBKNtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 08:49:31 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:20716 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbgBKNtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 08:49:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581428970; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=M3E9jVc+u0x29OA3gVofI6T4rbWAfdr3DnZ52s7PAwM=; b=Ii/rKPLTboyLVDTCqg8kZjE74X89UXfLLKXvRohz4Orcimcuyw12vOPf1rWTDsDsviB0VBDO
 2g01+7iEktf4UzpzumUIBUwB1QoaZjbB4njEmpl1fs+/1zUYYyJl5xwQ21cRDPjhQCvMcT37
 UmeLN0qYEufXW7JuZduI0MHK9LM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e42b0e3.7f51eaff43b0-smtp-out-n01;
 Tue, 11 Feb 2020 13:49:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BF23AC4479D; Tue, 11 Feb 2020 13:49:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38003C43383;
        Tue, 11 Feb 2020 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38003C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ath11k: add thermal sensor device support
References: <1580860830-12696-1-git-send-email-pradeepc@codeaurora.org>
        <1580860830-12696-2-git-send-email-pradeepc@codeaurora.org>
Date:   Tue, 11 Feb 2020 15:49:19 +0200
In-Reply-To: <1580860830-12696-2-git-send-email-pradeepc@codeaurora.org>
        (Pradeep Kumar Chitrapu's message of "Wed, 5 Feb 2020 05:30:30 +0530")
Message-ID: <87zhdpw7xc.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:

> Temperature sensor generates electrical analog voltage from temperature
> of each chain. The analog voltage is converted to digital value through
> ADC. For reading temperature values fom user space, hw monitoring device
> is used.
>
> Whenever the user requests for current temperature, the driver sends WMI
> command and wait for response. For reading temperature,
>
> cat /sys/class/ieee80211/phy*/device/hwmon/hwmon2/temp1_input
>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Multiple warnings, please fix those and resend the whole series.

drivers/net/wireless/ath/ath11k/wmi.c: In function 'ath11k_wmi_tlv_op_rx':
drivers/net/wireless/ath/ath11k/wmi.c:5651:7: warning: 'pdev_id' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath11k/wmi.c:5641:6: note: 'pdev_id' was declared here
drivers/net/wireless/ath/ath11k/wmi.c:5657:2: warning: 'temp' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath11k/wmi.c:5640:6: note: 'temp' was declared here
drivers/net/wireless/ath/ath11k/wmi.c: In function 'ath11k_wmi_tlv_op_rx':
drivers/net/wireless/ath/ath11k/wmi.c:5651:7: warning: 'pdev_id' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath11k/wmi.c:5641:6: note: 'pdev_id' was declared here
drivers/net/wireless/ath/ath11k/wmi.c:5657:2: warning: 'temp' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath11k/wmi.c:5640:6: note: 'temp' was declared here

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
