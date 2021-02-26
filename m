Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCA325FF5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 10:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhBZJZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 04:25:02 -0500
Received: from z11.mailgun.us ([104.130.96.11]:64826 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhBZJXE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 04:23:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614331358; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=WZto6la1xMW9OPXhnH+0FY0I0nURZt4YBbd4cgmNF6k=;
 b=hzb/WHvjVCHkTCO4+LKd0XowbNEbAsFDDHvA8SAyP79kkG99yboFwk44Bk/3NpHZGrjNiNgU
 6KTMkFqPUBCnQbKLhKqL/GHLW2MA04519+N9ulduFy0edZdphKFy1hM0v0QV4Bs0EYEGlJoj
 C5F6A1bknl4cKFbMpMea9g1kPTg=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6038bdddcc1f7d7e958364b2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Feb 2021 09:22:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC8BFC43466; Fri, 26 Feb 2021 09:22:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCCB0C433CA;
        Fri, 26 Feb 2021 09:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCCB0C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] mt76: mt7921: remove incorrect error handling
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210225145953.404859-2-arnd@kernel.org>
References: <20210225145953.404859-2-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210226092237.AC8BFC43466@smtp.codeaurora.org>
Date:   Fri, 26 Feb 2021 09:22:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang points out a mistake in the error handling in
> mt7921_mcu_tx_rate_report(), which tries to dereference a pointer that
> cannot be initialized because of the error that is being handled:
> 
> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:409:3: warning: variable 'stats' is uninitialized when used here [-Wuninitialized]
>                 stats->tx_rate = rate;
>                 ^~~~~
> drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:401:32: note: initialize the variable 'stats' to silence this warning
>         struct mt7921_sta_stats *stats;
>                                       ^
> Just remove the obviously incorrect line.
> 
> Fixes: 1c099ab44727 ("mt76: mt7921: add MCU support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Patch applied to wireless-drivers.git, thanks.

fb5fabb192b2 mt76: mt7921: remove incorrect error handling

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210225145953.404859-2-arnd@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

