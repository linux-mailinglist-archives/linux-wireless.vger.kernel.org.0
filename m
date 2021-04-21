Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3456366849
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbhDUJlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 05:41:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64486 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhDUJlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 05:41:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618998050; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=83TxWCLKD6lFDzpoyeLqoddy/amLuZE5/WldNfLsbfM=;
 b=evssq7sGcXLS83ug4g3E4OCVFd1MsaIcpcM1JesA/sV0OapEoj8xyeE86b2Hrhm0ddidVzpY
 5sSBI57rA6mVVa3hltnIl/+olrUGPzl8FwQ62GvBoGuZx0PkeAjwk1QPC+X97Mhbzdxf4VVa
 UkbVbwmtbcHa/8IqVWwFatGvUy8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607ff320a817abd39aaa0ce2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 09:40:48
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10D46C43460; Wed, 21 Apr 2021 09:40:48 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71466C433F1;
        Wed, 21 Apr 2021 09:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71466C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: implement set_tim by update beacon content
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210419065956.6085-1-pkshih@realtek.com>
References: <20210419065956.6085-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <mail@maciej.szmigiero.name>,
        <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210421094048.10D46C43460@smtp.codeaurora.org>
Date:   Wed, 21 Apr 2021 09:40:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Once beacon content is changed, we update the content to wifi card by
> send_beacon_frame(). Then, STA with PS can wake up properly to receive its
> packets.
> 
> Since we update beacon content to PCI wifi devices every beacon interval,
> the only one usb device, 8192CU, needs to update beacon content when
> mac80211 calling set_tim.
> 
> Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Patch applied to wireless-drivers-next.git, thanks.

afda33499bea rtlwifi: implement set_tim by update beacon content

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210419065956.6085-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

