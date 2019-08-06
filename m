Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D158319B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfHFMnn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:43:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMnn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:43:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC16760590; Tue,  6 Aug 2019 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095421;
        bh=BCfOHP9HalrfoaTlPtuAMFW08YetxuZS+9N/gnYCrcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IelaEY+6xGLR5+MMKwJ9GMsg70XLbQd0SkIk5v0krnKOAed0SeOGLHpM9CLp5XGHy
         jW+1pRD/WqDItPPj/wUvt6Z2vVZ8CjmrU44ReGopXDQriFdWaPVT0LzZxTvrAQJJKS
         u/UVHe3dGBm2dVGqmiPP2e/wYDxksMhCxCWGejhk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6275D6038E;
        Tue,  6 Aug 2019 12:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565095421;
        bh=BCfOHP9HalrfoaTlPtuAMFW08YetxuZS+9N/gnYCrcM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=DELvPZddHzuOW75TzKQ8L1rBkd2CJigWaTTdyz2vjfstbme25QsONOBFVbO2H9oJF
         juCzegsAMysv8H0rCrtu2jyZ6ocAJR1mlteIilxgqivabmcpvzFXLG+yGXRF5nZLUs
         dD0ZCk0MZo//WX1d3Qi2Al97Ex3VejH9sgsbn578=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6275D6038E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Revert "mwifiex: fix system hang problem after resume"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190805171504.48122-1-briannorris@chromium.org>
References: <20190805171504.48122-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Amitkumar Karwar <akarwar@marvell.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806124341.AC16760590@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:43:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> This reverts commit 437322ea2a36d112e20aa7282c869bf924b3a836.
> 
> This above-mentioned "fix" does not actually do anything to prevent a
> race condition. It simply papers over it so that the issue doesn't
> appear.
> 
> If this is a real problem, it should be explained better than the above
> commit does, and an alternative, non-racy solution should be found.
> 
> For further reason to revert this: there's no reason we can't try
> resetting the card when it's *actually* stuck in host-sleep mode. So
> instead, this is unnecessarily creating scenarios where we can't recover
> Wifi (and in fact, I'm fielding reports of Chromebooks that can't
> recover after the aforementioned commit).
> 
> Note that this was proposed in 2017 and Ack'ed then, but due to my
> marking as RFC, it never went anywhere:
> 
> https://patchwork.kernel.org/patch/9657277/
> [RFC] Revert "mwifiex: fix system hang problem after resume"
> 
> Cc: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Amitkumar Karwar <amitkarwar@gmail.com>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

654026df2635 Revert "mwifiex: fix system hang problem after resume"

-- 
https://patchwork.kernel.org/patch/11077645/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

