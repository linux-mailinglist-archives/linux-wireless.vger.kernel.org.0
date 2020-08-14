Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC08244C36
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHNPhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 11:37:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53571 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgHNPhi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 11:37:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597419457; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=VcTqxzch+HrgLH14RlsE8L1x7jT/qZTITOFlc4lZ7lo=;
 b=htzDPZGa5p2MVhnLZxfNziyFwZAsnhgRzfUk4SV1KksOerLhqn4mbvNvmKBp3GNnS/6nUXR7
 +q5ALRdA/9l41COlL3yba0bdfyOyFS+XbEmq+6ZKL/ItFTySF6/m7SDvsB8IVvnjhhIM6wi9
 YIlaSCWbh1ApKqNIhsXQYuz7YpQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f36afc003528d4024988d1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 15:37:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40ED8C433CA; Fri, 14 Aug 2020 15:37:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14FE2C433C9;
        Fri, 14 Aug 2020 15:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14FE2C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/2] ath10k: start recovery process when payload length
 exceeds max htc length for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200108031957.22308-3-wgong@codeaurora.org>
References: <20200108031957.22308-3-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200814153736.40ED8C433CA@smtp.codeaurora.org>
Date:   Fri, 14 Aug 2020 15:37:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When simulate random transfer fail for sdio write and read, it happened
> "payload length exceeds max htc length" and recovery later sometimes.
> 
> Test steps:
> 1. Add config and update kernel:
> CONFIG_FAIL_MMC_REQUEST=y
> CONFIG_FAULT_INJECTION=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> 
> 2. Run simulate fail:
> cd /sys/kernel/debug/mmc1/fail_mmc_request
> echo 10 > probability
> echo 10 > times # repeat until hitting issues
> 
> 3. It happened payload length exceeds max htc length.
> [  199.935506] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088
> ....
> [  264.990191] ath10k_sdio mmc1:0001:1: payload length 57005 exceeds max htc length: 4088
> 
> 4. after some time, such as 60 seconds, it start recovery which triggered
> by wmi command timeout for periodic scan.
> [  269.229232] ieee80211 phy0: Hardware restart was requested
> [  269.734693] ath10k_sdio mmc1:0001:1: device successfully recovered
> 
> The simulate fail of sdio is not a real sdio transter fail, it only
> set an error status in mmc_should_fail_request after the transfer end,
> actually the transfer is success, then sdio_io_rw_ext_helper will
> return error status and stop transfer the left data. For example,
> the really RX len is 286 bytes, then it will split to 2 blocks in
> sdio_io_rw_ext_helper, one is 256 bytes, left is 30 bytes, if the
> first 256 bytes get an error status by mmc_should_fail_request,then
> the left 30 bytes will not read in this RX operation. Then when the
> next RX arrive, the left 30 bytes will be considered as the header
> of the read, the top 4 bytes of the 30 bytes will be considered as
> lookaheads, but actually the 4 bytes is not the lookaheads, so the len
> from this lookaheads is not correct, it exceeds max htc length 4088
> sometimes. When happened exceeds, the buffer chain is not matched between
> firmware and ath10k, then it need to start recovery ASAP. Recently then
> recovery will be started by wmi command timeout, but it will be long time
> later, for example, it is 60+ seconds later from the periodic scan, if
> it does not have periodic scan, it will be longer.
> 
> Start recovery when it happened "payload length exceeds max htc length"
> will be reasonable.
> 
> This patch only effect sdio chips.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

2fd3c8f34d08 ath10k: start recovery process when payload length exceeds max htc length for sdio

-- 
https://patchwork.kernel.org/patch/11322583/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

