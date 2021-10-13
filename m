Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E452342B6EF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhJMGT4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Oct 2021 02:19:56 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42611 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbhJMGTz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Oct 2021 02:19:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634105872; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jY5uQapv7dUKYjqb7AO+EnSNhLB/zixLlogvRjSq578=; b=rDvsY9rWerHo17BtCSi1a4/qvufekpAwOBnVa22FvJRJErLXLbveGE7enIcxygBrKPNLXkHM
 8J3aqnWyg+RzpCfFaRqeZ56jToK8RdN5Hiayn5Cj9HzRceAnoRlxSyxLkVB78Aw3I0t1SEOa
 0ULm2KBhqeZF09aa/I8epEYebeM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61667a034ccc4cf2c76622ae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Oct 2021 06:17:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07FD1C43460; Wed, 13 Oct 2021 06:17:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DFB2C4338F;
        Wed, 13 Oct 2021 06:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4DFB2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] MAINTAINERS: mt76: update MTK folks
References: <5b452d209fb97be1a39a2d7775557bc8f43bd07c.1634104734.git.ryder.lee@mediatek.com>
Date:   Wed, 13 Oct 2021 09:17:34 +0300
In-Reply-To: <5b452d209fb97be1a39a2d7775557bc8f43bd07c.1634104734.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Wed, 13 Oct 2021 14:03:23 +0800")
Message-ID: <87y26xzbwh.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Update entries for MTK folks.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeb4c70b3d5b..6745119b70bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11818,7 +11818,9 @@ F:	drivers/mmc/host/mtk-sd.c
>  MEDIATEK MT76 WIRELESS LAN DRIVER
>  M:	Felix Fietkau <nbd@nbd.name>
>  M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> -R:	Ryder Lee <ryder.lee@mediatek.com>
> +M:	Ryder Lee <ryder.lee@mediatek.com>
> +M:	Shayne Chen <shayne.chen@mediatek.com>
> +M:	Sean Wang <sean.wang@mediatek.com>

I don't really like of having five maintainers for a driver, that just
usually ends up that nobody takes responsibility. I would rather have
just one, or maybe two, maintainers and no more.

Reviewers are of course another matter, having more of them is just a
good thing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
