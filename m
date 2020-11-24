Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269D72C2A90
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgKXO74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 09:59:56 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:20571 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbgKXO74 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 09:59:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606229996; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hM7l1qlnjr0Wvs6mp6kUpF6Xf99sTwOWW58cRMuXy2Q=;
 b=VPhphNEzlrlK6kXbIgFt0lSrh4rkiCZaEYFg2PnorwOynqfVp6OwFgUsZlPSvC2BMFxV6P3O
 AQc6wetQyetODe5726y72J7SLKvRKuszixgvUa7Q9FWj7XVnDDGXCO2CTwhLzsVRUoVjLx70
 e2TfFf3VbVJyLTYefNznN3TnowQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fbd1fe9b9b39088edfd4365 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 14:59:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C097C433C6; Tue, 24 Nov 2020 14:59:53 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1FBBC433C6;
        Tue, 24 Nov 2020 14:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1FBBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: cw1200: replace a set of atomic_add()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1604991491-27908-1-git-send-email-yejune.deng@gmail.com>
References: <1604991491-27908-1-git-send-email-yejune.deng@gmail.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     pizza@shaftnet.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yejune.deng@gmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124145953.1C097C433C6@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 14:59:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yejune Deng <yejune.deng@gmail.com> wrote:

> a set of atomic_inc() looks more readable
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

07f995ca1951 cw1200: replace a set of atomic_add()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1604991491-27908-1-git-send-email-yejune.deng@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

