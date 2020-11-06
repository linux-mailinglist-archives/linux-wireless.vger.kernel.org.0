Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5182A8F85
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 07:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgKFGjr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 01:39:47 -0500
Received: from z5.mailgun.us ([104.130.96.5]:48397 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFGjr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 01:39:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604644787; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=YDyUDKnBKPucTbwMOo6Fv+r9mejBac+SU6X1QOHgcgY=;
 b=bu/hgSwSjQZBtHUFqHwJfPMnln6tmRysRZf6KPuOetg2lv6QFF67iJZtfVCfPQ8XyMa8G4VT
 HPmK9tK7kBoT2lqZtD9lpIb5A3ZLjEEumq8F4I8F0a4BnpTaxOrBp2o1Vv5Qb2W1n8WvN1fG
 YA87O69HWnrV1t8FWqMWKLOftgg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa4ef6e257b36c43ec1dda6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 06:38:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF7BBC433CB; Fri,  6 Nov 2020 06:38:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47952C433C8;
        Fri,  6 Nov 2020 06:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47952C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: FILS discovery and unsolicited broadcast probe
 response support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201007204036.19780-1-alokad@codeaurora.org>
References: <20201007204036.19780-1-alokad@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Aloka Dixit <alokad@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201106063838.AF7BBC433CB@smtp.codeaurora.org>
Date:   Fri,  6 Nov 2020 06:38:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> wrote:

> This patch adds driver support for FILS discovery and unsolicited
> broadcast probe response transmission features which are used for
> in-band discovery in 6GHz band.
> Currently this support is enabled only in 6GHz by setting hardware flags.
> 
> Changes include WMI commands to enable transmission, set packet
> interval, set template, and handle events.
> 
> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

047679e366b9 ath11k: FILS discovery and unsolicited broadcast probe response support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201007204036.19780-1-alokad@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

