Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9538187E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhEOLsr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 07:48:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31820 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhEOLsq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 07:48:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621079253; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=m+19eFIYizapTi3Lc9ukGt6GmJNppNw8GXbYgdy3l8o=;
 b=la1oj0h7eMfOwXpQ/jSlEnpIihwcZ6ETXKjLQ97rNEC84Rqh8rXMSICP9Dtim4G3TX0nxqiS
 rDl0FWlSo0PtGkjlo2U1F82X6ZO12W0DjixOlvM6rcJgdW1R9gWvRFeJpejc9Aa8DTwfuSFQ
 7kdTqMZmVi7+V2BFLciWiB9uSZI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 609fb4d48dd30e785f459523 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 11:47:32
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1F9ECC43217; Sat, 15 May 2021 11:47:30 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 315FEC433D3;
        Sat, 15 May 2021 11:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 315FEC433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.13] mt76: mt76x0e: fix device hang during suspend/resume
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <4812f9611624b34053c1592fd9c175b67d4ffcb4.1620406022.git.lorenzo@kernel.org>
References: <4812f9611624b34053c1592fd9c175b67d4ffcb4.1620406022.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, luca.trombin@gmail.com, stf_xl@wp.pl
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515114730.1F9ECC43217@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 11:47:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Similar to usb device, re-initialize mt76x0e device after resume in order
> to fix mt7630e hang during suspend/resume
> 
> Reported-by: Luca Trombin <luca.trombin@gmail.com>
> Fixes: c2a4d9fbabfb9 ("mt76x0: inital split between pci and usb")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless-drivers.git, thanks.

509559c35bcd mt76: mt76x0e: fix device hang during suspend/resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4812f9611624b34053c1592fd9c175b67d4ffcb4.1620406022.git.lorenzo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

