Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7555E1C3603
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEDJrG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 05:47:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64875 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbgEDJrG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 05:47:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588585625; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=jZwrnHq2YtbLOAUBTGHaVPyvCsDNnYF2Sbt8I4X8yf8=;
 b=VizNKdkXZgUDKC7aA5/Rhbi2ZuMcrqP2T8BVvm3fsTWp034AevVGIirJu4HYkqq19iB666AN
 Kie4tyULWzP0tFyttMOlvZrC/81r2Y/LuEEDp9fkeGxfvQVrfNzQZLHu6N5NxRzdg4oy81ng
 EWWyupbGW0nz9aMHI4aUTfGvb1k=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafe48f.7fd359edb2d0-smtp-out-n02;
 Mon, 04 May 2020 09:46:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 425C0C433D2; Mon,  4 May 2020 09:46:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11DE3C433F2;
        Mon,  4 May 2020 09:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11DE3C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: update phy parameter tables to v50
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200424073812.26896-1-yhchuang@realtek.com>
References: <20200424073812.26896-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200504094654.425C0C433D2@smtp.codeaurora.org>
Date:   Mon,  4 May 2020 09:46:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Update RTL8822C devices' phy tables to v50.
> 
> The new parameters introduces new RFE type 5 for some new modules.
> Also added a new regulatory CN for power limit.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

421ae61c1056 rtw88: 8822c: update phy parameter tables to v50

-- 
https://patchwork.kernel.org/patch/11507265/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
