Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A633130DA
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhBHL3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:29:38 -0500
Received: from so15.mailgun.net ([198.61.254.15]:50923 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233181AbhBHL1Q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:27:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612783616; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=5QCI63NH6Wa4pD81iDZmUJs/qJLaqHjMmad3Bk2CwNE=;
 b=BDcgBfBJ+OSgJwTum8Wn7Xy59jSrDROtst0v76/bOWMBOzq9TMbYk3DS34thw9j5thKNFpGn
 B/60BAjbNf1f4ZAl02OlnWjeLoZ75YIuh0Oerv0UKvTNwgPDgjCAEaV+Vbb259vw3rL2GBEe
 1XkyPUeFMBnMFgqTSCaF7pg+4MU=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60211fe1f112b7872c458818 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 11:26:25
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CA59C433CA; Mon,  8 Feb 2021 11:26:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 740CFC43464;
        Mon,  8 Feb 2021 11:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 740CFC43464
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: Use true and false for bool variable
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     m@bues.ch, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208112625.5CA59C433CA@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 11:26:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Fix the following coccicheck warnings:
> 
> ./include/linux/ssb/ssb_driver_gige.h:89:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_one_dma_at_once' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:79:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_have_roboswitch' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:182:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_must_flush_posted_writes' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:178:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_one_dma_at_once' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:174:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_have_roboswitch' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:170:8-9: WARNING: return of 0/1 in
> function 'ssb_gige_is_rgmii' with return type bool.
> 
> ./include/linux/ssb/ssb_driver_gige.h:162:8-9: WARNING: return of 0/1 in
> function 'pdev_is_ssb_gige_core' with return type bool.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Acked-by: Michael Büsch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

4331667fa14e ssb: Use true and false for bool variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

