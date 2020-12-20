Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790552DF557
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Dec 2020 13:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgLTMGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Dec 2020 07:06:17 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:43624 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgLTMGR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Dec 2020 07:06:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608465957; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=EBRqmfS+dz7ogOBw3uThHJDJM3f62uw7cEVQymNuQqc=;
 b=Q3o2YGRmYSk520moE1M9fLIA+lGW6wkGLNz97l+GkyNV8WJqq8fgv3R5urre3khdUdPzHkX2
 Q4IkvB5iCUstvbwbnTBZR947zUwTHu5Ocoi7ccloJSrEqkClb1aDEq+/Tg5JTXBMySvJgIYW
 4sLFP2B034FdSAl3Sacw27fG/Mw=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fdf3e06253011a4b8adb4f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 20 Dec 2020 12:05:26
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6494CC433CA; Sun, 20 Dec 2020 12:05:25 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 021E3C433C6;
        Sun, 20 Dec 2020 12:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 021E3C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: mt76s: fix NULL pointer dereference in
 mt76s_process_tx_queue
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
References: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201220120525.6494CC433CA@smtp.codeaurora.org>
Date:   Sun, 20 Dec 2020 12:05:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
> can occur if status thread runs before allocating tx queues
> 
> Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_worker")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

f7217f718747 mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_queue

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

