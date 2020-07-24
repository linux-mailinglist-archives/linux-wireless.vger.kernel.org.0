Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40722C615
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGXNOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 09:14:52 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56614 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbgGXNOt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 09:14:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595596489; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=yk4bZqC752ih63Wy6zaU9RG+MiXqtZvr+rS//nmMLBs=; b=RHR8gkm8YEC1eUxBWrp2sgdrYYc32npp9D7xeYGQZMtMorMOt0kh7sdrzuuOtplSxfX817sm
 Ja12pYXE33ELsadREZoqt4FyfMa52lG3XTKvMnbsIMv5Z8ixKBsqlpDfH/gUiV6F1KJc1iQ8
 9psB7hAJWBOhrW2DMyzl5P7Umr8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5f1adebaca57a65d47a1adf8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 13:14:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2909C43391; Fri, 24 Jul 2020 13:14:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 373D6C433CB;
        Fri, 24 Jul 2020 13:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 373D6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     amitkarwar@gmail.com, ganapathi.bhat@nxp.com,
        huxinming820@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] slimbus: ngd: simplify error handling
References: <20200724130658.GA29458@duo.ucw.cz>
Date:   Fri, 24 Jul 2020 16:14:27 +0300
In-Reply-To: <20200724130658.GA29458@duo.ucw.cz> (Pavel Machek's message of
        "Fri, 24 Jul 2020 15:06:58 +0200")
Message-ID: <87365h5a30.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Simplify error handling; we already know mwq is NULL.
>
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c

I think you sent this to the wrong lists:

$ scripts/get_maintainer.pl drivers/slimbus/qcom-ngd-ctrl.c
Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> (maintainer:SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus))
linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
alsa-devel@alsa-project.org (moderated list:SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus))
linux-kernel@vger.kernel.org (open list)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
