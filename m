Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598A627BF38
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI2IXV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 04:23:21 -0400
Received: from z5.mailgun.us ([104.130.96.5]:18051 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgI2IXV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 04:23:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601367800; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZIbWjmupiyGvrRgnk4QJodsICDeobskHiYTYE9JYoyA=;
 b=Ei5/KHxez7gAWYCtLRhoP+eQF1SeawnEpMCX2nf/aJ6IaK3MCYkh7cd4oYYdiw93s778/61c
 YbePZOsorQp1+emvelSuvFecIgKH52fVcO5nX/Pd3wq8er9jcYUyqrQ2SceCx/zTY18Pjb+Z
 jk+9u94JIoVNoIqh5+XN4YQJd2k=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f72eef8767da8a9bb52aa87 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 08:23:20
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20502C433CB; Tue, 29 Sep 2020 08:23:20 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE67AC433C8;
        Tue, 29 Sep 2020 08:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE67AC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] rtw88: increse the size of rx buffer size
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200925061219.23754-2-tehuang@realtek.com>
References: <20200925061219.23754-2-tehuang@realtek.com>
To:     <tehuang@realtek.com>
Cc:     <yhchuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200929082320.20502C433CB@smtp.codeaurora.org>
Date:   Tue, 29 Sep 2020 08:23:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<tehuang@realtek.com> wrote:

> From: Tzu-En Huang <tehuang@realtek.com>
> 
> The vht capability of MAX_MPDU_LENGTH is 11454 in rtw88; however, the rx
> buffer size for each packet is 8192. When receiving packets that are
> larger than rx buffer size, it will leads to rx buffer ring overflow.
> 
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>

5 patches applied to wireless-drivers-next.git, thanks.

ee755732b7a1 rtw88: increse the size of rx buffer size
5c831644e1f4 rtw88: handle and recover when firmware crash
0fbc2f0f34cc rtw88: add dump firmware fifo support
714f71f94ab3 rtw88: add dump fw crash log
fada09311d17 rtw88: show current regulatory in tx power table

-- 
https://patchwork.kernel.org/patch/11799087/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

