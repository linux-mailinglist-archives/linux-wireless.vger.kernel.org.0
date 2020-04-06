Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBB19F168
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgDFIRB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 04:17:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58630 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgDFIRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 04:17:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586161021; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=9AlLCDu22gprCdXxbPGP+WMxLSZT+YaNsS8ys1Tod5s=; b=smZa3ETpzpD4PTQLFixOA+cLtN4tkQwnL/TaeXtLWYWTV7xxF0DBGVsqQx1K0Mv7U1Sw/gKR
 QslH9xudCGAi5yVYpr5kYsuD+wp0ae7KWp1SDcg3BX8DVELnPxXMsIgyDvLhvcUa6XYXYz7M
 /q/6qypOhr2u7pNaVVH9Fzyp0cs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8ae57b.7f338eea2ed8-smtp-out-n01;
 Mon, 06 Apr 2020 08:16:59 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEACAC433D2; Mon,  6 Apr 2020 08:16:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEC61C433F2;
        Mon,  6 Apr 2020 08:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEC61C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <timlee@realtek.com>
Subject: Re: [PATCH] rtw88: add more check for wowlan pattern
References: <20200406074705.25022-1-yhchuang@realtek.com>
Date:   Mon, 06 Apr 2020 11:16:54 +0300
In-Reply-To: <20200406074705.25022-1-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Mon, 6 Apr 2020 15:47:05 +0800")
Message-ID: <87eet1f2q1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Chin-Yen Lee <timlee@realtek.com>
>
> Previously the mask of wowlan pattern is not checked,
> and it may lead to wrong pattern match. We fix it and
> add wildcard type for the pattern whose DA is not masked.
> Besides, if user pattern is an invalid type for us,
> show the error in kernel log, and then wowlan will
> not work.
>
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static inline void ether_addr_copy_mask(u8 *dst, const u8 *src, u8 mask)
> +{
> +	int i;
> +
> +	eth_zero_addr(dst);
> +	for (i = 0; i < ETH_ALEN; i++) {
> +		if (mask & BIT(i))
> +			dst[i] = src[i];
> +	}
> +}

You should not use ether_ prefix within a driver, that is for
include/linux/etherdevice.h. But as you call this only from one place I
recommend just moving the code there and not using a separate function
at all.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
