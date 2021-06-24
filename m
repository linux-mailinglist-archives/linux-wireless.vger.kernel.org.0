Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68B63B270B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhFXF5y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 01:57:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59094 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhFXF5y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 01:57:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624514136; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8O/cq9ly+3QbgT4wNnS78baneEvWDWIxMiddMw4A6C0=; b=glvQxFd4MZUWsH7ZN8ODnmamrUsC4dxApPZV0sWqmeKzbZz+ho5lcwzWBzO0E73fQwz9mNPa
 Z5ulAqHYxHiT56pU1KgyuFj0pCGbwXDQvVIf2Tso15bHAtwFt2Ad4O37S0uefAJqwKyS/YrZ
 5UtBukVc2zKcax/N2QDmI6lFxgE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60d41e56638039e99762278e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 05:55:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9FE79C433D3; Thu, 24 Jun 2021 05:55:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44CFDC433F1;
        Thu, 24 Jun 2021 05:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 44CFDC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 01/12] wilc1000: move 'deinit_lock' lock init/destory inside module probe
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
        <20210423182925.5865-2-ajay.kathat@microchip.com>
        <d2e57ac8-f0ba-bc3a-7aea-9b233a8eb20b@microchip.com>
Date:   Thu, 24 Jun 2021 08:55:26 +0300
In-Reply-To: <d2e57ac8-f0ba-bc3a-7aea-9b233a8eb20b@microchip.com> (Ajay
        Kathat's message of "Thu, 24 Jun 2021 05:43:23 +0000")
Message-ID: <87wnqjiz75.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> I observed the series status is updated to 'Deferred' state in the 
> patchwork link. Since there are no comments in patchwork, so I just 
> wanted to confirm if anything is needed from me.

I don't remember anymore why I deferred it, most likely just to cleanup
my queue, but it's now back in New state. Thanks for the reminder.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
