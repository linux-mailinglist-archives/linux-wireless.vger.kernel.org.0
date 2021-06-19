Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487ED3AD8CE
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhFSJIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 05:08:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42543 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFSJIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 05:08:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624093585; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mH+qv9WCwRFtGepgrLgmaZiRBlcWLKrRo52cPCcVzxM=;
 b=urmnAM6TPNgeiOtfLbE8Xite/hzRqdaGKIIAu9/EAWkE8U8CHx0/iyiFkbBcnME8mz8yHhup
 xDw7qJHkg5CmHCs8oL/TpmF5nJCkfT9WgIq5yPandNjklgXr+lg9RbHxURmJaLsIzIMcgS8o
 9+fpR2CBelbhPqm9OIIUx3f44QY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60cdb3705eaa81cb1edddc41 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 19 Jun 2021 09:05:52
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D6B1C4338A; Sat, 19 Jun 2021 09:05:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3B7EC433F1;
        Sat, 19 Jun 2021 09:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3B7EC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtl8xxxu: Fix device info for RTL8192EU devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210424172959.1559890-1-pterjan@google.com>
References: <20210424172959.1559890-1-pterjan@google.com>
To:     Pascal Terjan <pterjan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <jes.sorensen@gmail.com>,
        Pascal Terjan <pterjan@google.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210619090551.4D6B1C4338A@smtp.codeaurora.org>
Date:   Sat, 19 Jun 2021 09:05:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pascal Terjan <pterjan@google.com> wrote:

> Based on 2001:3319 and 2357:0109 which I used to test the fix and
> 0bda:818b and 2357:0108 for which I found efuse dumps online.
> 
> == 2357:0109 ==
> === Before ===
> Vendor: Realtek
> Product: \x03802.11n NI
> Serial:
> === After ===
> Vendor: Realtek
> Product: 802.11n NIC
> Serial not available.
> 
> == 2001:3319 ==
> === Before ===
> Vendor: Realtek
> Product: Wireless N
> Serial: no USB Adap
> === After ===
> Vendor: Realtek
> Product: Wireless N Nano USB Adapter
> Serial not available.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>

Patch applied to wireless-drivers-next.git, thanks.

c240b044edef rtl8xxxu: Fix device info for RTL8192EU devices

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210424172959.1559890-1-pterjan@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

