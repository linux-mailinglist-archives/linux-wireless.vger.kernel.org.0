Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691852A32B8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKBSRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 13:17:32 -0500
Received: from z5.mailgun.us ([104.130.96.5]:39180 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgKBSRb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604341051; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WNliksh7Tgt2rSG29nRcv/foFEK09F28vFf8eMxlTdA=;
 b=cwc9e4vE9XU32H6yh64BrE350Ifd1acgO2sG0b0B/L/w1m2QahxUAeftSh4qgw5eyUEYSkTv
 28NmlaYF1O5zrj2CGNIlhHTdiPE+pM6w3Y3E64+1qGLFEOcHpFtTDt94tP3rH5Vt6bpa74m+
 dRjbxANzw2ZVD/9vTCLpQV8WC8M=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa04d3a23306fb6029782d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 18:17:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9788C433C9; Mon,  2 Nov 2020 18:17:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9052AC433F0;
        Mon,  2 Nov 2020 18:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9052AC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iwlwifi: pcie: limit memory read spin time
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid>
References: <iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201102181730.D9788C433C9@smtp.codeaurora.org>
Date:   Mon,  2 Nov 2020 18:17:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> When we read device memory, we lock a spinlock, write the address we
> want to read from the device and then spin in a loop reading the data
> in 32-bit quantities from another register.
> 
> As the description makes clear, this is rather inefficient, incurring
> a PCIe bus transaction for every read. In a typical device today, we
> want to read 786k SMEM if it crashes, leading to 192k register reads.
> Occasionally, we've seen the whole loop take over 20 seconds and then
> triggering the soft lockup detector.
> 
> Clearly, it is unreasonable to spin here for such extended periods of
> time.
> 
> To fix this, break the loop down into an outer and an inner loop, and
> break out of the inner loop if more than half a second elapsed. To
> avoid too much overhead, check for that only every 128 reads, though
> there's no particular reason for that number. Then, unlock and relock
> to obtain NIC access again, reprogram the start address and continue.
> 
> This will keep (interrupt) latencies on the CPU down to a reasonable
> time.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

04516706bb99 iwlwifi: pcie: limit memory read spin time

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20201022165103.45878a7e49aa.I3b9b9c5a10002915072312ce75b68ed5b3dc6e14@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

