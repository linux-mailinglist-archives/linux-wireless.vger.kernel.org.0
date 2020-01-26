Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E086C149B20
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 15:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAZOf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 09:35:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:35404 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgAZOf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 09:35:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580049357; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=t7GEreyimqz+onC7IYF2cJNL2S8W+cvNN+3KSxgRQuc=;
 b=c48wUBcMaXTIwGRUfajdG8RTYnebAwS/C9NP3ZquKV15yVGiQiqgxYljYz97c4bri6VjgH1z
 UnOvWQYUzodt+SPUdGA5VK9O/gxxz2/S4la7vZKAr+35j9+NRptdwLrlgiokGIE7N/ezb1v/
 BaD3Atqhi2J5XlKvKHxlwFo58c8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2da3cb.7f1953a0ed18-smtp-out-n02;
 Sun, 26 Jan 2020 14:35:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A630C43383; Sun, 26 Jan 2020 14:35:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18E51C433CB;
        Sun, 26 Jan 2020 14:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18E51C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ar5523: Add USB ID of SMCWUSBT-G2 wireless adapter
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200116111125.28915-1-mertdirik@gmail.com>
References: <20200116111125.28915-1-mertdirik@gmail.com>
To:     Mert Dirik <mertdirik@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Pontus Fuchs <pontus.fuchs@gmail.com>,
        Mert Dirik <mertdirik@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200126143554.6A630C43383@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 14:35:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Mert Dirik <mertdirik@gmail.com> wrote:

> Add the required USB ID for running SMCWUSBT-G2 wireless adapter (SMC
> "EZ Connect g").
> 
> This device uses ar5523 chipset and requires firmware to be loaded. Even
> though pid of the device is 4507, this patch adds it as 4506 so that
> AR5523_DEVICE_UG macro can set the AR5523_FLAG_PRE_FIRMWARE flag for pid
> 4507.
> 
> Signed-off-by: Mert Dirik <mertdirik@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

5b362498a796 ar5523: Add USB ID of SMCWUSBT-G2 wireless adapter

-- 
https://patchwork.kernel.org/patch/11336579/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
