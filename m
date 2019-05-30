Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196982FACF
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE3LW6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 07:22:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3LW6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 07:22:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63D0260A33; Thu, 30 May 2019 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559215377;
        bh=47ymiYIkobMeFci27erzsKJ1pSwLy75eawLOiymclzE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n/8lwSep4mSpJny4UMWsUZOrG1RUYNAzv4mnEWQEQ3sFzfZCXnnvhORHVkEizTsDu
         ifOaj+xPmnQz+tYCvZe5A9g+f27X2A3saUwcIUEt5GBapfc/RxzUmzyOq3K5Vts3E1
         kkw0penauJzYZki1W/r44gyOnq0l55wPwaejmNa8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6E714607CA;
        Thu, 30 May 2019 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559215376;
        bh=47ymiYIkobMeFci27erzsKJ1pSwLy75eawLOiymclzE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Er2gshbuwi98mx5dZQR76t/T1KWifWB/TUZV0k/rKq2uQ0CuwvqaK/Pp9P7NqCqVW
         gBHWpkssZkhxBxBCSafhL5WzZ92CjChIK1Ya6EOUtRFzHqvnTEjLeTbRGqntvKfEhZ
         K6eWqTu2adUeJQz6SFBkvjediPppn6TSdc3pDt7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E714607CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] mwifiex: Fix possible buffer overflows at parsing bss
 descriptor
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190529125220.17066-2-tiwai@suse.de>
References: <20190529125220.17066-2-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>, huangwen@venustech.com.cn,
        Solar Designer <solar@openwall.com>,
        Marcus Meissner <meissner@suse.de>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190530112257.63D0260A33@smtp.codeaurora.org>
Date:   Thu, 30 May 2019 11:22:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:

> mwifiex_update_bss_desc_with_ie() calls memcpy() unconditionally in
> a couple places without checking the destination size.  Since the
> source is given from user-space, this may trigger a heap buffer
> overflow.
> 
> Fix it by putting the length check before performing memcpy().
> 
> This fix addresses CVE-2019-3846.
> 
> Reported-by: huangwen <huangwen@venustech.com.cn>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

2 patches applied to wireless-drivers.git, thanks.

13ec7f10b87f mwifiex: Fix possible buffer overflows at parsing bss descriptor
685c9b7750bf mwifiex: Abort at too short BSS descriptor element

-- 
https://patchwork.kernel.org/patch/10967049/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

