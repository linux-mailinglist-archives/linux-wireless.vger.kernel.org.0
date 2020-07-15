Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32E220864
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgGOJO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jul 2020 05:14:26 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25246 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729577AbgGOJO0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jul 2020 05:14:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594804465; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=DV6aQhqvJbzRZ/tZSDCPBunW2l7bqThKNjTKlPlGBwk=;
 b=VKoA1S7u/hxyMJPvcwbSILv9btpk8Clo2bvJt9+vOJFkpbK/yfcdV1KBO35b5Tt2dGzx3bCL
 Dp1+0ZSo7PbyZwt0pe00uIz38Eq4ieCfiU+dq8BHfxUvIa7K3E/IbXUY4Tw1XAi7vzkvlvJg
 mwU3pgQAooyuqO6DmihJ/oSsM6g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f0ec8f11012768490bb1438 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 09:14:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 714A0C433CB; Wed, 15 Jul 2020 09:14:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 50610C433CA;
        Wed, 15 Jul 2020 09:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50610C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: coex: Fix ACL Tx pause during BT inquiry/page.
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200715023324.8600-1-yhchuang@realtek.com>
References: <20200715023324.8600-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715091425.714A0C433CB@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 09:14:25 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add a set of logic with corresponding coexistence parameters to
> handle the situation under BT inquiry/page.
> 
> We will set PSTDMA while WL-Busy + BT inquiry/page to separate
> WL/BT slots. PSTDMA can protect WL data rate and BT performance.
> 
> If WL-Busy + BT inquiry/page and there was BT device paired,
> We will set the mechanism to 4Slot PSTDMA.
> In 4Slot PSTDMA, the paired devices can perform more smoothly
> and prevent some issues trigger from insufficient data.
> 
> And to avoid A2DP glitch or disconnection, we will adjust ACL
> data priority higher than inquiry/page.
> 
> In addition, we found sometimes BT inquiry/page still working
> last for seconds after BT had notified inquiry/page finished.
> It will lead to A2DP glitch cause of ACL data, inquiry/page
> priority toggled. To fix the corner, we add a timer to remain
> the inquiry/page status.
> 
> And we found WL busy/idle threshold is too sensitive,
> it will keep switching in some weak network environment and
> coexistence mechanism will switch between TDMA and PSTDMA.
> 
> The very frequently switching may destroyed not only the
> handshake with AP, but BT performance. And it will trigger
> some unexpected error.
> 
> To prevent the frequently switching, we add a timer to delay
> the status change while WL busy switch to idle.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

001a3c902f6f rtw88: coex: Fix ACL Tx pause during BT inquiry/page.

-- 
https://patchwork.kernel.org/patch/11664065/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

