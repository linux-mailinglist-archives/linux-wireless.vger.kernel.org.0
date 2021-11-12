Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9041044E1CF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 07:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhKLGUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 01:20:09 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:35173 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhKLGUI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 01:20:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636697838; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=T0IC6bwzjwZCAe3cbVI66frgAwrZCsj/mcn5Gv5QDb0=; b=CxzDZM9E8SB0oTvipqafOXuEox5HKkomUN/sDjcUKwz0/irJRVEl5ZTtp5lMzFYpkebA4WsI
 ixkU83vwJ8jxh9o407nTADsLBn9Lng9EPGEZVIkHXzFlpnEXdxJyRZPWGheVlkK99p07vzxB
 mPTXzQw9p5RsuAtuwW5fhq6Ayi0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 618e06e7d8b69943a3fdbc09 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 06:17:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5AF9C4360D; Fri, 12 Nov 2021 06:17:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE839C43460;
        Fri, 12 Nov 2021 06:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AE839C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <tiwai@suse.de>,
        <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2 0/3] rtw89: fix crash when loading firmware file on certain platforms
References: <20211112003453.5073-1-pkshih@realtek.com>
Date:   Fri, 12 Nov 2021 08:17:04 +0200
In-Reply-To: <20211112003453.5073-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 12 Nov 2021 08:34:50 +0800")
Message-ID: <878rxtnbj3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> First patch is to avoid writing "partition size" on read-only firmware
> buffer, so it has to fix the crash.
> The later two patches are used to make the semantics clear, but they don't
> change the logic at all.
>
> I hope at least first patch can be taken into 5.16-rc, so people can avoid
> this crash.
>
> v2: Add Buglink and Tested-by tags.
>
> Ping-Ke Shih (3):
>   rtw89: update partition size of firmware header on skb->data
>   rtw89: add const in the cast of le32_get_bits()
>   rtw89: use inline function instead macro to set H2C and CAM
>
>  drivers/net/wireless/realtek/rtw89/cam.h  |  468 ++++--
>  drivers/net/wireless/realtek/rtw89/fw.c   |    2 +-
>  drivers/net/wireless/realtek/rtw89/fw.h   | 1768 ++++++++++++---------
>  drivers/net/wireless/realtek/rtw89/txrx.h |   46 +-
>  4 files changed, 1370 insertions(+), 914 deletions(-)

Patch 1 should definitely go to wireless-drivers to fix the crash. But
I'm not sure about patches 2-3, they are quite large, and more like
cleanup than fixes, so wireless-drivers-next sounds more approriate to
me. But I can't decide, any thoughts on this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
