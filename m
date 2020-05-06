Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718FF1C68D3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 08:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgEFGXs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 02:23:48 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:22480 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbgEFGWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 02:22:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588746157; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=60oP9wHZnPrs7sG+thMx25zDJpy0cHBG0Z9+FMFHpCA=;
 b=NfMzATC+I9goSMQWlym/JQ2TKBTsClinmU+AF6jf7/pdVN9diIludqbkXYpue9pZQxomK5Qu
 tACLC86TK9+vXjPzAg0BE2NAklGMFEN8C/Z9PjtUbUtLGDrklEQqzcCRWMIo66f3//o65rjq
 e78hPin0VpBzDxg7gTW/rFRd7z4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb257ac.7f8a4a017a40-smtp-out-n04;
 Wed, 06 May 2020 06:22:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B58CC44795; Wed,  6 May 2020 06:22:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 273E0C4478F;
        Wed,  6 May 2020 06:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 273E0C4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k_htc: Silence undersized packet warnings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200504214443.4485-1-masashi.honma@gmail.com>
References: <20200504214443.4485-1-masashi.honma@gmail.com>
To:     Masashi Honma <masashi.honma@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        pro.denis@protonmail.com, Masashi Honma <masashi.honma@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200506062236.1B58CC44795@smtp.codeaurora.org>
Date:   Wed,  6 May 2020 06:22:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Masashi Honma <masashi.honma@gmail.com> wrote:

> Some devices like TP-Link TL-WN722N produces this kind of messages
> frequently.
> 
> kernel: ath: phy0: Short RX data len, dropping (dlen: 4)
> 
> This warning is useful for developers to recognize that the device
> (Wi-Fi dongle or USB hub etc) is noisy but not for general users. So
> this patch make this warning to debug message.
> 
> Reported-By: Denis <pro.denis@protonmail.com>
> Ref: https://bugzilla.kernel.org/show_bug.cgi?id=207539
> Fixes: cd486e627e67 ("ath9k_htc: Discard undersized packets")
> Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

450edd280598 ath9k_htc: Silence undersized packet warnings

-- 
https://patchwork.kernel.org/patch/11527651/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
