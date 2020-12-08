Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C12D249C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 08:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgLHHhS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 02:37:18 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:35110 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgLHHhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 02:37:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607413013; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=2BOcgbEjxk0qkK5vuSHsp1tgA2eFO76dqag/8+SBIL4=;
 b=PzOfkS7VIvp2IsNlUcIDbdFHcggCThzafCDTYx/+aLtDH0foiXcTMG0wj/zY0O8cpYyO2PlA
 wH1fux/CXMouJBlHlVUyP5GwbfbpeJHiofzZmEQLAGsfqgB+wr1TBZJ+kzLT01O7AZP+XAZc
 S2lo0viaK5sjOsYCBbqe0dxjY+E=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fcf2cebfc7bcec118d475c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Dec 2020 07:36:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55ED8C43463; Tue,  8 Dec 2020 07:36:10 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9AE00C433ED;
        Tue,  8 Dec 2020 07:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AE00C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V2 RESEND] rtw88: reduce polling time of IQ calibration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201208014503.12118-1-pkshih@realtek.com>
References: <20201208014503.12118-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201208073610.55ED8C43463@smtp.codeaurora.org>
Date:   Tue,  8 Dec 2020 07:36:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> When 8822CE is associating with AP, driver will poll status bit of
> IQ calibration to confirm the IQ calibration is done, and then move on
> the association process. Current polling time for IQ calibration is 6
> seconds.
> 
> But occasionally driver fails in polling the status bit because the status
> bit is not set after IQ calibration is done. When it happends, association
> process will be serieously delayed up to 6 seconds. To avoid it, we reduce
> polling time to 300ms, in which the IQ calibration can be done.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

3324e05eca0d rtw88: reduce polling time of IQ calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201208014503.12118-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

