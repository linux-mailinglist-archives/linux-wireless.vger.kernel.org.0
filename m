Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0A9F420D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 09:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKHI1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 03:27:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHI1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 03:27:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09A036087D; Fri,  8 Nov 2019 08:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573201643;
        bh=8dHJUXm+gkvbK8xd+vbY/KG2Jga+rtTuELCVO6DQqMA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bA8hFwKYwGpCVEd8CeZCk1fDD3m2sLQPhTrZVtt/Elp8wLt/7FY+nLAhz7FvBx/9j
         AOCKQok1EF/FKlUIiXIKBQaZodQ0l2HGpjYV8NLGZmwucFgUToZ/7eV9J42tWmndmU
         AYgLJsbZHdnbcQrV3+bOq24zZtCcpsDUhtXKWU/E=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B69C60300;
        Fri,  8 Nov 2019 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573201642;
        bh=8dHJUXm+gkvbK8xd+vbY/KG2Jga+rtTuELCVO6DQqMA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=LF4lyKEYVW2JjiznWhJVnxnxGhYgfo+hmX3HSjncSCTonRDMux/DsHZ7Slie5RiMg
         p2khwdru2HysZvqNHJjklv/A7WrqNnzFwJOY8FUN6qg5/Zsajg6EfyYs6DMJ/Hh5I2
         o10Pzrixzvfxed701XwN3HRZUcTqWUCvmt6Y/WWs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1B69C60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: signal completion even on firmware-request failure
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191106213055.133424-1-briannorris@chromium.org>
References: <20191106213055.133424-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191108082723.09A036087D@smtp.codeaurora.org>
Date:   Fri,  8 Nov 2019 08:27:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Otherwise, the waiters (e.g., "modprobe rtwpci") will block forever.
> 
> Fixes: f530c1961af2 ("rtw88: fix potential NULL pointer access for firmware")
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

21c60a28af58 rtw88: signal completion even on firmware-request failure

-- 
https://patchwork.kernel.org/patch/11231189/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

