Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E265B45F146
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353727AbhKZQJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:09:45 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:12200 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhKZQHp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:07:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637942672; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=72Jn51EJNAech/2ThbEgA8eIv+7lDd1/UWa1dZkm+Fg=;
 b=PVXNMl7ai7yBjICXWYDp98oErqVqcEESDLREOyM9PO8BiU08L/YaoURuMnX54as978S8rKjS
 j6kryMrLyWFrYQEJgfoPRhZU5uHjZAjs3BReY4vPykd0RlgAq4vihMembvZrvv47BE5dtUlE
 6h2Or//NYh7w6LzjQB4jiJjqiAI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61a1058f135a8a9d0e8518e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:04:31
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6314C43618; Fri, 26 Nov 2021 16:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B94E8C4360C;
        Fri, 26 Nov 2021 16:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B94E8C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/3] rtw89: add const in the cast of le32_get_bits()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211119054512.10620-3-pkshih@realtek.com>
References: <20211119054512.10620-3-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794266430.10370.12782593167544053248.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:04:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add 'const' to be clear that this is a read-only access, and this patch
> doesn't change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Depends on:

5737b4515dee rtw89: update partition size of firmware header on skb->data

Currently in wireless-drivers.

2 patches set to Awaiting Upstream.

12628209 [v3,2/3] rtw89: add const in the cast of le32_get_bits()
12628211 [v3,3/3] rtw89: use inline function instead macro to set H2C and CAM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211119054512.10620-3-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

