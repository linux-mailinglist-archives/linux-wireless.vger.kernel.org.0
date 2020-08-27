Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4A254356
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgH0KPT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:15:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50491 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728766AbgH0KPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:15:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598523318; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UCtFuutglMgIWDDifCF1UD+Mv3E2qnbk1NFCG7xOeIg=;
 b=TKKr8M1F/DxOukEmDXV1e1j/HdIDElb4kYBTq7xOYSEOdMqmaGS0nn4MTaXyvM1D4LFG5CjN
 v4pgihkHgoaW4yUxxtS+GnjszjogJk4OfNpz4fsqhBYLV0p/oAo/an59MmUYooqxPcTllh6y
 3N9T0OKhJuJ20LsiiQBQpYWE5UI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f4787aee805f13fd72d46ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 10:15:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E5F3C4339C; Thu, 27 Aug 2020 10:15:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61F35C433CB;
        Thu, 27 Aug 2020 10:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61F35C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Disable bmps when encryption is disabled
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1598363127-26066-1-git-send-email-loic.poulain@linaro.org>
References: <1598363127-26066-1-git-send-email-loic.poulain@linaro.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, Loic Poulain <loic.poulain@linaro.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200827101510.2E5F3C4339C@smtp.codeaurora.org>
Date:   Thu, 27 Aug 2020 10:15:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Loic Poulain <loic.poulain@linaro.org> wrote:

> For whatever reason, when connected to an open/no-security BSS,
> the wcn36xx controller in bmps mode does not forward 'wake-up'
> beacons despite AP sends DTIM with station AID.
> 
> Meaning that AP is not able to wakeup the station and needs to wait
> for the station to wakeup by its own (TX data, keep alive pkt...),
> causing serious latency issues and unexpected deauth.
> 
> When connected to AP with encryption enabled, this issue does not occur.
> So a simple workaround is to only enable bmps support in that case.
> 
> Ideally, it should be propertly fixed to allow bmps support with open
> BSS, whatever the issue is at driver or firmware level.
> 
> Tested on wcn3620 and wcn3680.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

c6522a5076e1 wcn36xx: Disable bmps when encryption is disabled

-- 
https://patchwork.kernel.org/patch/11735719/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

