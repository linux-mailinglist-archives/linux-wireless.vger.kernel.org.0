Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431692AEC1C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 09:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKKIeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 03:34:15 -0500
Received: from z5.mailgun.us ([104.130.96.5]:44779 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgKKIeO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 03:34:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605083654; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GUOFDX4wFTT95fTeoX2pyCxY4DS+cStbW6J1wHebktw=; b=JVvhRkr9A+GMyA4AXvjyx7HEaSmylEmcskaGeIauUv/Hjy5PYObbG+stHHotkz9lvF7m7mxi
 hJGJUmkEq/hZ/ziuCC13boWDXl/jLba7CZE4vmX/fK41CiaJ+7WITPlBSqi8VtaboLZ5wDkY
 +88Fesu2NDt+Tip8pOjkVhfwLfQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5faba20540d4446125e8d5f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 08:34:13
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83D6BC433CB; Wed, 11 Nov 2020 08:34:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB3CBC433C9;
        Wed, 11 Nov 2020 08:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB3CBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 01/11] rtw88: coex: update TDMA settings for different beacon interval
References: <20201111022108.9834-1-pkshih@realtek.com>
        <20201111022108.9834-2-pkshih@realtek.com>
Date:   Wed, 11 Nov 2020 10:34:09 +0200
In-Reply-To: <20201111022108.9834-2-pkshih@realtek.com> (pkshih@realtek.com's
        message of "Wed, 11 Nov 2020 10:20:58 +0800")
Message-ID: <875z6ccmwu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> writes:

> From: Ching-Te Ku <ku920601@realtek.com>
>
> Add considering for different WLAN beacon interval in coexistence
> mechanism.
> Because the WLAN beacon period may be not 100 ms, so it's necessary
> to consider any beacon period and set timer according to the interval.
>
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +	} else if (tbtt_interval < 80 && tbtt_interval > 0) {
> +		para[1] = (100 / tbtt_interval);
> +
> +		if (100 % tbtt_interval != 0)
> +			para[1] = para[1] + 1;
> +
> +		para[1] = para[1] & 0x3f;
> +	} else if (tbtt_interval >= 180) {
> +		para[1] = (tbtt_interval / 100);
> +
> +		if (tbtt_interval % 100 <= 80)
> +			para[1] = para[1] - 1;
> +
> +		para[1] = para[1] & 0x3f;
> +		para[1] = para[1] | 0x80;

Magic numbers 0x3f and 0x80, GENMASK() & FIELD_PREP() is the modern way
to handle bitmasks like these. And there's also the operator '|='

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
