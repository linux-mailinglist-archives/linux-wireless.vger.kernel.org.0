Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385E1C3507
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgEDIzq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 04:55:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36638 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727951AbgEDIzq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 04:55:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588582545; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=w/QjpK4bbEUUbhEw3eVFOf8bWxqJ0zdxiEqcJ5+tCoE=;
 b=nt1bw62c7rkmcug9oPbPehYbXeLcDJAlkhdUqu3R53hOGDtG6rFSmAKm1pjknsAwRtP0mKAj
 M5ugt+cJMtCE9rXoi2Du9ZwEmURpYnwT9k3p5+JNVru0U74Ikw1uyRAUl1bbbqSfVGL0RRSY
 Rt8crO3AkX8wwt08IENxciqP+kY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafd87d.7f423f06b6f8-smtp-out-n02;
 Mon, 04 May 2020 08:55:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51DB1C433F2; Mon,  4 May 2020 08:55:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0FC5C433D2;
        Mon,  4 May 2020 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0FC5C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/2] ath11k: fix mgmt_tx_wmi cmd sent to FW for deleted
 vdev
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1588049126-1490-2-git-send-email-murugana@codeaurora.org>
References: <1588049126-1490-2-git-send-email-murugana@codeaurora.org>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504085524.51DB1C433F2@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 08:55:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sathishkumar Muruganandam <murugana@codeaurora.org> wrote:

> In Multi-AP VAP scenario with frequent interface up-down, there is a
> chance that ath11k_mgmt_over_wmi_tx_work() will dequeue a skb
> corresponding to currently deleted/stopped vdev.
> 
> FW will assert on receiving mgmt_tx_wmi cmd for already deleted vdev.
> Hence adding validation checks for arvif present on the corresponding
> ar before sending mgmt_tx_wmi cmd.
> 
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

66307ca04057 ath11k: fix mgmt_tx_wmi cmd sent to FW for deleted vdev
657680cc86ca ath11k: add DBG_MAC prints to track vdev events

-- 
https://patchwork.kernel.org/patch/11513813/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
