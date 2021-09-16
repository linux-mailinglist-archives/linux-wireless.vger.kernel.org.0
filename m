Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3040D448
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhIPIKC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 04:10:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:28836 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhIPIKB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 04:10:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631779721; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=HRzoTpPUOnnoCsB1dg6GBTv/n4PKCWlA8GJJVJjG+3A=;
 b=t1Sjk7jh7e52JCvQGKfhkxKXuxls+vQWBTgecFkQFryrmKM9PWPhBnHkmyiX2QMoH21C9uw+
 sPRaM5uh3Eh/BcFlcwbfiAOaSOwLiLA0bsBmap9LwJdckIrVbyWi6NRUm0KGDduh/8HAEtQw
 kw0pdvvXtxbJ2HcD/zik/y+431U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6142fb6eec62f57c9ae8c0c4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Sep 2021 08:08:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 00CDBC4360C; Thu, 16 Sep 2021 08:08:13 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7A7F4C4338F;
        Thu, 16 Sep 2021 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7A7F4C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 1/2] ath9k: fetch calibration data via nvmem subsystem
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com>
References: <f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210916080814.00CDBC4360C@smtp.codeaurora.org>
Date:   Thu, 16 Sep 2021 08:08:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> On most embedded ath9k devices (like range extenders,
> routers, accesspoints, ...) the calibration data is
> stored in a MTD partitions named "ART", or "caldata"/
> "calibration".
> 
> Since commit 4b361cfa8624 ("mtd: core: add OTP nvmem provider support"):
> All MTD partitions are all automatically available through
> the nvmem subsystem.
> 
> This feature - together with an nvmem cell definition either
> in the platform data or via device-tree allows drivers to get
> the data necessary for initializing the WIFI, without having
> to wait around for the filesystem and userspace to do
> the extractions.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

2 patches applied to ath-next branch of ath.git, thanks.

eb3a97a69be8 ath9k: fetch calibration data via nvmem subsystem
ef7bc2a76342 ath9k: owl-loader: fetch pci init values through nvmem

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

