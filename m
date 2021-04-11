Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC23635B299
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhDKJVZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:21:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21797 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbhDKJVY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:21:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618132868; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Z2pJg7o6eMIfi67JhpuNWUdhDbh2LdhKkw6o23FMepc=;
 b=jQ3QO5Lg8MvGiDlp12kHLmP2Ea4iL+C4rfAXn6YFU5uYjjPPWSdXSH1qNT+6/YvD0+dgPiQQ
 N819qtVuKnHd13j6+xKCueV83iTGs/p/D+UYh8a9mhrN8d2aY3qD88p6qpJukBwWYN1fqNyO
 ys0oyt7S6zk6BMHw3o/PhY5dtDU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6072bf7f03cfff34522edfe7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 11 Apr 2021 09:21:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40EE7C43461; Sun, 11 Apr 2021 09:21:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D562CC433CA;
        Sun, 11 Apr 2021 09:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D562CC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210319054218.3319-3-pkshih@realtek.com>
References: <20210319054218.3319-3-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <ku920601@realtek.com>, <phhuang@realtek.com>,
        <shaofu@realtek.com>, <steventing@realtek.com>,
        <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210411092102.40EE7C43461@smtp.codeaurora.org>
Date:   Sun, 11 Apr 2021 09:21:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Shao-Fu Cheng <shaofu@realtek.com>
> 
> By default the driver uses the 1M and 6M rate for managemnt frames
> in 2G and 5G bands respectively. But when the basic rates is configured
> from the mac80211, we need to send the management frames according the
> basic rates.
> 
> This commit makes the driver use the lowest basic rates to send
> the management frames and a debufs entry to enable/disable force to use
> the lowest rate 1M/6M for 2.4G/5G bands.
> 
> obtain current setting
> cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> 
> force lowest rate:
> echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates
> 
> Signed-off-by: Shao-Fu Cheng <shaofu@realtek.com>
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Why is a debugfs interface needed?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210319054218.3319-3-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

