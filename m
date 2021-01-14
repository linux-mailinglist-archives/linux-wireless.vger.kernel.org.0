Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCB2F67CC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 18:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbhANRds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 12:33:48 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:59203 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANRdr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 12:33:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610645608; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=x9glg1wP4Zom+MSxS0L6kYXjKajnhrKL8dU5z/hSMQE=;
 b=jLJHnkPXNlJzliv1OuP7EQP6x2haFz607hZiHhd23Ksn06Vh00KJb9Vkz5DG6n5agdD/sqSo
 nNHJNBsbPKlW70PpYSAmGcdl6/QgB1twlTk1CH8xLbsmNu7pjoyv0DFQe7QPx3YOspnhmNbV
 5gi/s8QjS0gcclEQXoMRl1QxBCc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 600080638fb3cda82fae4ef9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 17:33:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 39F10C433C6; Thu, 14 Jan 2021 17:33:22 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5E7BC433CA;
        Thu, 14 Jan 2021 17:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5E7BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: use flexible-array member instead of
 zero-length
 array
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608881703-37060-1-git-send-email-tiantao6@hisilicon.com>
References: <1608881703-37060-1-git-send-email-tiantao6@hisilicon.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     <ajay.kathat@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210114173322.39F10C433C6@smtp.codeaurora.org>
Date:   Thu, 14 Jan 2021 17:33:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tian Tao <tiantao6@hisilicon.com> wrote:

> Use flexible-array member introduced in C99 instead of zero-length
> array. Most of zero-length array was already taken care in previous
> patch [1].
> 
> [1]. https://patchwork.kernel.org/patch/11394197/
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Patch applied to wireless-drivers-next.git, thanks.

098238e80bed wilc1000: use flexible-array member instead of zero-length array

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608881703-37060-1-git-send-email-tiantao6@hisilicon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

