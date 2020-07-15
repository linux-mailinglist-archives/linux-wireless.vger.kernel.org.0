Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD9220858
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgGOJNZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:13:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25246 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgGOJNY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:13:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804403; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=cJTfxF7jG3cmZTbLQ6nosaLZLb7NsAnGvrnib0vwrTQ=;
 b=KW96+EeZkiovrDrqBQitvkYR/xXTG1mIz0/D3gDxWzpzoL1ZMIaH+AzADgXlj4PunC1egl9A
 DGZN036aDMW8F8ZrpvNj/ed8ZHTBqkvgqUHVsC+G01C61DBcZ5jcEXhOSCJ8FSo3fn6Kd06t
 AOEayd0Uz3eMcCollM0WFlYUGME=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f0ec8961012768490ba9f86 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:12:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B3CCC433C6; Wed, 15 Jul 2020 09:12:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D4D5C433C9;
        Wed, 15 Jul 2020 09:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D4D5C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wlcore: Simplify runtime resume ELP path
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200702162951.45392-2-tony@atomide.com>
References: <20200702162951.45392-2-tony@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Eyal Reizer <eyalr@ti.com>, Guy Mishol <guym@ti.com>,
        linux-wireless@vger.kernel.org, linux-omap@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091254.0B3CCC433C6@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:12:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:

> We can simplify the runtime resume ELP path by always setting and
> clearing the completion in runtime resume. This way we can test for
> WL1271_FLAG_IRQ_RUNNING after the resume write to see if we need
> completion at all.
> 
> And in wlcore_irq(), we need to take spinlock for running the
> completion and for the pm_wakeup_event(). Spinlock is not needed
> around the bitops flags check for WL1271_FLAG_SUSPENDED so the
> spinlocked sections get shorter.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

4 patches applied to wireless-drivers-next.git, thanks.

eb215c33f308 wlcore: Simplify runtime resume ELP path
f0325e38ab39 wlcore: Use spin_trylock in wlcore_irq_locked() for running the queue
35fba0f0fd76 wlcore: Use spin_trylock in wlcore_irq() to see if we need to queue tx
2c3601e6a340 wlcore: Remove pointless spinlock

-- 
https://patchwork.kernel.org/patch/11639577/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

