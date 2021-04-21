Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F4F36683C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238486AbhDUJj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 05:39:26 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12338 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhDUJjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 05:39:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618997932; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=OmoymGKDQoh4lDYpbHhLHHL66RCjlT7yrhoPGYNhVus=;
 b=X1fiB1Wgec51RBbgCufCXe8nzmjjqVWcWsIBVYAIRIC8fXNSyYf23a19oIWrxot5S5wPiHz2
 xZ6UTHY74DmW2Syqe0szSejOn970vXOM9ZvVFyoVsKIvHkaFWZN2mBCVjl841Z+3YvHTVtDQ
 aSQIJlxanF0+Ga/BuHa4ttDvsqg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607ff295a817abd39aa8d3bf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 09:38:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 46887C43460; Wed, 21 Apr 2021 09:38:28 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2DAB6C433F1;
        Wed, 21 Apr 2021 09:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2DAB6C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] rtw88: 8821c: Don't set RX_FLAG_DECRYPTED if packet
 has
 no encryption
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210415084703.27255-2-pkshih@realtek.com>
References: <20210415084703.27255-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <vincent_fann@realtek.com>, <phhuang@realtek.com>,
        <steventing@realtek.com>, <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210421093828.46887C43460@smtp.codeaurora.org>
Date:   Wed, 21 Apr 2021 09:38:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Guo-Feng Fan <vincent_fann@realtek.com>
> 
> The value of GET_RX_DESC_SWDEC() indicates that if this RX
> packet requires software decryption or not. And software
> decryption is required when the packet was encrypted and the
> hardware failed to decrypt it.
> 
> So, GET_RX_DESC_SWDEC() is negative does not mean that this
> packet is decrypted, it might just have no encryption at all.
> To actually see if the packet is decrypted, driver needs to
> further check if the hardware has successfully decrypted it,
> with a specific type of encryption algorithm.
> 
> Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-drivers-next.git, thanks.

559f6cb31837 rtw88: 8821c: Don't set RX_FLAG_DECRYPTED if packet has no encryption
a548909d7ad7 rtw88: Fix potential unrecoverable tx queue stop
7bd3760c71f7 rtw88: refine napi deinit flow

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210415084703.27255-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

