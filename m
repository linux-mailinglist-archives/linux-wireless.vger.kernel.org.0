Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452023AD0FB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhFRRPH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 13:15:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54364 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhFRRPF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 13:15:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624036376; h=Content-Type: MIME-Version: Message-ID: Date:
 References: In-Reply-To: Subject: Cc: To: From: Sender;
 bh=9WX/tS6yFNICIaQ97f9GR/N/9aRMSiCPvLjxFXkem3M=; b=WE+7Erf5iENLtmGoJXz/aQlImzv2gLJupy8g0GgOqfdOILZWt1S9Eo1EoEQw6tVShmBYvpou
 HZuuR3+nLXLDLmjSRcPJiz2tjNQ6v3S9TI6IZ2FA4eTFnLcxANPctp8bCT8X8dJ6G9bIgpRM
 EArPFK8KGp0/FVqJ6Sn/fzwnYK0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60ccd406e570c05619cef725 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 17:12:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 715A1C4338A; Fri, 18 Jun 2021 17:12:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8D98C433F1;
        Fri, 18 Jun 2021 17:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8D98C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-06-18
In-Reply-To: <3369c6a7-1fa5-7f9a-2d50-867d61dce304@nbd.name> (Felix Fietkau's
        message of "Fri, 18 Jun 2021 17:26:33 +0200")
References: <3369c6a7-1fa5-7f9a-2d50-867d61dce304@nbd.name>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 18 Jun 2021 20:12:34 +0300
Message-ID: <87v96bhzb1.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's an updated version of my first pull request for 5.14
>
> - Felix
>
> The following changes since commit 0c33795231bff5df410bd405b569c66851e92d4b:
>
>   Merge tag 'wireless-drivers-next-2021-06-16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-06-16 12:59:42 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-06-18
>
> for you to fetch changes up to 6edc39a381a0842d6dd5dc073879fcaee08e9989:
>
>   mt76: mt7921: allow chip reset during device restart (2021-06-18 17:18:09 +0200)
>
> ----------------------------------------------------------------
> mt76 patches for 5.14
>
> * mt7915 MSI support
> * disable ASPM on mt7915
> * mt7915 tx status reporting
> * mt7921 decap offload
> * driver fixes
> * cleanups
> * mt7921 runtime power management improvements
> * testmode improvements/fixes
> * runtime PM improvements
>
> ----------------------------------------------------------------

Unfortunately I still see the sysfs warning:

drivers/net/wireless/mediatek/mt76/mt7915/init.c: In function 'mt7915_thermal_init':
drivers/net/wireless/mediatek/mt76/mt7915/init.c:138:17: warning: ignoring return value of 'sysfs_create_link' declared with attribute 'warn_unused_result' [-Wunused-result]
  138 |                 sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  139 |                                   "cooling_device");
      |                                   ~~~~~~~~~~~~~~~~~

And s-o-b is missing in one commit:

Commit

  7c649aa4de81 ("mt76: move mt76_rates in mt76 module")

is missing a Signed-off-by from its committer.

I checked that I pulled the correct tag, and not the old one:

From https://github.com/nbd168/wireless
 * tag                         mt76-for-kvalo-2021-06-18 -> FETCH_HEAD

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
