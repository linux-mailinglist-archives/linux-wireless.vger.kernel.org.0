Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662232AA641
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKGPdK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:33:10 -0500
Received: from z5.mailgun.us ([104.130.96.5]:63378 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKGPdJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:33:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604763189; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=/HjLwTFVNSyiKbAAD2rrUw6XKtQBkBZyzE0Wy/sWEyc=;
 b=Ue+24ajhCcqOZceb++BnjY53Lja9u1irkG2gnRi46fc7ldJ/QGzl6tWK87MxycH5LgJKt3CN
 YKJdJsZz4uFa5uSwKgRGXfMKm3tCla7jV0P7gGsxylv59Z5Wz9LQlQ+O4879HEESqH401rU4
 KmnbScMkYrRk6coj37po+ZUYgP4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fa6be2f82aad55dcb43a671 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:33:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E6639C433C6; Sat,  7 Nov 2020 15:33:02 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14CD8C433C8;
        Sat,  7 Nov 2020 15:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14CD8C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/11] rtw88: coex: fixed some wrong register
 definition
 and setting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201027021157.6116-2-pkshih@realtek.com>
References: <20201027021157.6116-2-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107153302.E6639C433C6@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:33:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Some register definition and bit definition were incorrect.
> e.g. REG_BT_COEX_V2 should be word alignment to meet the coding style.
> e.g. set REG_BT_TDMA_TIME[5:0]=0x5,
> But the original is to set REG_BT_TDMA_TIME[7:0]=0x5.
> This will cause unexpected hardware behavior.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Dropped per Ping's request.

11 patches set to Changes Requested.

11859259 [v2,01/11] rtw88: coex: fixed some wrong register definition and setting
11859261 [v2,02/11] rtw88: coex: update coex parameter to improve A2DP quality
11859265 [v2,03/11] rtw88: coex: reduce magic number
11859251 [v2,04/11] rtw88: coex: coding style adjustment
11859263 [v2,05/11] rtw88: coex: Modify the timing of set_ant_path/set_rf_para
11859257 [v2,06/11] rtw88: coex: add separate flag for manual control
11859267 [v2,07/11] rtw88: coex: modified for BT info notify
11859255 [v2,08/11] rtw88: coex: change the parameter for A2DP when WLAN connecting
11859249 [v2,09/11] rtw88: coex: update WLAN 5G AFH parameter for 8822b
11859269 [v2,10/11] rtw88: coex: add debug message
11859253 [v2,11/11] rtw88: coex: simplify the setting and condition about WLAN TX limitation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201027021157.6116-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

