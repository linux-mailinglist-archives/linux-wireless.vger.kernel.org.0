Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF022AA33F
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 09:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgKGIKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 03:10:46 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17679 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgKGIKq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 03:10:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604736646; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=CDac/55/ztnXcpkU70zG+NytctU8BI7//SyBUySLyMQ=;
 b=N0wHXJmKy2A6xzjOQk38gmdyn6FBvvR+E/G+IIkADcYdtSVCkMgRu4kVvrCOFnurSh7ieoK2
 cUDr/2VngbHsJzql7LHV7BQ/CkycoyQKYvvu7l0LqxVIfHKfKALugLMvNlyRXA/Ha8ZCFW9n
 j8xra0pACRchq7H2GmYKcJVSRyg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa656829d6b206d94172031 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 08:10:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88A6CC433C6; Sat,  7 Nov 2020 08:10:42 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C804C433C8;
        Sat,  7 Nov 2020 08:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C804C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix ZERO address in probe request
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201012101733.24137-1-cjhuang@codeaurora.org>
References: <20201012101733.24137-1-cjhuang@codeaurora.org>
To:     Carl Huang <cjhuang@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107081042.88A6CC433C6@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 08:10:42 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Carl Huang <cjhuang@codeaurora.org> wrote:

> Host needs to pass at least on bssid with all 0xff to firmware in
> WMI_START_SCAN_CMDID, otherwise the bssid and receiver address
> in probe requeste are all ZEROs.
> 
> This also fixed some hidden AP connection issue because some AP
> doesn't respond to probe request which receiver address are all
> ZEROs.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fa7572c2cfe0 ath11k: fix ZERO address in probe request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201012101733.24137-1-cjhuang@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

