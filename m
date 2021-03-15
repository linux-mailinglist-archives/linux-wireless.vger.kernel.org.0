Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBA33AD67
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCOI1k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 04:27:40 -0400
Received: from z11.mailgun.us ([104.130.96.11]:11075 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhCOI1T (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 04:27:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615796838; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NgPHPzVjjMah6W99FHyjlf0ngyHkhGVZpYfsTvh05xc=;
 b=urGh57pWOKpkoBS+MWuQn1TmzSNoHEsyJNrVZZerJivvI7pMm5t3Zuxj9mCDozkr0fwo+oTO
 B3ORzPXjv9qqsNer4AXnBsrKmMnA1v0z2jRWEle4vRuCN9OrNnp6dge3SWha5/Xj4P6ZqXF9
 sWPOQ4v9JsG/jpgAE8gKePDYsXg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 604f1a4b5d70193f885bb5ed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Mar 2021 08:26:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9DF3C43463; Mon, 15 Mar 2021 08:26:51 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D85CC43461;
        Mon, 15 Mar 2021 08:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D85CC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210225042302.17048-1-ajay.kathat@microchip.com>
References: <20210225042302.17048-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210315082651.A9DF3C43463@smtp.codeaurora.org>
Date:   Mon, 15 Mar 2021 08:26:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Use same cookie for request_threaded_irq() & free_irq() to properly free
> IRQ during module unload. free_irq() already uses *wilc* handler so the
> changes are required for request_threaded_irq().
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless-drivers-next.git, thanks.

50773696301b wilc1000: use wilc handler as cookie in request_threaded_irq()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210225042302.17048-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

