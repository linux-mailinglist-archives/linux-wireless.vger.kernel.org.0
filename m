Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47F41831DC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCLNoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:44:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19027 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgCLNoV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:44:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020661; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=vPtGwSu1+5eK4tRGXIHzuXmuMUCPslSsRZ8+3nB35xk=;
 b=mlwH1pAdr0eChLnXaMUKaYMYJuqcaE5NI53umodvAOgXL4dphAysuxjUL1ng+Vu5cQTrvnFn
 87Thtkus6T5lQEx6Uz23lzx+7HdOBhr/hNlzPLR2XEcrbWUQ88zTl/SU6ejzlqBmxpagKNWM
 0UwuDpj9I8T4HrmUFMyUgFBZU9w=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3ca4.7fa8319655e0-smtp-out-n02;
 Thu, 12 Mar 2020 13:44:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 743FAC43636; Thu, 12 Mar 2020 13:44:04 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1FE68C433CB;
        Thu, 12 Mar 2020 13:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1FE68C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/7] carl9170: Use scnprintf() for avoiding potential
 buffer overflow
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200311084713.18220-4-tiwai@suse.de>
References: <20200311084713.18220-4-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134404.743FAC43636@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:44:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:

> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().
> 
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

5 patches applied to wireless-drivers-next.git, thanks.

5cb5b4759cf6 carl9170: Use scnprintf() for avoiding potential buffer overflow
68b02e0c512b b43: Use scnprintf() for avoiding potential buffer overflow
d3f8c708c0d7 b43legacy: Use scnprintf() for avoiding potential buffer overflow
f35ba45c39c9 ipw2x00: Use scnprintf() for avoiding potential buffer overflow
1da740e08a2d prism54: Use scnprintf() for avoiding potential buffer overflow

-- 
https://patchwork.kernel.org/patch/11431145/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
