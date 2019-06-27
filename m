Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A93D5893D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfF0RrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:47:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfF0RrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:47:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3FE25602F4; Thu, 27 Jun 2019 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657640;
        bh=93h5ucWKnjebqgnyo9qwcQbfcwMVTlGOyy79/6hwPmA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FW7o1oL+XivN3qkf1HZyb7Jmo+WYURWvmEJeALM2KsSmGrb9PxT2m1u9mAKttP7AX
         r1sWvfwp1E9BxAhXa76tqTrs5jwgth3BWT3cLWqj/FqMLRz1Lga+W1UoxGkE13WJnq
         Uv3/+5YiXINSmQIbHxGjezSpQAlTXT0mobmW3LPQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F90F6016D;
        Thu, 27 Jun 2019 17:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657639;
        bh=93h5ucWKnjebqgnyo9qwcQbfcwMVTlGOyy79/6hwPmA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=WwkFBCxtt2qhe/d8479dEVmxTsGKBF2XGy+7GoM/LmAeI2pQ1jCJiRySMH019FNzu
         NWdzvs3dhH7nKmYkSg1iSECCM56V0/OxJAOasta5BE+sC/RBKnX2+zT1o0xMyPHHNA
         QVgUHeKqIv4+N4AjIaY5qWCkgr/W+wfbPvlgHQzA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F90F6016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] carl9170: fix misuse of device driver API
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190608144947.744-3-chunkeey@gmail.com>
References: <20190608144947.744-3-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627174720.3FE25602F4@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:47:20 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch follows Alan Stern's recent patch:
> "p54: Fix race between disconnect and firmware loading"
> 
> that overhauled carl9170 buggy firmware loading and driver
> unbinding procedures.
> 
> Since the carl9170 code was adapted from p54 it uses the
> same functions and is likely to have the same problem, but
> it's just that the syzbot hasn't reproduce them (yet).
> 
> a summary from the changes (copied from the p54 patch):
>  * Call usb_driver_release_interface() rather than
>    device_release_driver().
> 
>  * Lock udev (the interface's parent) before unbinding the
>    driver instead of locking udev->parent.
> 
>  * During the firmware loading process, take a reference
>    to the USB interface instead of the USB device.
> 
>  * Don't take an unnecessary reference to the device during
>    probe (and then don't drop it during disconnect).
> 
> and
> 
>  * Make sure to prevent use-after-free bugs by explicitly
>    setting the driver context to NULL after signaling the
>    completion.
> 
> Cc: <stable@vger.kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

feb09b293327 carl9170: fix misuse of device driver API

-- 
https://patchwork.kernel.org/patch/10983223/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

