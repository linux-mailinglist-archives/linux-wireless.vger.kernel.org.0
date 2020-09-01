Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83921258B2F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAJOx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 05:14:53 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51947 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgIAJOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 05:14:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598951691; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vTY44rF8xPP0t6pJA9xrALfusMf0jGAsYsXi/IuPGlQ=; b=DrJZq8dRdt3H+GrdYu+yD0a5c1qVUF9FJ5zmoqB6S5WmT0DbIVq8OabiHy3iK9CHZ4rLezsS
 EB9bs2sTNf/gPRgrVWP3s/aIEjXZrBm9Ei3/i7phL4ASdbN0z89u9cgeNrWe3KEFhb0KnaZF
 Pu4b1n4KgJe0Qnm7eLFcNdQvpIc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f4e11004ba82a82fd7f8b34 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 09:14:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A43FC43387; Tue,  1 Sep 2020 09:14:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F991C433C6;
        Tue,  1 Sep 2020 09:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F991C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/32] Set 2: Rid W=1 warnings in Wireless
References: <20200821071644.109970-1-lee.jones@linaro.org>
Date:   Tue, 01 Sep 2020 12:14:36 +0300
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org> (Lee Jones's
        message of "Fri, 21 Aug 2020 08:16:12 +0100")
Message-ID: <87o8mp6epv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> There are quite a few W=1 warnings in the Wireless.  My plan
> is to work through all of them over the next few weeks.
> Hopefully it won't be too long before drivers/net/wireless
> builds clean with W=1 enabled.

BTW, now the patches are in random order and it's quite annoying to
review when there's no logic. Grouping them by the driver would be a lot
more pleasent for reviewers.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
