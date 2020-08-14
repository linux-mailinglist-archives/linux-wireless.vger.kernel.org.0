Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39483244BC3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHNPQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 11:16:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:59501 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgHNPQB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 11:16:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597418160; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=DMWgRHrRRjTDJXLtrLvtw3sk3LVQOvR9zSjiVrGpUPE=; b=V3zTkCpHYue3XyHdrUbTtWWfJBUU4ZHQO3K0H+gaAAZZ/FwasfXjO/hP/4AUZOn6uCpg3UvE
 sHRvooJj1nnHq/0MX15NkkdAcuEoneKKd4Xs313QOTluvAUlXDZ2eN6r/VTp6uaOwkVN9X+P
 3zYoMm5B92H/gcbH0vR6CFKfUYc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f36aaa01e4d3989d47fc516 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 15:15:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B6E7C43391; Fri, 14 Aug 2020 15:15:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 410CFC433C6;
        Fri, 14 Aug 2020 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 410CFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Reed <breed@users.sourceforge.net>,
        Javier Achirica <achirica@users.sourceforge.net>,
        Jean Tourrilhes <jt@hpl.hp.com>,
        Fabrice Bellet <fabrice@bellet.info>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 12/30] net: wireless: cisco: airo: Fix a myriad of coding style issues
References: <20200814113933.1903438-1-lee.jones@linaro.org>
        <20200814113933.1903438-13-lee.jones@linaro.org>
Date:   Fri, 14 Aug 2020 18:15:39 +0300
In-Reply-To: <20200814113933.1903438-13-lee.jones@linaro.org> (Lee Jones's
        message of "Fri, 14 Aug 2020 12:39:15 +0100")
Message-ID: <87r1s9l0mc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

>  - Ensure spaces appear after {for, if, while, etc}
>  - Ensure spaces to not appear after '('
>  - Ensure spaces to not appear before ')'
>  - Ensure spaces appear between ')' and '{'
>  - Ensure spaces appear after ','
>  - Ensure spaces do not appear before ','
>  - Ensure spaces appear either side of '='
>  - Ensure '{'s which open functions are on a new line
>  - Remove trailing whitespace
>
> There are still a whole host of issues with this file, but this
> patch certainly breaks the back of them.
>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Benjamin Reed <breed@users.sourceforge.net>
> Cc: Javier Achirica <achirica@users.sourceforge.net>
> Cc: Jean Tourrilhes <jt@hpl.hp.com>
> Cc: Fabrice Bellet <fabrice@bellet.info>
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/net/wireless/cisco/airo.c | 897 ++++++++++++++++--------------
>  1 file changed, 467 insertions(+), 430 deletions(-)

This is a driver for ancient hardware, I'm not sure if it's worth trying
to fix any style issues. Is anyone even using it? Should we instead just
remove the driver?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
