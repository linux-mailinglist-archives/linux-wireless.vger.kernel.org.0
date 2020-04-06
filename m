Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190A819F9F6
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgDFQOR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 12:14:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:47218 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728943AbgDFQOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 12:14:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586189657; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vds9pzhrhzp/LutKIUtS6tD/mzMWtsoKyQZ+g9sBae4=;
 b=WdrZUpff2ULDGU2kZQcBuKEg8wqHeJkbaXdYX4i53L6i4c0eaDGRGnZyPjoSdJJBlCOY3tRT
 Bmef4wn5QHkrpvqKZo5FspoHlyCtwd8F5FlZdYHKcO3JZrmuZN/1Ttimo/AChdDfZpAZIdAD
 1MNK2evl7da30bKHP90NtiIR/K0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b5557.7fcd3983ea78-smtp-out-n02;
 Mon, 06 Apr 2020 16:14:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4099C433F2; Mon,  6 Apr 2020 16:14:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 445D9C433D2;
        Mon,  6 Apr 2020 16:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 445D9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath11k: Add sta debugfs support to configure ADDBA and
 DELBA
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1585213026-28406-1-git-send-email-mkenna@codeaurora.org>
References: <1585213026-28406-1-git-send-email-mkenna@codeaurora.org>
To:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406161414.C4099C433F2@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 16:14:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maharaja Kennadyrajan <mkenna@codeaurora.org> wrote:

> Add support to test aggregation procedures (addba/addba_resp/delba)
> manually by adding the required callbacks in sta debugfs files.
> 
> To enable automatic aggregation in target,
> 
>     echo 0 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
> 	     stations/XX:XX:XX:XX:XX:XX/aggr_mode
> 
> For manual mode,
> 
>     echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
> 	     stations/XX:XX:XX:XX:XX:XX/aggr_mode
> 
> To send addba response,
>     echo 0 25 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
> 		stations/XX:XX:XX:XX:XX:XX/addba_resp
> 
> To send addba,
>     echo 1 32 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
> 		stations/XX:XX:XX:XX:XX:XX/addba
> 
> To send delba,
>     echo 0 1 37 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
> 		  stations/XX:XX:XX:XX:XX:XX/delba
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9556dfa28b4d ath11k: Add sta debugfs support to configure ADDBA and DELBA

-- 
https://patchwork.kernel.org/patch/11459699/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
