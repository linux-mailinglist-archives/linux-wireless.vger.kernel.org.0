Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54A41AD603
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 08:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgDQGUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 02:20:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16018 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgDQGUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 02:20:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587104402; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=4EdF8WxohuOQcibtnTIOgBWNABp0tvYDRmPwnTwXHgM=;
 b=VbDS25TySS0Qa0baHam1+XrbPo/BC8y0UpAeTTw9aYZ0TpoVTfR+RGtgZz/SLu59WktVNIz9
 etbXlLu9UUKydTibq1AReiYQFelbg0TNbIpO1fE0HO+l6S7el0VQeWLzqyz4ilcoq2qnruP2
 GUrvoPBTuHViXrNAr3xjMbzpaF8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e994a85.7ff1f164e768-smtp-out-n05;
 Fri, 17 Apr 2020 06:19:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 65FC3C433BA; Fri, 17 Apr 2020 06:19:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48D38C44793;
        Fri, 17 Apr 2020 06:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48D38C44793
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: update list of qtnfmac maintainers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200416182803.31201-1-sergey.matyukevich.os@quantenna.com>
References: <20200416182803.31201-1-sergey.matyukevich.os@quantenna.com>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     linux-wireless@vger.kernel.org,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200417061948.65FC3C433BA@smtp.codeaurora.org>
Date:   Fri, 17 Apr 2020 06:19:48 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sergey Matyukevich <sergey.matyukevich.os@quantenna.com> wrote:

> Removing Avinash since tomorrow is his last day at Quantenna.
> 
> Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> Signed-off-by: Avinash Patil <avinashp@quantenna.com>

Patch applied to wireless-drivers.git, thanks.

1f8fbe9c93fa MAINTAINERS: update list of qtnfmac maintainers

-- 
https://patchwork.kernel.org/patch/11493665/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
