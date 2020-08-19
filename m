Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A5D249549
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Aug 2020 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgHSGwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Aug 2020 02:52:54 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:64891 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726854AbgHSGwx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Aug 2020 02:52:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597819972; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=kk18VZt/UZaR2z1275ZwkWBhTQypRK0gS1BfRBqg2H0=; b=DS+03TURs57dl85G1zn9Ef+1wt5r3+Ko8xuiGofDnzkO5wZq8MLaevKepsumF/V/0T+fmVxv
 1XFKpr7yvsU95UoB0vWpmphW58jjvowWG4T6Sdx5KTfutLGXVyUiV4eEwd5ZjzQuoh3Df5kH
 TeLtVwV92Cye7HM6n6W9eKzLL1Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3ccc44440a07969a5737dd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 19 Aug 2020 06:52:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EBD19C433CA; Wed, 19 Aug 2020 06:52:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32F49C433C6;
        Wed, 19 Aug 2020 06:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32F49C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers-next tree
References: <20200819083359.67f45112@canb.auug.org.au>
Date:   Wed, 19 Aug 2020 09:52:47 +0300
In-Reply-To: <20200819083359.67f45112@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 19 Aug 2020 08:33:59 +1000")
Message-ID: <87y2mbi0u8.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> In commit
>
>   3b9fb6791e71 ("wcn36xx: Fix reported 802.11n rx_highest rate wcn3660/wcn3680")
>
> Fixes tag
>
>   Fixes: 8e84c2582169 ("wcn36xx: mac80211 driver for Qualcomm WCN3660/WCN3680
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more that one line.  Also, keep all
> the commit message tags together at the end of the message.

Doh, I have checked carefully the commit ids but of course I missed
checking the trailing. I really need to automate this. Stephen, are your
scripts checking these available somewhere?

But I'll leave this as is, no point of rebasing just because of this.
Thanks for the report.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
