Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F710356B71
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbhDGLmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 07:42:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52089 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234467AbhDGLmR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 07:42:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617795728; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2bEXU07KJTPWcpqZSC9pNhP9GNRo/qR1ochtvmF+2FY=; b=hzeXawYHdDsu4SgSqj9sFyNMuVGy7tuvqBLjtOpsrfCcvBwxxVepb+QDcsO904yyYCduSb1h
 Pg5P+zG8hrRZnvLImZcpzq2ciR6aksM2TYTE69bFIe7RwinwJQ6PSG7DnKdXInbZm5Y+8MXv
 DfNJP8cgSoLMHg6+bGeVU2n78Ug=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 606d9a8bc06dd10a2dadfe5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 07 Apr 2021 11:42:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DEC5FC433C6; Wed,  7 Apr 2021 11:42:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AE15C433C6;
        Wed,  7 Apr 2021 11:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AE15C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Luciano Coelho <coelho@ti.com>, Arik Nemtsov <arik@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] wlcore: fix overlapping snprintf arguments in debugfs
References: <20210323125723.1961432-1-arnd@kernel.org>
Date:   Wed, 07 Apr 2021 14:41:57 +0300
In-Reply-To: <20210323125723.1961432-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Tue, 23 Mar 2021 13:57:14 +0100")
Message-ID: <8735w2nwxm.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc complains about undefined behavior in calling snprintf()
> with the same buffer as input and output:
>
> drivers/net/wireless/ti/wl18xx/debugfs.c: In function
> 'diversity_num_of_packets_per_ant_read':
> drivers/net/wireless/ti/wl18xx/../wlcore/debugfs.h:86:3: error:
> 'snprintf' argument 4 overlaps destination object 'buf'
> [-Werror=restrict]
>    86 |   snprintf(buf, sizeof(buf), "%s[%d] = %d\n",  \
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    87 |     buf, i, stats->sub.name[i]);   \
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ti/wl18xx/debugfs.c:24:2: note: in expansion of
> macro 'DEBUGFS_FWSTATS_FILE_ARRAY'
>    24 |  DEBUGFS_FWSTATS_FILE_ARRAY(a, b, c, wl18xx_acx_statistics)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ti/wl18xx/debugfs.c:159:1: note: in expansion of macro 'WL18XX_DEBUGFS_FWSTATS_FILE_ARRAY'
>   159 | WL18XX_DEBUGFS_FWSTATS_FILE_ARRAY(diversity, num_of_packets_per_ant,
>
> There are probably other ways of handling the debugfs file, without
> using on-stack buffers, but a simple workaround here is to remember the
> current position in the buffer and just keep printing in there.
>
> Fixes: bcca1bbdd412 ("wlcore: add debugfs macro to help print fw statistics arrays")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ti/wlcore/boot.c    | 13 ++++++++-----
>  drivers/net/wireless/ti/wlcore/debugfs.h |  7 ++++---

This should go to wireless-drivers-next, not net-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
