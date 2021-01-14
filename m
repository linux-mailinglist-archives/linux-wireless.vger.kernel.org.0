Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88412F67BF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhANRbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:31:42 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:55826 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbhANRbl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:31:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645481; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pAqTPWEy5VXsKvzj0KLIoejiG4s9nm5dt3CkKTycPjo=;
 b=aqAh2dNT3oRg9UD/dzfQspENKnFPXK/3NEBxo+gix6b2LaTtx2f4MSu/WfqfZd+TwWmEQOin
 6XcIsQR4JY5D3vymZiT6+pC7VJjN0ej5kd74Gp+c7z1mEwu9V/80C87oaBNy7Lp6duGpnqL5
 X2fsyy/qIdBicn7WKb41jBpe7z4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 60007fce415a6293c5b62d8c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:30:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09EE1C43463; Thu, 14 Jan 2021 17:30:54 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF717C433CA;
        Thu, 14 Jan 2021 17:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF717C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: check the status of device in calibration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201217161657.GB12562@E480>
References: <20201217161657.GB12562@E480>
To:     Zhi Han <z.han@gmx.net>
Cc:     linux-wireless@vger.kernel.org, kuba@kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114173054.09EE1C43463@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:30:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhi Han <z.han@gmx.net> wrote:

> When the usb device being plugged out, before ieee80211 gets to know the
> hw being removed, it gets to know that the association status changed,
> and thus ask for the device to do the calibration. This causes error as
> the hw is absent.
> 
> This can be avoid by checking the status of the device before sending
> the calibration request to the device.
> 
> Signed-off-by: Zhi Han <z.han@gmx.net>
> Acked-by: Jakub Kicinski <kuba@kernel.org>

Patch applied to wireless-drivers-next.git, thanks.

1dac51269d05 mt7601u: check the status of device in calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201217161657.GB12562@E480/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

