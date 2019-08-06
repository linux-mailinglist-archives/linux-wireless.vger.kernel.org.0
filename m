Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248778319C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfHFMoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:44:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:44:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8A496038E; Tue,  6 Aug 2019 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095448;
        bh=HAu7TsW0Iie3+5DrXvxcWN8iTVu6QAEL2sslX8UhT5k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lo8RqwlQE5Xi0nIj0VPa0UZ39EZ7qOVHWA4qL+17ZIPV1oi0tasFEzwjKhAVr9W7P
         AG9dsCg3IgIHL6rHGAwfXvdeb5zl01aSrEQIT0FP/jh0M3UGMn4efvjXoqdAfpAYQt
         JCUurAAd7ArIuFYWypYT2GzIaNQ6d73JrmziUF1c=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EDB960867;
        Tue,  6 Aug 2019 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095448;
        bh=HAu7TsW0Iie3+5DrXvxcWN8iTVu6QAEL2sslX8UhT5k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=RGc2qDdndYOY+tJhAqFvfznPJbOUNFNJLTIZtdJTACWHYqLt5heBo8w2IDXYmogtZ
         ibyCZrRLFye6jgs4SmRc+JJANJa3UFjI9WHDYJSvrSydrjfrXc5nEqubhN3V0Z4dZB
         XP1L/YwCUcHLqvAzcfurviqNbZP4JdTD1rZ9eHFs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EDB960867
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2] b43legacy: Remove pointless cond_resched() wrapper
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <alpine.DEB.2.21.1908021353190.3924@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908021353190.3924@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        b43-dev@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806124408.C8A496038E@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:44:08 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:

> cond_resched() can be used unconditionally. If CONFIG_PREEMPT is set, it
> becomes a NOP scheduler wise.
> 
> Also the B43_BUG_ON() in that wrapper is a homebrewn variant of
> __might_sleep() which is part of cond_resched() already.
> 
> Remove the cruft and invoke cond_resched() directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-drivers-next.git, thanks.

6004cf298a41 b43legacy: Remove pointless cond_resched() wrapper

-- 
https://patchwork.kernel.org/patch/11073225/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

