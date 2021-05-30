Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61642395032
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 11:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhE3JGs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 05:06:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:57219 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhE3JGs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 05:06:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622365510; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=IYEzPpzNddtJ4gTbxg+/khBNIkF4erIR+OqdIOUOVms=;
 b=VOr4JQPue36m5i/Gz5q+kM9R0Tdxar64M6DEKhr/vIIYjW9Us6kXZc6ydJQp1ia+8vw3MoQt
 jk2VtgQ7oC1S5opGf34C+nArq5MKgldmBXLJgIsbYng87Wk4fz7Aw7cCwHMWxCufm2gdOptP
 yJVxlX2HdwghBT+4d4uWGYR8WXQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60b35541ea2aacd729dcdaba (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 30 May 2021 09:05:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6546EC433F1; Sun, 30 May 2021 09:05:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A8ACC433D3;
        Sun, 30 May 2021 09:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A8ACC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath9k: ar9003_mac: read STBC indicator from rx descriptor
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210517172426.15919-1-borgers@mi.fu-berlin.de>
References: <20210517172426.15919-1-borgers@mi.fu-berlin.de>
To:     Philipp Borgers <borgers@mi.fu-berlin.de>
Cc:     ath9k-devel@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        Philipp Borgers <borgers@mi.fu-berlin.de>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210530090505.6546EC433F1@smtp.codeaurora.org>
Date:   Sun, 30 May 2021 09:05:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Philipp Borgers <borgers@mi.fu-berlin.de> wrote:

> The rx descriptor contains a STBC indicator. If the indicator is set the
> frame was received with STBC.
> 
> Signed-off-by: Philipp Borgers <borgers@mi.fu-berlin.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

238ebd8b487b ath9k: ar9003_mac: read STBC indicator from rx descriptor

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210517172426.15919-1-borgers@mi.fu-berlin.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

