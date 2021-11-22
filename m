Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94324594DD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 19:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhKVSpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 13:45:43 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:54815 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhKVSpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 13:45:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637606555; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Vf12YfEr3RfYVNwiANWBbpXbDvN1D0+Z3EQLyzSciHE=;
 b=G9HBD61YLplELxYzotnNIM1jIR6ofq6pmwXTCIaRVPLxTf1/EBKhmtOS0T4ZfdbjsGA62HiV
 DzZZZyKRIMXd79hvzZ3NWUjJTEsXkP0k24MVIbb4/wMdeCNPW12LJCov2xCNuLzYKv9HKk6k
 En7B2RXE97t/Ci+32EAlZlHXaGE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 619be49adb3ac5552acc0d12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Nov 2021 18:42:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C43DDC4360C; Mon, 22 Nov 2021 18:42:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2AF7C4338F;
        Mon, 22 Nov 2021 18:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org F2AF7C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] rtw89: update partition size of firmware header on
 skb->data
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211119054512.10620-2-pkshih@realtek.com>
References: <20211119054512.10620-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163760654946.7371.10993435866062669169.kvalo@codeaurora.org>
Date:   Mon, 22 Nov 2021 18:42:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The partition size is used to tell hardware the size of piece we are going
> to send a firmware. The old code updates the size in constant buffer of
> firmware, and leads system crash.
> 
> To fix this, update the size on skb->data after we copy the firmware data
> into skb.
> 
> Buglink: https://bugzilla.opensuse.org/show_bug.cgi?id=1188303
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers.git, thanks.

5737b4515dee rtw89: update partition size of firmware header on skb->data

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211119054512.10620-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

