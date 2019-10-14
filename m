Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07933D5E5D
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJNJMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 05:12:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbfJNJMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 05:12:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F0B6660790; Mon, 14 Oct 2019 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044356;
        bh=z86qs8oa5szuC0NQeOfALKkUKQBsvq/91KSguI7teFY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HcDV04lztRVkQX3Uw5u2bdDU3GYWKHZOvdYuS0+s4aPEa/10WiGTViRQOhDqkjiJS
         S1NQchBrL/zs7t7xndeTlFjvdbx1IQiujXO/D9tHye7BygidcO/svPNNq++OU11+3S
         ykmHqKB4zJlNGqhAgtYsv62FkW5BSPxqjlwsyAeI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED82E605FE;
        Mon, 14 Oct 2019 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571044342;
        bh=z86qs8oa5szuC0NQeOfALKkUKQBsvq/91KSguI7teFY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Z7NH+NKyvaNuX1Rdbjo4AkIVmLSmkEaC/zZkcYaB089aJv/1iXi61jk+4jPU9AzPc
         l5hSyXib67fsY1N8mWNFd7MQvkN0UelCDK5t9mNlGy7U8IFhwcMZA64/WB9HHWr74C
         upbjzPK8CBXNtoLetXngCc3C5vzTxF7aQwjYCPaI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED82E605FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: include interrupt.h for tasklet_struct
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191012014421.21592-1-briannorris@chromium.org>
References: <20191012014421.21592-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191014091235.F0B6660790@smtp.codeaurora.org>
Date:   Mon, 14 Oct 2019 09:12:35 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Depending on implicit header includes, we might see this compilation
> error:
> 
> .../main.h:1391:24: error: field has incomplete type 'struct tasklet_struct'
>         struct tasklet_struct tx_tasklet;
>                               ^
> 
> Fixes: 3745d3e550d1 ("rtw88: add driver TX queue support")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

c3226d93f85c rtw88: include interrupt.h for tasklet_struct

-- 
https://patchwork.kernel.org/patch/11186535/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

