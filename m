Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8235B2C20FC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 10:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgKXJRd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 04:17:33 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:23750 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgKXJRc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 04:17:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606209452; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=U2eifR8MvJfHIYH2gGf4nyN+jzzNFszTNjxEhcvnKF8=;
 b=bjRZPh+CqLBwuczcgSjNJl/t+EzNRieskbv+WItaj87vqrDOn22SUN+kNrCO92LzbB8g/oV2
 OSlWh8kif7HrgNE2ko9fYLoS0P+QInhFwXIodUFIiuvePDpM3od7ATyBPofga/lvl4ePUEED
 K3OKxIhHWIkbBSg4ShdBtwX47V4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fbccfa74146c5eefde2157f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 09:17:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10DE9C43460; Tue, 24 Nov 2020 09:17:27 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66BC8C433C6;
        Tue, 24 Nov 2020 09:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66BC8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/11] rtw88: coex: update TDMA settings for different
 beacon interval
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201112031430.4846-2-pkshih@realtek.com>
References: <20201112031430.4846-2-pkshih@realtek.com>
To:     <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124091727.10DE9C43460@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 09:17:27 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> Add considering for different WLAN beacon interval in coexistence
> mechanism.
> Because the WLAN beacon period may be not 100 ms, so it's necessary
> to consider any beacon period and set timer according to the interval.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-drivers-next.git, thanks.

7ed9e062178d rtw88: coex: update TDMA settings for different beacon interval
ca30905b1d6a rtw88: coex: remove unnecessary feature/function
513fb27f6a52 rtw88: coex: add write scoreboard action when WLAN in critical procedure
3a6616f96624 rtw88: coex: Add force flag for coexistence table function
a9359faaa47d rtw88: coex: add the mechanism for RF4CE
22a9dc720f10 rtw88: coex: update the TDMA parameter when leave LPS
65c6861f6382 rtw88: coex: Change antenna setting to enhance free-run performance
e098c3c3314e rtw88: coex: fix BT performance drop during initial/power-on step
72b14be75111 rtw88: coex: remove write scan bit to scoreboard in scan and connect notify
2485bc7c7816 rtw88: coex: remove unnecessary WLAN slot extend
362c4a5cc886 rtw88: coex: change the decode method from firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201112031430.4846-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

