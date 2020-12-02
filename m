Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3B2CC698
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbgLBTZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:25:34 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:63655 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbgLBTZe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:25:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606937114; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=O0ptRWRkKU36smFGsQvk3tOR7PLYF2sCk+8S4x4jg6M=;
 b=igs+F2VTiratW6FWKYiakBwkmzrAbGQNX9u3hGHOfhZBKrro/JWAWcu9anU6qulQsqm39sqd
 D+YRXvmFjFYC5PiEKG+LCCXRGWGalhX4Z8lx6/UamjQ7KyymyI4xXuLhmARZbAf1Wf7CJlJS
 36SwYdWSPLnWGCwhqWU3QihtFUI=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fc7e9ff4a918fcc07ad9edc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:24:47
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EA67EC43461; Wed,  2 Dec 2020 19:24:46 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E63B4C433C6;
        Wed,  2 Dec 2020 19:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E63B4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/10] rtw88: coex: run coexistence when WLAN
 entering/leaving LPS
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201126021059.11981-2-pkshih@realtek.com>
References: <20201126021059.11981-2-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202192446.EA67EC43461@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:24:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> When WLAN entering or leaving, it's necessary to run coexistence mechanism
> to ensure the setting matched current status.
> Without calling rtw_coex_run_coex(), WLAN poor throughput or bad A2DP
> quality may happen.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patches applied to wireless-drivers-next.git, thanks.

1329c0dbd485 rtw88: coex: run coexistence when WLAN entering/leaving LPS
1a589bd5be92 rtw88: coex: add debug message
76f631cb401f rtw88: coex: update the mechanism for A2DP + PAN
4d0087e763a8 rtw88: coex: update AFH information while in free-run mode
6a910a2a7d5d rtw88: coex: change the coexistence mechanism for HID
c404dbd4fbfc rtw88: coex: change the coexistence mechanism for WLAN connected
8e6947dcb95d rtw88: coex: add function to avoid cck lock
79d06b20d00b rtw88: coex: add action for coexistence in hardware initial
1a74daed6cef rtw88: coex: upgrade coexistence A2DP mechanism
5b2e9a35e456 rtw88: coex: add feature to enhance HID coexistence performance

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201126021059.11981-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

