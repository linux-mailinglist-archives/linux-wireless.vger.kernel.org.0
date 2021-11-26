Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1606A45F1BF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhKZQZl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:25:41 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:54886 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhKZQXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:23:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943628; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ZIPDAO9aal52DO6o4DiXOFWPKkGsFMo0Kvf2OkNiMHc=;
 b=cTqhz+wnP6+/w0i9wbu66xek2yU4CST+GTyeropKj4rh8pdmG8e0RSVzX/jPSlgpQv3iw+kK
 nxdRSpIY2GG8wsg1IiD6aES6OL4IXdD2qnY3+lEqgDJXuBrCLH4KXarGsfbFsu8CsyJx8hlV
 QZOUkmI5TuHwvy78AlFvIhA+SvQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61a1094b5daaeec797a9fe13 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:20:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F9C6C4360D; Fri, 26 Nov 2021 16:20:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E274EC4360C;
        Fri, 26 Nov 2021 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E274EC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/2] rtw88: follow the AP basic rates for tx mgmt frame
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211102022454.10944-1-pkshih@realtek.com>
References: <20211102022454.10944-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <steventing@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794362368.10370.8628497759556665859.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:20:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Yu-Yen Ting <steventing@realtek.com>
> 
> By default the driver uses the 1M and 6M rate for managemnt frames
> in 2G and 5G bands respectively. But when the basic rates is
> configured from the mac80211, we need to send the management frames
> according to the basic rates.
> 
> This commit makes the driver use the lowest basic rates to send
> the management frames.
> 
> Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

2f1367b564c1 rtw88: follow the AP basic rates for tx mgmt frame
272cda71e857 rtw88: add debugfs to force lowest basic rate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211102022454.10944-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

