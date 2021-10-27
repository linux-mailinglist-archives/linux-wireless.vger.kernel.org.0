Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B048C43C67B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ0JfK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:35:10 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:40256 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbhJ0JfJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:35:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635327164; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=mjw+FJ0C3ceDpUYn3K+CD6YvEM6VOlE6BPkSqy+5rcE=; b=bf4llXjw1Srvg377Bmy7UPAtk/CRwAZyD5k1x4QDSrLTkuVMldez8cmHE6CSx28P32cGW9lQ
 F3RuzUmQtI9HMsvdAMRgiDUd4dQqDRl4vnuwC+6QW35hUkGIuW+nMysvz+8HIHe0GmbCco1G
 A0zsX0Alh5aWtvRE1W8g/T5H3DE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61791ca79ef7bd81bdb2347d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 09:32:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A67FC4360C; Wed, 27 Oct 2021 09:32:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F098C4338F;
        Wed, 27 Oct 2021 09:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3F098C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-10-23
References: <6d896d65-235c-41b8-89bd-8349f031dd53@nbd.name>
Date:   Wed, 27 Oct 2021 12:32:20 +0300
In-Reply-To: <6d896d65-235c-41b8-89bd-8349f031dd53@nbd.name> (Felix Fietkau's
        message of "Sat, 23 Oct 2021 13:28:09 +0200")
Message-ID: <87bl3a7qzf.fsf@codeaurora.org>
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

Unfortunately I had already applied some of the fixes directly:

753453afacc0 mt76: mt7615: mt7622: fix ibss and meshpoint
a88cae727b3e mt76: mt7921: fix Wformat build warning
8603caaec98f mt76: mt7921: fix mt7921s Kconfig

Fortunately git-pull seems to handle this without problems so my plan is
to pull this anyway, despite the the duplicate commits. But if you
prefer to instead rebase your tree and send a new pull request, do let
me know. Either way is fine for me.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
