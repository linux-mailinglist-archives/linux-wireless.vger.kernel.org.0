Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450C82AA671
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Nov 2020 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgKGPvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Nov 2020 10:51:37 -0500
Received: from z5.mailgun.us ([104.130.96.5]:23655 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgKGPvh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Nov 2020 10:51:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604764297; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=yEEkjN4pGLAcLNHcwYyG0U+CbCUjLFiAbGy0Ex34DqA=;
 b=Mn7TYLnNZkd5XKEvQZdbpCVnAmHhqecZCOWhp23Gn+lOSPowFBRkBkcS2C2F6T0FmhfSXy+F
 p3RFtFeUUyv9keMPk5SG+VyDrOTotJMwwwRxIE3Zdv5ZxisBlaY5X7hDD6I0EQcU+PuSwG6k
 LtrKEZ5E3afjvCEb6sG4W+Xe9Tw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa6c2877d4f16f92f2292d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 07 Nov 2020 15:51:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 129BCC433C6; Sat,  7 Nov 2020 15:51:35 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92DE0C433C8;
        Sat,  7 Nov 2020 15:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92DE0C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtw88: sync the power state between driver and
 firmware
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201030084826.9034-2-tehuang@realtek.com>
References: <20201030084826.9034-2-tehuang@realtek.com>
To:     <tehuang@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201107155135.129BCC433C6@smtp.codeaurora.org>
Date:   Sat,  7 Nov 2020 15:51:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<tehuang@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In current flow, driver issues power requests to firmware for entering or
> leaving deep power mode. But driver does not wait for an ack from firmware
> via reading CPWM register when driver requests to enter deep power mode.
> The behavior will lead to unsynchronized state between firmware and driver.
> Furthermore, consecutive same power requests may confuse firmware and leads
> to unexpected value of CPWM register. This patch ensures that the power
> request will wait for an ack from firmware and only send one power request
> each time.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>

4 patches applied to wireless-drivers-next.git, thanks.

690390d841d2 rtw88: sync the power state between driver and firmware
a95949606828 rtw88: store firmware feature in firmware header
f31e039fab38 rtw88: add C2H response for checking firmware leave lps
fc3ac64a3a28 rtw88: decide lps deep mode from firmware feature.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201030084826.9034-2-tehuang@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

