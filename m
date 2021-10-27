Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A80043CDBE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhJ0PkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 11:40:17 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25707 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhJ0PkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 11:40:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635349071; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=gB2Fp8jnEq42aIVHIs5yhpiBQ0OjJlOTbPEgdx8qzEQ=; b=wdfdq5AOvqjNZc18RXCbyPXguHkPEDJ8BrfBw2+I2zQgn3Xxyx0H7JkK4B+zBTeqaKxm59ir
 mg/j3/Kc83sQ06+WrYC+3JZUYzUuqYYjyGz/xjKGibc6foNIOFtYQgxMq8ozMBsaKm7GzyKJ
 fA2fEJMWMDyCmvQZtucNjDAnD6I=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 617972452e144ac4d382428a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 15:37:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 17F5FC43460; Wed, 27 Oct 2021 15:37:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDB8BC4338F;
        Wed, 27 Oct 2021 15:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CDB8BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-10-23
References: <6d896d65-235c-41b8-89bd-8349f031dd53@nbd.name>
Date:   Wed, 27 Oct 2021 18:37:34 +0300
In-Reply-To: <6d896d65-235c-41b8-89bd-8349f031dd53@nbd.name> (Felix Fietkau's
        message of "Sat, 23 Oct 2021 13:28:09 +0200")
Message-ID: <8735om7a2p.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's a pull request with some follow-up fixes for 5.16
>
> - Felix
>
> The following changes since commit 753453afacc0243bd45de45e34218a8d17493e8f:
>
>   mt76: mt7615: mt7622: fix ibss and meshpoint (2021-10-23 10:29:39 +0300)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-10-23
>
> for you to fetch changes up to 52a99a13cb880845cd77f1da7136d689347489ef:
>
>   mt76: connac: fix unresolved symbols when CONFIG_PM is unset (2021-10-23 13:23:45 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.16
>
> * fix a compile error with !CONFIG_PM
> * cleanups
> * MT7915 DBDC fixes
> * endian warning fixes
>
> ----------------------------------------------------------------

Pulled, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
