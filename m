Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6A2F67AC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbhANR3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:29:33 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:49191 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhANR3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:29:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645348; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=J7fXt9Pzjy4xDZMwYIou3GmDhIbn8nANhLmm5feFgtU=;
 b=gKPo7cwiSdt5J/UUYgU+nabWkVrRwFTAg+pK2inYn8RtHC17xCfOZo6bN71mEGg1zN9srvsP
 WcszgdpBAw5rBT4x11eptPYaFmF/tpAkPPKgYUFrM0I6Wo2Rjwfnl2VjM7W0teDlAnmP7d7J
 d4pW8Ne666e6d/OvLDBCPmLhxrQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60007f61af68fb3b061148c6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:29:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38C71C433C6; Thu, 14 Jan 2021 17:29:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1234C433CA;
        Thu, 14 Jan 2021 17:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1234C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][V2] wilc1000: fix spelling mistake in Kconfig "devision"
 ->
 "division"
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201216115808.12987-1-colin.king@canonical.com>
References: <20201216115808.12987-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114172905.38C71C433C6@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:29:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

e4c748ee4af1 wilc1000: fix spelling mistake in Kconfig "devision" -> "division"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201216115808.12987-1-colin.king@canonical.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

