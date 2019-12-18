Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040A512511F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLRS6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 13:58:33 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61797 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbfLRS6d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 13:58:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695512; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=3C5mvevNz9A0VbgTQX/fgHixrc51/NX8lScWfWySnQ8=;
 b=Ye0tSf1BeFgk/WqS7nwVGfDW40up+EA0niOPlUIew7jnI4Z4xzTHrzT9PthppBpMqoVr2NoW
 guXprEVWrCFc35qlNrx3lEdNMLXuFp07vHfmdwOVn4kMhWvomp8f/oF1bVy0DE5xULC3YpAa
 MuZpkCpaW4iBS6Rzdtv4Lgr9vTg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa76d7.7f01658e8df8-smtp-out-n02;
 Wed, 18 Dec 2019 18:58:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 613F4C447A0; Wed, 18 Dec 2019 18:58:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD57BC433A2;
        Wed, 18 Dec 2019 18:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD57BC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: Fix use after free in brcmf_sdio_readframes()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191203095855.c4fradmsixgbq7mc@kili.mountain>
References: <20191203095855.c4fradmsixgbq7mc@kili.mountain>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218185830.613F4C447A0@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 18:58:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The brcmu_pkt_buf_free_skb() function frees "pkt" so it leads to a
> static checker warning:
> 
>     drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1974 brcmf_sdio_readframes()
>     error: dereferencing freed memory 'pkt'
> 
> It looks like there was supposed to be a continue after we free "pkt".
> 
> Fixes: 4754fceeb9a6 ("brcmfmac: streamline SDIO read frame routine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Franky Lin <franky.lin@broadcom.com>

Patch applied to wireless-drivers-next.git, thanks.

216b44000ada brcmfmac: Fix use after free in brcmf_sdio_readframes()

-- 
https://patchwork.kernel.org/patch/11270885/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
