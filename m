Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C831E63E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Feb 2021 07:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBRGQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Feb 2021 01:16:49 -0500
Received: from z11.mailgun.us ([104.130.96.11]:50558 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231785AbhBRGJc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Feb 2021 01:09:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613628520; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XEoXeKj0XypLz93hJsGeDrTRfvtE7RnuAzjDvQMWI9g=;
 b=ox0tgAZ3iaBuYUexb3+tXh21lRE/aNvB5Eb5QgTIW9XuMZDLJTRcSZiz9PeWAflJMmzeYv0V
 8WoLfYxSc01xXTgYeYrmsK2J5N6ZoGVTu4O1ZMzgtGo7w6+UB7GyNCLoxyq10P9lxofVX4oa
 wC8ByHTe3k8j89TVoW3koklDEFA=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 602e044ca1a71e420ff65995 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 06:08:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 23B25C433CA; Thu, 18 Feb 2021 06:08:12 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B90C9C433C6;
        Thu, 18 Feb 2021 06:08:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B90C9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: fix transmitting to stations in dynamic SMPS mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210214184911.96702-1-nbd@nbd.name>
References: <20210214184911.96702-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org, hurricos@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210218060812.23B25C433CA@smtp.codeaurora.org>
Date:   Thu, 18 Feb 2021 06:08:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> When transmitting to a receiver in dynamic SMPS mode, all transmissions that
> use multiple spatial streams need to be sent using CTS-to-self or RTS/CTS to
> give the receiver's extra chains some time to wake up.
> This fixes the tx rate getting stuck at <= MCS7 for some clients, especially
> Intel ones, which make aggressive use of SMPS.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Martin Kennedy <hurricos@gmail.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

3b9ea7206d7e ath9k: fix transmitting to stations in dynamic SMPS mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210214184911.96702-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

