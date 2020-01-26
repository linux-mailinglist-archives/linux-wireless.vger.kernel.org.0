Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F8149B8E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAZPo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:44:26 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:19485 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725838AbgAZPo0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:44:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053465; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WzzYj7CYCKCxaN5uAMBczOHT/Ktahts0k/pHCoX/w1U=;
 b=nFVjqFMUeWwJdZ2H2LAwjOoU/hfR1v72ipPjvSMR96OYvEj2JHuLcvgu3d0+Ooog0vQW/Dr1
 8kkekfJg24XW57+n3IWjmQS1FBkmBZvz1Z7+La5fqkIPUV5ZT3hKHUKES6F9h6OxGCYtBrRQ
 D5sRZRec4j+BAk7+Pn5bMwZtqcU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db3d8.7f2803b89618-smtp-out-n03;
 Sun, 26 Jan 2020 15:44:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14E38C433CB; Sun, 26 Jan 2020 15:44:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 832BBC43383;
        Sun, 26 Jan 2020 15:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 832BBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] qtnfmac: cleanup slave_radar access function
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200109131755.7729-2-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-2-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126154424.14E38C433CB@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 15:44:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> Currently this parameter is global, it is not specific to mac.
> So this function does not need any input parameters.
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

5 patches applied to wireless-drivers-next.git, thanks.

e92b07a20b5f qtnfmac: cleanup slave_radar access function
155b424c86f8 qtnfmac: add module param to configure DFS offload
e14291752e56 qtnfmac: control qtnfmac wireless interfaces bridging
b73f0aac731c qtnfmac: add support for STA HE rates
ed7791d9d0ab qtnfmac: add support for TWT responder and spatial reuse

-- 
https://patchwork.kernel.org/patch/11325659/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
