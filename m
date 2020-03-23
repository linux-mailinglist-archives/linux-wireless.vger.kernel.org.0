Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C890F18FB8A
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 18:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgCWReV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 13:34:21 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:60490 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgCWReV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 13:34:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584984860; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=SCTjATZ3qnPRY/Zu85XDghzjZtiQUeZiurZDQd7DCKo=;
 b=p3ta1vMYa59NGsAmhZ2hgJGjhtbiARWcB5pUCrsFGwqFfhguyW5MN4KQohnT25dIrRb06Cnp
 GWmg+4udSioJ1H/XJDU3Cg0j94XsUfx27JnpVeVrTkJYogXXWLkImEE6x2aRF7iG3Ttw1MRK
 JOUIV0Ky74CGX8tViuviw84QMik=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78f317.7f59d4878ca8-smtp-out-n02;
 Mon, 23 Mar 2020 17:34:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE20BC433BA; Mon, 23 Mar 2020 17:34:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9625FC433D2;
        Mon, 23 Mar 2020 17:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9625FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: 8822c: config RF table path B before path A
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200318095224.12940-1-yhchuang@realtek.com>
References: <20200318095224.12940-1-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200323173415.BE20BC433BA@smtp.codeaurora.org>
Date:   Mon, 23 Mar 2020 17:34:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> After MAC switched power, the hardware's RF registers will have
> its default value, but the default value for path B is incorrect.
> So, load RF path B first, to decrease the period between MAC on
> and RF path B config.
> 
> By test, if we load path A first, then there's ~300ms that the
> path B is incorrect, it could lead to BT coex's A2DP glitch.
> But if we configure path B first, there will only have ~3ms,
> significantly lower possibility to have A2DP sound glitch.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

11a64888c79b rtw88: 8822c: config RF table path B before path A

-- 
https://patchwork.kernel.org/patch/11444805/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
