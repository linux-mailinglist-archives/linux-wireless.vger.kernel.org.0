Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069442ADEEE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 19:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKJS7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 13:59:37 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46472 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgKJS7h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 13:59:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605034776; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1019T1WbqeaNKvhLZV10I4fMKt64g7PeO8bXUK4CIo4=;
 b=cr4YsBK/B20WHhEX+z+RrjJ4pMmcsiOqMnXpNFUWNzLkJOii3gdUOtiQtu2X99hzCi6qb/T4
 6G2u/bFslifgnDYEyW0T7zlXxg8tAJVU0ppJlI00KKpvJ9l0zt1q1IxUxlh06/vSoM8ZBs0z
 xA/8n8lr+lBBRBCCnKLXXpZXj3c=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5faae2ff40d44461257a806d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 18:59:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C8B03C433C6; Tue, 10 Nov 2020 18:59:11 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66337C433C8;
        Tue, 10 Nov 2020 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66337C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/11] rtw88: coex: fixed some wrong register
 definition
 and setting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201109085909.9143-2-pkshih@realtek.com>
References: <20201109085909.9143-2-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201110185911.C8B03C433C6@smtp.codeaurora.org>
Date:   Tue, 10 Nov 2020 18:59:11 +0000 (UTC)
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

11 patches applied to wireless-drivers-next.git, thanks.

3f3fef5f6a8f rtw88: coex: fixed some wrong register definition and setting
19ecd61d2c3c rtw88: coex: update coex parameter to improve A2DP quality
1d82c49764aa rtw88: coex: reduce magic number
d8350768d629 rtw88: coex: coding style adjustment
ae8732d7673d rtw88: coex: Modify the timing of set_ant_path/set_rf_para
32c3a8c7d91f rtw88: coex: add separate flag for manual control
37a59b940fc6 rtw88: coex: modified for BT info notify
150ce8e34a45 rtw88: coex: change the parameter for A2DP when WLAN connecting
ec06c4adac96 rtw88: coex: update WLAN 5G AFH parameter for 8822b
21020fc80d3b rtw88: coex: add debug message
1ccaa898868d rtw88: coex: simplify the setting and condition about WLAN TX limitation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201109085909.9143-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

