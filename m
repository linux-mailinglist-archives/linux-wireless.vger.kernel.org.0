Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C028635B27A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDKIsI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 04:48:08 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39600 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKIsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 04:48:07 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618130872; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=a2G7vTFDh+Q+9V1OXanbd//eBGo5z3KYcHHK6KjCCtA=;
 b=MW5ypptELoWOdUw/6VZxH3fWfWLumF18e2P6Ufw8Rv/JiWwS2nobURZpYUkbhqsV+hsRtBjf
 fl01OhMWBsKPZGSj8/6EFBRfQc7KPapZs5Evrt4/zffSJdnmfBlBLG0fnd737Pzr6UUR7mzu
 YIHGgrrEuqwo/lX9reJy+HXPCfs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6072b7b6febcffa80fe7ed3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 08:47:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D976AC43461; Sun, 11 Apr 2021 08:47:50 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C805C433C6;
        Sun, 11 Apr 2021 08:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C805C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.12] mt76: fix potential DMA mapping leak
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210323214737.53254-1-nbd@nbd.name>
References: <20210323214737.53254-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, greearb@candelatech.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411084750.D976AC43461@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 08:47:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> With buf uninitialized in mt76_dma_tx_queue_skb_raw, its field skip_unmap
> could potentially inherit a non-zero value from stack garbage.
> If this happens, it will cause DMA mappings for MCU command frames to not be
> unmapped after completion
> 
> Fixes: 27d5c528a7ca ("mt76: fix double DMA unmap of the first buffer on 7615/7915")
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Sorry, I missed this and I suspect it's now too late for v5.12. Felix, can you
instead take this to your tree so that we can get this to v5.13? I assigned
this to you on patchwork.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210323214737.53254-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

