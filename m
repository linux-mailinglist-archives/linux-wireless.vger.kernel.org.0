Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9952AA66E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKGPus (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:50:48 -0500
Received: from z5.mailgun.us ([104.130.96.5]:23655 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKGPur (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:50:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764247; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2TwWeCsmkxQecCle8VjJKxFoPn3xSb13M0XBhPimx0c=;
 b=J0iXDxUmToqstzky/8Jufb9+A4Z63lhgnMD0Br3rVmc4UM8KUW+EHgNvxXBlDd3qgsIObA5Q
 DnMoMsxEecDSMpZuMzNJCgM3SzZZpS9df24hbb7Ny1RIt3vG3wWEzxaSWhnz/Jg/Xqd1pASk
 ceTjYS9uopts+uJA/iv461ELz8M=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa6c25782aad55dcb4eb5c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:50:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E14DAC433C6; Sat,  7 Nov 2020 15:50:46 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91DF1C433C8;
        Sat,  7 Nov 2020 15:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91DF1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: coex: separate BLE HID profile from BLE profile
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201030055506.6560-1-pkshih@realtek.com>
References: <20201030055506.6560-1-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107155046.E14DAC433C6@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:50:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> BT firmware will report BLE-HID and BLE-RCU in different profile.
> We can distinguish the two profile from BT info now.
> 
> Add the coexistence for BLE-HID coexistence,
> it can make BLE HID work more smoothly.
> 
> BLE-HID need to Tx/Rx packet more frequently to respond
> user operation, but RCU doesn't.
> 
> In the case of RCU coexistence, it will make Wi-Fi have a
> higher priority to earn more Wi-Fi throughput.
> 
> If BLE-HID go for the same case,
> it will make user feel mouse is lagging.
> 
> Desired BT firmware BT-COEX version: 0x1c
> Desired WL firmware version: 9.9
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

842280da81a9 rtw88: coex: separate BLE HID profile from BLE profile

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201030055506.6560-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

