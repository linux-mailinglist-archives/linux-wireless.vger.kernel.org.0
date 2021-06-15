Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A143A8067
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFONk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:40:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13184 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhFONjX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:39:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764239; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NRI2lSngvSXad61YyzZ7ljzijSbW4H1D1VGOsKwJUo0=;
 b=OJzpOUCP8YGuv7yceYaapchMmy71zyIQN0oI1K4y9GA4L97tWjhenqSVvFip7Q1yqpISuKlc
 jObCVx/PlDavQ3RiPyfZkcJkcQKTr529nqQIHqxCDzDmp1sPhQkvehhTAeP7NsmP7Rvia78s
 AamDAno8SAbDTnZtps3tx32xs7Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60c8ad082eaeb98b5ef0e782 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:37:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D450FC43145; Tue, 15 Jun 2021 13:37:12 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A01AC433D3;
        Tue, 15 Jun 2021 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A01AC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: zd1211rw: Prefer pr_err over printk error msg
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210506044838.GA7260@user>
References: <20210506044838.GA7260@user>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     dsd@gentoo.org, kune@deine-taler.de, davem@davemloft.net,
        kuba@kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210615133712.D450FC43145@smtp.codeaurora.org>
Date:   Tue, 15 Jun 2021 13:37:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Saurav Girepunje <saurav.girepunje@gmail.com> wrote:

> In zd_usb.c usb_init we can prefer pr_err() over printk KERN_ERR
> log level.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

29d97219f403 zd1211rw: Prefer pr_err over printk error msg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210506044838.GA7260@user/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

