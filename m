Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0809F223B1A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgGQMFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 08:05:42 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:52411 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgGQMFm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 08:05:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594987542; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=hPWgjh6Z31+8mVshXFtGOQtuU1a/Lut0EMPEI8zc8j4=; b=o6/UxmOQ6p6mpE1KvcN5GF6f5czE38yknUDBqqZJwVwFgwUlOmJLxS4k7LIBGSmLwUtsMU6u
 BzaNAHtAvV/U3PoVuD00U9ieglQBVMefl0GZVD27fpuKLQ56pSZzXbmAZGMk9ejQ9JnKqqHH
 QPNevdojJt1HVnIGvmt3I/Cvi1M=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f119414166c1c54948c54e7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 12:05:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8807C43395; Fri, 17 Jul 2020 12:05:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22D79C433C6;
        Fri, 17 Jul 2020 12:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22D79C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: manual merge of the dmaengine tree with the wireless-drivers-next and Linus' trees
References: <20200717165336.312dcf09@canb.auug.org.au>
Date:   Fri, 17 Jul 2020 15:05:34 +0300
In-Reply-To: <20200717165336.312dcf09@canb.auug.org.au> (Stephen Rothwell's
        message of "Fri, 17 Jul 2020 16:53:36 +1000")
Message-ID: <87tuy673e9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the dmaengine tree got a conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   5625f965d764 ("wilc1000: move wilc driver out of staging")
>
> from the wireless-drivers-next tree, commit:
>
>   6e701c299469 ("MAINTAINERS: merge entries for felix and ocelot drivers")
>
> from Linus' tree and commit:
>
>   c3846c4cce15 ("MAINTAINERS: dmaengine: Microchip: add Tudor Ambarus
> as co-maintainer")
>
> from the dmaengine tree.

I think this is trivial enough that Linus can take care of it without
any extra actions. Thanks for the report.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
