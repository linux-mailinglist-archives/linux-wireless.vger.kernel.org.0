Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397541B53CD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2020 06:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgDWEsZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Apr 2020 00:48:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:61597 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgDWEsZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Apr 2020 00:48:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587617304; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4KqW80Lk34D6SHlMevxI8P0z8deukEKe164/XcUP/xk=;
 b=id7Duc98HJ5/bxCoQov6x6fk7XP8fRb0NUoFokLLlzcQ9rWPbMKkfL0NrGvZmF84B8JRNaop
 VRv5lNdasuGFpk5uJtkL7uMxIUgRjRSJa3jNqzcauoBt3I7KU/PZGnKJ90wdwDHAi4hTgUzP
 0mVnm+danqAr7QbQ6qE7Zkg5d/8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea11e17.7f804ab4a6f8-smtp-out-n02;
 Thu, 23 Apr 2020 04:48:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42DD9C433F2; Thu, 23 Apr 2020 04:48:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F29AFC433CB;
        Thu, 23 Apr 2020 04:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F29AFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/8] rtw88: add legacy firmware download for 8723D devices
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200422034607.28747-2-yhchuang@realtek.com>
References: <20200422034607.28747-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200423044823.42DD9C433F2@smtp.codeaurora.org>
Date:   Thu, 23 Apr 2020 04:48:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> The WLAN CPU of 8723D device is different from others, add legacy
> firmware download function for it. A new variable wlan_cpu is used to
> decide which firmware download function we should use.
> 
> Legacy firmware file contains 32 bytes header including version and
> subversion. When downloading to wlan cpu, header is excluded.
> 
> Firmware is downloaded via beacon queue to reserved page that is a part of
> TX buffer. Since 11N WLAN CPU uses different control registers, this patch
> introduces related control registers.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

8 patches applied to wireless-drivers-next.git, thanks.

15d2fcc6b2de rtw88: add legacy firmware download for 8723D devices
e5f57ad06ade rtw88: no need to send additional information to legacy firmware
4e223a5f5342 rtw88: 8723d: Add mac power-on/-off function
fd9ead385102 rtw88: decompose while(1) loop of power sequence polling command
7907b52de08a rtw88: 8723d: 11N chips don't support H2C queue
ba9f0d1b8d9d rtw88: 8723d: implement set_tx_power_index ops
d91277de2331 rtw88: 8723d: Organize chip TX/RX FIFO
75e69fb11b40 rtw88: 8723d: initialize mac/bb/rf basic functions

-- 
https://patchwork.kernel.org/patch/11502789/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
