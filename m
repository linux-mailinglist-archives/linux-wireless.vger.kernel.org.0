Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F038FB0B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 08:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhEYGkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 02:40:09 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:51074 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhEYGkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 02:40:07 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8467D80CC;
        Mon, 24 May 2021 23:38:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8467D80CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1621924717;
        bh=9ReqCI5p1XC/LQvadcWaVcnKjPwThCMssaKZwL+1rFk=;
        h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
        b=WUIf5kokbdFml3MMrTeYAvyt7XW1y3DilgX6A2cdTfF+wG3ST0TRuy9Rn22wUgbAP
         rq8jwEzXrTrUSLI58W+AfGQIRwN+WeOgrRPGBOA1+CpeTWsGl7ECLKvRaKw3itaYrc
         jH31yjNnpek8xInMI6tj2j204qnkBWzHiP7nXmhw=
Received: from [10.230.41.88] (unknown [10.230.41.88])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 9F1241874BE;
        Mon, 24 May 2021 23:38:36 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 5.4 39/52] brcmfmac: properly check for bus
 register errors
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210524144903.2498518-1-sashal@kernel.org>
 <20210524144903.2498518-39-sashal@kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Message-ID: <437445ee-a360-597f-f058-3b913984e064@broadcom.com>
Date:   Tue, 25 May 2021 08:38:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524144903.2498518-39-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/24/2021 4:48 PM, Sasha Levin wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [ Upstream commit 419b4a142a7ece36cebcd434f8ce2af59ef94b85 ]
> 
> The brcmfmac driver ignores any errors on initialization with the
> different busses by deferring the initialization to a workqueue and
> ignoring all possible errors that might happen.  Fix up all of this by
> only allowing the module to load if all bus registering worked properly.

Hi Greg,

Saw this one flying by for stable kernel. Actually the first time I saw 
this patch, because I don't follow LKML as much as linux-wireless. The 
patch is fine, but wanted to give some context on the workqueue 
approach. It was there for historic reasons. Back then we had the UMH to 
provide firmware loading and because we request firmware during driver 
probe we could cause kernel boot to show significant delay when driver 
was built-in. Hence the workqueue which allowed kernel boot to proceed 
and driver probe was running in another thread context. These days we 
have direct firmware loading from the kernel and brcmfmac uses the 
asynchronous firmware loading API so there is indeed no longer a need 
for the workqueue.

Just for my understanding could you explain the motivation behind this 
change. In the preceding revert patch I saw this remark:

"""
The original commit here did nothing to actually help if usb_register()
failed, so it gives a "false sense of security" when there is none.  The
correct solution is to correctly unwind from this error.
"""

Does this mean the patch is addressing some security issue. Before your 
patch the module would remain loaded despite a bus register failure. I 
guess there is a story behind this that I am curious about.

Regards,
Arend

> Cc: Kalle Valo <kvalo@codeaurora.org>
> Link: https://lore.kernel.org/r/20210503115736.2104747-70-gregkh@linuxfoundation.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  8 +---
>   .../broadcom/brcm80211/brcmfmac/bus.h         | 19 ++++++++-
>   .../broadcom/brcm80211/brcmfmac/core.c        | 42 ++++++++-----------
>   .../broadcom/brcm80211/brcmfmac/pcie.c        |  9 +---
>   .../broadcom/brcm80211/brcmfmac/pcie.h        |  5 ---
>   .../broadcom/brcm80211/brcmfmac/usb.c         |  4 +-
>   6 files changed, 41 insertions(+), 46 deletions(-)
