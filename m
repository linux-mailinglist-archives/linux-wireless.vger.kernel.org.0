Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3B53A7B83
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 12:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFOKNI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 06:13:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24475 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhFOKNI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 06:13:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623751864; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=UCLjSc2OsRB2MhmPxdZ74WoZto4hJmz7+md+x6NkNV4=;
 b=YoSPtV/0U7yNOyID5KxaGt7UJj4MQ2/oPU/k3KmAoG8qYSdx3MDBKCMWPD/9ZvIerKMQpT7z
 +Z+V29cCZUDoJ340RnM7jholGn+HkqzVlYL0qCGwmXvDqHJEiukkHL4Um8FvTbimN1koL0QX
 i4nrc+q3HV9+tseCt5SFBB0w4bM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c87caaed59bf69cc22e310 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 10:10:50
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DB5CBC433F1; Tue, 15 Jun 2021 10:10:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97E2DC43460;
        Tue, 15 Jun 2021 10:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97E2DC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] ssb: Fix error return code in ssb_bus_scan()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210515072949.7151-1-thunder.leizhen@huawei.com>
References: <20210515072949.7151-1-thunder.leizhen@huawei.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Michael Buesch <m@bues.ch>,
        "John W . Linville" <linville@tuxdriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615101050.DB5CBC433F1@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 10:10:50 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zhen Lei <thunder.leizhen@huawei.com> wrote:

> Fix to return -EINVAL from the error handling case instead of 0, as done
> elsewhere in this function.
> 
> Fixes: 61e115a56d1a ("[SSB]: add Sonics Silicon Backplane bus support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

77a0989baa42 ssb: Fix error return code in ssb_bus_scan()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210515072949.7151-1-thunder.leizhen@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

