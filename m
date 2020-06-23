Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF6204CC3
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgFWInB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 04:43:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54897 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbgFWInB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 04:43:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592901781; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=0dDguUpV7o+I1zTuJHHDo9U7rVqeENPyGGkwU/3XKbk=;
 b=vLVDhOj95W6P0PrQQdjDrIjq0RR6ectxR7cUAreRIXLyhIBZ4Vi7H0V+x2FejLRN1+886sQ1
 cau6RPniDLf50ZBpC/FtHvve6XHVEVL8/fDBpgIzNlT31aGpBW0OwnYTaPe91Sl4wUCUraPQ
 lat+wwQN0s11TKpEur7pWPpAEcY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-west-2.postgun.com with SMTP id
 5ef1c08ffe1db4db89d12f12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 08:42:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E09B5C433CA; Tue, 23 Jun 2020 08:42:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A5752C433CA;
        Tue, 23 Jun 2020 08:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5752C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.8] mt76: mt76x02: do not access uninitialized NAPI
 structs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200615181341.81871-1-nbd@nbd.name>
References: <20200615181341.81871-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623084254.E09B5C433CA@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 08:42:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Fixes a crash on MMIO devices when running into the watchdog reset
> 
> Fixes: d3377b78cec6 ("mt76: add HE phy modes and hardware queue")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

4ac668a3b8c9 mt76: mt76x02: do not access uninitialized NAPI structs

-- 
https://patchwork.kernel.org/patch/11605487/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

