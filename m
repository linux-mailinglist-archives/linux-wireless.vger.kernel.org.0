Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04945F1FC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 17:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378483AbhKZQiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 11:38:16 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:39817 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378606AbhKZQgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 11:36:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637944383; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=eaSosQOu1szub+ibVnzjtek81Xwk+ZUhUxB5g3hNm8E=;
 b=tkHkSCmxfjJGZdoEiNW7xq/NUUqn5smY8Xf6lVLozJcZ7/Ls0p08S2C4+i8J6qKGzZnkz88T
 QwmttPNI7dBLhzJnRdbhl5TB4lLqhY8BRMSG+2Chi3lXGa97kP2npgItnLdF8b1Lb9sSAqpq
 MFZh2zFprcQQWHuERRLkC1uBlaY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61a10c3edb3ac5552aafa860 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 26 Nov 2021 16:33:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B40FC43616; Fri, 26 Nov 2021 16:33:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6493C4338F;
        Fri, 26 Nov 2021 16:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B6493C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: remove '-Wunused-but-set-variable' warning in
 chip_wakeup()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20211115102809.1408267-1-ajay.kathat@microchip.com>
References: <20211115102809.1408267-1-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Ajay.Kathat@microchip.com>, <lkp@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163794437900.10370.13472021044884634684.kvalo@codeaurora.org>
Date:   Fri, 26 Nov 2021 16:33:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Remove unused variables to avoid the below warnings:
> 
>    drivers/net/wireless/microchip/wilc1000/wlan.c: In function 'chip_wakeup':
> >> drivers/net/wireless/microchip/wilc1000/wlan.c:620:34: warning: variable 'to_host_from_fw_bit' set but not used [-Wunused-but-set-variable]
>      620 |         u32 to_host_from_fw_reg, to_host_from_fw_bit;
>          |                                  ^~~~~~~~~~~~~~~~~~~
> >> drivers/net/wireless/microchip/wilc1000/wlan.c:620:13: warning: variable 'to_host_from_fw_reg' set but not used [-Wunused-but-set-variable]
>      620 |         u32 to_host_from_fw_reg, to_host_from_fw_bit;
>          |             ^~~~~~~~~~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

Patch applied to wireless-drivers-next.git, thanks.

d1e69b5492d1 wilc1000: remove '-Wunused-but-set-variable' warning in chip_wakeup()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211115102809.1408267-1-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

