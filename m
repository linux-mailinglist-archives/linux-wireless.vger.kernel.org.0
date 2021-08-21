Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB643F38DC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 07:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhHUFlU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Aug 2021 01:41:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61669 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhHUFlT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Aug 2021 01:41:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629524441; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=UC5eWRTEzqulkg0w1otRArNQRDvCbpACDgnYwfxDjIY=; b=kmVo2PMBipMpEzX1DjekLoBDddqrWZi15L9ujgbr/XkGScu9cV4KMpLu2bWRiHw4OOrD3TrC
 3ArN+kGC53Z8hXhWHUb6/6dQ+Bk174NyhU63hssvxZsA+pVKqBtkAM0etj+AH5pJho1ROvM5
 Gcv4W/V0TaFcTpACa6bt8Xw1BkM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 612091cbf588e42af198aea8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 21 Aug 2021 05:40:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2E42C43616; Sat, 21 Aug 2021 05:40:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCF54C4338F;
        Sat, 21 Aug 2021 05:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CCF54C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: Re: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add nvmem-cells for calibration data
References: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
Date:   Sat, 21 Aug 2021 08:40:20 +0300
In-Reply-To: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
        (Christian Lamparter's message of "Sat, 21 Aug 2021 03:09:13 +0200")
Message-ID: <87ilzz9wzf.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> writes:

> On most embedded ath9k devices (like range extenders,
> routers, accesspoints, ...) the calibration data for
> the RF/PHY is simply stored in a MTD partition named
> "ART", "caldata"/"calibration", etc.
>
> Any mtd partition is automatically registered in the
> nvmem subsystem. This makes is possible to fetch the
> necessary calibration directly from there at the low
> cost of adding nvmem cell information via the
> device-tree or via similar means.
>
> This speeds up the driver's initialization a lot,
> because the driver doesn't have to wait for userspace
> to provide the data via helpers.
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

The series looks good to me. But I'm curious, why you marked this as
RFC? Is there something controversial I missed?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
