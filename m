Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16FD40B5A4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbhINRKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Sep 2021 13:10:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22407 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhINRKx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Sep 2021 13:10:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631639375; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=v/h2NHmZ48S8ivTYLuGCAlo3zBEQQqX1G8NQF7h8Sa8=;
 b=ie8D3YpZRz7CMKJfj0uvG/1+SilItyFjNS8p/K0xX/I5Zx+gCeTHHaeO1xIbbpGo6RQWjBo9
 BIWWnAgIC2dvl/UzEXY0O3Rn5zJzNFdPv48LEE7ka3E40NsAKn6bA4ykDwc+vhNVMbvs2eY2
 wL18tAOgmX+0MW/q1y3nz4eJf48=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6140d734c1b30e2f02281281 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Sep 2021 17:09:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6A68C43460; Tue, 14 Sep 2021 17:09:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C88BFC4338F;
        Tue, 14 Sep 2021 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C88BFC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] ath11k: Change DMA_FROM_DEVICE to DMA_TO_DEVICE when
 map
 reinjected packets
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210913180246.193388-1-jouni@codeaurora.org>
References: <20210913180246.193388-1-jouni@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210914170907.B6A68C43460@smtp.codeaurora.org>
Date:   Tue, 14 Sep 2021 17:09:07 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> wrote:

> For fragmented packets, ath11k reassembles each fragment as a normal
> packet and then reinjects it into HW ring. In this case, the DMA
> direction should be DMA_TO_DEVICE, not DMA_FROM_DEVICE, otherwise
> invalid payload will be reinjected to HW and then delivered to host.
> What is more, since arbitrary memory could be allocated to the frame, we
> don't know what kind of data is contained in the buffer reinjected.
> Thus, as a bad result, private info may be leaked.
> 
> Note that this issue is only found on Intel platform.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Dropping due to the issue Peter found.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210913180246.193388-1-jouni@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

