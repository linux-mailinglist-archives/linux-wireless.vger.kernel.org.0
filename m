Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9845F1C3
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbhKZQ0J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:26:09 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:39387 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhKZQYJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:24:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637943656; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=c3bmYoIA25RasimTxdzYwROg0K48DKwdRSMCDiUorMM=;
 b=nl1manYRvcjnqmcqYkWnmmWAQaMZkhTiOO668bEIV8o1rWynfboQmVtp5Zsng5dYjDBRw9Um
 lmXJHh1c8fjspeLwA7kzQnRleZcM3CuUnCCyug6vPy/5+UYY7RnkbVqNhFv0/r/U7d8vwCoo
 Hg/N7FGCIPl9APYZ+I5n9jqttmY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61a109634fca5da46d8b757b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:20:51
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B3F4C43618; Fri, 26 Nov 2021 16:20:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3C89C4338F;
        Fri, 26 Nov 2021 16:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E3C89C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: add quirk to disable pci caps on HP 250 G7
 Notebook PC
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211119052437.8671-1-pkshih@realtek.com>
References: <20211119052437.8671-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <rtl8821cerfe2@protonmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794364821.10370.16121080855905942170.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:20:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8821CE causes random freezes on HP 250 G7 Notebook PC. Add a quirk
> to disable pci ASPM capability.
> 
> Reported-by: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

c81edb8dddaa rtw88: add quirk to disable pci caps on HP 250 G7 Notebook PC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211119052437.8671-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

