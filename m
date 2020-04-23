Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF991B53CB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 06:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDWErO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 00:47:14 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53852 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgDWErN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 00:47:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587617233; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=qf8++3tHua2j2gm/2U034kulj1B5QYb/qkJ3EhdMeTo=;
 b=i8uPXzqbdCBw+hs4sdhTYRq0W/nYSM7ZCp0jKNGF/NKiQX/s+GF2PXkA84IjmS++v5HPVzcw
 fzElnrD5ar4Aq3l5b0NR2I0p/3QsGYxY7ceOyc10MK+vFG/kKpushk+1WjAfPaQCaKy6qZBD
 huvnIibJHIoFsmFvdzzyZMav0EU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea11dca.7f5285a762d0-smtp-out-n02;
 Thu, 23 Apr 2020 04:47:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C783C433CB; Thu, 23 Apr 2020 04:47:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 439C1C433CB;
        Thu, 23 Apr 2020 04:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 439C1C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wlcore: Adding suppoprt for IGTK key in wlcore driver
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1587472085-755-1-git-send-email-r-bouganim@ti.com>
References: <1587472085-755-1-git-send-email-r-bouganim@ti.com>
To:     Raz Bouganim <r-bouganim@ti.com>
Cc:     <linux-wireless@vger.kernel.org>, <d-levy@ti.com>,
        Raz Bouganim <r-bouganim@ti.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423044706.9C783C433CB@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 04:47:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Raz Bouganim <r-bouganim@ti.com> wrote:

> This patch adding support for new cipher suite - AES-CMAC in wlcore driver.
> This patch is required for support PMF/WPA3 connection to install IGTK key.
> 
> Signed-off-by: Raz Bouganim <r-bouganim@ti.com>

Patch applied to wireless-drivers-next.git, thanks.

2b7aadd3b9e1 wlcore: Adding suppoprt for IGTK key in wlcore driver

-- 
https://patchwork.kernel.org/patch/11501187/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
